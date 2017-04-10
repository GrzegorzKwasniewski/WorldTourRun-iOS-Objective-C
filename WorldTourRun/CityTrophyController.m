//
//  CityTrophyController.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 06/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import "CityTrophyController.h"
#import "CityTrophy.h"
#import "TrophyStatus.h"
#import "Run+CoreDataClass.h"

@interface CityTrophyController()

@property (strong, nonatomic) NSArray *trophies;

@end

@implementation CityTrophyController

+(CityTrophyController *)sharedInstance {

    static CityTrophyController *ctc;
    if (ctc == nil) {
        ctc = [[CityTrophyController alloc] init];
        ctc.trophies = [self trophiesCollection];
    }
    
    return ctc;
    
}

+(NSArray *)trophiesCollection {

    NSString *fileLocation = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@".txt"];
    NSString *jsonData = [NSString stringWithContentsOfFile:fileLocation encoding:nil error:nil];
    
    NSData *data = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *trophiesFromJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSMutableArray *trophiesCollection = [NSMutableArray array];
    
    for (NSDictionary *trophy in trophiesFromJSON) {
        
        [trophiesCollection addObject:[self parsTrophy:trophy]];
        
    }
    
    NSArray *sortedCityTrophies = [self quickSort:trophiesCollection];
    
    return sortedCityTrophies;
}

+(NSArray *)quickSort:(NSMutableArray *)unsortedDataArray {
    
    int quickSortCount;
    
    NSMutableArray *lessArray = [[NSMutableArray alloc] init];
    NSMutableArray *greaterArray = [[NSMutableArray alloc] init];
    
    if ([unsortedDataArray count] <1) {
        return nil;
    }
    
    int randomPivotPoint = arc4random() % [unsortedDataArray count];
    CityTrophy *pivotValue = [unsortedDataArray objectAtIndex:randomPivotPoint];
    [unsortedDataArray removeObjectAtIndex:randomPivotPoint];
    
    for (CityTrophy *cityTrophy in unsortedDataArray) {
        quickSortCount++; //This is required to see how many iterations does it take to sort the array using quick sort
        if (cityTrophy.distanceToGetTrophy < pivotValue.distanceToGetTrophy) {
            [lessArray addObject:cityTrophy];
        } else {
            [greaterArray addObject:cityTrophy];
        }
    }
    
    NSMutableArray *sortedArray = [[NSMutableArray alloc] init];
    [sortedArray addObjectsFromArray:[self quickSort:lessArray]];
    [sortedArray addObject:pivotValue];
    [sortedArray addObjectsFromArray:[self quickSort:greaterArray]];
    
    return sortedArray;
}

+(CityTrophy *)parsTrophy:(NSDictionary *)dictionary {
    
    CityTrophy *cityTrophy = [CityTrophy new];
    cityTrophy.cityName = [dictionary objectForKey:@"name"];
    cityTrophy.cityInformation = [dictionary objectForKey:@"information"];
    cityTrophy.cityImageName = [dictionary objectForKey:@"imageName"];
    cityTrophy.distanceToGetTrophy = [[dictionary objectForKey:@"distance"] floatValue];
    return cityTrophy;
    
}

- (NSArray *)trophiesInfo:(NSArray *)userRuns {
    
    NSMutableArray *trophiesInfo = [NSMutableArray array];
    
    for (CityTrophy *trophy in self.trophies) {
        
        TrophyStatus *trophyStatus = [TrophyStatus new];
        trophyStatus.trophy = trophy;
        
        for (Run *userRun in userRuns) {
            
            if ((float)userRun.distance > trophy.distanceToGetTrophy) {
                
                if (!trophyStatus.endedRun) {
                    trophyStatus.endedRun = userRun;
                }
                
                double endedRunSpeed = (double)trophyStatus.endedRun.distance / (double)trophyStatus.endedRun.duration;
                
                double userRunSpeed = (double)userRun.distance / (double)userRun.duration;
                
                if (!trophyStatus.bestRun) {
                    trophyStatus.bestRun = userRun;
                    
                } else {
                    double bestRunSpeed = (double)trophyStatus.bestRun.distance / (double)trophyStatus.bestRun.duration;
                    
                    if (userRunSpeed > bestRunSpeed) {
                        trophyStatus.bestRun = userRun;
                    }
                }
            }
        }
        
        [trophiesInfo addObject:trophyStatus];
    }
    
    return trophiesInfo;
}

@end

