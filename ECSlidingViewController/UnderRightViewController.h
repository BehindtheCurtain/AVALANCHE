//
//  UnderRightViewController.h
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/23/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "NetworkManager.h"
#import <sys/socket.h>
#import <sys/dirent.h>

#import <CFNetwork/CFNetwork.h>

@interface UnderRightViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, NSStreamDelegate, UISearchBarDelegate>

@end
