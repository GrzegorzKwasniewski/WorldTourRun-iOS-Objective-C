//
//  Run+CoreDataProperties.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 30/01/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import "Run+CoreDataProperties.h"

@implementation Run (CoreDataProperties)

+ (NSFetchRequest<Run *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Run"];
}

@dynamic distance;
@dynamic duration;
@dynamic timestamp;
@dynamic locations;

@end
