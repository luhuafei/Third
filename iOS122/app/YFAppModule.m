//
//  YFAppModule.m
//  iOS122
//
//  Created by 颜风 on 15/11/9.
//  Copyright © 2015年 iOS122. All rights reserved.
//

#import "YFAppModule.h"
#import "YFPatchModel.h"
#import "YFPatchViewModel.h"
#import "YFPatchRequest.h"
#import "YFObjectionExternalUtility.h"
#import "YFObjectionCarProvider.h"
#import "YFObjectionCar.h"
#import "YFObjectionBrakes.h"
#import "YFObjectionRedBrakes.h"

@protocol APIService <NSObject>

@end

@interface MyAPIService : NSObject

@end

@implementation MyAPIService

@end


@implementation YFAppModule

/**
 *  配置依赖.根据需要自行添加即可.
 */
- (void)configure
{
    [self bind:[UIApplication sharedApplication] toClass:[UIApplication class]];
    [self bind:[UIApplication sharedApplication].delegate toProtocol:@protocol(UIApplicationDelegate)];
    [self bindClass:[MyAPIService class] toProtocol:@protocol(APIService)];
    [self bindMetaClass:[YFObjectionExternalUtility class] toProtocol:@protocol(YFObjectionExternalUtility)];
    
    //    [self bindProvider:[[YFObjectionCarProvider alloc] init] toClass:[YFObjectionCar class]];
    
    //    [self bindBlock:^(JSObjectionInjector *context) {
    //        // 手动创建对像.
    //        YFObjectionCar * car = [[YFObjectionCar alloc] init];
    //
    //        return car;
    //    } toClass:[YFObjectionCar class]];
    
    // 作用域.
    [self bindClass:[YFObjectionBrakes class] inScope:JSObjectionScopeNormal];
    //    [self bindClass:[YFObjectionCar class] inScope:JSObjectionScopeSingleton];
    
    // 别名绑定.
    [self bindClass:[YFObjectionRedBrakes class] toClass:[YFObjectionBrakes class] named:@"RedBrakes"];
    
    // 及早初始化单例.
    [self bindClass:[YFObjectionBrakes class] inScope:JSObjectionScopeSingleton];
    [self registerEagerSingleton:[YFObjectionBrakes class]];
    
    /* 补丁. */
    [self bindClass:[YFPatchModel class] toProtocol:@protocol(YFPatchModel)];
    [self bindClass:[YFPatchViewModel class] toProtocol:@protocol(YFPatchViewModel)];
    
    [self registerEagerSingleton:[YFPatchViewModel class]];
    [self bindClass:[YFPatchRequest class] toProtocol:@protocol(YFPatchRequest)];
}

@end
