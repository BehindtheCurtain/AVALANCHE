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
#import "UserModel.h"
#import "SensorSelectController.h"


@interface RunSelectController : UITableViewController <UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate>

@property (retain) NSMutableArray* sensors;
@property (retain) NSMutableDictionary* typeDict;
@property (retain) RunModel* selectedRun;
@property (copy) NSString* lastSensor;
@property (copy) NSString* type;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (NSComparisonResult)compareString;
- (IBAction)revealMenu:(id)sender;

@end
