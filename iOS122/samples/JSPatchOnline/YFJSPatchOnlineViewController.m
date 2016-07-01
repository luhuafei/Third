//
//  YFJSPatchOnlineViewController.m
//  iOS122
//
//  Created by 颜风 on 15/12/7.
//  Copyright © 2015年 iOS122. All rights reserved.
//

#import "YFJSPatchOnlineViewController.h"

@implementation YFJSPatchOnlineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"补丁?" message:[self mcPatchTest] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    
    [alert show];
}

- (NSString *)mcPatchTest
{
    return @"我不是补丁";
}
@end
