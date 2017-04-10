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
    self.dateEarned.text = [NSString stringWithFormat:NSLocalizedString(@"Earned: %@", nil) , [formatter stringFromDate:self.trophyStatus.endedRun.timestamp]];
    self.trophyImage.image = [UIImage imageNamed:self.trophyStatus.trophy.cityImageName];
    self.topPace.text = [NSString stringWithFormat:NSLocalizedString(@"Best: %@", nil), [ToString stringFromAverageSpeed:(float)self.trophyStatus.bestRun.distance overTime:(int)self.trophyStatus.bestRun.duration]];

}

@end
