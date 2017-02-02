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

static NSString * const detailSegue = @"RunDetails";

@interface NewRunVC () <CLLocationManagerDelegate>

@property (nonatomic, strong) Run *run;

@property NSNumber *distance;
@property NSInteger *seconds;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableArray *loactions;
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.startButton.hidden = NO;
    self.welcomeLabel.hidden = NO;
    
    self.timeLabel.text = @"";
    self.timeLabel.hidden = YES;
    self.distanceLabel.hidden = YES;
    self.paceLabel.hidden = YES;
    self.startButton.hidden = YES;
}

-(IBAction)startPressed:(id)sender {
    self.timeLabel.hidden = NO;
    self.distanceLabel.hidden = NO;
    self.paceLabel.hidden = NO;
    self.stopButton.hidden = NO;
    
    self.startButton.hidden = YES;
    self.welcomeLabel.hidden = YES;
}

- (IBAction)stopPressed:(id)sender {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:@"Message" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //
    }];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // this will set Run details on RunDetailVC
    [[segue destinationViewController] setRun:self.run];
}

@end
