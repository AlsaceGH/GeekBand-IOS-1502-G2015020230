//
//  GHReNameRequest.h
//  GHMoran
//
//  Created by alsace on 11/25/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GHReNameRequest;
@protocol GHReNameRequestDelegate <NSObject>

-(void)renameRequestSuccess:(GHReNameRequest *)request;
-(void)renameRequestFailed:(GHReNameRequest *)request error:(NSError *)error;

@end

@interface GHReNameRequest : NSObject<NSURLConnectionDataDelegate>

@property(nonatomic,strong) NSURLConnection *urlConnection;
@property(nonatomic,strong) NSMutableData *receivedData;

@property (nonatomic, assign) id<GHReNameRequestDelegate> delegate;

-(void)sendReNameRequestWithName:(NSString *)name
                        delegate:(id<GHReNameRequestDelegate>)delegate;

@end
