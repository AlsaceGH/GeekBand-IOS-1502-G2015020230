//
//  GHSquareCellTableViewCell.m
//  GHMoran
//
//  Created by alsace on 11/26/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import "GHSquareCell.h"
#import "GHSquareCollectionCell.h"
#import "GHPictureModel.h"


@implementation GHSquareCell

- (void)awakeFromNib {
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma MARK --Implement square cell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
    }
    return self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GHSquareCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    
    GHPictureModel *pictureModel=self.dataArr[indexPath.row];
    NSString *pic=pictureModel.pic_link;
    pic=[pic stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *pic_url=[ NSURL URLWithString:pic];

 
    [cell.pictureImageView sd_setImageWithURL:pic_url];
    cell.titleLabel.text=pictureModel.title;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%zd",indexPath.row);
    GHPictureModel *pictureModel=self.dataArr[indexPath.row];
    self.squareVC.pic_id=pictureModel.pic_id;
    self.squareVC.pic_link=pictureModel.pic_link;
    [self.squareVC toCheckPicture];
}
@end
