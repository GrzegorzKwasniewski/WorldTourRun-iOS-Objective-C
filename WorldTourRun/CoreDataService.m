//
//  CoreDataService.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 09/02/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import "CoreDataService.h"

@implementation CoreDataService

NSString *const SCHEDULED_RUNS = @"ScheduledRuns";

-(NSMutableArray *)fetchRequestFromEntity:(NSString *)entity inManagedObjectContext:(NSManagedObjectContext *)context {
    
    NSMutableArray * fetchResults;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity];
    
    NSError *error = nil;
    fetchResults = [[context executeFetchRequest:request error:&error] mutableCopy];
    if (!fetchResults) {
        NSLog(@"Error fetching objects: %@", error);
        abort();
        return nil;
    }
    
    return fetchResults;
}

-(SheduledRuns *)addNewRunWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context {
    
    SheduledRuns *newRun = [NSEntityDescription insertNewObjectForEntityForName:SCHEDULED_RUNS inManagedObjectContext:context];
    newRun.name = name;
    
    NSError *error = nil;
    if (![context save:&error]) {
        abort();
    }
    
    return newRun;
}

@end
