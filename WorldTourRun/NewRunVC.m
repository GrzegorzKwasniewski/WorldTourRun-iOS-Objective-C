//
//  NewRunVC.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 31/01/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import "NewRunVC.h"
#import "RunDetailVC.h"
#import "Run+CoreDataClass.h"
#import <CoreLocation/CoreLocation.h>
#import "Location+CoreDataClass.h"

static NSString * const detailSegue = @"userRunDetails";

@interface NewRunVC () <CLLocationManagerDelegate>

@property (nonatomic, strong) Run *userRun;

@property float distance;
@property int seconds;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableArray *runLocations;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, weak) IBOutlet UILabel *welcomeLabel;
@property (nonatomic, weak) IBOutlet UILabel *distanceLabel;
@property (nonatomic, weak) IBOutlet UILabel *paceLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UIButton *startButton;
@property (nonatomic, weak) IBOutlet UIButton *stopButton;

@end

@implementation NewRunVC

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - View State

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.startButton.hidden = NO;
    self.welcomeLabel.hidden = NO;
    
    self.timeLabel.text = @"";
    self.timeLabel.hidden = YES;
    self.distanceLabel.hidden = YES;
    self.paceLabel.hidden = YES;
    self.stopButton.hidden = YES;
}

-(IBAction)startPressed:(id)sender {
    self.timeLabel.hidden = NO;
    self.distanceLabel.hidden = NO;
    self.paceLabel.hidden = NO;
    self.stopButton.hidden = NO;
    
    self.startButton.hidden = YES;
    self.welcomeLabel.hidden = YES;
    
    self.seconds = 0;
    self.distance = 0;
    self.runLocations =  [NSMutableArray array];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    
    [self updateLocactions];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
}

#pragma mark - Custom Functions

-(void)saveNewRun {
    
    Run *userRun = [NSEntityDescription insertNewObjectForEntityForName:@"Run" inManagedObjectContext:self.managedObjectContext];
    userRun.timestamp = [NSDate date];
    userRun.duration = self.seconds;
    userRun.distance = self.distance;
    
    NSMutableArray *locationsCollection = [NSMutableArray array];
    for (CLLocation *location in self.runLocations) {
        Location *singleLocation = [NSEntityDescription insertNewObjectForEntityForName:@"Location"
                                                                 inManagedObjectContext:self.managedObjectContext];
        
        singleLocation.latitude = location.coordinate.latitude;
        singleLocation.longitude = location.coordinate.longitude;
        singleLocation.timestamp = location.timestamp;
        
        [locationsCollection addObject:singleLocation];
    }
    
    userRun.locations = [NSOrderedSet orderedSetWithArray:locationsCollection];
    self.userRun = userRun;
    
    // Save To Core Data
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        abort();
    }
    
}

- (IBAction)stopPressed:(id)sender {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:@"Message" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //
    }];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self saveNewRun];
        [self performSegueWithIdentifier:detailSegue sender:nil];
    }];
    
    UIAlertAction *discardAction = [UIAlertAction actionWithTitle:@"Discard" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    [actionSheet addAction:cancelAction];
    [actionSheet addAction:saveAction];
    [actionSheet addAction:discardAction];
    [self presentViewController:actionSheet animated:YES completion:NULL];
    
}

-(void)updateTimer {
    self.seconds++;
    //self.timeLabel.text = [NSString stringWithFormat:@"Time: %@", self.seconds]; // move to separate class
    self.distanceLabel.text =  [NSString stringWithFormat:@"Distane: %@", self.distance];
    float pace = (self.distance / self.seconds);
    self.paceLabel.text = [NSString stringWithFormat:@"Pace: %@", pace];
}

#pragma mark - Location Manager Functions

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {

    for (CLLocation *singleLoaction in locations) {
        if (singleLoaction.horizontalAccuracy < 10) { // try with verical
            if (self.runLocations.count > 0) {
                self.distance += [singleLoaction distanceFromLocation:self.runLocations.lastObject];
            }
            
            [self.runLocations addObject:singleLoaction];
            
        }
    }
}

-(void)updateLocactions {
    if (self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.activityType = CLActivityTypeFitness;
    
    self.locationManager.distanceFilter = 15;
    
    [self.locationManager startUpdatingLocation];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // this will set Run details on RunDetailVC
    [[segue destinationViewController] setUserRun:self.userRun];
}

@end
