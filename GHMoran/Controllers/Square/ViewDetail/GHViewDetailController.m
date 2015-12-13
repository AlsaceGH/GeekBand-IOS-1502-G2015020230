//
//  GHViewDetailController.m
//  GHMoran
//
//  Created by alsace on 12/3/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import "GHViewDetailController.h"
#import "GHGlobal.h"
#import "GHViewDetailRequest.h"
#import "GHViewDetailModel.h"
#import "GHCommentListCell.h"
@interface GHViewDetailController ()
{
    UIActivityIndicatorView *activity;
    UITableView *_tableView;
}
@end

@implementation GHViewDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    activity=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    CGFloat width=self.view.frame.size.width/2;
    [activity setCenter:CGPointMake(width, 160)];
    [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:activity];
    [activity startAnimating];
    self.photoImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.pic_url]]];
    [activity startAnimating];
    NSString *token = [GHGlobal shareGlobal].user.token;
    NSString *userId = [GHGlobal shareGlobal].user.userId;
    NSDictionary *dic = @{@"user_id":userId, @"token":token, @"pic_id":self.pic_id};
    
    GHViewDetailRequest *request = [[GHViewDetailRequest alloc]init];
    [request sendViewDetailRequest:dic delegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark---viewDetailRequest delegate
- (void)viewDetailRequestSuccess:(GHViewDetailRequest *)request data:(NSArray *)data {
    [activity stopAnimating];
    self.commentArr = data;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.photoImage.frame.size.height+self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)viewDetailRequestFailed:(GHViewDetailRequest *)request error:(NSError *)error {
    [activity stopAnimating];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.commentArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIndentifier";
    GHCommentListCell *cell = (GHCommentListCell *)[_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[GHCommentListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    GHViewDetailModel *model = self.commentArr[indexPath.row];
    cell.textOfComment.text = model.comment;
    cell.dateOfComment.text = model.modified;
    return cell;
}

@end
