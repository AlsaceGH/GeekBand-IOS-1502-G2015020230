//
//  LoginAndRegisterViewController.h
//  GHMoran
//
//  Created by alsace on 11/1/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHLoginRequest.h"
#import "GHUserModel.h"

@interface GHLoginAndRegisterViewController : UIViewController<UITextFieldDelegate, GHLoginRequestDelegate>

@property (nonatomic, strong) GHLoginRequest *loginRequest;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)loginButtonClicked:(id)sender;
- (IBAction)touchDownAction:(id)sender;

@end
