//
//  ScheduleRunsVC.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 07/02/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import "ScheduleRunsVC.h"
#import "SheduledRuns+CoreDataClass.h"


@interface ScheduleRunsVC ()

@end

@implementation ScheduleRunsVC

#pragma mark - View State

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self checkForAuthorizationStatus];
    
    self.cdService = [[CoreDataService alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveNewRun:) name:SAVE_NEW_RUN_EVENT object:nil];
    
    self.scheduledRuns = [self.cdService fetchRequestFromEntity:SCHEDULED_RUNS inManagedObjectContext:self.managedObjectContext];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.scheduledRuns count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSManagedObject *name = [self.scheduledRuns objectAtIndex:indexPath.row];
    NSString *scheduledRunName = [name valueForKey:@"name"];

    cell.backgroundColor = [UIColor greenColor];
    cell.textLabel.text = scheduledRunName;

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.cdService deleteRun:[self.scheduledRuns objectAtIndex:indexPath.row] inManagedObjectContext:self.managedObjectContext];
        
        [self.scheduledRuns removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


#pragma mark - Custom Functions

-(IBAction)addNewRun:(id)sender {
    
    UIAlertController *alert = [CustomAlerts createAlertWithTitle:@"New Run Event" withMessage:@"Give a name for Your Run" withNotification:SAVE_NEW_RUN_EVENT];
    [self presentViewController:alert animated:YES completion:NULL];
}

-(void)saveNewRun:(NSNotification *)notification {
    
    if ([notification.name isEqualToString:SAVE_NEW_RUN_EVENT]) {
        NSString *runName = notification.object;
        [self.scheduledRuns addObject: [self.cdService addNewRunWithName:runName inManagedObjectContext:self.managedObjectContext]];
        
        NSUInteger row = [self.scheduledRuns count] - 1;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

// lazy initializer
- (EKEventStore *)eventStore {
    if (!_eventStore) {
        _eventStore = [[EKEventStore alloc]init];
    }
    return _eventStore;
}

-(void)checkForAuthorizationStatus {
    
    EKAuthorizationStatus authorizationStatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    
    switch (authorizationStatus) {
        case EKAuthorizationStatusDenied:
        case EKAuthorizationStatusRestricted: {
            self.isEventStoreAccessGranted = NO;
            UIAlertController *alert = [CustomAlerts createAlertWithTitle:@"This app doesn't have access" withMessage:@"You didn't allow this app to access Your Reminders"];
            [self presentViewController:alert animated:YES completion:NULL];
            break;
        }
        case EKAuthorizationStatusAuthorized:
            self.isEventStoreAccessGranted = YES;
            break;
        case EKAuthorizationStatusNotDetermined: {
            [self.eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    self.isEventStoreAccessGranted = granted;
                });
            }];
            break;
        }
    }
}

-(EKCalendar *)calendarWithReminders {
    if (!_calendarWithReminders) {
        NSArray *calendars = [self.eventStore calendarsForEntityType:EKEntityTypeReminder];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title matches %@", @"ScheduledRuns"];
        NSArray *filterdCalendars = [calendars filteredArrayUsingPredicate:predicate];
        
        if ([filterdCalendars count]) {
            _calendarWithReminders = [filterdCalendars firstObject];
        } else {
            _calendarWithReminders = [EKCalendar calendarForEntityType:EKEntityTypeReminder eventStore:self.eventStore];
            _calendarWithReminders.title = @"ScheduledRuns";
            _calendarWithReminders.source = self.eventStore.defaultCalendarForNewReminders.source;
            
            NSError *calendarError = nil;
            BOOL calendarSuccess = [self.eventStore saveCalendar:_calendarWithReminders commit:YES error:&calendarError];
            if (!calendarError) {
                // show alert with error
            }
        }
    }
    return _calendarWithReminders;
}

@end
