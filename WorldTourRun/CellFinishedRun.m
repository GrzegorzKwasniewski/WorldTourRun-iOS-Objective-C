//
//  CellFinishedRun.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 14/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import "CellFinishedRun.h"

@implementation CellFinishedRun

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCellWith:(Run *)userRun {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    self.runDate.text = [dateFormatter stringFromDate:userRun.timestamp];
    self.runDuration.text = [NSString stringWithFormat:NSLocalizedString(@"Time: %@", nil), [ToString stringFromSecondCount:userRun.duration usingLongFormat:YES]];
    self.runDistance.text = [NSString stringWithFormat:NSLocalizedString(@"Distance: %@", nil), [ToString stringFromDistance:userRun.distance]];
}

@end
