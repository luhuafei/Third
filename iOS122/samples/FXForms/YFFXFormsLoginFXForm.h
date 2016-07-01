//
//  LoginFXForm.h
//  FXFormsTutorial
//
//  Created by Ben Liu on 28/11/2015.
//  Copyright © 2015 Ben Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXForms.h"

@interface YFFXFormsLoginFXForm : NSObject <FXForm>

@property (nonatomic, copy)     NSString        *email;
@property (nonatomic, copy)     NSString        *password;

@end
