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
#import "ECSlidingViewController.h"
#import "ASIHTTPRequest.h"
#import "NetworkConfigModel.h"

@interface RunSelectController : UITableViewController <UITableViewDelegate, UITableViewDataSource, ASIHTTPRequestDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)revealMenu:(id)sender;

@end
