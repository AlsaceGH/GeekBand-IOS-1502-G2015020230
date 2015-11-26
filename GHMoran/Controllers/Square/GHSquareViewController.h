//
//  GHSquareViewController.h
//  GHMoran
//
//  Created by alsace on 11/26/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHSquareViewController : UIViewController

@property (nonatomic,strong) NSMutableArray *addrArray;
@property (nonatomic,strong) NSDictionary *dataDic;
@property (nonatomic, strong) UIButton *titleButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
