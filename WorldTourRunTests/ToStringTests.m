//
//  ToStringTests.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 19/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"

@interface ToStringTests : XCTestCase

@end

@implementation ToStringTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testIntToStringConversion_NoLongFormat {
    
    NSString *time = [NSString stringWithFormat:@"%@", [ToString stringFromSecondCount:26 usingLongFormat:NO]];
    
    XCTAssertEqualObjects(time, @"00:26");
    
    time = [NSString stringWithFormat:@"%@", [ToString stringFromSecondCount:100 usingLongFormat:NO]];
    
    XCTAssertEqualObjects(time, @"01:40");
    
    time = [NSString stringWithFormat:@"%@", [ToString stringFromSecondCount:3600 usingLongFormat:NO]];
    
    XCTAssertEqualObjects(time, @"01:00:00");
}

-(void)testIntToStringConversion_WithLongFormat {
    
    NSString *time = [NSString stringWithFormat:@"%@", [ToString stringFromSecondCount:26 usingLongFormat:YES]];
    
    XCTAssertEqualObjects(time, @"26sec");
    
    time = [NSString stringWithFormat:@"%@", [ToString stringFromSecondCount:100 usingLongFormat:YES]];
    
    XCTAssertEqualObjects(time, @"1min 40sec");
    
    time = [NSString stringWithFormat:@"%@", [ToString stringFromSecondCount:3600 usingLongFormat:YES]];
    
    XCTAssertEqualObjects(time, @"1hr 0min 0sec");
}


@end
