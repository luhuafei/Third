//
//  YFObjectionCar.h
//  iOS122
//
//  Created by 颜风 on 15/11/7.
//  Copyright © 2015年 iOS122. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Objection.h>
#import "YFObjectionExternalUtility.h"
@class YFObjectionEngine, YFObjectionBrakes;


@interface YFObjectionCar : NSObject


@property(nonatomic, strong) YFObjectionEngine *engine; //!< 将会通过依赖注入赋值.
@property(nonatomic, strong) YFObjectionBrakes *brakes; //!< 将会通过依赖注入赋值.
@property(nonatomic) BOOL awake;

@property(nonatomic, strong) JSObjectFactory *objectFactory; //!< 对象工厂.

@property (nonatomic, assign) id<YFObjectionExternalUtility> externalUtility; //!< 元类的绑定.

@property(nonatomic, strong) YFObjectionBrakes *redBrakes; //!< 将会通过依赖注入赋值.

/**
 *  自定义初始化方法.
 *
 *  @param obj 自定义出售方法.
 *
 *  @return 实例对象.
 */
- (instancetype)initWith:(id) obj;

@end
