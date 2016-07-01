//
//  YFReactViewController.m
//  iOS122
//
//  Created by 颜风 on 15/11/22.
//  Copyright © 2015年 iOS122. All rights reserved.
//

#import "YFReactViewController.h"
#import <RCTRootView.h>

@implementation YFReactViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/ReactComponent/iOS/index.ios.bundle?platform=ios&dev=true"];
    
    // For production use, this `NSURL` could instead point to a pre-bundled file on disk:
    //
    //   NSURL *jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
    //
    // To generate that file, run the curl command and add the output to your main Xcode build target:
    //
    //   curl http://localhost:8081/index.ios.bundle -o main.jsbundle
    RCTRootView * rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation moduleName:@"AwesomeProject" initialProperties:nil launchOptions:nil];
    
    [self.view addSubview: rootView];
    
    [rootView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
}
@end
