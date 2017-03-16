//
//  FinishedRunsDelegate.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 16/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import "FinishedRunsVCDelegate.h"

@interface FinishedRunsVCDelegate()

@end

@implementation FinishedRunsVCDelegate

NSString *const CELL_FINISHED_RUN = @"CellFinishedRun";

-(id)initWithTableView:(UITableView *)tableView inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {

    if (self = [super init]) {
                
        tableView.dataSource = self;
        tableView.delegate = self;
        
        self.cdService = [[CoreDataService alloc]init];
        self.managedObjectContext = managedObjectContext;
        
        self.dataSource = [self.cdService fetchRequestFromEntity:RUN inManagedObjectContext:managedObjectContext];
    
        return self;
        
    }
    
    return nil;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellFinishedRun *cell = [tableView dequeueReusableCellWithIdentifier:CELL_FINISHED_RUN forIndexPath:indexPath];
    Run *singleRun = [self.dataSource objectAtIndex:indexPath.row];
    
    [cell configureCellWith:singleRun];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // delte from Core Data
        [self.cdService deleteRun:[self.dataSource objectAtIndex:indexPath.row] inManagedObjectContext:self.managedObjectContext];
        
        // delete from array
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
