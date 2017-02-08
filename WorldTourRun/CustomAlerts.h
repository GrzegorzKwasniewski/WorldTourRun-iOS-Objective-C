//
//  CustomAlerts.h
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 08/02/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const SAVE_NEW_RUN_EVENT;

@interface CustomAlerts : UIAlertController

+(UIAlertController *)createAlertWithTitle:(NSString *)title withMessage:(NSString *)message withNotification:(NSString *) notification;

@end
