//
//  FirstTopViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/23/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import "FirstTopViewController.h"

static NSMutableArray* viewArray;

@implementation FirstTopViewController

+ (NSMutableArray*)viewArray
{
    if(viewArray == nil)
    {
        viewArray = [[NSMutableArray alloc] init];
    }
    
    return viewArray;
}

+ (void)setViewArray:(NSMutableArray *)views
{
    viewArray = views;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  // shadowPath, shadowOffset, and rotation is handled by ECSlidingViewController.
  // You just need to set the opacity, radius, and color.
  self.view.layer.shadowOpacity = 0.75f;
  self.view.layer.shadowRadius = 10.0f;
  self.view.layer.shadowColor = [UIColor blackColor].CGColor;
  
  if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
    self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
  }
   
    //Allow a 2 finger swipe to reveal the menu
    self.slidingViewController.panGesture.minimumNumberOfTouches = 2;
    self.slidingViewController.panGesture.maximumNumberOfTouches = 2;
    
  [self.view addGestureRecognizer:self.slidingViewController.panGesture];
  
    [RealTimeBuilder gaugeModelFactory];
    [BLEGaugeAlarmService instance:NO];
    
    [[GaugeModel instance:NO] setStartTimeStamp:[NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]]];
}

- (IBAction)revealMenu:(id)sender
{
  [self.slidingViewController anchorTopViewTo:ECRight];
}

- (IBAction)endAction:(id)sender
{
    for(GaugeViewController* gaugeView in viewArray)
    {
        [gaugeView removeObservers];
    }
    
    [RealTimeBuilder endProcessing];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)startAction:(id)sender
{
    for(GaugeViewController* gaugeView in viewArray)
    {
        [gaugeView removeObservers];
    }
    
    [RealTimeBuilder beginProcessing];
    
    for(GaugeViewController* gaugeView in viewArray)
    {
        [gaugeView setObservers];
    }
}

@end