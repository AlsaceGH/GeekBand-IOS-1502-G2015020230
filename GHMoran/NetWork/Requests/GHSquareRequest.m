//
//  GHSquareRequest.m
//  GHMoran
//
//  Created by alsace on 11/26/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import "GHSquareRequest.h"
#import "GHSquareModel.h"
#import "GHSquareRequestParser.h"

@implementation GHSquareRequest

-(void)sendSquareRequestWithParameter:(NSDictionary *)paramDic delegate:(id<GHSquareRequestDelegate>)delegate{
    [self.urlConnection cancel];
    self.delegate = delegate;
    
    NSString *urlString = [NSString stringWithFormat:@"http://moran.chinacloudapp.cn/moran/web/node/list?distance=%@&latitude=%@&longitude=%@&token=%@&user_id=%@", paramDic[@"distance"], paramDic[@"latitude"], paramDic[@"longitude"], paramDic[@"token"], paramDic[@"user_id"]];
    NSString *encodedURLString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encodedURLString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 60;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    self.urlConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    
}

#pragma MARK -- GHSquareRequestDelegate method

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode == 200) {
        self.receivedData = [NSMutableData data];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *result = [[NSString alloc]initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", result);
    
    GHSquareRequestParser *parser = [[GHSquareRequestParser alloc]init];
    if ([_delegate respondsToSelector:@selector(squareRequestSuccess:dictionary:)]) {
        [_delegate squareRequestSuccess:self dictionary:[parser parseJson:self.receivedData]];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"GHSquareRequest.Error: %@", error);
    if ([_delegate respondsToSelector:@selector(squareRequestFailed:error:)]) {
        [_delegate squareRequestFailed:self error:error];
    }
}

@end
