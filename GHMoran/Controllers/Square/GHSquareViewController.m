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
#import "GHSquareCell.h"
#import "MJRefresh.h"
#import "GHViewDetailController.h"


@interface GHSquareViewController ()<GHSquareRequestDelegate>{
    
}

@end

@implementation GHSquareViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //location manager
    self.locationDic=[NSMutableDictionary dictionary];
    self.locationManager=[[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    self.locationManager.distanceFilter=1000.0f;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
        [_locationManager requestWhenInUseAuthorization];
        if ([CLLocationManager locationServicesEnabled]) {
            [self.locationManager startUpdatingLocation];
        }else{
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误" message:@"定位失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [alert show];
        }
    }
    
    
    self.titleButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.titleButton setTitle:@"全部" forState:UIControlStateNormal];
    self.titleButton.frame=CGRectMake(0, 0, 200, 35);
    [self.titleButton addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.titleButton setImage:[UIImage imageNamed:@"icon_arrow_dow"] forState:UIControlStateNormal];
    self.titleButton.imageEdgeInsets=UIEdgeInsetsMake(0, 133, 0, 0);
    self.titleButton.titleEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 40);
    
    self.navigationItem.titleView=self.titleButton;
    
    //MJRefresh
    self.tableView.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
            [self.tableView.header endRefreshing];
            NSString *title=self.titleButton.titleLabel.text;
          
            if([title isEqualToString: @"全部"]){
                    [self requestAllData];
            }
            if([title isEqualToString: @"附近500m"]){
                [self request500meterData];
            }
            if([title isEqualToString: @"附近1000m"]){
                [self request1000meterData];
            }
            if([title isEqualToString: @"附近15000m"]){
                [self request1500meterData];
            }
        });
    }];

    self.tableView.header.automaticallyChangeAlpha=YES;
    //footer refresh
    self.tableView.footer=[MJRefreshBackFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
            [self.tableView.footer endRefreshing];
            
        });
    }];
    
    [self requestAllData];
 
}

-(void)toCheckPicture{
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"GHViewDetail" bundle:nil];
    
    GHViewDetailController *detailVC=[story instantiateViewControllerWithIdentifier:@"ViewDetailStoryboard"];
    [detailVC.photoImage sd_setImageWithURL:[NSURL URLWithString:_pic_link]];
    detailVC.pic_id=_pic_id;
    detailVC.pic_url=_pic_link;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---request data
-(void)requestAllData{
    NSDictionary *paramDic=@{@"user_id":[GHGlobal shareGlobal].user.userId,@"token":[GHGlobal shareGlobal].user.token,@"longitude":@"121.47794",@"latitude":@"31.22516",@"distance":@"1000"};
    
    GHSquareRequest *squareRequest=[[GHSquareRequest alloc] init];
    [squareRequest sendSquareRequestWithParameter:paramDic delegate:self];
    [self.titleButton setTitle:@"全部" forState:UIControlStateNormal];
}
- (void)request500meterData {
    NSDictionary *paramDic = @{@"user_id":[GHGlobal shareGlobal].user.userId, @"token":[GHGlobal shareGlobal].user.token,
                               @"longitude":@"121.47794", @"latitude":@"31.22516", @"distance":@"500"};
    GHSquareRequest *squareRequest = [[GHSquareRequest alloc]init];
    [squareRequest sendSquareRequestWithParameter:paramDic delegate:self];
     [self.titleButton setTitle:@"附近500米" forState:UIControlStateNormal];
}

- (void)request1000meterData {
    NSDictionary *paramDic = @{@"user_id":[GHGlobal shareGlobal].user.userId, @"token":[GHGlobal shareGlobal].user.token,
                               @"longitude":@"121.47794", @"latitude":@"31.22516", @"distance":@"1000"};
    GHSquareRequest *squareRequest = [[GHSquareRequest alloc]init];
    [squareRequest sendSquareRequestWithParameter:paramDic delegate:self];
    [self.titleButton setTitle:@"附近1000米" forState:UIControlStateNormal];
}

- (void)request1500meterData {
    NSDictionary *paramDic = @{@"user_id":[GHGlobal shareGlobal].user.userId, @"token":[GHGlobal shareGlobal].user.token,
                               @"longitude":@"121.47794", @"latitude":@"31.22516", @"distance":@"1500"};
    GHSquareRequest *squareRequest = [[GHSquareRequest alloc]init];
    [squareRequest sendSquareRequestWithParameter:paramDic delegate:self];
    [self.titleButton setTitle:@"附近1500米" forState:UIControlStateNormal];
}
-(void)titleButtonClicked:(UIButton *) button{
    NSArray *menuItems = @[
                           [KxMenuItem menuItem:@"显示全部"
                                          image:nil
                                         target:self
                                         action:@selector(requestAllData)],
                           [KxMenuItem menuItem:@"附近500米"
                                          image:nil
                                         target:self
                                         action:@selector(request500meterData)],
                           [KxMenuItem menuItem:@"附近1000米"
                                          image:nil
                                         target:self
                                         action:@selector(request1000meterData)],
                           
                           [KxMenuItem menuItem:@"附近1500米"
                                          image:nil
                                         target:self
                                         action:@selector(request1500meterData)],
                           ];
    
    UIButton *btn = (UIButton *)button;
    CGRect editImageFrame = btn.frame;
    UIView *targetSuperView = btn.superview;
    CGRect rect = [targetSuperView convertRect:editImageFrame toView:[[UIApplication sharedApplication] keyWindow]];
    
    [KxMenu showMenuInView:[[UIApplication sharedApplication] keyWindow] fromRect:rect menuItems:menuItems];
}

#pragma mark---tableView delegate method
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"addrArr:%zd",self.addrArray.count);
    return self.addrArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GHSquareCell *cell=[tableView dequeueReusableCellWithIdentifier:@"squareCell" forIndexPath:indexPath];
    if (!cell) {
        cell=[[GHSquareCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"square"];
    }
    GHSquareModel *squareModel=self.addrArray[indexPath.row][0];
    cell.squareVC=self;
    cell.locationLabel.text=squareModel.addr;
    cell.dataArr = self.dataDic[self.addrArray[indexPath.row]];
    cell.collectionView.delegate=cell;
    cell.collectionView.dataSource=cell;
    
    [cell.collectionView reloadData];
    return cell;
    
}
#pragma mark --square request delegate  method

-(void)squareRequestSuccess:(GHSquareRequest *)request dictionary:(NSDictionary *)dictionary{
    self.addrArray=[NSMutableArray arrayWithArray:[dictionary allKeys]];
    self.dataDic=dictionary;
    [self.tableView reloadData];
}

-(void)squareRequestFailed:(GHSquareRequest *)request error:(NSError *)error{
    NSLog(@"square request error:%@",error);
}


#pragma  Mark--location manager delegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"==latitude %f, longitude %f",
          [[locations objectAtIndex:([locations count]-1)] coordinate].latitude ,
          [[locations objectAtIndex:([locations count]-1)] coordinate].longitude);
    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    //get location lontitude and latitude
    self.locationDic=[NSMutableDictionary dictionary];
    NSLog(@"维度:%f",newLocation.coordinate.latitude);
    NSLog(@"经度:%f",newLocation.coordinate.latitude);
    NSString *latitude=[NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
    NSString *longitude=[NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
    
    [self.locationDic setValue:latitude forKey:@"latitude"];
    [self.locationDic setValue:longitude forKey:@"longitude"];
    
    CLLocationDegrees latitude2=newLocation.coordinate.latitude;
    CLLocationDegrees longitude2=newLocation.coordinate.longitude;
    
    CLLocation *c=[[CLLocation alloc] initWithLatitude:latitude2 longitude:longitude2];
    
    //create location
    CLGeocoder *revGeo=[[CLGeocoder alloc] init];
    [revGeo reverseGeocodeLocation:c completionHandler:^(NSArray *placemarks,NSError *error){
        if(!error&&[placemarks count]>0){
            NSDictionary *dict=[[placemarks objectAtIndex:0] addressDictionary];
            NSLog(@"street address:%@",[dict objectForKey:@"Street"]);
            [self.locationDic setValue:dict[@"Name"] forKey:@"location"];
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
@end
