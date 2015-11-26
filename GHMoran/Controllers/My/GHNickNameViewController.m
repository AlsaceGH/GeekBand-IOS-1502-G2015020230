//
//  GHNickNameViewController.m
//  GHMoran
//
//  Created by alsace on 11/24/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import "GHNickNameViewController.h"
#import "GHGlobal.h"

@interface GHNickNameViewController ()

@end

@implementation GHNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}


- (IBAction)doneButtonClicked:(id)sender {
    GHReNameRequest *reNameRequest=[[GHReNameRequest alloc] init];
    [reNameRequest sendReNameRequestWithName:self.nickNameTextField.text delegate:self];
}

#pragma mark reNameRequest delegate methods

-(void)renameRequestSuccess:(GHReNameRequest *)request{
    [GHGlobal shareGlobal].user.username=self.nickNameTextField.text;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)renameRequestFailed:(GHReNameRequest *)request error:(NSError *)error{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
