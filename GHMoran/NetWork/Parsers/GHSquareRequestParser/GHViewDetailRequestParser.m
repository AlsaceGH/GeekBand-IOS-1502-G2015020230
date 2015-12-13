//
//  GHViewDetailRequestParser.m
//  GHMoran
//
//  Created by alsace on 12/3/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import "GHViewDetailRequestParser.h"
#import "GHViewDetailModel.h"

@implementation GHViewDetailRequestParser
- (NSArray *)parseJson:(NSData *)data {
    NSError *error = nil;
    NSMutableArray *array = nil;
    
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        NSLog(@"GHViewDetailRequestParser");
    } else {
        if ([[jsonDic class]isSubclassOfClass:[NSDictionary class]]) {
            array = [[NSMutableArray alloc]init];
            id data = [jsonDic valueForKey:@"data"];
            for (id dic in data) {
                GHViewDetailModel *model = [[GHViewDetailModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [array addObject:model];
            }
        }
    }
    
    return array;
}
@end
