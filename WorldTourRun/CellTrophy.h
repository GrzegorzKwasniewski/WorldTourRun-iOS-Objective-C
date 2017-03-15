//
//  CellTrophy.h
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 10/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityTrophy.h"
#import "TrophyStatus.h"
#import "Run+CoreDataClass.h"
#import "ToString.h"

@interface CellTrophy : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *name;
@property (nonatomic, weak) IBOutlet UILabel *trophyDescription;
@property (nonatomic, weak) IBOutlet UIImageView *trophyImage;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;

-(void)configureCellWithTrophyStatus:(TrophyStatus *)trophyStatus;
-(void)configureEmptyCell:(TrophyStatus *)trophyStatus;

@end
