//
//  GaugeViewController.h
//  KnobSampleProject
//
//  Created by Kevin Donnelly on 5/17/12.
//  Copyright (c) 2012 -. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDGoalBar.h"

//TEST
#import "RealTimeBuilder.h"
#import "BLEGaugeAlarmService.h"
#import "GaugeModel.h"
//TEST


@interface GaugeViewController : UIViewController

@property (weak, nonatomic) IBOutlet KDGoalBar *firstGoalBar;
@property (weak, nonatomic) IBOutlet KDGoalBar *secondGoalBar;
@property (weak, nonatomic) IBOutlet KDGoalBar *thirdGoalBar;

@end