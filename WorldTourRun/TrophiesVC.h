//
//  TrophiesVC.h
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 10/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityTrophy.h"
#import "TrophyStatus.h"
#import "CellTrophy.h"
#import "ToString.h"
#import "Run+CoreDataClass.h"
#import "TrophiesDetailsVC.h"
#import "BackgroundView.h"
#import "CellTrophy.h"

@interface TrophiesVC : UITableViewController

@property (strong, nonatomic) NSArray *trophiesInfo;

@end
