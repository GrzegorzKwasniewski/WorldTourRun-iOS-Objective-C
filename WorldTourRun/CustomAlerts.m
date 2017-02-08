//
//  CustomAlerts.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 08/02/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import "CustomAlerts.h"

@interface CustomAlerts()

@end

@implementation CustomAlerts

NSString *const SAVE_NEW_RUN_EVENT = @"SAVE_NEW_RUN_EVENT";

+(UIAlertController *)createAlertWithTitle:(NSString *)title withMessage:(NSString *)message withNotification:(NSString *) notification {
    
    __block NSString *textFiledValue;
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [actionSheet addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([actionSheet.textFields[0].text  isEqual: @""]) {
            textFiledValue = @"Default Name";
        } else {
            textFiledValue = actionSheet.textFields[0].text;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:notification object:textFiledValue];
    }];
    
    [actionSheet addAction:cancelAction];
    [actionSheet addAction:saveAction];
    
    return actionSheet;
}

@end
