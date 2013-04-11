//
//  SensorTableController.h
//  ECSlidingViewController
//
//  Created by BehindTheCurtain on 3/28/13.
//
//

#import <UIKit/UIKit.h>
#import "ConfigurationModelMap.h"
#import "SensorConfigViewController.h"

@interface SensorTableController : UITableViewController <UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

- (IBAction)resetAction:(id)sender;

@end
