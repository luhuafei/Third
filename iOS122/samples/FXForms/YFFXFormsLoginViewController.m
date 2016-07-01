//
//  LoginViewController.m
//  FXFormsTutorial
//
//  Created by Ben Liu on 28/11/2015.
//  Copyright © 2015 Ben Liu. All rights reserved.
//

#import "YFFXFormsLoginViewController.h"

@interface YFFXFormsLoginViewController ()

@end

@implementation YFFXFormsLoginViewController


- (void)awakeFromNib
{
    //set up form
    self.formController.form = [[YFFXFormsLoginFXForm alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.formController.form = [[YFFXFormsLoginFXForm alloc] init];
}

#pragma submit event
- (void)submitLoginForm:(UITableViewCell<FXFormFieldCell> *)cell{
    
    YFFXFormsLoginFXForm *form= cell.field.form;
    NSString *szInfo= [NSString stringWithFormat:@"username: %@ password: %@",
                       form.email,
                       form.password];
    
    [[[UIAlertView alloc] initWithTitle:@"Login Form Submitted"
                                message:szInfo
                               delegate:nil
                      cancelButtonTitle:nil
                      otherButtonTitles:@"OK", nil] show];
}


#pragma return back to previous view
-(void)returnPreviousView{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
