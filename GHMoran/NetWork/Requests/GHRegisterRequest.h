//
//  GHRegisterRequest.h
//  GHMoran
//
//  Created by alsace on 11/23/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHUserModel.h"

@class GHRegisterRequest;
@protocol GHRegisterRequestDelegate <NSObject>

-(void)registerRequestSuccess:(GHRegisterRequest *)request user:(GHUserModel *)user;
-(void)registerRequestFailed: (GHRegisterRequest *)request error:(NSError *)error;

@end


@interface GHRegisterRequest : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, strong)NSURLConnection *urlConnection;
@property(nonatomic,strong)NSMutableData *receivedData;

@property (nonatomic ,assign) id<GHRegisterRequestDelegate> delegate;

-(void)sendRegisterRequestWithUserName:(NSString *)username
                                 email:(NSString *)email
                              password:(NSString *) password
                                  gbid:(NSString *)  gbid
                              delegate:(id<GHRegisterRequestDelegate>)delegate;


@end
