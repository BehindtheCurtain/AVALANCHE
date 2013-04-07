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
    
    self.arrStatus = [[NSArray alloc] initWithObjects:@"Tachometer", @"Tempature", @"Oxygen", @"Pressure", @"Voltage", @"PulseRate", @"PulseCount", @"AirFuel", nil];
    
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
        
        // Sensor Name
        // If the text field has a value set the configuration to that, otherwise use a default value.
        if([self.sensorNameField.text length] != 0)
        {
            [configuration setName:self.sensorNameField.text];
        }
        else
        {
            [configuration setName:@"New Sensor"];
        }
        
        // Transform Constant
        // If the text field has a value set the configuration to that, otherwise use a default value.
        if([self.transformConstantField.text length] != 0)
        {
            [configuration setTransformConstant:[self.transformConstantField.text intValue]];
        }
        else
        {
            [configuration setTransformConstant:0];
        }
        
        // Sensor ID
        // If the text field has a value set the configuration to that, otherwise use a default value.
        if([self.sensorIDField.text length] != 0)
        {
            [configuration setSensorID:[self.sensorIDField.text intValue]];
        }
        else
        {
            [configuration setSensorID:1];
        }
        
        // Sensor Type
        switch([self.sensorTypePicker selectedRowInComponent:0])
        {
            case 0:
            {
                [configuration setSensorType:Tachometer];
                break;
            }
            case 1:
            {
                [configuration setSensorType:Tempature];
                break;
            }
            case 2:
            {
                [configuration setSensorType:Oxygen];
                break;
            }
            case 3:
            {
                [configuration setSensorType:Pressure];
                break;
            }
            case 4:
            {
                [configuration setSensorType:Voltage];
                break;
            }
            case 5:
            {
                [configuration setSensorType:PulseRate];
                break;
            }
            case 6:
            {
                [configuration setSensorType:PulseCount];
                break;
            }
            case 7:
            {
                [configuration setSensorType:AirFuel];
                break;
            }
        }
        
        // Active Switch
        [configuration setActive:self.activeSwitch.isOn];
        
        [[[ConfigurationModelMap instance] configurationMap] addObject:configuration];
        [[ConfigurationModelMap instance] archive];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//SensorTypePicker Config
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //One column
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //set number of rows
    return self.arrStatus.count;
}
-(NSString *)pickerView:(UIPickerView *)e titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //set item per row
    return [self.arrStatus objectAtIndex:row];
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
