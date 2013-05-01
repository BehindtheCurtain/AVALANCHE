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
    
    GaugeViewController* gaugePage1 = [self.storyboard instantiateViewControllerWithIdentifier:@"gaugeView"];
    GaugeViewController* gaugePage2 = [self.storyboard instantiateViewControllerWithIdentifier:@"gaugeView"];
    GaugeViewController* gaugePage3 = [self.storyboard instantiateViewControllerWithIdentifier:@"gaugeView"];
    
    
    [gaugePage1 setPage:1];
    [gaugePage2 setPage:2];
    [gaugePage3 setPage:3];
    
    [gaugePage1 setGaugeDisplays:[[GaugeDisplayModel alloc] initwithPage:1]];
    [gaugePage2 setGaugeDisplays:[[GaugeDisplayModel alloc] initwithPage:2]];
    [gaugePage3 setGaugeDisplays:[[GaugeDisplayModel alloc] initwithPage:3]];

	[self addChildViewController:gaugePage1];
	[self addChildViewController:gaugePage2];
	[self addChildViewController:gaugePage3];
    
    
    [[FirstTopViewController viewArray] addObject:gaugePage1];
    [[FirstTopViewController viewArray] addObject:gaugePage2];
}

@end
