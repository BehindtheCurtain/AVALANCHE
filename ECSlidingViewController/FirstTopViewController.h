//
//  FirstTopViewController.h
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/23/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "UnderRightViewController.h"
#import "RealTimeBuilder.h"
#import "BLEGaugeAlarmService.h"
#import "GaugeViewController.h"

@interface FirstTopViewController : UIViewController

- (IBAction)revealMenu:(id)sender;

- (IBAction)startAction:(id)sender;

- (IBAction)endAction:(id)sender;

+ (NSMutableArray*)viewArray;
+ (void)setViewArray:(NSMutableArray*) views;
@end
