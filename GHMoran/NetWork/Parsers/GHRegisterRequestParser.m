//
//  GHRegisterRequestParser.m
//  GHMoran
//
//  Created by alsace on 11/23/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import "GHRegisterRequestParser.h"

@implementation GHRegisterRequestParser

- (GHUserModel *)parseJson:(NSData *)data {
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data
                                                 options:NSJSONReadingAllowFragments
                                                   error:&error];
    if (error) {
        NSLog(@"parse is not work!");
    } else {
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            id returnMessage = [jsonDic valueForKey:@"message"];
            if ([[returnMessage class] isSubclassOfClass:[NSString class]]) {
                GHUserModel *user = [[GHUserModel alloc]init];
                user.registerReturnMessage = returnMessage;
                return user;
            }
        }
    }
    
    return nil;
}

@end
