//
//  ViewController.m
//  WorldTourRun
//
//  Created by Grzegorz Kwaśniewski on 30/01/17.
//  Copyright © 2017 Grzegorz Kwaśniewski. All rights reserved.
//

#import "StartScreenVC.h"
#import "NewRunVC.h"

@interface StartScreenVC ()

@end

@implementation StartScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// pass managed contex for CoreData
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *nextVC = [segue destinationViewController];
    if ([nextVC isKindOfClass:[NewRunVC class]]) {
        ((NewRunVC *) nextVC).managedObjectContext = self.managedObjectContext;
    }
}

@end
