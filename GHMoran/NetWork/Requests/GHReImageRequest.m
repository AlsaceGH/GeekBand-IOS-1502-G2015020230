//
//  GHReImageRequest.m
//  GHMoran
//
//  Created by alsace on 11/25/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import "GHReImageRequest.h"
#import "GHGlobal.h"
#import "BLMultipartForm.h"

@implementation GHReImageRequest
-(void)sendReImageRequestWithImage:(UIImage *)image
                        delegate:(id<GHReImageRequestDelegate>)delegate
{
    [self.urlConnection cancel];
    
    self.delegate = delegate;
    NSData *data=UIImageJPEGRepresentation(image, 0.000001);
    // POST
    NSString *urlString = @"http://moran.chinacloudapp.cn/moran/web/user/avatar";
    NSString *encodedUrlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:encodedUrlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 60;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    BLMultipartForm *form = [[BLMultipartForm alloc]init];
    [form addValue:[GHGlobal shareGlobal].user.userId forField:@"user_id"];
    [form addValue:[GHGlobal shareGlobal].user.token forField:@"token"];
    [form addValue:data forField:@"data"];
    request.HTTPBody = [form httpBody];
    [request setValue:form.contentType forHTTPHeaderField:@"Content-Type"];
    self.urlConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
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
    NSString *result = [[NSString alloc]initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", result);
    if ([_delegate respondsToSelector:@selector(reimageRequestSuccess:)]) {
        [_delegate reimageRequestSuccess:self];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
    if ([_delegate respondsToSelector:@selector(reimageRequestFailed:error:)]) {
        [_delegate reimageRequestFailed:self error:error];
    }
}


@end
