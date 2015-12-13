//
//  GHViewDetailRequest.h
//  GHMoran
//
//  Created by alsace on 12/3/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GHViewDetailRequest;

@protocol GHViewDetailRequestDelegate <NSObject>

- (void)viewDetailRequestSuccess:(GHViewDetailRequest *)request data:(NSArray *)data;
- (void)viewDetailRequestFailed:(GHViewDetailRequest *)request error:(NSError *)error;

@end

@interface GHViewDetailRequest : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, assign) id<GHViewDetailRequestDelegate> delegate;

- (void)sendViewDetailRequest:(NSDictionary *)paramDic delegate:(id<GHViewDetailRequestDelegate>) delegate;


@end
