//
//  HttpClientTests.m
//  HttpClientTests
//
//  Created by yoshihiro on 2018/04/27.
//  Copyright © 2018年 Yoshihiro Kato. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "YKTHttpClient.h"

@interface HttpClientTests : XCTestCase

@end

@implementation HttpClientTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetWithUrlString {
    YKTHttpClient *client = [YKTHttpClient new];
    [client getWithUrlString:@"https://www.google.co.jp/"];
    [client getWithUrlString:@"https://www.google.co.jp/"];

    [NSThread sleepForTimeInterval:1];
}

@end
