//
//  GaugeViewController.m
//  KnobSampleProject
//
//  Created by Kevin Donnelly on 5/17/12.
//  Copyright (c) 2012 -. All rights reserved.
//

#import "GaugeViewController.h"

@interface GaugeViewController ()

@end

//TEST
static void * const temp1Context = (void*)&temp1Context;
static void * const temp2Context = (void*)&temp2Context;
static void * const temp3Context = (void*)&temp3Context;
static void * const temp4Context = (void*)&temp4Context;
//TEST

@implementation GaugeViewController
@synthesize firstGoalBar;
@synthesize secondGoalBar;
@synthesize thirdGoalBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	[firstGoalBar setAllowDragging:NO];
    [firstGoalBar setAllowDecimal:YES];
    [firstGoalBar setAllowTap:NO];
    [firstGoalBar setAllowSwitching:NO];
    [firstGoalBar setPercent:0 animated:NO];
    
	[secondGoalBar setAllowDragging:NO];
    [secondGoalBar setAllowDecimal:YES];
    [secondGoalBar setAllowTap:NO];
    [secondGoalBar setAllowSwitching:NO];
    [secondGoalBar setPercent:0 animated:NO];
    
    [thirdGoalBar setAllowDragging:NO];
    [thirdGoalBar setAllowDecimal:YES];
    [thirdGoalBar setAllowTap:NO];
    [thirdGoalBar setAllowSwitching:NO];
    [thirdGoalBar setPercent:0 animated:NO];
}





- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [RealTimeBuilder gaugeModelFactory];
    
    [[[[GaugeModel instance:NO] sensorAggregateModelMap] objectForKey:@"Temperature0"] addObserver:self forKeyPath:@"snapshots" options:NSKeyValueObservingOptionNew context:temp1Context];
    [[[[GaugeModel instance:NO] sensorAggregateModelMap] objectForKey:@"Temperature1"] addObserver:self forKeyPath:@"snapshots" options:NSKeyValueObservingOptionNew context:temp2Context];
    [[[[GaugeModel instance:NO] sensorAggregateModelMap] objectForKey:@"Temperature2"] addObserver:self forKeyPath:@"snapshots" options:NSKeyValueObservingOptionNew context:temp3Context];
    [[[[GaugeModel instance:NO] sensorAggregateModelMap] objectForKey:@"Temperature3"] addObserver:self forKeyPath:@"snapshots" options:NSKeyValueObservingOptionNew context:temp4Context];
    
    [BLEGaugeAlarmService instance];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSIndexSet* set = [change objectForKey:NSKeyValueChangeIndexesKey];
    SensorSnapshotModel* snapshot = [[object snapshots] objectAtIndex:[set firstIndex]];
    
    if(context == temp1Context)
    {
        [firstGoalBar setPercent:[snapshot sensorData]/25 animated:NO];
    }
    else if(context == temp2Context)
    {
        [secondGoalBar setPercent:[snapshot sensorData]/25 animated:NO];
    }
    else if(context == temp3Context)
    {
        [thirdGoalBar setPercent:[snapshot sensorData]/25 animated:NO];
    }
//     else if(context == temp4Context)
//     {
//         
//     }
}





- (void)viewDidUnload
{
    [self setThirdGoalBar:nil];
    [self setSecondGoalBar:nil];
    [self setFirstGoalBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
