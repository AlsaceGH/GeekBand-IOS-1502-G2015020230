//
//  GHViewDetailModel.h
//  GHMoran
//
//  Created by alsace on 12/3/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GHViewDetailModel : NSObject
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *modified;

- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key;
@end
