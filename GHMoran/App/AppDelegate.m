//
//  AppDelegate.m
//  GHMoran
//
//  Created by alsace on 11/20/15.
//  Copyright © 2015 GH. All rights reserved.
//


#import "AppDelegate.h"
#import "GHLoginAndRegisterViewController.h"
#import "GHMyViewController.h"
#import "GHSquareCell.h"
#import "GHSquareViewController.h"
#import "GHPublishViewController.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
   
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
   
}

- (void)applicationWillTerminate:(UIApplication *)application {

}

//load login view for log off
- (void)loadLoginView {
    UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"GHLoginAndRegister" bundle:[NSBundle mainBundle]];
    GHLoginAndRegisterViewController *loginController = [loginStoryboard instantiateViewControllerWithIdentifier:@"LoginStoryboard"];
    
    [UIView transitionWithView:self.window
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{ self.window.rootViewController = loginController; }
                    completion:nil];

}

#pragma mark load view controller
-(void)loadMainViewWithController:(UIViewController *)controller{
    //square
    UIStoryboard *squareStoryboard=[UIStoryboard storyboardWithName:@"GHSquare" bundle:[NSBundle mainBundle]];
    GHSquareViewController *squareVC=[squareStoryboard instantiateViewControllerWithIdentifier:@"SquareStoryboard"];
   
    UINavigationController *nav1=[[UINavigationController alloc] initWithRootViewController:squareVC];
    nav1.navigationBar.barTintColor=[[UIColor alloc] initWithRed:230/255.0 green:106/255.0 blue:58/255.0 alpha:1];
    
    nav1.tabBarItem.title=@"广场";
    nav1.tabBarItem.image=[UIImage imageNamed:@"square"];
    
    //my
    UIStoryboard *myStoryboard=[UIStoryboard storyboardWithName:@"GHMy" bundle:[NSBundle mainBundle]];
    GHMyViewController *myVC=[myStoryboard instantiateViewControllerWithIdentifier:@"MyStoryboard"];
    
    myVC.tabBarItem.title=@"我的";
    myVC.tabBarItem.image=[UIImage imageNamed:@"my"];
    
    self.tabBarController=[[UITabBarController alloc] init];
    self.tabBarController.viewControllers=@[nav1,myVC];
  
    
    [UIView transitionWithView:self.window
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromBottom
                    animations:^{ self.window.rootViewController = self.tabBarController; }
                    completion:nil];

    
    //publish
     CGFloat viewwidth = [UIScreen mainScreen].bounds.size.width;
    UIButton *photoButton=[[UIButton alloc]initWithFrame:CGRectMake(viewwidth/2-60,-25,120,50)];
    [photoButton setImage:[UIImage imageNamed:@"publish"] forState:UIControlStateNormal];
    [photoButton addTarget:self action:@selector(photoButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarController.tabBar addSubview:photoButton];
    
}
-(void)addOrderView{
    UIActionSheet *sheet=[[UIActionSheet alloc]
                          initWithTitle:nil
                          delegate:self
                          cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [sheet showInView:self.tabBarController.view];
}

-(void)photoButtonClicked:(UIButton *)button{
    [self addOrderView];
}
// -(void)addOrderView:(UIButton *)button {
//    UIActionSheet *sheet=[[UIActionSheet alloc]
//                          initWithTitle:nil
//                          delegate:self
//                          cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
//    [sheet showInView:self.tabBarController.view];
//}
#pragma mark --UIAction delegate methods
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    self.pickerController=[[UIImagePickerController alloc] init];
    if (buttonIndex==0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.pickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
            
            self.pickerController.allowsEditing=NO;
            
            self.pickerController.delegate=self;
            
            [self.tabBarController  presentViewController:self.pickerController animated:YES completion:nil];
            
        }else{
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误" message:@"无法获取照相机" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
            return;
        }
    }else if( buttonIndex==1){
        self.pickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        self.pickerController.delegate=self;
        [self.tabBarController presentViewController:self.pickerController animated:YES completion:nil];
    }
}
#pragma MARK --UIImagePickerController delegate method
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image=info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    int tag=0;
    if(self.pickerController.sourceType==UIImagePickerControllerSourceTypePhotoLibrary){
        tag=2;
    }else{
        tag=1;
    }
        UIStoryboard *story=[UIStoryboard storyboardWithName:@"GHPublish" bundle:nil];
        GHPublishViewController *publish=[story instantiateViewControllerWithIdentifier:@"CMJ"];
        UINavigationController *navigationController=[[UINavigationController alloc] initWithRootViewController:publish];
    
        publish.publishPhoto=image;
        publish.tag=tag;
        [self.tabBarController presentViewController:navigationController
                                            animated:YES
                                          completion:^{self.pickerController=nil;}];
        
//    }
}

@end
