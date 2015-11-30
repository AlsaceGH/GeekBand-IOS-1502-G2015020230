//
//  GHPublishRequestParser.h
//  GHMoran
//
//  Created by alsace on 11/30/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHPublishModel.h"

@interface GHPublishRequestParser : NSObject
- (GHPublishModel *)parseJson:(NSData *)data;
@end
