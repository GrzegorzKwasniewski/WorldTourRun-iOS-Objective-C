//
//  TrophiesVC.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 10/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import "TrophiesVC.h"
#import "CellTrophy.h"

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
        [cell configureCellWithTrophyStatus:trophyStatus];
    } else {
        [cell configureEmptyCell:trophyStatus];
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
