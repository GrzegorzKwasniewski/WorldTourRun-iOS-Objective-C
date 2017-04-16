//
//  ViewController.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 30/01/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import "StartScreenVC.h"

@interface StartScreenVC ()

@end

@implementation StartScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bannerView.adUnitID = @"ca-app-pub-1657846570640547/9857116910";
    self.bannerView.rootViewController = self;
    [self.bannerView loadRequest:[GADRequest request]];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Run" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    self.usersRuns = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
}


// pass managed contex for CoreData
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *nextVC = [segue destinationViewController];
    if ([nextVC isKindOfClass:[NewRunVC class]]) {
        ((NewRunVC *) nextVC).managedObjectContext = self.managedObjectContext;
    } else if ([nextVC isKindOfClass:[ScheduleRunsVC class]]) {
        ((ScheduleRunsVC *) nextVC).managedObjectContext = self.managedObjectContext;
    } else if ([nextVC isKindOfClass:[FinishedRunsVC class]]) {
        ((FinishedRunsVC *) nextVC).managedObjectContext = self.managedObjectContext;
    } else if ([nextVC isKindOfClass:[TrophiesVC class]]) {
        ((TrophiesVC *) nextVC).trophiesInfo = [[CityTrophyController sharedInstance] trophiesInfo:self.usersRuns];
    }
}

@end
