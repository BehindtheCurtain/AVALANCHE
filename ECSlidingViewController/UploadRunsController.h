//
//  UploadRunsController.h
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/27/13.
//
//

#import <UIKit/UIKit.h>
#import "RunListModel.h"
#import "RunModel.h"
#import "ECSlidingViewController.h"
#import "ASIHTTPRequest.h"
#import "NetworkConfigModel.h"
#import "UserModel.h"

@interface UploadRunsController : UITableViewController <UITableViewDelegate, UITableViewDataSource, ASIHTTPRequestDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)revealMenu:(id)sender;

@end
