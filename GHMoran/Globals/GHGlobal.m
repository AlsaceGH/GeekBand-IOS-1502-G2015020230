//
//  GHGlobal.m
//  GHMoran
//
//  Created by alsace on 11/1/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import "GHGlobal.h"

static GHGlobal *global = nil;

@implementation GHGlobal

+ (GHGlobal *)shareGlobal {
    if (global == nil) {
        global = [[GHGlobal alloc]init];
    }
    return global;
}

@end
