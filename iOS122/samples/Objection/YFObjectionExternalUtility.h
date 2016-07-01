//
//  YFObjectionExternalUtility.h
//  iOS122
//
//  Created by 颜风 on 15/11/8.
//  Copyright © 2015年 iOS122. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YFObjectionExternalUtility <NSObject>

- (void)doSomething;

@end
@interface YFObjectionExternalUtility : NSObject
+ (void)doSomething;

@end
