//
//  GHLocationParser.h
//  GHMoran
//
//  Created by alsace on 12/2/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHLocationModel.h"

@interface GHLocationParser : NSObject
- (GHLocationModel *)parseJson:(NSData *)data;
@end
