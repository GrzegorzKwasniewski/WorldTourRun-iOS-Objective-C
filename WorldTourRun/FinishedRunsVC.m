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
    
    BackgroundView *background = [[BackgroundView alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview:background];
    [self.view sendSubviewToBack:background];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.tableViewDelegate = [[FinishedRunsVCDelegate alloc] initWithTableView:self.tableView inManagedObjectContext:self.managedObjectContext];
}

@end
