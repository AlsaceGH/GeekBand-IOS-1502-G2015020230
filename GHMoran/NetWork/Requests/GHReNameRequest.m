//
//  GHReNameRequest.m
//  GHMoran
//
//  Created by alsace on 11/25/15.
//  Copyright © 2015 GH. All rights reserved.
//

#import "GHReNameRequest.h"
#import "BLMultipartForm.h"
#import "GHGlobal.h"


@implementation GHReNameRequest

-(void)sendReNameRequestWithName:(NSString *)name
                        delegate:(id<GHReNameRequestDelegate>)delegate
{
    [self.urlConnection cancel];
    
    self.delegate = delegate;
    // POST
    NSString *urlString = @"http://moran.chinacloudapp.cn/moran/web/user/rename";
    NSString *encodedUrlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:encodedUrlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 60;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    BLMultipartForm *form = [[BLMultipartForm alloc]init];
    [form addValue:[GHGlobal shareGlobal].user.userId forField:@"user_id"];
    [form addValue:[GHGlobal shareGlobal].user.token forField:@"token"];
    [form addValue:name forField:@"new_name"];
    request.HTTPBody = [form httpBody];
    [request setValue:form.contentType forHTTPHeaderField:@"Content-Type"];
    self.urlConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
}

#pragma Mark NSURLConnectionDataDelegate



- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *string=[[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"ReName data string:%@",string);
    if ([_delegate respondsToSelector:@selector(renameRequestSuccess:)]) {
        [_delegate renameRequestSuccess:self];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"error: %@", error);
    if ([_delegate respondsToSelector:@selector(renameRequestFailed:error:)]) {
        [_delegate renameRequestFailed:self error:error];
    }
}

@end
