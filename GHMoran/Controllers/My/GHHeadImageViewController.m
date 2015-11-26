//
//  GHHeadImageViewController.m
//  GHMoran
//
//  Created by alsace on 11/24/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import "GHHeadImageViewController.h"
#import "GHGlobal.h"
#import "GHPublishViewController.h"

@interface GHHeadImageViewController ()<UIImagePickerControllerDelegate>

@end

@implementation GHHeadImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headImageView.image=[GHGlobal shareGlobal].user.image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)doneBarButtonClicked:(id)sender {
    GHReImageRequest  *request=[[GHReImageRequest alloc] init];
    [request sendReImageRequestWithImage:self.headImageView.image delegate:self];
}

- (IBAction)addOrderView:(id)sender {
    UIActionSheet *sheet=[[UIActionSheet alloc]
                          initWithTitle:nil
                          delegate:self
                          cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [sheet showInView:self.tabBarController.view];
}
#pragma mark --UIAction delegate methods
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    self.pickerController=[[UIImagePickerController alloc] init];
    if (buttonIndex==0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.pickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
            self.pickerController.allowsEditing=NO;
            
            self.pickerController.delegate=self;
            [self.tabBarController  presentViewController:self.pickerController animated:YES completion:nil];
            
        }else{
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误" message:@"无法获取照相机" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
            return;
        }
    }else if( buttonIndex==1){
        self.pickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        self.pickerController.delegate=self;
        [self.tabBarController presentViewController:self.pickerController animated:YES completion:nil];
    }
}
#pragma MARK --UIImagePickerController delegate method
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image=info[UIImagePickerControllerOriginalImage];
    CGSize imagesize=image.size;
    imagesize.height=626;
    imagesize.width=413;
    image=[self imageWithImage:image scaleToSize:imagesize];
    self.headImageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    if(self.pickerController.sourceType==UIImagePickerControllerSourceTypePhotoLibrary){
        UIStoryboard *story=[UIStoryboard storyboardWithName:@"GHPublish" bundle:nil];
        GHPublishViewController *publish=[story instantiateViewControllerWithIdentifier:@"CMJ"];
        UINavigationController *navigationController=[[UINavigationController alloc] initWithRootViewController:publish];
       // publish.tag=2;
        publish.publishPhoto=image;
        [picker presentViewController:navigationController animated:YES completion:nil];
        
    }
}

- (UIImage *)imageWithImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size change the image to size
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

#pragma mark reImage delegate methods

-(void)reimageRequestSuccess:(GHReImageRequest *)request{
    [GHGlobal shareGlobal].user.image=self.headImageView.image;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)reimageRequestFailed:(GHReImageRequest *)request error:(NSError *)error{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
