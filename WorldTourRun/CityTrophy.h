//
//  CityTrophy.h
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 06/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityTrophy : NSObject

@property (strong, nonatomic) NSString *cityName;
@property (strong, nonatomic) NSString *cityImageName;
@property (strong, nonatomic) NSString *cityInformation;
@property float distanceToGetTrophy;

@end
