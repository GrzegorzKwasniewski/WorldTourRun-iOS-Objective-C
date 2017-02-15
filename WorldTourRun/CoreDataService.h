//
//  CoreDataService.h
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 09/02/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SheduledRuns+CoreDataClass.h"

extern NSString *const SCHEDULED_RUNS;

@interface CoreDataService : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

-(NSArray *)fetchRequestFromEntity:(NSString *)entity inManagedObjectContext:(NSManagedObjectContext *)context;

-(SheduledRuns *)addNewRunWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context;

-(void)deleteRun:(NSManagedObject *)object inManagedObjectContext:(NSManagedObjectContext *)context;

@end
