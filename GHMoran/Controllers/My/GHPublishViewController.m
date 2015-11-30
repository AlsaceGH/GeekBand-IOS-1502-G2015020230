//
//  GHPublishViewController.m
//  GHMoran
//
//  Created by alsace on 11/25/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import "GHPublishViewController.h"
#import "GHPublishCell.h"
#import "AppDelegate.h"
#import "GHPublishRequest.h"
#import "GHUserModel.h"
#import "GHGlobal.h"

#define selfWidth self.view.frame.size.width
#define selfHeight self.view.frame.size.height
@interface GHPublishViewController ()<GHPublishRequestDelegate>{
    BOOL openOrNot;
    UIActivityIndicatorView  *activity;
   
}

@end

@implementation GHPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photoView.image=self.publishPhoto;
    activity=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    CGFloat width=self.view.frame.size.width/2;
    [activity setCenter:CGPointMake(width, 160)];
    [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:activity];
    
    self.navigationController.navigationBar.backgroundColor=[[UIColor alloc] initWithRed:230/255.0 green:106/255.0 blue:58/255.0 alpha:1];
    
    self.navigationController.navigationBar.barTintColor=[[UIColor alloc] initWithRed:230/255.0 green:106/255.0 blue:58/255.0 alpha:1];
    self.textView.delegate=self;
    [self.navigationController.navigationBar setAlpha:1.0];
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-30, 10, 100, 30)];
    titleLabel.text=@"发布照片";
    titleLabel.textColor=[UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:titleLabel];
    
    // add publish button
    [self makePublishButton];
    [self makeBackButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma MARK----make back button
-(void)makeBackButton{
    UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
    self.navigationItem.leftBarButtonItem=cancelButton;
}
-(void)cancelAction:(id)sender{
    if (self.tag==1) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
       
    }else if(self.tag==2){
//        [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
//            [self.navigationController dismissViewControllerAnimated:NO completion:nil];
//        } completion:nil];
        
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
       // [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
-(void)makePublishButton{
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    button.frame=CGRectMake(self.view.frame.size.width-65, 0, 50, 40);
    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-65, 8, 50, 30)];
    
    button.backgroundColor=[UIColor whiteColor];
    button.alpha=0.8;
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(publishButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius=3.0;
    button.clipsToBounds=YES;
    [self.navigationController.navigationBar addSubview:button];
}

-(void)publishButtonClicked:(id)sender{
    if([self.textView.text isEqual:@"你想说的话"]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"请写上你的留言" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else{
        NSData *data=UIImageJPEGRepresentation(self.photoView.image, 0.000001);
        GHPublishRequest *request=[[GHPublishRequest alloc] init];
        GHUserModel *user=[GHGlobal shareGlobal].user;
        [request sendPublishRequestWithUserId:user.userId token:user.token longitude:[self.dic valueForKey:@"longitude"] latitude:[self.dic valueForKey:@"latitude"] title:self.textView.text data:data location:self.locationButton.titleLabel.text delegate:self];
       
        if([activity isAnimating]){
            [activity  stopAnimating];
        }
        [activity  startAnimating];
    }
}

#pragma mark ---publish request delegate
-(void)requestSuccess:(GHPublishRequest *)request picId:(NSString *)picId{
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
    if (self.tag==1) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        
    }else if(self.tag==2){
        //        [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        //            [self.navigationController dismissViewControllerAnimated:NO completion:nil];
        //        } completion:nil];
        
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        // [self.navigationController popToRootViewControllerAnimated:YES];
    }
     [activity  startAnimating];
    
}
-(void)requestFailed:(GHPublishRequest *)request error:(NSError *)error{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误" message:@"重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert show];
    [(UIActivityIndicatorView *)activity stopAnimating];
}
#pragma  MARK-- text view delegate method
-(void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length>25) {
        [self.textView resignFirstResponder];
    }
    self.numberLabel.text=[NSString stringWithFormat:@"%lu/25",textView.text.length];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    if([textView.text isEqualToString:@"你想说的话"]){
        textView.text=@"";  
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length<1) {
        textView.text=@"你想说的话";
    }
}

#pragma  mark----location and camera button event
- (IBAction)touchDown:(id)sender {
    [self.textView resignFirstResponder];
}

- (IBAction)publishLocation:(id)sender {
    [self makeTableView];
}

- (IBAction)returnToCamera:(id)sender {
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate addOrderView];
}

// make table view

-(void)makeTableView{
    if(!self.tableView){
        self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, selfHeight, selfWidth, 230) style:UITableViewStylePlain];
        [self.tableView setDataSource:self];
        [self.tableView setDelegate:self];
        [self.tableView setBackgroundColor:[UIColor whiteColor]];
        [self.tableView setSeparatorColor:[UIColor blackColor]];
        [self.tableView setShowsHorizontalScrollIndicator:NO];
        [self.tableView setShowsVerticalScrollIndicator:YES];
        [self.tableView registerNib:[UINib nibWithNibName:@"GHPublishCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"publishCell"];
        [self.view addSubview:self.tableView];
        openOrNot=NO;
    }
        if (openOrNot==NO) {
            _blackView=[[UIControl alloc] initWithFrame:CGRectMake(0, 0, selfWidth, selfHeight-230)];
            [_blackView addTarget:self action:@selector(blackViewTouchDown) forControlEvents:UIControlEventTouchDown];
            _blackView.backgroundColor=[UIColor blackColor];
            _blackView.alpha=0;
            [self.view addSubview:_blackView];
            [UIView animateWithDuration:0.5 animations:^{
                [self.tableView setFrame:CGRectMake(0, selfHeight-230, selfWidth, 230)];
                _blackView.alpha=0.5;
            }];
            openOrNot=YES;
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                [self.tableView setFrame:CGRectMake(0, selfHeight, selfWidth, 230)];
                _blackView.alpha=0;
            }];
            [_blackView removeFromSuperview];
            openOrNot=NO;
        }
}

-(void)blackViewTouchDown{
    if (openOrNot==YES) {
        [self makeTableView];
    }
}

#pragma  MARK---tableView delegate methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GHPublishCell *cell=[tableView dequeueReusableCellWithIdentifier:@"publishCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    cell.nameLabel.text=@"上海";
    cell.placeLabel.text=@"上海浦东国际金融中心";
    
    return cell;
}

-(CGFloat *)tableView:(UITableView *)tableView {
    return 63;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (openOrNot==YES) {
        [self makeTableView];
    }
}


@end
