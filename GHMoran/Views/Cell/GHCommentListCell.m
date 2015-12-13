//
//  GHCommentListCell.m
//  GHMoran
//
//  Created by alsace on 12/3/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import "GHCommentListCell.h"

@interface GHCommentListCell(){
    CGFloat _cellWidth;
}
@end
@implementation GHCommentListCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellWidth=[UIScreen mainScreen].bounds.size.width;
        
        _headImageOfComment=[[UIImageView alloc] initWithFrame:CGRectMake(12, 10, 40, 40)];
        _headImageOfComment.backgroundColor=[UIColor blueColor];
        _headImageOfComment.layer.cornerRadius=20;
        [self.contentView addSubview:_headImageOfComment];
        
         _usernameOfComment = [[UILabel alloc]initWithFrame:CGRectMake(12+60+9, 7, _cellWidth-24
        -60-18-100, 18)];
        _usernameOfComment.textColor = [UIColor blueColor];
        _usernameOfComment.font = [UIFont fontWithName:@"Heiti SC" size:14];
        [self.contentView addSubview:_usernameOfComment];
        
        _textOfComment = [[UILabel alloc]initWithFrame:CGRectMake(12+60+9, 30, _cellWidth-24-60-18, 18)];
        _textOfComment.textColor = [UIColor blueColor];
        _textOfComment.font = [UIFont fontWithName:@"Heiti SC" size:14];
        [self.contentView addSubview:_textOfComment];
        
        _dateOfComment = [[UILabel alloc]initWithFrame:CGRectMake(_cellWidth-90-24, 7, 90, 18)];
        _dateOfComment.textColor = [UIColor blueColor];
        _dateOfComment.font = [UIFont fontWithName:@"Heiti SC" size:14];
        [self.contentView addSubview:_dateOfComment];

    }
    return self;
}

@end
