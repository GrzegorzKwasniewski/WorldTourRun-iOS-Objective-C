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
    
    self.cdService = [[CoreDataService alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveNewRun:) name:SAVE_NEW_RUN_EVENT object:nil];
    
    self.sheduledRuns = [self.cdService fetchRequestFromEntity:SCHEDULED_RUNS inManagedObjectContext:self.managedObjectContext];
    
    NSManagedObject *name = [self.sheduledRuns lastObject];
    NSString *string = [name valueForKey:@"name"];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Custom Functions

-(IBAction)addNewRun:(id)sender {
    
    UIAlertController *alert = [CustomAlerts createAlertWithTitle:@"New Run Event" withMessage:@"Give a name for Your Run" withNotification:SAVE_NEW_RUN_EVENT];
    [self presentViewController:alert animated:YES completion:NULL];
}

-(void)saveNewRun:(NSNotification *)notification {
    
    if ([notification.name isEqualToString:SAVE_NEW_RUN_EVENT]) {
        NSString *object = notification.object;
        SheduledRuns *newRun = [NSEntityDescription insertNewObjectForEntityForName:@"ScheduledRuns" inManagedObjectContext:self.managedObjectContext];
        newRun.name = object;
        
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            abort();
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
