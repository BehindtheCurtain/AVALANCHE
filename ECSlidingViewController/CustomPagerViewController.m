//
//  CustomPageViewController.m
//  PageViewController
//
//  Created by Tom Fewster on 11/01/2012.
//

#import "CustomPagerViewController.h"


@interface CustomPagerViewController ()

@end

@implementation CustomPagerViewController

- (void)viewDidLoad
{
	// Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];
    
    GaugeViewController* gaugePage1 = [self.storyboard instantiateViewControllerWithIdentifier:@"View1"];
    GaugeViewController* gaugePage2 = [self.storyboard instantiateViewControllerWithIdentifier:@"View2"];
    GaugeViewController* gaugePage3 = [self.storyboard instantiateViewControllerWithIdentifier:@"View3"];
    
    [[FirstTopViewController viewArray] addObject:gaugePage1];
    [[FirstTopViewController viewArray] addObject:gaugePage2];
    [[FirstTopViewController viewArray] addObject:gaugePage3];
    
    [gaugePage1 setGaugeDisplays:[[GaugeDisplayModel alloc] init]];
    [gaugePage2 setGaugeDisplays:[[GaugeDisplayModel alloc] init]];
    [gaugePage3 setGaugeDisplays:[[GaugeDisplayModel alloc] init]];
    
    [[[gaugePage1 gaugeDisplays] sensors] addObject:@"Temperature1"];
    [[[gaugePage1 gaugeDisplays] sensors] addObject:@"Temperature2"];
    [[[gaugePage1 gaugeDisplays] sensors] addObject:@"Temperature3"];
    [[[gaugePage1 gaugeDisplays] sensors] addObject:@"Temperature4"];
    
    [[[gaugePage2 gaugeDisplays] sensors] addObject:@"Pressure1"];
    [[[gaugePage2 gaugeDisplays] sensors] addObject:@"Pressure2"];
    [[[gaugePage2 gaugeDisplays] sensors] addObject:@"Pressure3"];
    [[[gaugePage2 gaugeDisplays] sensors] addObject:@"AirFuel1"];
    
    [[[gaugePage3 gaugeDisplays] sensors] addObject:@"RPM1"];
    [[[gaugePage3 gaugeDisplays] sensors] addObject:@"RPM2"];
    [[[gaugePage3 gaugeDisplays] sensors] addObject:@"RPM3"];
    [[[gaugePage3 gaugeDisplays] sensors] addObject:@"AirFuel2"];
    
    [gaugePage1 setPage:1];
    [gaugePage2 setPage:2];
    [gaugePage3 setPage:3];

	[self addChildViewController:gaugePage1];
	[self addChildViewController:gaugePage2];
	[self addChildViewController:gaugePage3];
}

@end
