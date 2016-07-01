//
//  YFKiwiCar.h
//  iOS122
//
//  Created by 颜风 on 15/11/17.
//  Copyright © 2015年 iOS122. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFKiwiCar : NSObject
@property (strong ,nonatomic) NSArray * wheels; //!< 车轮.
@property (assign, nonatomic) CGFloat speed; //!< 速度.
@property (assign, nonatomic) NSInteger currentGear;

- (BOOL)changeToGear:(NSInteger) gear;

- (void)jumpToStarSystemWithIndex: (CGFloat) index;

- (void)applyBrakes;

- (void)speak: (NSString *) str;
- (void)speak:(NSString *)str afterDelay:(NSInteger) delay whenDone: (void (^)())block;
@end
