//
//  CustomButton.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 12/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = self.bounds.size.height / 2;
    self.layer.borderWidth = 0;
    self.backgroundColor = [UIColor colorWithRed:62.00/255.00 green:81.00/255.00 blue:181.00/255.00 alpha:1];
    self.layer.borderColor = [UIColor colorWithRed:255.00/255.00 green:82.00/255.00 blue:82.00/255.00 alpha:1].CGColor;
}

@end
