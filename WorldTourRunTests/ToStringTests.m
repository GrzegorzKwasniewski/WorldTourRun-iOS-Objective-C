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

@property (strong, nonatomic) NewRunVC *runVC;

@end

@implementation ToStringTests

- (void)setUp {
    [super setUp];
   
    // for example
    self.runVC = [[NewRunVC alloc] init];
}

- (void)tearDown {
    
    // Always release objects form setUp
    self.runVC = nil;
    [super tearDown];
}

-(void)testIntToStringConversion_NoLongFormat {
    
    // given - preparation
    NSString *time;
    
    // when - execute code
    time = [NSString stringWithFormat:@"%@", [ToString stringFromSecondCount:26 usingLongFormat:NO]];
    
    // then - assertion
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
