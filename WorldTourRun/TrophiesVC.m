//
//  TrophiesVC.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 10/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import "TrophiesVC.h"
#import "CityTrophy.h"
#import "TrophyStatus.h"
#import "CellTrophy.h"
#import "ToString.h"
#import "Run+CoreDataClass.h"

@interface TrophiesVC ()

@property (strong, nonatomic) UIColor *blueColor;
@property (strong, nonatomic) UIColor *orangeColor;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (assign, nonatomic) CGAffineTransform transform;

@end

@implementation TrophiesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.blueColor = [UIColor colorWithRed:1.0f green:20/255.0 blue:44/255.0 alpha:1.0f];
    self.orangeColor = [UIColor colorWithRed:0.0f green:146/255.0 blue:78/255.0 alpha:1.0f];
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    self.transform = CGAffineTransformMakeRotation(M_PI/8);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.trophiesInfo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellTrophy *cell = [tableView dequeueReusableCellWithIdentifier:@"CellTrophy" forIndexPath:indexPath];
    TrophyStatus *trophyStatus = [self.trophiesInfo objectAtIndex:indexPath.row];
    
    if (trophyStatus.endedRun) {
        cell.name.textColor = self.orangeColor;
        cell.name.text = trophyStatus.trophy.cityName;
        cell.trophyDescription.textColor = self.orangeColor;
        cell.trophyDescription.text = [NSString stringWithFormat:@"Earned: %@", [self.dateFormatter stringFromDate:trophyStatus.endedRun.timestamp]];
        cell.trophyImage.image = [UIImage imageNamed:trophyStatus.trophy.cityImageName];
        cell.userInteractionEnabled = YES;
    } else {
        cell.name.textColor = self.blueColor;
        cell.name.text = @"?????";
        cell.trophyDescription.textColor = self.orangeColor;
        cell.trophyDescription.text = [NSString stringWithFormat:@"Run %@ to Earn", [ToString stringFromDistance:trophyStatus.trophy.distanceToGetTrophy]];
        cell.trophyImage.image = [UIImage imageNamed:@"question_mark.jpg"];
        cell.userInteractionEnabled = NO;
    }
    
    return cell;
}

@end
