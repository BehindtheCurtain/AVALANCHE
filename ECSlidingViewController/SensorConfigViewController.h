//
//  SensorConfigViewController.h
//  ECSlidingViewController
//
//  Created by BehindTheCurtain on 3/26/13.
//
//

#import <UIKit/UIKit.h>
#import "ConfigurationModel.h"
#import "ConfigurationModelMap.h"

@interface SensorConfigViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *sensorNameField;
@property (weak, nonatomic) IBOutlet UITextField *transformConstantField;
@property (weak, nonatomic) IBOutlet UITextField *maxValueField;
@property (weak, nonatomic) IBOutlet UITextField *minValueField;
@property (weak, nonatomic) IBOutlet UISwitch *activeSwitch;

@property (retain) ConfigurationModel* configuration;

@end
