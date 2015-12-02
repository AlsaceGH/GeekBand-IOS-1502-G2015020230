//
//  GHLocationParser.m
//  GHMoran
//
//  Created by alsace on 12/2/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import "GHLocationParser.h"
#import "GHLocationModel.h"

@implementation GHLocationParser
- (GHLocationModel *)parseJson:(NSData *)data {
    NSError *error=nil;
    id jsonDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    GHLocationModel *model=[[GHLocationModel alloc]init];
    model.nameArray=[NSMutableArray array];
    model.addrArray=[NSMutableArray array];
    if (error) {
        NSLog(@"The Square request parser is nor working.");
    }else{
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            id data=[jsonDic valueForKey:@"addrList"];
            for(id dic in data) {
                if([dic[@"name"] length]>0&&[dic[@"addr"] length]>0){
                    [model.nameArray addObject:dic[@"name"]];
                    [model.addrArray addObject:dic[@"addr"]];
                }
                
                }
            }
        }
        return model;
    }
@end
