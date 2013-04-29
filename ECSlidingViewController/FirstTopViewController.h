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
#import "RealTimeBuilder.h"
#import "BLEGaugeAlarmService.h"
#import "GaugeViewController.h"
#import "CustomPagerViewController.h"

@interface FirstTopViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *twoTap;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UIToolbar *pickerBar;

@property (assign) int page;
@property (assign) int sensorIndex;
@property (retain) NSString* key;

- (IBAction)dismissAction:(id)sender;

- (IBAction)twoTapAction:(id)sender;


- (IBAction)revealMenu:(id)sender;

- (IBAction)startAction:(id)sender;

- (IBAction)endAction:(id)sender;


+ (NSMutableArray*)viewArray;
+ (void)setViewArray:(NSMutableArray*) views;

- (void)showPicker;
@end
