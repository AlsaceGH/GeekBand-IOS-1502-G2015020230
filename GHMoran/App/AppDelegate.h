//
//  AppDelegate.h
//  GHMoran
//
//  Created by alsace on 11/20/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *loginViewController;
@property  (strong,nonatomic) UITabBarController *tabBarController;
-(void)loadMainViewWithController:(UIViewController *)controller;

- (void)loadLoginView;


@end

