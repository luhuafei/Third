//
//  YFObjectionCarProvider.m
//  iOS122
//
//  Created by 颜风 on 15/11/8.
//  Copyright © 2015年 iOS122. All rights reserved.
//

#import "YFObjectionCarProvider.h"
#import "YFObjectionCar.h"

@implementation YFObjectionCarProvider
- (id)provide:(JSObjectionInjector *)context arguments:(NSArray *)arguments {
    // 手动创建对象.
    YFObjectionCar * car = [[YFObjectionCar alloc] init];
    
    return car;
}
@end
