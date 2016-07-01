//
//  YFPatchRequest.m
//  iOS122
//
//  Created by 颜风 on 15/11/13.
//  Copyright © 2015年 iOS122. All rights reserved.
//

#import "YFPatchRequest.h"

@interface YFPatchRequest ()
@property(nonatomic, weak) JSObjectFactory * mcObjectFactory;
@property(nonatomic, strong) NSString * mcUrl;
@property (nonatomic, strong) NSArray<YFPatchModel> * mcVirtualPatchs; //!< 模拟返回数据,用于测试,仅当mcIsTest为YES时使用.

@end
@implementation YFPatchRequest
objection_register_singleton(YFPatchRequest)
objection_requires(@"mcObjectFactory")

- (void)awakeFromObjection
{
        
    
}

- (void)get: (void (^)(NSArray<YFPatchModel> *)) success
    failure:(void(^) (NSError*)) failure
{
    /* 真实的网络请求,根据自己需要实现即可. */
    success([self mcVirtualPatchs]);
}

/**
 *  是否是测试模式.此处单独控制,与Debug模式无本质关联.
 *
 *  测试开发时,通常会选一个特定的返回固定内容的地址来查看效果.
 *
 *  @return YES,正在测试;NO,不是在测试.
 */
-(BOOL) mcIsTest
{
    return YES;
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
 *  测试用的模拟数据.
 *
 *  @return 测试用的模拟数据.
 */
- (NSArray<YFPatchModel> *)mcVirtualPatchs
{
    if (nil == _mcVirtualPatchs) {
        /* 可以测试增删改查等. */
        
        /* 使用补丁修改测试例子. */
        id<YFPatchModel> sample = [self.mcObjectFactory getObject:@protocol(YFPatchModel)];
        sample.patchId = @"patchId_sample";
        sample.md5 = @"fecf31237c9c0aa4845a77f67a6cce32";
        sample.url = @"http://ios122.bj.bcebos.com/sample_patch.js";
        sample.ver = [self mcCurrentVer];
        
        _mcVirtualPatchs = (NSArray<YFPatchModel> *)@[sample];
    }
    
    return _mcVirtualPatchs;
}

- (NSString *)mcUrl
{
    if (nil == _mcUrl) {
        _mcUrl = @"update/ios";
    }
    
    return _mcUrl;
}
@end
