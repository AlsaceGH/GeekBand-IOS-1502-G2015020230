//
//  GHViewDetailRequestParser.h
//  GHMoran
//
//  Created by alsace on 12/3/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GHViewDetailRequestParser : NSObject
- (NSArray *)parseJson:(NSData *)data;
@end
