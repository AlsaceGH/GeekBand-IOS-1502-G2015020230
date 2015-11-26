//
//  GHFollowUsAndHomePageViewController.m
//  GHMoran
//
//  Created by alsace on 11/24/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import "GHFollowUsAndHomePageViewController.h"

@interface GHFollowUsAndHomePageViewController ()

@end

@implementation GHFollowUsAndHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showHomePage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)showHomePage{
    NSString *urlString=@"http://geekband.com";
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

@end
