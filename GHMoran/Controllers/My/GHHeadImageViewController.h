//
//  GHHeadImageViewController.h
//  GHMoran
//
//  Created by alsace on 11/24/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHReImageRequest.h"

@interface GHHeadImageViewController : UIViewController<GHReImageRequestDelegate,UIActionSheetDelegate>

@property (nonatomic,strong)UIImagePickerController *pickerController;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

- (IBAction)doneBarButtonClicked:(id)sender;



- (IBAction)addOrderView:(id)sender;

@end
