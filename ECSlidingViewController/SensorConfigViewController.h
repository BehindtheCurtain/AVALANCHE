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

@interface SensorConfigViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITextField *sensorNameField;
@property (weak, nonatomic) IBOutlet UITextField *transformConstantField;
@property (weak, nonatomic) IBOutlet UISwitch *activeSwitch;

@property (retain) ConfigurationModel* configuration;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
- (IBAction)deleteConfig:(id)sender;

@end
