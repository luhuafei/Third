//
//  YFKiwiFlyingMachine.h
//  iOS122
//
//  Created by 颜风 on 15/11/19.
//  Copyright © 2015年 iOS122. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YFKiwiFlyingMachine <NSObject>
- (float)dragCoefficient;

- (void)takeOff;
@end
