//
//  CellTrophy.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 10/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import "CellTrophy.h"

@implementation CellTrophy

- (void)awakeFromNib {
    [super awakeFromNib];
    self.name.textColor = [UIColor whiteColor];
    self.trophyDescription.textColor = [UIColor whiteColor];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)configureCellWithTrophyStatus:(TrophyStatus *)trophyStatus {
    self.name.text = trophyStatus.trophy.cityName;
    self.trophyDescription.text = [NSString stringWithFormat:NSLocalizedString(@"Earned: %@", nil), [self.dateFormatter stringFromDate:trophyStatus.endedRun.timestamp]];
    self.trophyImage.image = [UIImage imageNamed:trophyStatus.trophy.cityImageName];
    self.userInteractionEnabled = YES;
}

-(void)configureEmptyCell:(TrophyStatus *)trophyStatus {
    self.name.text = @"?????";
    self.trophyDescription.text = [NSString stringWithFormat:NSLocalizedString(@"Run %@ to Earn", nil), [ToString stringFromDistance:trophyStatus.trophy.distanceToGetTrophy]];
    self.trophyImage.image = [UIImage imageNamed:@"question_mark.jpg"];
    self.userInteractionEnabled = NO;
}



@end
