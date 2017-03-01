//
//  HandleMath.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 01/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import "ToString.h"

static bool const isEuropeanMetric = YES;
static float const metersInKilometers = 1000;
static float const metersInMile = 1609.344;

@implementation ToString

+ (NSString *)stringFromSecondCount:(int)seconds usingLongFormat:(BOOL)longFormat {
    
    int secondsLeft = seconds;
    int hours = secondsLeft / 3600;
    secondsLeft = secondsLeft - hours * 3600;
    int minutes = secondsLeft / 60;
    secondsLeft = secondsLeft - minutes * 60;
    
    if (longFormat) {
        if (hours > 0) {
            return [NSString stringWithFormat:@"%ihr %imin %isec", hours, minutes, secondsLeft];
        } else if (minutes > 0) {
            return [NSString stringWithFormat:@"%imin %isec", minutes, secondsLeft];
        } else {
            return [NSString stringWithFormat:@"%isec", secondsLeft];
        }
    } else {
        if (hours > 0) {
            return [NSString stringWithFormat:@"%02i:%02i:%02i", hours, minutes, secondsLeft];
        } else if (minutes > 0) {
            return [NSString stringWithFormat:@"%02i:%02i", minutes, secondsLeft];
        } else {
            return [NSString stringWithFormat:@"00:%02i", secondsLeft];
        }
    }
}

+ (NSString *)stringFromAvgPace:(float)meters overTime:(int)seconds {
    
    float averagePace = seconds / meters;
    
    float multiplier;
    NSString *unit;
    
    if (seconds == 0 || meters == 0) {
        return @"0";
    }
    
    if (isEuropeanMetric) {
        unit = @"min/km";
        multiplier = metersInKilometers;
    } else {
        unit = @"min/mi";
        multiplier = metersInMile;
    }
    
    int paceMinute = (int) ((averagePace * multiplier) / 60);
    int paceSeconds = (int) (averagePace * multiplier - (paceMinute * 60));
    
    return [NSString stringWithFormat:@"%i:%02i %@", paceMinute, paceSeconds, unit];
}

+ (NSString *)stringFromDistance:(float)meters {
    
    float divider;
    NSString *unit;
    
    if (isEuropeanMetric) {
        unit = @"km";
        divider = metersInKilometers;
    } else {
        unit = @"mi";
        divider = metersInMile;
    }
    
    return [NSString stringWithFormat:@"%.2f %@", (meters / divider), unit];
}

@end
