//
//  GHGetImage.m
//  GHMoran
//
//  Created by alsace on 11/25/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import "GHGetImage.h"
#import "BLMultipartForm.h"
#import "GHGlobal.h"

@implementation GHGetImage

- (void)sendGetImageRequest{
    [self.connection cancel];
    
  
    NSString *urlString = @"http://moran.chinacloudapp.cn/moran/web/user/show";
    
    urlString=[NSString stringWithFormat:@"%@?user_id=%@",urlString,[GHGlobal shareGlobal].user.userId];
    NSString *encodeString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:encodeString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    request.HTTPMethod = @"GET";
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    request.timeoutInterval = 60;
    self.connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
}

#pragma Mark NSURLConnectionDataDelegate

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
    [GHGlobal shareGlobal].user.image = [[UIImage alloc]initWithData:self.receivedData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"error: %@", error);
}
@end
