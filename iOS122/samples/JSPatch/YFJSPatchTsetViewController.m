//
//  TsetViewController.m
//  TestProject
//
//  Created by 偌一茗 on 15/11/9.
//  Copyright © 2015年 boleketang. All rights reserved.
//

#import "YFJSPatchTsetViewController.h"

@interface YFJSPatchTsetViewController ()

@end

@implementation YFJSPatchTsetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"偌一茗";
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    lable.center = self.view.center;
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = @"JS到原生UI";
    [self.view addSubview:lable];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
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
