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
#import <CoreLocation/CoreLocation.h>
#import "GHLocationModel.h"
#import "GHLocationParser.h"

#define selfWidth self.view.frame.size.width
#define selfHeight self.view.frame.size.height
@interface GHPublishViewController ()<GHPublishRequestDelegate>{
    BOOL openOrNot;
    BOOL locationOrNot;
    UIActivityIndicatorView  *activity;
    GHLocationModel *locationModel;
   
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
    [self getLatitudeAndLongitude];
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

-(void)getLatitudeAndLongitude{
    self.locationManager=[[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    self.locationManager.distanceFilter=kCLDistanceFilterNone;
    self.locationManager.delegate=self;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
        [_locationManager requestWhenInUseAuthorization];
    }
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation];
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误" message:@"定位失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
    }
}

#pragma  Mark--location manager delegate

//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
//    NSLog(@"==latitude %f, longitude %f",
//          [[locations objectAtIndex:([locations count]-1)] coordinate].latitude ,
//          [[locations objectAtIndex:([locations count]-1)] coordinate].longitude);
//    
//}



-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    //get location lontitude and latitude
    self.dic=[NSMutableDictionary dictionary];
    NSLog(@"维度:%f",newLocation.coordinate.latitude);
    NSLog(@"经度:%f",newLocation.coordinate.latitude);
    NSString *latitude=[NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
    NSString *longitude=[NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
    
    [self.dic setValue:latitude forKey:@"latitude"];
    [self.dic setValue:longitude forKey:@"longitude"];
    
    CLLocationDegrees latitude2=newLocation.coordinate.latitude;
    CLLocationDegrees longitude2=newLocation.coordinate.longitude;
    
    CLLocation *c=[[CLLocation alloc] initWithLatitude:latitude2 longitude:longitude2];
    
    //create location
    CLGeocoder *revGeo=[[CLGeocoder alloc] init];
    [revGeo reverseGeocodeLocation:c completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!error && [placemarks count] > 0) {
            NSDictionary *dict = [[placemarks objectAtIndex:0] addressDictionary];
            self.locationButton.titleLabel.text = dict[@"Name"];

        }else {
            NSLog(@"ERROR:%@",error);
        }
    }];
    //STOP update location
    [manager stopUpdatingLocation];
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"error:%@",error);
}
#pragma mark--get location from baidu apis
-(void)makeLocation{
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    NSBlockOperation *operation=[NSBlockOperation blockOperationWithBlock:^{
        NSString *latitude=[NSString stringWithFormat:@"l=%@",[self.dic valueForKey:@"latitude"]];
        NSString *str1=[latitude stringByAppendingString:@"%2C"];
        NSString *httpArg=[NSString stringWithFormat:@"%@%@",str1,[self.dic valueForKey:@"longitude"]];
        
        NSString *httpUrl=@"http://apis.baidu.com/3023/geo/address";
        [self requestApi:httpUrl withHttpArg:httpArg];
    }];
    [queue addOperation:operation];
}
-(void)requestApi:(NSString *)httpUrl withHttpArg:(NSString *)httpArg{
    
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"0216bcbfec0aa9cd49e41e09f0289d30" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                               } else {
                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   NSLog(@"HttpResponseCode:%ld", responseCode);
                                   NSLog(@"HttpResponseBody:%@",responseString);
                                   locationModel=[[GHLocationModel alloc] init];
                                   GHLocationParser *parser=[[GHLocationParser alloc] init];
                                   locationModel=[parser parseJson:data];
                                   locationOrNot=YES;
                                   [self makeTableView];
                               }
                           }];
    
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
    [self makeLocation];
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
    return locationModel.addrArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GHPublishCell *cell=[tableView dequeueReusableCellWithIdentifier:@"publishCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    cell.nameLabel.text=locationModel.nameArray[indexPath.row];
    cell.placeLabel.text=locationModel.addrArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 63;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.locationButton.titleLabel.text=locationModel.nameArray[indexPath.row];
    if (openOrNot==YES) {
        [self makeTableView];
    }
}


@end
