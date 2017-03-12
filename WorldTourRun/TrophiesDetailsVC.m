//
//  TrophiesDetailsVC.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 12/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import "TrophiesDetailsVC.h"
#import "CityTrophy.h"
#import "Run+CoreDataClass.h"
#import "CityTrophyController.h"
#import "ToString.h"
#import "TrophyStatus.h"

@interface TrophiesDetailsVC ()

@property (nonatomic, weak) IBOutlet UILabel *trophyName;
@property (nonatomic, weak) IBOutlet UILabel *runDistance;
@property (nonatomic, weak) IBOutlet UILabel *dateEarned;
@property (nonatomic, weak) IBOutlet UILabel *topPace;
@property (nonatomic, weak) IBOutlet UIImageView *trophyImage;

@end

@implementation TrophiesDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
        
    self.trophyName.text = self.trophyStatus.trophy.cityName;
    self.runDistance.text = [ToString stringFromDistance:self.trophyStatus.trophy.distanceToGetTrophy];
    self.dateEarned.text = [NSString stringWithFormat:@"Reached on %@" , [formatter stringFromDate:self.trophyStatus.endedRun.timestamp]];
    self.trophyImage.image = [UIImage imageNamed:self.trophyStatus.trophy.cityImageName];
    self.topPace.text = [NSString stringWithFormat:@"Best: %@, %@", [ToString stringFromAvgPace:(float)self.trophyStatus.bestRun.distance overTime:(int)self.trophyStatus.bestRun.duration], [formatter stringFromDate:self.trophyStatus.bestRun.timestamp]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
