//
//  CellScheduledRun.h
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 15/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SheduledRuns+CoreDataClass.h"

@import EventKit;

extern NSString *const SET_RUN_REMINDER;

@interface CellScheduledRun : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *runName;
@property (weak, nonatomic) IBOutlet UIImageView *completeStatus;


@property (strong, nonatomic) SheduledRuns *scheduledRun;

-(void)configureCellForNewRunReminder:(SheduledRuns *)scheduledRun;
-(void)configureCellWithSetReminder:(NSArray *)runReminders scheduledRun:(SheduledRuns *) scheduledRun;

@end
