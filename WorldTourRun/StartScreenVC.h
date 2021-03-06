//
//  ViewController.h
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 30/01/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NewRunVC.h"
#import "ScheduleRunsVC.h"
#import "FinishedRunsVC.h"
#import "TrophiesVC.h"
#import "CityTrophyController.h"
#import "BackgroundView.h"

@import GoogleMobileAds;

@interface StartScreenVC : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, weak) IBOutlet GADBannerView *bannerView;

@property (strong, nonatomic) NSArray *usersRuns;

@end

