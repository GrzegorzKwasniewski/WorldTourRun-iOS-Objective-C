//
//  ScheduleRunsVC.h
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 07/02/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataService.h"
#import "CustomAlerts.h"

@interface ScheduleRunsVC : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) CoreDataService *cdService;
@property (strong, nonatomic) NSArray *sheduledRuns;

@end
