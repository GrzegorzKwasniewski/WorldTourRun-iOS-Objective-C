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
    
    //BackgroundView *background = [[BackgroundView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height / 2, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    //[self.view addSubview:background];
    //[self.view sendSubviewToBack:background];
    
    self.bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
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
