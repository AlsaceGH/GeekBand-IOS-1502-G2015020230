//
//  GHSquareViewController.m
//  GHMoran
//
//  Created by alsace on 11/26/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import "GHSquareViewController.h"
#import "GHSquareRequest.h"
#import "GHGlobal.h"

@interface GHSquareViewController ()<GHSquareRequestDelegate>

@end

@implementation GHSquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.titleButton setTitle:@"全部" forState:UIControlStateNormal];
    self.titleButton.frame=CGRectMake(0, 0, 200, 35);
    [self.titleButton addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.titleButton setImage:[UIImage imageNamed:@"icon_arrow_dow"] forState:UIControlStateNormal];
    self.titleButton.imageEdgeInsets=UIEdgeInsetsMake(0, 133, 0, 0);
    self.titleButton.titleEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 40);
    
    self.navigationItem.titleView=self.titleButton;
    [self requestAllData];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestAllData{
    NSDictionary *paramDic=@{@"user_id":[GHGlobal shareGlobal].user.userId,@"token":[GHGlobal shareGlobal].user.token,@"longitude":@"121.47794",@"latitude":@"31.22516",@"distance":@"1000"};
    
    GHSquareRequest *squareRequest=[[GHSquareRequest alloc] init];
    [squareRequest sendSquareRequestWithParameter:paramDic delegate:self];
}

-(void)squareRequestSuccess:(GHSquareRequest *)request dictionary:(NSDictionary *)dictionary{
    self.addrArray=[NSMutableArray arrayWithArray:[dictionary allKeys]];
    self.dataDic=dictionary;
    [self.tableView reloadData];
}

-(void)squareRequestFailed:(GHSquareRequest *)request error:(NSError *)error{
    NSLog(@"square request error:%@",error);
}

@end
