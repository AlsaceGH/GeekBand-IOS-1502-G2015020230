//
//  GHLoginRequest.m
//  GHMoran
//
//  Created by alsace on 11/1/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import "GHLoginRequest.h"
#import "GHLoginRequestParser.h"
#import "BLMultipartForm.h"

@implementation GHLoginRequest

- (void)sendLoginRequestWithEmail:(NSString *)email
                         password:(NSString *)password
                             gbid:(NSString *)gbid
                         delegate:(id<GHLoginRequestDelegate>)delegate {
    [self.urlConnection cancel];
    self.delegate = delegate;
    
    // POST
    NSString *urlString = @"http://moran.chinacloudapp.cn/moran/web/user/login";
    NSString *encodedUrlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:encodedUrlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 60;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    BLMultipartForm *form = [[BLMultipartForm alloc]init];
    [form addValue:email forField:@"email"];
    [form addValue:password forField:@"password"];
    [form addValue:gbid forField:@"gbid"];
    request.HTTPBody = [form httpBody];
    [request setValue:form.contentType forHTTPHeaderField:@"Content-Type"];
    self.urlConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode == 200) {
        self.receivedData = [NSMutableData data];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    self.receivedData=[NSMutableData data];
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *string = [[NSString alloc]initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"receive string:%@", string);
    
    GHLoginRequestParser *parser = [[GHLoginRequestParser alloc]init];
    GHUserModel *user = [parser parseJson:self.receivedData];
    
    if ([_delegate respondsToSelector:@selector(loginRequestSuccess:user:)]) {
        [_delegate loginRequestSuccess:self user:user];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"error: %@", error);
    if ([_delegate respondsToSelector:@selector(loginRequestFailed:error:)]) {
        [_delegate loginRequestFailed:self error:error];
    }
}

@end
