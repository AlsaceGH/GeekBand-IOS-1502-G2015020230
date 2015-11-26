//
//  GHMyViewController.m
//  GHMoran
//
//  Created by alsace on 11/24/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import "GHMyViewController.h"
#import "GHGlobal.h"
#import "AppDelegate.h"

@interface GHMyViewController ()

@end

@implementation GHMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:237/255.0 green:127/255.0 blue:74/255.0 alpha:1.0f];
    
    self.headImageView.layer.cornerRadius=self.headImageView.frame.size.width/2.0f;
    self.headImageView.clipsToBounds=YES;
    
}
-(void)viewDidAppear:(BOOL)animated{
    self.userNameLabel.text=[GHGlobal shareGlobal].user.username;
    self.emailLabel.text=[GHGlobal shareGlobal].user.email;
    self.headImageView.image=[GHGlobal shareGlobal].user.image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma MARK TableView Data Source methods

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat header;
    if (section==0) {
        header=13.0;
    }else if(section==1){
        header=10;
    }
    return header;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if(indexPath.row==2){// log out
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"确定注销吗？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *enterAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                [self dismissViewControllerAnimated:YES completion:nil];
                [GHGlobal shareGlobal].user=nil;
                AppDelegate *appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
                [appDelegate loadLoginView];
            }];
            
            UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:enterAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
