//
//  GHCommentListCell.h
//  GHMoran
//
//  Created by alsace on 12/3/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHCommentListCell : UITableViewCell
@property(nonatomic,retain)UILabel *usernameOfComment;
@property(nonatomic,retain)UILabel *textOfComment;
@property(nonatomic,retain)UIImageView *headImageOfComment;
@property(nonatomic,retain)UILabel *dateOfComment;
@end
