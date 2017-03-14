//
//  CellFinishedRun.h
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 14/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Run+CoreDataClass.h"
#import "ToString.h"

@interface CellFinishedRun : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *runDate;
@property (nonatomic, weak) IBOutlet UILabel *runDuration;
@property (nonatomic, weak) IBOutlet UILabel *runDistance;

-(void)configureCellWith:(Run *)userRun;

@end
