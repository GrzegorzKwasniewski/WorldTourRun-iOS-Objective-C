//
//  HandleMath.h
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 01/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToString : NSObject

+ (NSString *)stringFromSecondCount:(int)seconds usingLongFormat:(BOOL)longFormat;
+ (NSString *)stringFromAverageSpeed:(float)meters overTime:(int)seconds;
+ (NSString *)stringFromDistance:(float)meters;

@end
