//
//  GHSquareViewController.h
//  GHMoran
//
//  Created by alsace on 11/26/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "KxMenu.h"

@interface GHSquareViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>

@property (nonatomic,strong) NSMutableArray *addrArray;
@property (nonatomic,strong) NSDictionary *dataDic;
@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic,strong) NSString *pic_link;
@property (nonatomic,strong) NSString *pic_id;
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) NSMutableDictionary *locationDic;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
