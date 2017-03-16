//
//  FinishedRunsVCDelegate.h
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 16/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "CoreDataService.h"
#import "CellFinishedRun.h"

extern NSString *const CELL_FINISHED_RUN;

@interface FinishedRunsVCDelegate : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) CoreDataService *cdService;

-(id)initWithTableView:(UITableView *)tableView inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
