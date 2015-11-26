//
//  GHLoginRequest.h
//  GHMoran
//
//  Created by alsace on 11/1/15.
//  Copyright © 2015 GH. All rights reserved.
//


#import "GHUserModel.h"
#import <Foundation/Foundation.h>
@class GHLoginRequest;

@protocol GHLoginRequestDelegate <NSObject>

- (void)loginRequestSuccess:(GHLoginRequest *)request user:(GHUserModel *)user;
- (void)loginRequestFailed:(GHLoginRequest *)request error:(NSError *)error;

@end

@interface GHLoginRequest : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, assign) id<GHLoginRequestDelegate> delegate;

- (void)sendLoginRequestWithEmail:(NSString *)email
                         password:(NSString *)password
                             gbid:(NSString *)gbid
                         delegate:(id<GHLoginRequestDelegate>)delegate;

@end