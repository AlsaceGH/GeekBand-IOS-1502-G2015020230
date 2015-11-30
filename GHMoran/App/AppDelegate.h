//
//  AppDelegate.h
//  GHMoran
//
//  Created by alsace on 11/20/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *loginViewController;
@property  (strong,nonatomic) UITabBarController *tabBarController;

@property (nonatomic,strong)UIImagePickerController *pickerController;

-(void)loadMainViewWithController:(UIViewController *)controller;

- (void)loadLoginView;
-(void)addOrderView;


@end

