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
#import "TrophiesDetailsVC.h"
#import "BackgroundView.h"

@interface TrophiesVC ()

@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation TrophiesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BackgroundView *background = [[BackgroundView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height / 2, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    [self.view addSubview:background];
    [self.view sendSubviewToBack:background];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
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
        cell.name.textColor = [UIColor whiteColor];
        cell.name.text = trophyStatus.trophy.cityName;
        cell.trophyDescription.textColor = [UIColor whiteColor];
        cell.trophyDescription.text = [NSString stringWithFormat:@"Earned: %@", [self.dateFormatter stringFromDate:trophyStatus.endedRun.timestamp]];
        cell.trophyImage.image = [UIImage imageNamed:trophyStatus.trophy.cityImageName];
        cell.userInteractionEnabled = YES;
    } else {
        cell.name.textColor = [UIColor whiteColor];
        cell.name.text = @"?????";
        cell.trophyDescription.textColor = [UIColor whiteColor];
        cell.trophyDescription.text = [NSString stringWithFormat:@"Run %@ to Earn", [ToString stringFromDistance:trophyStatus.trophy.distanceToGetTrophy]];
        cell.trophyImage.image = [UIImage imageNamed:@"question_mark.jpg"];
        cell.userInteractionEnabled = NO;
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue destinationViewController] isKindOfClass:[TrophiesDetailsVC class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        TrophyStatus *trophyStatus = [self.trophiesInfo objectAtIndex:indexPath.row];
        [(TrophiesDetailsVC *)[segue destinationViewController] setTrophyStatus:trophyStatus];
    }
}

@end