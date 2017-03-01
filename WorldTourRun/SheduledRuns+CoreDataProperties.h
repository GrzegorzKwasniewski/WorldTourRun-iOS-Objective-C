//
//  SheduledRuns+CoreDataProperties.h
//  
//
//  Created by Grzegorz Kwaśniewski on 07/02/17.
//
//

#import "SheduledRuns+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SheduledRuns (CoreDataProperties)

+ (NSFetchRequest<SheduledRuns *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
