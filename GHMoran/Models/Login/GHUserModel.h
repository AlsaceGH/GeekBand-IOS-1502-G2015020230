//
//  GHUserModel.h
//  GHMoran
//
//  Created by alsace on 11/1/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GHUserModel : NSObject

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *loginReturnMessage;
@property (nonatomic, copy) NSString *registerReturnMessage;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, strong) UIImage *image;

@end
