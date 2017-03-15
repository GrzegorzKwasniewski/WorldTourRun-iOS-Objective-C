//
//  CellScheduledRun.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 15/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import "CellScheduledRun.h"

@implementation CellScheduledRun

NSString *const SET_RUN_REMINDER = @"SetRunReminder";

- (void)awakeFromNib {
    [super awakeFromNib];
    self.runName.textColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCellForNewRunReminder:(SheduledRuns *)scheduledRun {
    
    self.scheduledRun = scheduledRun;
    self.runName.text = scheduledRun.name;
    
    UIButton *reminderButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    reminderButton.frame = CGRectMake(0.0, 0.0, 100.0, 30.0);
    [reminderButton setTitle:@"Reminde me" forState:UIControlStateNormal];
    
    [reminderButton addTarget:self action:@selector(addRunReminder) forControlEvents:UIControlEventTouchUpInside];
    
    self.accessoryView = reminderButton;
}

-(void)configureCellWithSetReminder:(NSArray *)runReminders scheduledRun:(SheduledRuns *) scheduledRun {
    
    self.runName.text = scheduledRun.name;
    
    self.accessoryView = nil;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title matches %@", scheduledRun.name];
    NSArray *reminders = [runReminders filteredArrayUsingPredicate:predicate];
    EKReminder *reminder = [reminders firstObject];
    self.imageView.image = (reminder.isCompleted) ? [UIImage imageNamed:@"pixel_1"] : [UIImage imageNamed:@"pixel_2"];
    
}

-(void)addRunReminder {
    [[NSNotificationCenter defaultCenter] postNotificationName:SET_RUN_REMINDER object:self.scheduledRun];
}

@end
