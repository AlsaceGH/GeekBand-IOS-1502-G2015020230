//
//  GHReImageRequest.h
//  GHMoran
//
//  Created by alsace on 11/25/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GHReImageRequest;
@protocol GHReImageRequestDelegate <NSObject>
-(void)reimageRequestSuccess:(GHReImageRequest *)request;
-(void)reimageRequestFailed:(GHReImageRequest *)request error:(NSError *)error;

@end

@interface GHReImageRequest : NSObject<NSURLConnectionDataDelegate>
@property(nonatomic,strong) NSURLConnection *urlConnection;
@property(nonatomic,strong) NSMutableData *receivedData;

@property (nonatomic, assign) id<GHReImageRequestDelegate> delegate;

-(void)sendReImageRequestWithImage:(UIImage *)image
                        delegate:(id<GHReImageRequestDelegate>)delegate;

@end
