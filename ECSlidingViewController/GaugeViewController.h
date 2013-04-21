//
//  GaugeViewController.h
//  KnobSampleProject
//
//  Created by Kevin Donnelly on 5/17/12.
//  Copyright (c) 2012 -. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KDGoalBar.h"
#import "KDBarGraph.h"
#import "RealTimeBuilder.h"
#import "BLEGaugeAlarmService.h"
#import "GaugeModel.h"

#import "AppDelegate.h"
#import "SensorAggregateModel.h"
#import "SensorSnapshotModel.h"


@interface GaugeViewController : UIViewController

@property (weak, nonatomic) IBOutlet KDGoalBar *firstGoalBar;
@property (weak, nonatomic) IBOutlet KDGoalBar *secondGoalBar;
@property (weak, nonatomic) IBOutlet KDGoalBar *thirdGoalBar;
@property (weak, nonatomic) IBOutlet KDGoalBar *fourthGoalBar;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *startButton;
- (IBAction)startAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *endButton;
- (IBAction)endAction:(id)sender;

@end