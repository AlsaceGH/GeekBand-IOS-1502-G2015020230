//
//  GHGlobal.h
//  GHMoran
//
//  Created by alsace on 11/1/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHUserModel.h"

@interface GHGlobal : NSObject

@property (nonatomic, strong)GHUserModel *user;

+ (GHGlobal *)shareGlobal;

@end
