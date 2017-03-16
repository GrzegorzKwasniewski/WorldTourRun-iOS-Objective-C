//
//  FinishedRunsVC.h
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 14/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataService.h"
#import "FinishedRunsVCDelegate.h"

@interface FinishedRunsVC : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) CoreDataService *cdService;
@property (strong, nonatomic) NSMutableArray *userRuns;

@property (strong, nonatomic) NSDate *runDate;
@property (strong, nonatomic) NSNumber *runDuration;
@property (strong, nonatomic) NSNumber *runDistance;

@property (strong, nonatomic) FinishedRunsVCDelegate *tableViewDelegate;


@end
