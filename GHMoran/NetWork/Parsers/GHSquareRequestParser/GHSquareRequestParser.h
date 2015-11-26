//
//  GHSquareRequestParser.h
//  GHMoran
//
//  Created by alsace on 11/26/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GHSquareRequestParser : NSObject

-(NSDictionary *)parseJson:(NSData *)data;

@property (nonatomic,strong) NSMutableArray *addrArray;
@property (nonatomic,strong) NSMutableArray *pictureArray;

@end
