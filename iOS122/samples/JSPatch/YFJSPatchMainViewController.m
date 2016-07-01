
//
//  MainViewController.m
//  TestProject
//
//  Created by 偌一茗 on 15/10/30.
//  Copyright © 2015年 boleketang. All rights reserved.
//

#import "YFJSPatchMainViewController.h"
#import "JPEngine.h"

@interface YFJSPatchMainViewController ()

@end

@implementation YFJSPatchMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //先生成个提示框看下效果
    [JPEngine startEngine];
    [JPEngine evaluateScript:@"\
     var alertView = require('UIAlertView').alloc().init();\
     alertView.setTitle('警告');\
     alertView.setMessage('JS正在靠近！'); \
     alertView.addButtonWithTitle('OK');\
     alertView.show(); \
     "];

    
    self.title = @"Home";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
//    加载引擎
    [JPEngine startEngine];
    
//    本地JS，动态更新技术就是通过服务器获取JS更新这个JS
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"js"];
    NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
    [JPEngine evaluateScript:script];
    
    //从服务器获取更新JS
//    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://cnbang.net/test.js"]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        NSString *script = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        [JPEngine evaluateScript:script];
//    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 200, 50);
    button.center = self.view.center;
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"进入JS生成的UI" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view.
}

- (void)buttonTouch:(UIButton *)button {
//    触发的方法在demo.JS中
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
