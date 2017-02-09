//
//  CoreDataService.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 09/02/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import "CoreDataService.h"

@implementation CoreDataService

NSString *const SCHEDULED_RUNS = @"SCHEDULED_RUNS";

-(NSArray *)fetchRequestFromEntity:(NSString *)entity inManagedObjectContext:(NSManagedObjectContext *)context {
    
    NSArray * fetchResults;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity];
    
    NSError *error = nil;
    fetchResults = [context executeFetchRequest:request error:&error];
    if (!fetchResults) {
        NSLog(@"Error fetching Employee objects: %@", error);
        abort();
        return nil;
    }
    
    return fetchResults;
}

@end
