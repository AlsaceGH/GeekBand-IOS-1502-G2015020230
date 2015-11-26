//
//  GHNickNameViewController.h
//  GHMoran
//
//  Created by alsace on 11/24/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHReNameRequest.h"

@interface GHNickNameViewController : UIViewController<GHReNameRequestDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
- (IBAction)doneButtonClicked:(id)sender;

@end
