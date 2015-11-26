//
//  GHRegisterViewController.m
//  GHMoran
//
//  Created by alsace on 11/23/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import "GHRegisterViewController.h"
#import "GHRegisterRequest.h"

@interface GHRegisterViewController ()<GHRegisterRequestDelegate>
@property (nonatomic, strong) GHRegisterRequest *registerRequest;
@end

@implementation GHRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.registerButton.layer.cornerRadius=5.0;
    self.registerButton.clipsToBounds=YES;
    
    self.emailTextField.delegate=self;
    self.passwordTextField.delegate=self;
    self.repeatPasswordTextField.delegate=self;
    self.userNameTextField.delegate=self;
    
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

#pragma mark text delegate and event handle

- (IBAction)registerButtonClickd:(id)sender {
    NSString *username=self.userNameTextField.text;
    NSString *password=self.passwordTextField.text;
    NSString *email=self.emailTextField.text;
    NSString *repeatPassword=self.repeatPasswordTextField.text;
    
    if ([username length]==0||email.length==0||password.length==0||repeatPassword.length==0) {
        [self showErrorMessage:@"用户名、邮箱和密码不能为空"];
    }else if(![self isValidateEmail:email]){
        [self showErrorMessage:@"你输入的邮箱格式有误，请重试"];
    }else if(![password isEqualToString:repeatPassword]){
        [self showErrorMessage:@"两次输入密码不一致，请重试"];
    }else if(![self isValidatePassword:password]){
        [self showErrorMessage:@"密码格式有误，应为6~20位字母或者数字"];
    }else{
        [self registerHandle];
    }
}

- (IBAction)loginButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)touchDownAction:(id)sender {
    [self.userNameTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.repeatPasswordTextField resignFirstResponder];
    
    self.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
      
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    self.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect frame=self.registerButton.frame;
    int offset=frame.origin.y+36-(self.view.frame.size.height-216);
    NSTimeInterval animationDuration=0.36f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    if (offset>0) {
        self.view.frame=CGRectMake(0,-offset, self.view.frame.size.width,self.view.frame.size.height);
        [UIView commitAnimations];
    }
    
}

#pragma  mark validate methods

-(BOOL)isValidateEmail:(NSString *)email{
    NSString *emailRegex = @"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

-(BOOL)isValidatePassword:(NSString *)password{
    NSString *passwordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordTest evaluateWithObject:password];
}

-(void)showErrorMessage:(NSString *)msg{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

-(void)registerHandle{
    NSString *username=self.userNameTextField.text;
    NSString *password=self.passwordTextField.text;
    NSString *email=self.emailTextField.text;
    NSString *gbid=@"G2015020230";
    
    self.registerRequest = [[GHRegisterRequest alloc]init];
    [self.registerRequest sendRegisterRequestWithUserName:username email:email password:password gbid:gbid delegate:self];
}

#pragma Mark GHRegisterRequestDeleage

- (void)registerRequestSuccess:(GHRegisterRequest *)request user:(GHUserModel *)user {
    if ([user.registerReturnMessage isEqualToString:@"Register success"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                       message:@"注册成功，请登录"
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        [alert show];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)registerRequestFailed:(GHRegisterRequest *)request error:(NSError *)error {
    NSLog(@"注册错误原因：%@", error);
}

@end
