//
//  SXQ.m
//  实验助手
//
//  Created by SXQ on 15/11/19.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWZonePickerDelegate.h"
#import <XCTest/XCTest.h>

@interface SXQ : XCTestCase

@end

@implementation SXQ

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}
- (void)testInit
{
    DWZonePickerDelegate *delegate = [[DWZonePickerDelegate alloc] init];
    XCTAssertNotNil(delegate,@"");
}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
