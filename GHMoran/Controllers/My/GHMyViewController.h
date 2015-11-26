//
//  GHMyViewController.h
//  GHMoran
//
//  Created by alsace on 11/24/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHMyViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@end
