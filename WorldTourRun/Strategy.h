//
//  Strategy.h
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 13/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Run+CoreDataClass.h"

@interface Strategy : NSObject

-(SLComposeViewController *)createSheetWith:(Run *)userRunDetails;

@end
