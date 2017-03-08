//
//  CityTrophyController.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 06/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import "CityTrophyController.h"
#import "CityTrophy.h"

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
    
    return trophiesCollection;
}

+(CityTrophy *)parsTrophy:(NSDictionary *)dictionary {
    
    CityTrophy *cityTrophy = [CityTrophy new];
    cityTrophy.cityName = [dictionary objectForKey:@"name"];
    cityTrophy.cityInformation = [dictionary objectForKey:@"information"];
    cityTrophy.cityImageName = [dictionary objectForKey:@"imageName"];
    cityTrophy.distanceToGetTrophy = [[dictionary objectForKey:@"distance"] floatValue];
    return cityTrophy;
    
}

@end

