//
//  YFObjectionCar.m
//  iOS122
//
//  Created by 颜风 on 15/11/7.
//  Copyright © 2015年 iOS122. All rights reserved.
//

#import "YFObjectionCar.h"
#import <Objection.h>

@implementation YFObjectionCar
objection_requires(@"engine", @"brakes", @"objectFactory", @"externalUtility")
//objection_requires_sel(@selector(engine), @selector(brakes))
//@synthesize engine, brakes, awake;
//objection_register_singleton(YFObjectionCar)
objection_requires_names((@{@"RedBrakes":@"redBrakes"}))

//objection_initializer(initWith:, @"YFObjectionCar")

//objection_initializer(initWith:)


objection_initializer(creatWith:)


- (instancetype)initWith:(id)obj
{
    self = [super init];
    
    if (nil != self) {
        NSLog(@"%@", obj);
    }
    
    return self;
}

+ (instancetype)creatWith:(id)obj
{
    YFObjectionCar * car = [[YFObjectionCar alloc]initWith:obj];
    
    return car;
}

- (instancetype)init
{
    self = [super init];
    
    if (nil != self) {
        // 在初始化方法中使用injectDependencies:可以保证即使不从注射器中初始化此类,也能保证依赖被正确注入.
//        [[JSObjection defaultInjector] injectDependencies:self];
    }
    
    return self;
}


- (void)awakeFromObjection {
    self.awake = YES;
}

@end
