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

@interface FirstTopViewController : UIViewController

- (IBAction)revealMenu:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *startButton;
- (IBAction)startAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *endButton;
- (IBAction)endAction:(id)sender;

@end
