//
//  AddSensorController.h
//  ECSlidingViewController
//
//  Created by BehindTheCurtain on 4/1/13.
//
//

#import <UIKit/UIKit.h>
#import "ConfigurationModel.h"
#import "ConfigurationModelMap.h"

@interface AddSensorController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITextField *sensorNameField;
@property (weak, nonatomic) IBOutlet UITextField *transformConstantField;
@property (weak, nonatomic) IBOutlet UISwitch *activeSwitch;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *sensorIDButton;
@property (weak, nonatomic) IBOutlet UIButton *sensorTypeButton;

- (IBAction)save:(id)sender;
@end
