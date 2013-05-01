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

@interface AddSensorController : UITableViewController <UITextFieldDelegate, UIActionSheetDelegate, UITableViewDelegate>
{
}

@property (weak, nonatomic) IBOutlet UITextField *sensorNameField;
@property (weak, nonatomic) IBOutlet UITextField *transformConstantField;
@property (weak, nonatomic) IBOutlet UITextField *sensorIDField;
@property (weak, nonatomic) IBOutlet UITextField *maxValueField;
@property (weak, nonatomic) IBOutlet UITextField *minValueField;
@property (weak, nonatomic) IBOutlet UISwitch *activeSwitch;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;


@property (nonatomic,copy) NSString *sensorType;

@property (weak, nonatomic) IBOutlet UITableViewCell *temperature;
@property (weak, nonatomic) IBOutlet UITableViewCell *pressure;
@property (weak, nonatomic) IBOutlet UITableViewCell *rpm;
@property (weak, nonatomic) IBOutlet UITableViewCell *airFuel;


- (IBAction)save:(id)sender;
@end
