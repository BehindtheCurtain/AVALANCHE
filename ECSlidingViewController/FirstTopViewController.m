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

@synthesize page;
@synthesize sensorIndex;

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

- (void)viewWillDisappear:(BOOL)animated
{
    for(GaugeViewController* gaugeView in viewArray)
    {
        [gaugeView removeObservers];
    }
    
    [[BLEGaugeAlarmService instance:NO] disconnect];
}


- (IBAction)twoTapAction:(id)sender
{
    CGPoint location = [self.twoTap locationInView:self.view];
    
    if((location.x >= 30 && location.y >= 20) && (location.x <= 150 && location.y <= 140))
    {
        self.page = [CustomPagerViewController pageWatch];
        self.sensorIndex = 0;  
        [self showPicker];
    }
    else if((location.x >= 158 && location.y >= 20) && (location.x <= 278 && location.y <= 140))
    {
        self.page = [CustomPagerViewController pageWatch];
        self.sensorIndex = 1;
        [self showPicker];
    }
    else if((location.x >= 268 && location.y >= 20) && (location.x <= 406 && location.y <= 140))
    {
        self.page = [CustomPagerViewController pageWatch];
        self.sensorIndex = 2;
        [self showPicker];
    }
    else if((location.x >= 414 && location.y >= 20) && (location.x <= 534 && location.y <= 140))
    {
        self.page = [CustomPagerViewController pageWatch];
        self.sensorIndex = 3;
        [self showPicker];
    }
}

- (IBAction)revealMenu:(id)sender
{
  [self.slidingViewController anchorTopViewTo:ECRight];
}

- (IBAction)endAction:(id)sender
{
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

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //One column
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //set number of rows
    return [[[ConfigurationModelMap instance:NO] configurationMap] count];
}
-(NSString *)pickerView:(UIPickerView *)e titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //set item per row
    return [[[ConfigurationModelMap instance:NO] sensorNames] objectAtIndex:row];
}


//Show sensor type picker
- (void)showPicker
{
    GaugeViewController* gauge = [viewArray objectAtIndex:self.page];
    
    NSArray* names = [[ConfigurationModelMap instance:NO] sensorNames];
    
    NSString* key = [[[gauge gaugeDisplays] sensors] objectAtIndex:self.sensorIndex];
    
    NSString* name = [[[ConfigurationModelMap instance:NO] keyMapping] objectForKey:key];
    
    int index = [[[ConfigurationModelMap instance:NO] sensorNames] indexOfObject:name];
    
    [self.picker selectRow:index inComponent:0 animated:NO];
    
    self.picker.hidden = NO;
    self.pickerBar.hidden = NO;
}

- (IBAction)dismissAction:(id)sender
{
    NSString* name = [[[ConfigurationModelMap instance:NO] sensorNames] objectAtIndex:[self.picker selectedRowInComponent:0]];
    NSString* key = [[[ConfigurationModelMap instance:NO] nameMapping] objectForKey:name];
    
    GaugeViewController* gauge = [viewArray objectAtIndex:self.page];
    [gauge removeObservers];
    
    [[[gauge gaugeDisplays] sensors] removeObjectAtIndex:self.sensorIndex];
    [[[gauge gaugeDisplays] sensors] insertObject:key atIndex:self.sensorIndex];
    [[gauge gaugeDisplays] archive:(self.page + 1)];
    
    [gauge setObservers];
    
    self.picker.hidden = YES;
    self.pickerBar.hidden = YES;
}

@end
