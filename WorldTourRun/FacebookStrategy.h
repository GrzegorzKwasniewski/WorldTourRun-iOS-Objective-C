//
//  FacebookStrategy.h
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 13/03/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import "Strategy.h"

@interface FacebookStrategy : Strategy

-(SLComposeViewController *)createSheetWith:(Run *)userRunDetails;

@end
