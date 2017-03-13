//
//  RunDetailVC.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 31/01/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <Social/Social.h>

#import "RunDetailVC.h"
#import "Run+CoreDataClass.h"
#import "Location+CoreDataClass.h"
#import "ToString.h"
#import "CustomAlerts.h"
#import "Strategy.h"
#import "TwitterStrategy.h"
#import "FacebookStrategy.h"

@interface RunDetailVC () <MKMapViewDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UILabel *date;
@property (nonatomic, weak) IBOutlet UILabel *distance;
@property (nonatomic, weak) IBOutlet UILabel *pace;
@property (nonatomic, weak) IBOutlet UILabel *time;

@property (nonatomic, strong) Strategy *socialMediaStrategy;
@property (nonatomic, strong) SLComposeViewController * socialMediaSheet;
@property (nonatomic, strong) UIAlertController *alert;

@end

@implementation RunDetailVC

# pragma mark View State

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    
    self.distance.text = [NSString stringWithFormat:@"Distance: %@", [ToString stringFromDistance:(float)self.userRun.distance]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    self.date.text = [dateFormatter stringFromDate:self.userRun.timestamp];
    
    self.pace.text = [NSString stringWithFormat:@"Pace: %@", [ToString stringFromAvgPace:(float)self.userRun.distance overTime:(int)self.userRun.duration]];
    
    self.time.text = [NSString stringWithFormat:@"Time: %@", [ToString stringFromSecondCount:(int)self.userRun.duration usingLongFormat:YES]];
    
    [self configureMapView];
}

#pragma mark Custom Functions

-(IBAction)shareWithTwitter:(id)sender {

    self.socialMediaStrategy = [[TwitterStrategy alloc] init];
    [self shareOnSocialMediaWith:self.socialMediaStrategy];
    
}

-(IBAction)shareWithFacebook:(id)sender {
    
    self.socialMediaStrategy = [[FacebookStrategy alloc] init];
    [self shareOnSocialMediaWith:self.socialMediaStrategy];
    
}

-(void)shareOnSocialMediaWith:(Strategy *)strategy {
    
    self.socialMediaSheet = [strategy createSheetWith:self.userRun];
    
    if (self.socialMediaSheet) {
        [self presentViewController:self.socialMediaSheet animated:YES completion:nil];
    } else {
        self.alert = [CustomAlerts createAlertWithTitle:@"There is no account" withMessage:@"You need to assign account in Your settings"];
        [self presentViewController:self.alert animated:YES completion:NULL];
    }
}

- (void)setRun:(Run *)userRun {
    if (_userRun != userRun) {
        _userRun = userRun;
    }
}

- (MKCoordinateRegion)setMapRegion {
    
    MKCoordinateRegion regionToSet;
    Location *firstLocation = self.userRun.locations.firstObject;
    
    float minimumLatitude = (float)firstLocation.latitude;
    float minimumLongitude = (float)firstLocation.longitude;
    float maximumLatitiude = (float)firstLocation.latitude;
    float maximumLongitude = (float)firstLocation.longitude;
    
    for (Location *location in self.userRun.locations) {
        
        float converteLatitude = (float)location.latitude;
        float convertedLongitude = (float)location.longitude;
        
        if (converteLatitude < minimumLatitude) {
            minimumLatitude = converteLatitude;
        }
        if (convertedLongitude < minimumLongitude) {
            minimumLongitude = convertedLongitude;
        }
        if (converteLatitude > maximumLatitiude) {
            maximumLatitiude = converteLatitude;
        }
        if (convertedLongitude > maximumLongitude) {
            maximumLongitude = convertedLongitude;
        }
    }
    
    regionToSet.center.latitude = (minimumLatitude + maximumLatitiude) / 2.0f;
    regionToSet.center.longitude = (minimumLongitude + maximumLongitude) / 2.0f;
    
    regionToSet.span.latitudeDelta = (maximumLatitiude - minimumLatitude) * 1.1;
    regionToSet.span.longitudeDelta = (maximumLongitude - minimumLongitude) * 1.1;
    
    return regionToSet;
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay {
    
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        NSLog(@"README");
        MKPolyline *polyLine = (MKPolyline *)overlay;
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:polyLine];
        renderer.strokeColor = [UIColor redColor];
        renderer.fillColor = [UIColor redColor];
        renderer.lineWidth = 10;
        return renderer;
    }
    
    return nil;
}

- (MKPolyline *)createPolyLine {
    
    CLLocationCoordinate2D coords[self.userRun.locations.count];
    
    for (int i = 0; i < self.userRun.locations.count; i++) {
        Location *location = [self.userRun.locations objectAtIndex:i];
        coords[i] = CLLocationCoordinate2DMake((double)location.latitude, (double)location.longitude);
    }
    
    return [MKPolyline polylineWithCoordinates:coords count:self.userRun.locations.count];
}

- (void)configureMapView {
    
    if (self.userRun.locations.count > 0) {
        
        self.mapView.hidden = NO;
        
        [self.mapView setRegion:[self setMapRegion]];
        
        [self.mapView addOverlay:[self createPolyLine] level:MKOverlayLevelAboveRoads];
        
    } else {

        self.mapView.hidden = YES;
        
        UIAlertController *alertView = [CustomAlerts createAlertWithTitle:@"Oh no!" withMessage:@"There is on data to display"];
        
        [self presentViewController:alertView animated:YES completion:NULL];
        
    }
}

@end
