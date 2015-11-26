//
//  GHSquareRequestParser.m
//  GHMoran
//
//  Created by alsace on 11/26/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import "GHSquareRequestParser.h"
#import "GHSquareModel.h"
#import "GHPictureModel.h"


@implementation GHSquareRequestParser

@synthesize addrArray,pictureArray;


-(NSDictionary *)parseJson:(NSData *)data{
    NSError *error=nil;
    id jsonDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSMutableDictionary *dictionary=[NSMutableDictionary dictionary];
    if (error) {
        NSLog(@"The Square request parser is nor working.");
    }else{
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            id data=[[jsonDic valueForKey:@"data"] allValues];
            for(id dic in data) {
                self.addrArray=[NSMutableArray array];
                self.pictureArray=[NSMutableArray array];
                GHSquareModel *squareModel=[[GHSquareModel alloc] init];
                [squareModel setValuesForKeysWithDictionary:dic[@"node"]];
                for (id picDictionary in dic[@"pic"]) {
                    GHPictureModel *pictureModel=[[GHPictureModel alloc] init];
                    [pictureModel setValuesForKeysWithDictionary:picDictionary];
                    [self.pictureArray addObject:pictureModel];
                }
                [self.addrArray addObject:squareModel];
                [dictionary setObject:pictureArray forKey:addrArray];
            }
        }
    }
    return dictionary;
}

@end
