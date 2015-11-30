//
//  GHSquareCellTableViewCell.h
//  GHMoran
//
//  Created by alsace on 11/26/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHSquareViewController.h"
#import "UIImageView+WebCache.h"


@interface GHSquareCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)GHSquareViewController *squareVC;

@property(nonatomic,strong)NSArray *dataArr;


@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end
