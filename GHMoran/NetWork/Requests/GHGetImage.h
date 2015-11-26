//
//  GHGetImage.h
//  GHMoran
//
//  Created by alsace on 11/25/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHUserModel.h"

@interface GHGetImage : NSObject<NSURLConnectionDataDelegate>
@property (nonatomic,strong) NSURLConnection *connection;
@property (nonatomic,strong) NSMutableData *receivedData;

-(void)sendGetImageRequest;

@end
