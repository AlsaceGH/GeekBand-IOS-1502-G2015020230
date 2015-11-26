//
//  LoginAndRegisterViewController.m
//  GHMoran
//
//  Created by alsace on 11/1/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import "GHLoginAndRegisterViewController.h"
#import "AppDelegate.h"
#import "GHGlobal.h"
#import "GHGetImage.h"


@interface GHLoginAndRegisterViewController ()

@end

@implementation GHLoginAndRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    self.emailTextField.text = @"hh@163.com";
    self.passwordTextField.text = @"111111";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginButtonClicked:(id)sender {
    NSString *userName = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    
    if (([userName length] == 0) || [password length] == 0) {
        [self showErrorMessage:@"邮箱和密码不能为空"];
    } else {
        [self loginHandle];
    }
}

- (void)showErrorMessage:(NSString *)msg {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

- (void)loginHandle {
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *gbid = @"G2015020230";
    
    self.loginRequest = [[GHLoginRequest alloc]init];
    [self.loginRequest sendLoginRequestWithEmail:email password:password gbid:gbid delegate:self];
}

- (IBAction)touchDownAction:(id)sender {
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)loginRequestSuccess:(GHLoginRequest *)request user:(GHUserModel *)user {
    if ([user.loginReturnMessage isEqualToString:@"Login success"]) {
        NSLog(@"登录成功，现在转换页面");
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
       [GHGlobal shareGlobal].user = user;
       [GHGlobal shareGlobal].user.email = self.emailTextField.text;
       GHGetImage *getImage = [[GHGetImage alloc]init];
       [getImage sendGetImageRequest];
        appDelegate.loginViewController=self;
        [appDelegate loadMainViewWithController:self];
    } else {
        NSLog(@"服务器错误:%@", user.loginReturnMessage);
    }
}

- (void)loginRequestFailed:(GHLoginRequest *)request error:(NSError *)error {
    NSLog(@"登录错误原因：%@", error);
}

@end
