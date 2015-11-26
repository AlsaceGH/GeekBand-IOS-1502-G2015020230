
//
//  GHRegisterRequestParser.h
//  GHMoran
//
//  Created by alsace on 11/23/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHUserModel.h"

@interface GHRegisterRequestParser : NSObject
-(GHUserModel *)parseJson:(NSData *)data;
@end
