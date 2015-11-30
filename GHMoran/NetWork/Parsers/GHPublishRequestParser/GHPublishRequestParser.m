//
//  GHPublishRequestParser.m
//  GHMoran
//
//  Created by alsace on 11/30/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import "GHPublishRequestParser.h"

@implementation GHPublishRequestParser

- (GHPublishModel *)parseJson:(NSData *)data {
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        NSLog(@"Error in GHPublishRequestParser");
    } else {
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            id returnMessage = [jsonDic valueForKey:@"data"];
            id returnPic = [returnMessage valueForKey:@"pic_id"];
            if ([[returnPic class] isSubclassOfClass:[NSString class]]) {
                GHPublishModel *model = [[GHPublishModel alloc]init];
                model.picId = returnPic;
                return model;
            }
        }
    }
    
    return nil;
}
@end
