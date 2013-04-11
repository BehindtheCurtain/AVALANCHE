//
//  RealTimeViewController.h
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/4/13.
//
//

#import <UIKit/UIKit.h>
#import "GaugeModel.h"
#import "SensorAggregateModel.h"
#import "SensorSnapshotModel.h"
#import "RealTimeBuilder.h"

@interface RealTimeViewControllerTest : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;
@property (weak, nonatomic) IBOutlet UILabel *sensorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sensorTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sensorIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *sensorDataLabel;
@property (weak, nonatomic) IBOutlet UIButton *createButton;

- (IBAction)createAction:(id)sender;

@end
