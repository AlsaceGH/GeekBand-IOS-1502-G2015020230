//
//  GHSquareRequest.h
//  GHMoran
//
//  Created by alsace on 11/26/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHSquareModel.h"
@class GHSquareRequest;
@protocol GHSquareRequestDelegate <NSObject>

-(void)squareRequestSuccess:(GHSquareRequest *)request dictionary:(NSDictionary *)dictionary;

-(void)squareRequestSuccess:(GHSquareRequest *)request squareModel:(GHSquareModel *)squareModel;
-(void)squareRequestFailed:(GHSquareRequest *)request error:(NSError *)error;


@end
@interface GHSquareRequest : NSObject<NSURLConnectionDataDelegate>

@property(nonatomic,strong) NSURLConnection *urlConnection;
@property(nonatomic,strong) NSMutableData *receivedData;
@property(nonatomic,assign)id<GHSquareRequestDelegate>delegate;
-(void)sendSquareRequestWithParameter:(NSDictionary *)paramDic
                             delegate:(id<GHSquareRequestDelegate>) delegate;

@end
