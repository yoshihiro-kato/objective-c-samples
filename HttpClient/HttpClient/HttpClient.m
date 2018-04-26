//
//  HttpClient.m
//  HttpClient
//
//  Created by yoshihiro on 2018/04/27.
//  Copyright © 2018年 Yoshihiro Kato. All rights reserved.
//

#import "HttpClient.h"

@implementation HttpClient

- (void)startDownLoad {
    NSLog(@"startDownLoad start");
    
    // 初期化
    self.recevedData      = [NSMutableData data];
    
    // セッション作成
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // タイムアウトの設定
    sessionConfig.timeoutIntervalForRequest  =  5;
    sessionConfig.timeoutIntervalForResource =  20;
    
    // 通信設定
    self.sessionConnect = [NSURLSession sessionWithConfiguration: sessionConfig
                                                        delegate: self
                                                   delegateQueue: [NSOperationQueue mainQueue]];
    // Header 作成
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    [request setURL            :[NSURL URLWithString:@"https://www.google.co.jp/"]];
    [request setCachePolicy    :NSURLRequestReloadIgnoringLocalCacheData];
    [request setValue          :@"identity"   forHTTPHeaderField:@"Accept-encording"];
    [request setValue          :@"no-cache"   forHTTPHeaderField:@"Cache-Control"];
    [request setHTTPMethod     :@"GET"];
    
    NSURLSessionDataTask *dataTask =  [self.sessionConnect dataTaskWithRequest:request];
    
    // ダウンロード開始
    [dataTask resume];
    
    NSLog(@"startDownLoad end");
}

// レスポンス処理
- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    
    NSLog(@"URLSession didReceiveResponse start");

    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
    if (httpResponse.statusCode == 200) {
        
        NSLog(@"URLSession didReceiveResponse 200");
       completionHandler(NSURLSessionResponseAllow);   // 続ける
        
    } else {
        
        // error.code = -999で終了メソッドが呼ばれる
        NSLog(@"URLSession didReceiveResponse error");
        completionHandler(NSURLSessionResponseCancel);  // 止める
    }
    
    NSLog(@"URLSession didReceiveResponse end");
}

// 受信データ処理
- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    
    NSLog(@"URLSession didReceiveData start");
    // 受信データ格納
    [self.recevedData appendData:data];
    
    NSLog(@"URLSession didReceiveData end");
}

//
// 終了処理 [正常終了、エラー終了、途中終了でもこのメソッドが呼ばれる]
- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error {
    
    NSLog(@"URLSession didCompleteWithError start");
    if (!error) {
        NSLog(@"URLSession didCompleteWithError success");
        //
        // 正常終了
        //
        
    } else {
        NSLog(@"URLSession didCompleteWithError error");
        //
        // エラー終了
        //
        
    }
    
    [session invalidateAndCancel];
    
    NSLog(@"URLSession didCompleteWithError end");
}

@end
