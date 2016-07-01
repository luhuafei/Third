//
//  YFPatchViewModel.m
//  iOS122
//
//  Created by 颜风 on 15/11/12.
//  Copyright © 2015年 iOS122. All rights reserved.
//

#import "YFPatchViewModel.h"
#import "JPEngine.h"
#include <CommonCrypto/CommonDigest.h>
#import <PINCache.h>
#import <AFNetworking.h>

@interface YFPatchViewModel ()
@property (strong, nonatomic) NSArray<YFPatchModel> * mcLocalPatchs; //!< 本地补丁的信息.
@property (readonly, nonatomic, copy) NSString * mcPatchCacheKey; //!< 补丁缓存时用的key值.
@property (readonly, assign, nonatomic) id<YFPatchRequest> mcRequest; //!< 补丁请求.

@end
@implementation YFPatchViewModel
objection_register_singleton(YFPatchViewModel)
objection_requires(@"mcRequest");

- (void)awakeFromObjection
{
    /* 基本思路: 安装本地所有补丁 --> 联网更新补丁信息,并安装有更新或新增加的补丁. */
    /* DEBUG模式,总会执行测试函数,以测试某个JS. */
    [self mcDebug];
    
    /* 安装本地已有补丁. */
    [self mcInstallLocalPatchs];
    
    /* 联网获取最新补丁. */
    [[[[self mcFetchLatestPatchs] flattenMap:^RACStream *(NSArray<YFPatchModel> * models) {
        return [self mcUpdateLocalPatchs: models];
    }] then:^RACSignal *{/* 更新本地补丁文件. */
        return [self mcUpdateAllLocalPatchFiles];
    }] subscribeNext:^(id<YFPatchModel> patch) { /* 安装新增或有更新的补丁. */
        [self mcInstallPatch: patch];
    }];
}

/**
 *  测试模式下,会执行此方法,以验证某个JS文件的作用.默认使用本地demo.js.
 */
- (void)mcDebug
{
#ifdef DEBUG
    NSString * path = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"js"];
    [self mcEvaluateScriptFile: path];
#endif

}

- (NSString *)mcPatchCacheKey
{
    return @"mcPatchCacheKey";
}

- (NSArray<YFPatchModel> *)mcLocalPatchs
{
    if (nil == _mcLocalPatchs) {
        _mcLocalPatchs = [NSMutableArray<YFPatchModel> arrayWithCapacity: 42];
        
        NSArray<YFPatchModel>* cache = [[PINCache sharedCache] objectForKey: self.mcPatchCacheKey];
        
        id<YFPatchModel> patchModel = cache.firstObject;
        
        if (! [patchModel.ver isEqualToString: [self mcCurrentVer]]) {
            /* 清除与此版本无关的补丁信息.目前可以安全地认为补丁包中的所有补丁版本都是一致的 */
            cache = nil;
            [[PINCache sharedCache] removeObjectForKey: [self mcPatchCacheKey]];
        }
        
        _mcLocalPatchs = cache;
        
        /* 补丁的初始状态设置为"未安装". */
        [_mcLocalPatchs enumerateObjectsUsingBlock:^(id<YFPatchModel> obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.status = YFPatchModelStatusUnInstall;
        }];
    }
    
    return _mcLocalPatchs;
}

/**
 *  验证文件的md5值是否与给定的md5匹配.
 *
 *  @param filePath 本地文件路径.
 *  @param md5      应该具有的md5值.
 *
 *  @return YES,文件md5与给定的md5匹配;NO,不匹配或文件不存在.
 */
- (BOOL)mcVerify:(NSString *)filePath Md5: (NSString *)md5
{
    NSString * fileMd5 = [self mcMd5HashOfPath: filePath];
    
    BOOL result = [md5 isEqualToString:fileMd5];
    
    return result;
}

/**
 *  获取文件的md5信息.
 *
 *  @param path 文件路径.
 *
 *  @return 文件的md5值.
 */
-(NSString *)mcMd5HashOfPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 确保文件存在.
    if( [fileManager fileExistsAtPath:path isDirectory:nil] )
    {
        NSData *data = [NSData dataWithContentsOfFile:path];
        unsigned char digest[CC_MD5_DIGEST_LENGTH];
        CC_MD5( data.bytes, (CC_LONG)data.length, digest );
        
        NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
        
        for( int i = 0; i < CC_MD5_DIGEST_LENGTH; i++ )
        {
            [output appendFormat:@"%02x", digest[i]];
        }
        
        return output;
    }
    else
    {
        return @"";
    }
}

/**
 *  获取某个补丁的本地存储路径.
 *
 *  注意: 此方法仅会根据既定规则计算出补丁应具有的路径,但是该路径下可能暂无对应文件.
 *
 *  @param model 补丁模型.
 *
 *  @return 补丁的本地存储路径.
 */
- (NSString *) mcPathForModel: (id<YFPatchModel>) model
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString * libCachePath = [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
    
    NSString * patchRootPath =  [libCachePath stringByAppendingString:[NSString stringWithFormat:@"/patch/%@", [self mcCurrentVer]]];
    
    if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:patchRootPath] )
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:patchRootPath
                                         withIntermediateDirectories:YES
                                                          attributes:nil
                                                               error:NULL];
    }
    
    NSString * path =  [patchRootPath stringByAppendingString:[NSString stringWithFormat:@"/%@", model.patchId]];
    
    return path;
}

/**
 *  执行某个JS文件.
 *
 *  @param path JS文件路径.
 *
 *  @return YES,执行成功;NO,执行失败.
 */
- (BOOL) mcEvaluateScriptFile: (NSString *) path
{
    /* 打开JSPathc引擎. */
    [JPEngine startEngine];
    
    NSString *script = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error: NULL];
    
    if (nil != script) {
        [JPEngine evaluateScript:script];
        
        // 修复成功.
        return YES;
    }
    
    return NO;
}

/**
 *  当前版本号.
 *
 *  @return 当前版本号.
 */
- (NSString *) mcCurrentVer
{
    NSString * ver = [[NSBundle mainBundle].infoDictionary objectForKey:(NSString *)kCFBundleVersionKey];
    
    return ver;
}

/**
 *  获取此App版本最新补丁信息.
 *
 *
 *  @return sendNext 最新的完整补丁包.
 */
- (RACSignal *)mcFetchLatestPatchs
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [self.mcRequest get:^(NSArray<YFPatchModel> * patchs) {
            [subscriber sendNext: patchs];
            [subscriber sendCompleted];
        } failure:^(NSError * error) {
            [subscriber sendError: error];
        }];
        
        return nil;
    }];
    
}

/**
 *  安装单个补丁.
 *
 *  @param patch 补丁.
 *
 */
- (void) mcInstallPatch: (id<YFPatchModel>) patch
{
    // 仅安装为"未安装状态的"补丁.
    if (YFPatchModelStatusUnInstall != patch.status) {
        return;
    }
    
    NSString * path = [self mcPathForModel: patch];
    
    /* 本地补丁是否存在? */
    if (YES != [[NSFileManager defaultManager] fileExistsAtPath: path]) {
        patch.status = YFPatchModelStatusFileNotExit;
        
        return;
    }
    
    /* md5校验,匹配吗? */
    if (YES != [self mcVerify:path Md5: patch.md5]) {
        patch.status = YFPatchModelStatusFileNotMatch;
        
        return;
    }
    
    /* 补丁安装成功了吗?  */
    if (YES != [self mcEvaluateScriptFile: path]) {
        patch.status = YFPatchModelStatusUnKnownError;
        
        return;
    }
    
    patch.status = YFPatchModelStatusSuccess;
}

/**
 *  安装本地补丁.
 */
- (void)mcInstallLocalPatchs
{
    @weakify(self);
    [self.mcLocalPatchs enumerateObjectsUsingBlock:^(id<YFPatchModel> obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        
        [self mcInstallPatch: obj];
    }];
}

/**
 *  更新本地补丁包.
 *
 *  因为大部分补丁,本地可能已经具有,并正确安装,所以不能简单覆盖本地补丁包;简单覆盖,会引起补丁不必需哟啊的重复下载.
 *
 *  @param latestPatchs 最新的补丁包.
 */
- (RACSignal *)mcUpdateLocalPatchs: (NSArray<YFPatchModel>*) latestPatchs
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        NSMutableArray * localPatchs = [NSMutableArray arrayWithArray: self.mcLocalPatchs];
        
        NSMutableArray<YFPatchModel> * allUpdatePatchs = [NSMutableArray<YFPatchModel> arrayWithArray: latestPatchs];
        
        [allUpdatePatchs enumerateObjectsUsingBlock:^(id<YFPatchModel> latestPatch, NSUInteger idx, BOOL * _Nonnull stop) {
            // 新添加的补丁,默认状态时"新增".
            latestPatch.status = YFPatchModelStatusAdd;
            
            [localPatchs enumerateObjectsUsingBlock:^(id<YFPatchModel> localPatch, NSUInteger idx, BOOL * _Nonnull stop) {
                if (YES != [localPatch.patchId isEqualToString: latestPatch.patchId]) {
                    return;
                }
                
                /* 有可能是补丁本身的更新吗? */
                if ( ! [localPatch.md5 isEqualToString: latestPatch.md5] ||
                    ! [localPatch.url isEqualToString: latestPatch.url]) {
                    latestPatch.status = YFPatchModelStatusUpdate;
                    
                    return;
                }
                
                /* 对于已经存在的,没有更新的补丁,默认继续使用原来的"状态"即可. */
                latestPatch.status = localPatch.status;
            }];
        }];
        
        self.mcLocalPatchs = allUpdatePatchs;
        
        /* 更新本地补丁缓存信息. */
        [[PINCache sharedCache] setObject: self.mcLocalPatchs forKey:self.mcPatchCacheKey];
        
        [subscriber sendCompleted];
        return nil;
    }];
}

/**
 *  更新单个补丁的补丁文件.
 *
 *  @param patch 补丁模型.
 *
 *  @return sendNext: 传入的补丁.
 */
- (RACSignal *) mcUpdatePatchFile: (id<YFPatchModel>) patch
{
    @weakify(self);
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        
        if (YFPatchModelStatusSuccess == patch.status) {
            [subscriber sendCompleted];
            
            return nil;
        }
        
        NSString * url = patch.url;
        
        NSString * savePath = [self mcPathForModel:patch];

        NSMutableURLRequest * patchRequest =[NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]];
        
        AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:patchRequest];
        [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:savePath append:NO]];

        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            patch.status = YFPatchModelStatusUnInstall;
            [subscriber sendNext: patch];
            [subscriber sendCompleted];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError: error];
        }];
        
        [operation start];
        
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }];
}

/**
 *  更新本地所有需要更新的补丁的补丁文件.
 *
 *
 *  @return sendNext: 文件已被更新的补丁.
 */

- (RACSignal *) mcUpdateAllLocalPatchFiles
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        
        if (0 == self.mcLocalPatchs) {
            [subscriber sendCompleted];
        }
        
        [self.mcLocalPatchs enumerateObjectsUsingBlock:^(id<YFPatchModel> obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [[self mcUpdatePatchFile: obj] subscribeNext:^(id x) {
                [subscriber sendNext: x];
                
                if (idx == self.mcLocalPatchs.count - 1) {
                    [subscriber sendCompleted];
                }
            }];
        }];
        
        return nil;
    }];
}

@end
