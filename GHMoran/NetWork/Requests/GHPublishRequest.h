//
//  GHPublishRequest.h
//  GHMoran
//
//  Created by alsace on 11/30/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GHPublishRequest;

@protocol GHPublishRequestDelegate <NSObject>

- (void)requestSuccess:(GHPublishRequest *)request picId:(NSString *)picId;
- (void)requestFailed:(GHPublishRequest *)request error:(NSError *)error;

@end

@interface GHPublishRequest : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, assign) id<GHPublishRequestDelegate> delegate;

- (void)sendPublishRequestWithUserId:(NSString *)userId
                               token:(NSString *)token
                           longitude:(NSString *)longitude
                            latitude:(NSString *)latitude
                               title:(NSString *)title
                                data:(NSData *)data
                            location:(NSString *)location
                            delegate:(id<GHPublishRequestDelegate>)delegate;
@end
