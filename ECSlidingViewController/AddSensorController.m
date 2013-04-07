//
//  AddSensorController.m
//  ECSlidingViewController
//
//  Created by BehindTheCurtain on 4/1/13.
//
//

#import "AddSensorController.h"
#import "ConfigurationModel.h"

@interface AddSensorController () <UITextFieldDelegate, UIActionSheetDelegate>

@end

@implementation AddSensorController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Add Sensor";
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.sensorNameField && [self.sensorNameField isFirstResponder])
    {
        [self.sensorNameField resignFirstResponder];
    }
    else if(textField == self.transformConstantField && [self.transformConstantField isFirstResponder])
    {
        [self.transformConstantField resignFirstResponder];
    }
    else if(textField == self.sensorIDField && [self.sensorIDField isFirstResponder])
    {
        [self.sensorIDField resignFirstResponder];
    }
    
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField selectAll:nil];
}

- (IBAction)save:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Create Sensor Configuration" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Create" otherButtonTitles:nil, nil];
    
    [actionSheet showFromRect:[self.view bounds] inView:self.view  animated:NO];
    
    [super viewDidLoad];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // Create button clicked.
    if(buttonIndex == 0)
    {
        ConfigurationModel* configuration = [[ConfigurationModel alloc] init];
        
        // If the text field has a value set the configuration to that, otherwise use a default value.
        if([self.sensorNameField.text length] != 0)
        {
            [configuration setName:self.sensorNameField.text];
        }
        else
        {
            [configuration setName:@"New Sensor"];
        }
        
        // If the text field has a value set the configuration to that, otherwise use a default value.
        if([self.transformConstantField.text length] != 0)
        {
            [configuration setTransformConstant:[self.transformConstantField.text intValue]];
        }
        else
        {
            [configuration setTransformConstant:0];
        }
        
        // If the text field has a value set the configuration to that, otherwise use a default value.
        if([self.sensorIDField.text length] != 0)
        {
            [configuration setSensorID:[self.sensorIDField.text intValue]];
        }
        else
        {
            [configuration setSensorID:1];
        }
        
        [configuration setActive:self.activeSwitch.isOn];
        
        // Placeholder replace when sensorType picker is finished.
        [configuration setSensorType:Tachometer];
        
        [[[ConfigurationModelMap instance] configurationMap] addObject:configuration];
        [[ConfigurationModelMap instance] archive];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//Show sensor type picker
-(IBAction)showPicker:(id)sender{
    self.sensorTypePicker.hidden = NO;
    self.sensorPickerNavBar.hidden = NO;
}

//Hide sensor type picker
-(IBAction)hidePicker:(id)sender{
    self.sensorTypePicker.hidden = YES;
    self.sensorPickerNavBar.hidden = YES;
}

@end
