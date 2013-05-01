//
//  HelpPagerViewController.m
//  AVALANCHE
//
//  Created by Austen Herbst on 4/30/13.
//
//

#import "HelpPagerViewController.h"


@interface HelpPagerViewController ()

@end

@implementation HelpPagerViewController

- (void)viewDidLoad
{
	// Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];
    
	[self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"helpView1"]];
	[self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"helpView2"]];
}

@end
