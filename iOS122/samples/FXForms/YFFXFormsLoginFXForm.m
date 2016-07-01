//
//  LoginFXForm.m
//  FXFormsTutorial
//
//  Created by Ben Liu on 28/11/2015.
//  Copyright © 2015 Ben Liu. All rights reserved.
//

#import "YFFXFormsLoginFXForm.h"

@implementation YFFXFormsLoginFXForm



// 定制 Form

// -- username
- (NSDictionary *)emailField{
    return @{
             FXFormFieldHeader:         @"Login",       // Form Title
             FXFormFieldKey:            @"email",       // 对应的 key
             FXFormFieldTitle:          @"Email",       // 字段的 Title
             FXFormFieldPlaceholder:    @"Your Email",  // 字段的预留信息
             @"textField.enabled":      @(NO)           // set readonly
             };
}
// -- password
- (NSDictionary *)passField {
    return @{
             FXFormFieldKey:            @"password",    // 这里如果FXForm知道这里用的是密码，则自动屏蔽密码，用星标代替
             FXFormFieldTitle:          @"password",
             };
}


// Submit button and return button
- (NSArray *)extraFields
{
    return @[
             // 这里你不用在头文件里声明, 只需要在返回的 NSArray中添加一个元素即可
             @{FXFormFieldTitle: @"Submit", FXFormFieldHeader: @"", FXFormFieldAction: @"submitLoginForm:"},
             @{FXFormFieldTitle: @"Return", FXFormFieldHeader: @"", FXFormFieldAction: @"returnPreviousView"},
             ];
}

@end
