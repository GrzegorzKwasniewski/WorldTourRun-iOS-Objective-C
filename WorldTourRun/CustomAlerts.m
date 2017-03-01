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
    
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertView addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([alertView.textFields[0].text  isEqual: @""]) {
            textFiledValue = @"Default Name";
        } else {
            textFiledValue = alertView.textFields[0].text;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:notification object:textFiledValue];
    }];
    
    [alertView addAction:cancelAction];
    [alertView addAction:saveAction];
    
    return alertView;
}

+(UIAlertController *)createAlertWithTitle:(NSString *)title withMessage:(NSString *)message {
    
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alertView addAction:cancelAction];
    
    return alertView;
}

@end
