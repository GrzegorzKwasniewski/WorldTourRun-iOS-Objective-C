//
//  RunDetailVC.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 31/01/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import "RunDetailVC.h"
#import <MapKit/MapKit.h>
#import "Run+CoreDataClass.h"
#import "Location+CoreDataClass.h"
#import "ToString.h"

@interface RunDetailVC ()

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UILabel *date;
@property (nonatomic, weak) IBOutlet UILabel *distance;
@property (nonatomic, weak) IBOutlet UILabel *pace;
@property (nonatomic, weak) IBOutlet UILabel *time;

@end

@implementation RunDetailVC

# pragma mark View State

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Custom Functions

- (void)setRun:(Run *)userRun {
    if (_userRun != userRun) {
        _userRun = userRun;
    }
}

-(void)setView {
    self.distance.text = [ToString stringFromDistance:(float)self.userRun.distance];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    self.date.text = [dateFormatter stringFromDate:self.userRun.timestamp];
    
    self.time.text = [NSString stringWithFormat:@"Time: %@", [ToString stringFromSecondCount:(int)self.userRun.duration usingLongFormat:YES]];
}

@end
