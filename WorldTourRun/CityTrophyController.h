//
//  CityTrophyController.h
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 06/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityTrophyController : NSObject

+ (CityTrophyController *)sharedInstance;
- (NSArray *)trophiesInfo:(NSArray *)userRuns;

@end
