//
//  SecondTopViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/23/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import "SecondTopViewController.h"

@implementation SecondTopViewController

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
    self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
  }
    
    //Allow a 2 finger swipe to reveal the menu
    self.slidingViewController.panGesture.minimumNumberOfTouches = 2;
    self.slidingViewController.panGesture.maximumNumberOfTouches = 2;
    
  [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (IBAction)revealMenu:(id)sender
{
  [self.slidingViewController anchorTopViewTo:ECRight];
}

@end
