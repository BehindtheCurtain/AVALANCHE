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

static void * const sensor1Context = (void*)&sensor1Context;
static void * const sensor2Context = (void*)&sensor2Context;
static void * const sensor3Context = (void*)&sensor3Context;
static void * const sensor4Context = (void*)&sensor4Context;

@implementation GaugeViewController
@synthesize firstGoalBar;
@synthesize secondGoalBar;
@synthesize thirdGoalBar;
@synthesize fourthGoalBar;

@synthesize page;
@synthesize gaugeDisplays;

- (void)viewDidLoad
{
    [super viewDidLoad];
        
	[firstGoalBar setAllowDragging:NO];
    [firstGoalBar setAllowDecimal:YES];
    [firstGoalBar setAllowTap:NO];
    [firstGoalBar setAllowSwitching:NO];
    [firstGoalBar setPercent:0 animated:NO];
    [firstGoalBar setCustomText:[NSString stringWithFormat:@" "]];
    
	[secondGoalBar setAllowDragging:NO];
    [secondGoalBar setAllowDecimal:YES];
    [secondGoalBar setAllowTap:NO];
    [secondGoalBar setAllowSwitching:NO];
    [secondGoalBar setPercent:0 animated:NO];
    [secondGoalBar setCustomText:[NSString stringWithFormat:@" "]];
    
    [thirdGoalBar setAllowDragging:NO];
    [thirdGoalBar setAllowDecimal:YES];
    [thirdGoalBar setAllowTap:NO];
    [thirdGoalBar setAllowSwitching:NO];
    [thirdGoalBar setPercent:0 animated:NO];
    [thirdGoalBar setCustomText:[NSString stringWithFormat:@" "]];
    
    [fourthGoalBar setAllowDragging:NO];
    [fourthGoalBar setAllowDecimal:YES];
    [fourthGoalBar setAllowTap:NO];
    [fourthGoalBar setAllowSwitching:NO];
    [fourthGoalBar setPercent:0 animated:NO];
    [fourthGoalBar setCustomText:[NSString stringWithFormat:@" "]];
    
    [self setObservers];
}


- (void)setObservers
{

    //if([[GaugeDisplayModel alloc] initwithPage:self.page] != nil)
    {
      //  self.gaugeDisplays = [[GaugeDisplayModel alloc] initwithPage:self.page];
    }
    
    if(self.gaugeDisplays != nil)
    {
    
        NSString* observe1 = [[self.gaugeDisplays sensors] objectAtIndex:0];
        NSString* observe2 = [[self.gaugeDisplays sensors] objectAtIndex:1];
        NSString* observe3 = [[self.gaugeDisplays sensors] objectAtIndex:2];
        NSString* observe4 = [[self.gaugeDisplays sensors] objectAtIndex:3];
        
        SensorAggregateModel* aggregate1 = [[[GaugeModel instance:NO] sensorAggregateModelMap] objectForKey:observe1];
        SensorAggregateModel* aggregate2 = [[[GaugeModel instance:NO] sensorAggregateModelMap] objectForKey:observe2];
        SensorAggregateModel* aggregate3 = [[[GaugeModel instance:NO] sensorAggregateModelMap] objectForKey:observe3];
        SensorAggregateModel* aggregate4 = [[[GaugeModel instance:NO] sensorAggregateModelMap] objectForKey:observe4];
        self.sensorLabel1.text = [aggregate1 sensorName];
        self.sensorLabel2.text = [aggregate2 sensorName];
        self.sensorLabel3.text = [aggregate3 sensorName];
        self.sensorLabel4.text = [aggregate4 sensorName];
        
        [aggregate1 addObserver:self forKeyPath:@"snapshots" options:NSKeyValueObservingOptionNew context:sensor1Context];
        [aggregate2 addObserver:self forKeyPath:@"snapshots" options:NSKeyValueObservingOptionNew context:sensor2Context];
        [aggregate3 addObserver:self forKeyPath:@"snapshots" options:NSKeyValueObservingOptionNew context:sensor3Context];
        [aggregate4 addObserver:self forKeyPath:@"snapshots" options:NSKeyValueObservingOptionNew context:sensor4Context];
    }
    
    //[self.gaugeDisplays archive:self.page];
}

- (void)removeObservers
{
    if(self.gaugeDisplays != nil)
    {

        NSString* observe1 = [[self.gaugeDisplays sensors] objectAtIndex:0];
        NSString* observe2 = [[self.gaugeDisplays sensors] objectAtIndex:1];
        NSString* observe3 = [[self.gaugeDisplays sensors] objectAtIndex:2];
        NSString* observe4 = [[self.gaugeDisplays sensors] objectAtIndex:3];

        [[[[GaugeModel instance:NO] sensorAggregateModelMap] objectForKey:observe1] removeObserver:self forKeyPath:@"snapshots"];
        [[[[GaugeModel instance:NO] sensorAggregateModelMap] objectForKey:observe2] removeObserver:self forKeyPath:@"snapshots"];
        [[[[GaugeModel instance:NO] sensorAggregateModelMap] objectForKey:observe3] removeObserver:self forKeyPath:@"snapshots"];
        [[[[GaugeModel instance:NO] sensorAggregateModelMap] objectForKey:observe4] removeObserver:self forKeyPath:@"snapshots"];
    }
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSIndexSet* set = [change objectForKey:NSKeyValueChangeIndexesKey];
    SensorSnapshotModel* snapshot = [[object snapshots] objectAtIndex:[set firstIndex]];
    KDGoalBar* current = nil;
    NSString* key = nil;
    
    if(context == sensor1Context)
    {
        current = firstGoalBar;
        key = [[self.gaugeDisplays sensors] objectAtIndex:0];
        
    }
    else if(context == sensor2Context)
    {
        current = secondGoalBar;
        key = [[self.gaugeDisplays sensors] objectAtIndex:1];
    }
    else if(context == sensor3Context)
    {
        current = thirdGoalBar;
        key = [[self.gaugeDisplays sensors] objectAtIndex:2];
    }
    else if(context == sensor4Context)
    {
        current = fourthGoalBar;
        key = [[self.gaugeDisplays sensors] objectAtIndex:3];
    }
    
    int high = [object warningHigh];
    int low = [object warningLow];
    
    if([key rangeOfString:@"Temperature"].location != NSNotFound)
    {
        int sensorData = [snapshot sensorData];
        double percent = sensorData;
        if(sensorData >= 0)
        {
            percent /= high;
            percent *= 100;
            
            if(percent <= 60)
            {
                [current setBarColor:[UIColor greenColor]];
            }
            else if(percent <= 80)
            {
                [current setBarColor:[UIColor orangeColor]];
            }
            else
            {
                [current setBarColor:[UIColor redColor]];
            }
        }
        else
        {
            percent /= low;
            percent *= 100;
            
            
            if(percent <= 80)
            {
                [current setBarColor:[UIColor cyanColor]];
            }
            else
            {
                [current setBarColor:[UIColor redColor]];
            }
            
            percent *= -1;
        }
        
        [current setPercent:percent animated:NO];
        [current setCustomText:[NSString stringWithFormat:@"%u °F", sensorData]];
    }
    else if([key rangeOfString:@"Pressure"].location != NSNotFound)
    {
        int sensorData = [snapshot sensorData];
        double percent = sensorData;
        if(sensorData >= 0)
        {
            percent /= (high * 10);
            percent *= 100;
            
            if(percent <= 60)
            {
                [current setBarColor:[UIColor greenColor]];
            }
            else if(percent <= 80)
            {
                [current setBarColor:[UIColor orangeColor]];
            }
            else
            {
                [current setBarColor:[UIColor redColor]];
            }
        }
        else
        {
            percent /= low;
            percent *= 100;
            
            
            if(percent <= 80)
            {
                [current setBarColor:[UIColor cyanColor]];
            }
            else
            {
                [current setBarColor:[UIColor redColor]];
            }
        }
        
        double data = sensorData;
        data /= 10;
        [current setPercent:percent animated:NO];
        [current setCustomText:[NSString stringWithFormat:@"%.1f PSI", data]];
    }
    else if([key rangeOfString:@"RPM"].location != NSNotFound)
    {

        int sensorData = [snapshot sensorData];
        double percent = sensorData;
        if(sensorData >= 0)
        {
            percent /= high;
            percent *= 100;
            
            if(percent <= 60)
            {
                [current setBarColor:[UIColor greenColor]];
            }
            else if(percent <= 80)
            {
                [current setBarColor:[UIColor orangeColor]];
            }
            else
            {
                [current setBarColor:[UIColor redColor]];
            }
        }
        
        [current setPercent:percent animated:NO];
        [current setCustomText:[NSString stringWithFormat:@"%u", sensorData]];
    }
    else if([key rangeOfString:@"AirFuel"].location != NSNotFound)
    {

        int sensorData = [snapshot sensorData];
        double percent = sensorData;
        if(sensorData >= 0)
        {
            percent /= high;
            percent *= 100;
            
            if(percent <= 60)
            {
                [current setBarColor:[UIColor greenColor]];
            }
            else if(percent <= 80)
            {
                [current setBarColor:[UIColor orangeColor]];
            }
            else
            {
                [current setBarColor:[UIColor redColor]];
            }
        }
        else
        {
            percent /= low;
            percent *= 100;
            
            
            if(percent <= 80)
            {
                [current setBarColor:[UIColor cyanColor]];
            }
            else
            {
                [current setBarColor:[UIColor redColor]];
            }
            
        }
        
        double data = sensorData;
        data /= 100;
        [current setPercent:percent animated:NO];
        [current setCustomText:[NSString stringWithFormat:@"%.2f %%", data]];
    }
}

- (void)viewDidUnload
{
    [self setFourthGoalBar:nil];
    [self setThirdGoalBar:nil];
    [self setSecondGoalBar:nil];
    [self setFirstGoalBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

/*
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[BLEGaugeAlarmService instance:NO] disconnect];
    [[[[GaugeModel instance:NO] sensorAggregateModelMap] objectForKey:@"Temperature1"] removeObserver:self forKeyPath:@"snapshots"];
    [[[[GaugeModel instance:NO] sensorAggregateModelMap] objectForKey:@"Temperature2"] removeObserver:self forKeyPath:@"snapshots"];
    [[[[GaugeModel instance:NO] sensorAggregateModelMap] objectForKey:@"Temperature3"] removeObserver:self forKeyPath:@"snapshots"];
    [[[[GaugeModel instance:NO] sensorAggregateModelMap] objectForKey:@"Temperature4"] removeObserver:self forKeyPath:@"snapshots"];
}
*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
