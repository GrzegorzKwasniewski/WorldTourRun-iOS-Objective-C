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

-(void)test_Int_ToString_Conversion_NoLongFormat {
    
    // given - preparation
    NSString *time;
    
    // when - execute code
    time = [NSString stringWithFormat:@"%@", [ToString stringFromSecondCount:26 usingLongFormat:NO]];
    
    // then - assertion
    XCTAssertEqualObjects(time, @"00:26", @"Time converstion to string is incorrect");
    
    time = [NSString stringWithFormat:@"%@", [ToString stringFromSecondCount:100 usingLongFormat:NO]];
    
    XCTAssertEqualObjects(time, @"01:40", @"Time converstion to string is incorrect");
    
    time = [NSString stringWithFormat:@"%@", [ToString stringFromSecondCount:3600 usingLongFormat:NO]];
    
    XCTAssertEqualObjects(time, @"01:00:00", @"Time converstion to string is incorrect");
}

-(void)test_Int_ToString_Conversion_WithLongFormat {
    
    NSString *time = [NSString stringWithFormat:@"%@", [ToString stringFromSecondCount:26 usingLongFormat:YES]];
    
    XCTAssertEqualObjects(time, @"26sec", @"Time converstion to string with long format is incorrect");
    
    time = [NSString stringWithFormat:@"%@", [ToString stringFromSecondCount:100 usingLongFormat:YES]];
    
    XCTAssertEqualObjects(time, @"1min 40sec", @"Time converstion to string with long format is incorrect");
    
    time = [NSString stringWithFormat:@"%@", [ToString stringFromSecondCount:3600 usingLongFormat:YES]];
    
    XCTAssertEqualObjects(time, @"1hr 0min 0sec", @"Time converstion to string with long format is incorrect");
}

-(void)test_String_From_Average_Speed {

    NSString *averagePace = [NSString stringWithFormat:@"%@",[ToString stringFromAverageSpeed:1000 overTime:300]];
    
    XCTAssertEqualObjects(averagePace, @"3.33 m/s", @"Average pace is not calculated correctly");
    
    averagePace = [NSString stringWithFormat:@"%@",[ToString stringFromAverageSpeed:50000 overTime:4000]];
    
    XCTAssertEqualObjects(averagePace, @"12.50 m/s", @"Average pace is not calculated correctly");
    
    averagePace = [NSString stringWithFormat:@"%@",[ToString stringFromAverageSpeed:700000 overTime:60456]];
    
    XCTAssertEqualObjects(averagePace, @"11.58 m/s", @"Average pace is not calculated correctly");
    
}


// RESZTA KLASY TOSTRING


@end
