//
//  CellTrophy.h
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 10/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellTrophy : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *name;
@property (nonatomic, weak) IBOutlet UILabel *trophyDescription;
@property (nonatomic, weak) IBOutlet UIImageView *trophyImage;

@end
