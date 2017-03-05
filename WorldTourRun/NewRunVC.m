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
#import "ToString.h"
#import <MapKit/MapKit.h>

static NSString * const detailSegue = @"userRunDetails";

@interface NewRunVC () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (nonatomic, strong) Run *userRun;

@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@property float runDistance;
@property int runTime;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableArray *runLocations;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, weak) IBOutlet UILabel *welcomeMessage;
@property (nonatomic, weak) IBOutlet UILabel *distance;
@property (nonatomic, weak) IBOutlet UILabel *pace;
@property (nonatomic, weak) IBOutlet UILabel *time;
@property (nonatomic, weak) IBOutlet UIButton *startButton;
@property (nonatomic, weak) IBOutlet UIButton *stopButton;

@end

@implementation NewRunVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.locationManager requestWhenInUseAuthorization];
    self.mapView.delegate = self;

}

#pragma mark - View State

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.startButton.hidden = NO;
    self.welcomeMessage.hidden = NO;
    
    self.time.text = @"";
    self.time.hidden = YES;
    self.distance.hidden = YES;
    self.pace.hidden = YES;
    self.stopButton.hidden = YES;
    
    self.mapView.hidden = YES;

}

-(IBAction)startPressed:(id)sender {
    self.time.hidden = NO;
    self.distance.hidden = NO;
    self.pace.hidden = NO;
    self.stopButton.hidden = NO;
    
    self.startButton.hidden = YES;
    self.welcomeMessage.hidden = YES;
    
    self.runTime = 0;
    self.runDistance = 0;
    self.runLocations =  [NSMutableArray array];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    
    [self updateLocactions];
    
    self.mapView.hidden = NO;
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
    userRun.duration = self.runTime;
    userRun.distance = self.runDistance;
    
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
    
    [self.locationManager stopUpdatingLocation];
    
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
    self.runTime++;
    self.time.text = [NSString stringWithFormat:@"Time: %@", [ToString stringFromSecondCount:self.runTime usingLongFormat:NO]];
    self.distance.text =  [NSString stringWithFormat:@"Distane: %@", [ToString stringFromDistance:self.runDistance]];
    self.pace.text = [NSString stringWithFormat:@"Pace: %@", [ToString stringFromAvgPace:self.runDistance overTime:self.runTime]];
}

#pragma mark - Location Manager Functions

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    for (CLLocation *singleLoaction in locations) {
        
        NSDate *eventDate = singleLoaction.timestamp;
        
        NSTimeInterval timeInterval = [eventDate timeIntervalSinceNow];
        
        if (fabs(timeInterval) < 5.0 && singleLoaction.horizontalAccuracy < 20) { // try with verical
            
            if (self.runLocations.count > 0) {
                self.runDistance += [singleLoaction distanceFromLocation:self.runLocations.lastObject];
                
                CLLocationCoordinate2D coords[2];
                coords[0] = ((CLLocation *)self.runLocations.lastObject).coordinate;
                coords[1] = singleLoaction.coordinate;
                
                MKCoordinateRegion region =
                MKCoordinateRegionMakeWithDistance(singleLoaction.coordinate, 500, 500);
                [self.mapView setRegion:region animated:YES];
                
                [self.mapView addOverlay:[MKPolyline polylineWithCoordinates:coords count:2]];
            }
            
            [self.runLocations addObject:singleLoaction];
            
        }
    }
}

-(void)updateLocactions {
    
    if (self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    
    // TODO: Move to other place
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.activityType = CLActivityTypeFitness;
    
    self.locationManager.distanceFilter = 15;
    
    [self.locationManager startUpdatingLocation];
}

#pragma mark - Map View Methods

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolyline *polyLine = (MKPolyline *)overlay;
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:polyLine];
        renderer.strokeColor = [UIColor greenColor];
        renderer.lineWidth = 10;
        return renderer;
    }
    return nil;
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // this will set Run details on RunDetailVC
    [[segue destinationViewController] setUserRun:self.userRun];
}

@end
