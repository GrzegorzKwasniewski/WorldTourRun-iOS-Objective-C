//
//  FinishedRunsVC.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 14/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import "FinishedRunsVC.h"
#import "Run+CoreDataClass.h"
#import "CellFinishedRun.h"
#import "BackgroundView.h"

@interface FinishedRunsVC ()

@end

@implementation FinishedRunsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BackgroundView *background = [[BackgroundView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height / 2, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    [self.view addSubview:background];
    [self.view sendSubviewToBack:background];
        
    self.cdService = [[CoreDataService alloc]init];
    
    self.userRuns = [self.cdService fetchRequestFromEntity:RUN inManagedObjectContext:self.managedObjectContext];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.userRuns count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellFinishedRun *cell = [tableView dequeueReusableCellWithIdentifier:@"CellFinishedRun" forIndexPath:indexPath];
    Run *singleRun = [self.userRuns objectAtIndex:indexPath.row];
    
    [cell configureCellWith:singleRun];
    
    return cell;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // delte from Core Data
        [self.cdService deleteRun:[self.userRuns objectAtIndex:indexPath.row] inManagedObjectContext:self.managedObjectContext];
        
        // delete from array
        [self.userRuns removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
