//
//  RunSelectController.h
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/16/13.
//
//

#import <UIKit/UIKit.h>
#import "RunListModel.h"
#import "RunModel.h"
#import "RunViewController.h"
#import "ECSlidingViewController.h"

@interface RunSelectController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)revealMenu:(id)sender;

@end
