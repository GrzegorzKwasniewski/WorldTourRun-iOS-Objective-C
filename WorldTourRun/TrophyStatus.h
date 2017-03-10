//
//  TrophyStatus.h
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 09/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CityTrophy;
@class Run;

@interface TrophyStatus : NSObject

@property (strong, nonatomic) CityTrophy *trophy;
@property (strong, nonatomic) Run *endedRun;
@property (strong, nonatomic) Run *bestRun;

@end
