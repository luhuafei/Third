//
//  YFObjectionViewController.m
//  iOS122
//
//  Created by 颜风 on 15/11/7.
//  Copyright © 2015年 iOS122. All rights reserved.
//

#import "YFObjectionViewController.h"
#import "YFObjectionCar.h"
#import <Objection.h>
#import "YFObjectionBrakes.h"
#import "YFObjectionExternalUtility.h"
#import "YFAppModule.h"

@implementation YFObjectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"详见控制台输出" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
    [alertView show];
    
    // 使用正常方式初始化.
//    YFObjectionCar * car = [[YFObjectionCar alloc] init];
//    NSLog(@"%@", car);
    
    // 使用注射器初始化.
//    JSObjectionInjector *injector = [JSObjection createInjector];
//    id car2 = [injector getObject:[YFObjectionCar class]];
//    NSLog(@"%@", car2);
    
    
    // 使用注射器初始化,此时YFObjectionEngine实例和Car2是一样的.
//    id car3 = [injector getObject:[YFObjectionCar class]];
//    NSLog(@"%@", car3);

    // 全局注射器.
    YFObjectionCar *car4 = [[JSObjection defaultInjector] getObject:[YFObjectionCar class]];
    NSLog(@"%@", car4);

    // 下标操作.
//    YFObjectionCar* car5 = injector[[YFObjectionCar class]];
//    NSLog(@"%@", car5);
    
    // 对象工厂.
//    id brakes = [car4.objectFactory getObject:[YFObjectionBrakes class]];
//    NSLog(@"%@", brakes);
//    
//    id brakes2 = [car5.objectFactory getObject:[YFObjectionBrakes class]];
//    NSLog(@"%@", brakes2);

    // 获取自定义模块的配置中绑定到注射器的对象.
    id moduleObject  = [[JSObjection defaultInjector] getObject:[UIApplication class]];
    NSLog(@"%@", moduleObject);
    
    // 元类与协议的绑定.
    id<YFObjectionExternalUtility>  externalUtility = [[JSObjection defaultInjector] getObject:@protocol(YFObjectionExternalUtility)];

    [externalUtility doSomething];
    NSLog(@"%@", externalUtility);
    
    // 提供者的测试.
//    id carP = [[JSObjection defaultInjector] getObject:[YFObjectionCar class]];
//    NSLog(@"%@", carP);
//    
//    
//    id carP2 = [[JSObjection defaultInjector] getObject:[YFObjectionCar class]];
//    NSLog(@"%@", carP2);
    
    // 作用域测试.
    id carS = [[JSObjection defaultInjector] getObject:[YFObjectionCar class]];
    NSLog(@"%@", carS);


    id carS2 = [[JSObjection defaultInjector] getObject:[YFObjectionCar class]];
    NSLog(@"%@", carS2);
    
    // 派生新的注射器.
    JSObjectionInjector * newInjector = [[JSObjection defaultInjector] withModule:[[YFAppModule alloc] init]];
    NSLog(@"%@", newInjector);
    
    
    JSObjectionInjector *injector2 = [[JSObjection createInjector:[[YFAppModule alloc] init]] withoutModuleOfType:[YFAppModule class]];
    NSLog(@"%@", injector2);

    // 自定义初始化参数
    id carArg = [[JSObjection defaultInjector] getObjectWithArgs:[YFObjectionCar class], @"自定义参数", nil];
    NSLog(@"%@", carArg);
    
    // 专用初始化方法.
    id carArg2 = [[JSObjection defaultInjector] getObject:[YFObjectionCar class] initializer:@selector(initWith:) argumentList:@[@"专用初始化方法"]];
    NSLog(@"%@", carArg2);


}
@end
