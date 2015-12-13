//
//  GHViewDetailController.h
//  GHMoran
//
//  Created by alsace on 12/3/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHViewDetailController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;

@property (nonatomic,copy) NSString *pic_id;
@property (nonatomic,copy) NSString *pic_url;
@property (nonatomic,strong)NSArray *commentArr;
@end
