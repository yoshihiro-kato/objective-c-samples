//
//  HttpClient.m
//  HttpClient
//
//  Created by yoshihiro on 2018/04/27.
//  Copyright © 2018年 Yoshihiro Kato. All rights reserved.
//

#import "YKTHttpClient.h"

@implementation YKTHttpClient

- (id)init {
    NSLog(@"init");
    if (self = [super init]) {
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfig.timeoutIntervalForRequest  =  5;
        sessionConfig.timeoutIntervalForResource =  20;
        self.sessionConnect = [NSURLSession sessionWithConfiguration: sessionConfig
                                                            delegate: nil
                                                       delegateQueue: nil];
    }
    return self;
}

- (void)getWithUrlString:(NSString *)urlString {
    NSLog(@"get start");

    NSMutableURLRequest *request = [NSMutableURLRequest new];
    [request setURL            :[NSURL URLWithString:urlString]];
    [request setCachePolicy    :NSURLRequestReloadIgnoringLocalCacheData];
    [request setValue          :@"YKTHttpClient"   forHTTPHeaderField:@"User-Agent"];
    [request setHTTPMethod     :@"GET"];

    NSURLSessionDataTask *dataTask
        = [self.sessionConnect dataTaskWithRequest:request
                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                     NSHTTPURLResponse *httpUrlResponse = (NSHTTPURLResponse *)response;
                                     NSLog(@"Status code: %ld", httpUrlResponse.statusCode);

                                     CFStringEncoding encoding = CFStringConvertIANACharSetNameToEncoding((CFStringRef)[response textEncodingName]);
                                     NSString *body = [[NSString alloc] initWithData:data encoding:CFStringConvertEncodingToNSStringEncoding(encoding)];
                                     NSLog(@"body : %@...", [body substringToIndex:20]);
                                 }];

    [dataTask resume];
    
    NSLog(@"get end");
}

-(void) dealloc {
    NSLog(@"dealloc");
    [self.sessionConnect invalidateAndCancel];
}
@end
