//
//  GHRegisterViewController.h
//  GHMoran
//
//  Created by alsace on 11/23/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHRegisterViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *repeatPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

- (IBAction)registerButtonClickd:(id)sender;

- (IBAction)loginButtonClicked:(id)sender;
- (IBAction)touchDownAction:(id)sender;



@end
