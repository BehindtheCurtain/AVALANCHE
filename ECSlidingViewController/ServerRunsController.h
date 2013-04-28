//
//  ServerRunsController.h
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/27/13.
//
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "NetworkConfigModel.h"
#import "UserModel.h"
#import "RunListModel.h"
#import "RunModel.h"
#import "ECSlidingViewController.h"

@interface ServerRunsController : UIViewController <UITableViewDataSource, UITableViewDelegate, ASIHTTPRequestDelegate, NSXMLParserDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (retain) NSMutableArray* runs;
@property (copy) NSString* runName;
- (IBAction)revealMenu:(id)sender;

@end
