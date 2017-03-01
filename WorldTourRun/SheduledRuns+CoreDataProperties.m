//
//  SheduledRuns+CoreDataProperties.m
//  
//
//  Created by Grzegorz Kwaśniewski on 07/02/17.
//
//

#import "SheduledRuns+CoreDataProperties.h"

@implementation SheduledRuns (CoreDataProperties)

+ (NSFetchRequest<SheduledRuns *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"SheduledRuns"];
}

@dynamic name;

@end
