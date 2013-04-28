//
//  SensorSelectController.h
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/28/13.
//
//

#import <UIKit/UIKit.h>
#import "RunModel.h"
#import "GraphViewController.h"

@interface SensorSelectController : UITableViewController

@property (retain) RunModel* run;
@property (retain) NSMutableArray* sensors;
@property (retain) NSMutableDictionary* typeDict;

@end
