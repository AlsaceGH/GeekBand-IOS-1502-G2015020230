//
//  GHPublishViewController.h
//  GHMoran
//
//  Created by alsace on 11/25/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface GHPublishViewController : UIViewController<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>

@property (nonatomic,strong)UIImage *publishPhoto;
@property (nonatomic,strong)UIImagePickerController *imagePicker;
@property (nonatomic)int tag;
@property (nonatomic,strong)NSDictionary *dic;
@property (retain, nonatomic) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) UIControl *blackView;
- (IBAction)touchDown:(id)sender;
- (IBAction)publishLocation:(id)sender;
- (IBAction)returnToCamera:(id)sender;

@end
