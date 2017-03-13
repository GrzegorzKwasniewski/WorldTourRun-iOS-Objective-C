//
//  FacebookStrategy.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 13/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import <Social/Social.h>

#import "FacebookStrategy.h"

@implementation FacebookStrategy

-(SLComposeViewController *)createSheetWith:(Run *)userRunDetails {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController * tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:[NSString stringWithFormat:@"My new run stats: Distance: %0.2f Time: %hd", userRunDetails.distance, userRunDetails.duration]];
        return tweetSheet;
    }
    
    return nil;
    
}

@end
