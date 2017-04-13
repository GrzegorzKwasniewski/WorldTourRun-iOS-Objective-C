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
    
    //self.backgroundColor = UIColorFromRGB(0x3E51B5);
    //self.layer.borderWidth = 0;
    //self.layer.borderColor = UIColorFromRGB(0xFF5252).CGColor;
}

-(void)layoutSubviews {
    self.layer.cornerRadius = self.bounds.size.height / 2;
    [super layoutSubviews];
}

@end
