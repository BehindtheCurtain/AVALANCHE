//
//  RealTimeController.h
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/10/13.
//
//

#import <UIKit/UIKit.h>
#import "RealTimeBuilder.h"
#import "AppDelegate.h"
#import "SensorAggregateModel.h"
#import "SensorSnapshotModel.h"
#import "BLEGaugeAlarmService.h"

@interface RealTimeController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *temp0Label;
@property (weak, nonatomic) IBOutlet UILabel *temp1Label;
@property (weak, nonatomic) IBOutlet UILabel *temp2Label;
@property (weak, nonatomic) IBOutlet UILabel *temp3Label;

@property (weak, nonatomic) IBOutlet UILabel *serializationLabel;
@property (weak, nonatomic) IBOutlet UIButton *serializeButton;
- (IBAction)serializeAction:(id)sender;
@end
