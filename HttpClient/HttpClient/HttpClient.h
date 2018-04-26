//
//  HttpClient.h
//  HttpClient
//
//  Created by yoshihiro on 2018/04/27.
//  Copyright © 2018年 Yoshihiro Kato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpClient : NSObject <NSURLSessionDataDelegate>

// Var
@property (nonatomic) NSURLSession          *sessionConnect;
@property (nonatomic) NSMutableData         *recevedData;

- (void)startDownLoad;

@end
