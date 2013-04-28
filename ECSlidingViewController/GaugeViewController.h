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
#import "GaugeDisplayModel.h"
#import "ConfigurationModel.h"
#import "ConfigurationModelMap.h"


@interface GaugeViewController : UIViewController //<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet KDGoalBar *firstGoalBar;
@property (weak, nonatomic) IBOutlet KDGoalBar *secondGoalBar;
@property (weak, nonatomic) IBOutlet KDGoalBar *thirdGoalBar;
@property (weak, nonatomic) IBOutlet KDGoalBar *fourthGoalBar;

@property (weak, nonatomic) IBOutlet UILabel *sensorLabel1;
@property (weak, nonatomic) IBOutlet UILabel *sensorLabel2;
@property (weak, nonatomic) IBOutlet UILabel *sensorLabel3;
@property (weak, nonatomic) IBOutlet UILabel *sensorLabel4;


@property (assign) int page;
@property (retain) GaugeDisplayModel* gaugeDisplays;

- (void)setObservers;
- (void)removeObservers;

@end