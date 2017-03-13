//
//  CustomImage.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 13/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import "CustomImage.h"

@implementation CustomImage

-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = self.bounds.size.height / 2;
    self.clipsToBounds = YES;
    self.layer.borderWidth = 2;
    self.backgroundColor = UIColorFromRGB(0xFF5252);
    self.layer.borderColor = UIColorFromRGB(0x3E51B5).CGColor;
}

@end
