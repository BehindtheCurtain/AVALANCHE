//
//  ScanController.h
//  sampleterm
//
//  Created by Michael Testa on 11/1/12.
//  Copyright (c) Blueradios, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ConnectionController.h"
#import "Brsp.h"

@interface ScanController : UIViewController <UITableViewDelegate, UITableViewDataSource, CBCentralManagerDelegate> {
    IBOutlet UITableView *_deviceTableView;
    IBOutlet UIButton *_scanButton;
    NSMutableArray *_peripherals;
}

@property (strong, nonatomic) UITableView* deviceTableView;

//UI Elements
- (IBAction)startScanButton:(id)sender;
- (IBAction)stopScanButton:(id)sender;
- (void)enableButton:(UIButton*)butt;
- (void)disableButton:(UIButton*)butt;
@end
