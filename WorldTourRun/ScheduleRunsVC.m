//
//  ScheduleRunsVC.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 07/02/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import "ScheduleRunsVC.h"
#import "SheduledRuns+CoreDataClass.h"
#import "BackgroundView.h"

@interface ScheduleRunsVC ()

@end

@implementation ScheduleRunsVC

#pragma mark - View State

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"README: %f", CGRectGetMaxY(self.view.bounds));
    
    // TODO: Can I use dependency injection here?
    BackgroundView *back = [[BackgroundView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height / 2, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    [self.view addSubview:back];
    [self.view sendSubviewToBack:back];
    
    [self checkForAuthorizationStatus];
    
    self.cdService = [[CoreDataService alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveNewRun:) name:SAVE_NEW_RUN_EVENT object:nil];
    
    self.scheduledRuns = [self.cdService fetchRequestFromEntity:SCHEDULED_RUNS inManagedObjectContext:self.managedObjectContext];
    
    [self getRunReminders];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getRunReminders)
                                                 name:EKEventStoreChangedNotification object:nil];
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
    self.scheduledRunName = [name valueForKey:@"name"];

    //cell.backgroundColor = [UIColor greenColor];
    cell.textLabel.text = self.scheduledRunName;
    
    if (![self isRunReminderSet:self.scheduledRunName]) {
        UIButton *reminderButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        reminderButton.frame = CGRectMake(0.0, 0.0, 100.0, 30.0);
        [reminderButton setTitle:@"Reminde me" forState:UIControlStateNormal];
        
        [reminderButton addTarget:self action:@selector(addRemainder) forControlEvents:UIControlEventTouchUpInside];
        
        cell.accessoryView = reminderButton;
    } else {
        cell.accessoryView = nil;
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title matches %@", self.scheduledRunName];
        NSArray *reminders = [self.runReminders filteredArrayUsingPredicate:predicate];
        EKReminder *reminder = [reminders firstObject];
        cell.imageView.image = (reminder.isCompleted) ? [UIImage imageNamed:@"pixel_1"] : [UIImage imageNamed:@"pixel_2"];
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // delte from Core Data
        [self.cdService deleteRun:[self.scheduledRuns objectAtIndex:indexPath.row] inManagedObjectContext:self.managedObjectContext];
        
        // delte from reminders
        NSManagedObject *run = [self.scheduledRuns objectAtIndex:indexPath.row];
        NSString *name = [run valueForKey:@"name"];
        [self deleteRunReminder:name];
        
        // delete from array
        [self.scheduledRuns removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSManagedObject *name = [self.scheduledRuns objectAtIndex:indexPath.row];
    self.scheduledRunName = [name valueForKey:@"name"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title matches %@", self.scheduledRunName];
    
    NSArray *results = [self.runReminders filteredArrayUsingPredicate:predicate];
    EKReminder *reminder = [results firstObject];
    reminder.completed = !reminder.isCompleted;
    
    NSError *error;
    [self.eventStore saveReminder:reminder commit:YES error:&error];
    if (error) {
        // Handle error
    }
    
    cell.imageView.image = (reminder.isCompleted) ? [UIImage imageNamed:@"pixel_1"] : [UIImage imageNamed:@"pixel_2"];
}


#pragma mark - Custom Functions

-(IBAction)addNewRun:(id)sender {
    
    UIAlertController *alert = [CustomAlerts createAlertWithTitle:@"New Run Event" withMessage:@"Give Your Run a name" withNotification:SAVE_NEW_RUN_EVENT];
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
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title matches %@", @"Scheduled Runs"];
        NSArray *filterdCalendars = [calendars filteredArrayUsingPredicate:predicate];
        
        if ([filterdCalendars count]) {
            _calendarWithReminders = [filterdCalendars firstObject];
        } else {
            _calendarWithReminders = [EKCalendar calendarForEntityType:EKEntityTypeReminder eventStore:self.eventStore];
            _calendarWithReminders.title = @"Scheduled Runs";
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

-(void)addRemainder {
    
    // TODO: Try to add date later
    
    if (!self.isEventStoreAccessGranted) {
        return;
    }
    
    EKReminder *runRemainder = [EKReminder reminderWithEventStore:self.eventStore];
    runRemainder.title = self.scheduledRunName;
    runRemainder.calendar = self.calendarWithReminders;
    
    NSError *error = nil;
    BOOL success = [self.eventStore saveReminder:runRemainder commit:YES error:&error];
    if (!success) {
        // handle error
    }
    
    NSString *message = (success) ? @"Reminder for Your Run was added!" : @"Something went wrong. Reminder was not added.";
    
    UIAlertController *alert = [CustomAlerts createAlertWithTitle:message withMessage:@""];
    [self presentViewController:alert animated:YES completion:NULL];
}

- (void)getRunReminders {
    if (self.isEventStoreAccessGranted) {

        NSPredicate *predicate =
        [self.eventStore predicateForRemindersInCalendars:@[self.calendarWithReminders]];
        
        [self.eventStore fetchRemindersMatchingPredicate:predicate completion:^(NSArray *reminders) {

            self.runReminders = reminders;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
    }
}

- (void)deleteRunReminder:(NSString *)run {

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title matches %@", run];
    NSArray *runs = [self.runReminders filteredArrayUsingPredicate:predicate];
    
    if ([runs count]) {
        [runs enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
            NSError *error = nil;

            BOOL success = [self.eventStore removeReminder:object commit:NO error:&error];
            if (!success) {
                // Handle error
            }
        }];
        
        NSError *commitError = nil;
        BOOL success = [self.eventStore commit:&commitError];
        if (!success) {
            // Handle error.
        }
    }
}


- (BOOL)isRunReminderSet:(NSString *)item {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title matches %@", item];
    NSArray *filteredArray = [self.runReminders filteredArrayUsingPredicate:predicate];
    return (self.isEventStoreAccessGranted && [filteredArray count]);
}

@end
