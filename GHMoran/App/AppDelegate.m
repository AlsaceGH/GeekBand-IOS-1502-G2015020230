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
#import "GHSquareCellTableViewCell.h"
#import "GHSquareViewController.h"


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
    
    //[controller presentViewController:self.tabBarController animated:YES completion:nil];
    
//    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionTransitionFlipFromRight
//                     animations:^{self.loginViewController=nil;} completion:nil];
    
    [UIView transitionWithView:self.window
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromBottom
                    animations:^{ self.window.rootViewController = self.tabBarController; }
                    completion:nil];
//
//    [UIView animateKeyframesWithDuration:0.5 delay:0.1
//                                 options:uiv animations:UIViewAnimationOptionTransitionFlipFromLeft
//                              completion:0.3
//       options:UIViewAnimationOptionTransitionFlipFromLeft
//                     animations:^{
//                         self.loginViewController.view.alpha=0;
//                     }
//                     completion:^(BOOL finished){
//                         self.loginViewController=nil;
//                     }];
    
    //publish
     CGFloat viewwidth = [UIScreen mainScreen].bounds.size.width;
    UIButton *photoButton=[[UIButton alloc]initWithFrame:CGRectMake(viewwidth/2-60,-25,120,50)];
    [photoButton setImage:[UIImage imageNamed:@"publish"] forState:UIControlStateNormal];
    [photoButton addTarget:self action:@selector(addOrderView) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarController.tabBar addSubview:photoButton];
    
}


@end
