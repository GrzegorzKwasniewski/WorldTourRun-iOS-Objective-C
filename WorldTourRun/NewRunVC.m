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

static NSString * const detailSegueName = @"RunDetails";

@interface NewRunVC ()

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

@end
