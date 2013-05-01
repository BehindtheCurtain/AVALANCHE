//
//  AddSensorController.m
//  ECSlidingViewController
//
//  Created by BehindTheCurtain on 4/1/13.
//
//

#import "AddSensorController.h"
#import "ConfigurationModel.h"

@interface AddSensorController ()

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
    self.sensorType = @"Temperature";
    
    
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
    else if(textField == self.maxValueField && [self.maxValueField isFirstResponder])
    {
        [self.maxValueField resignFirstResponder];
    }
    else if(textField == self.minValueField && [self.minValueField isFirstResponder])
    {
        [self.minValueField resignFirstResponder];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if(cell == self.temperature)
    {
        self.temperature.accessoryType = UITableViewCellAccessoryCheckmark;
        self.pressure.accessoryType = UITableViewCellAccessoryNone;
        self.rpm.accessoryType = UITableViewCellAccessoryNone;
        self.airFuel.accessoryType = UITableViewCellAccessoryNone;
        
        self.sensorType = @"Temperature";
    }
    else if(cell == self.pressure)
    {
        self.temperature.accessoryType = UITableViewCellAccessoryNone;
        self.pressure.accessoryType = UITableViewCellAccessoryCheckmark;
        self.rpm.accessoryType = UITableViewCellAccessoryNone;
        self.airFuel.accessoryType = UITableViewCellAccessoryNone;
        
        self.sensorType = @"Pressure";
    }
    else if(cell == self.rpm)
    {
        self.temperature.accessoryType = UITableViewCellAccessoryNone;
        self.pressure.accessoryType = UITableViewCellAccessoryNone;
        self.rpm.accessoryType = UITableViewCellAccessoryCheckmark;
        self.airFuel.accessoryType = UITableViewCellAccessoryNone;
    
        self.sensorType = @"RPM";
    }
    else if(cell == self.airFuel)
    {
        self.temperature.accessoryType = UITableViewCellAccessoryNone;
        self.pressure.accessoryType = UITableViewCellAccessoryNone;
        self.rpm.accessoryType = UITableViewCellAccessoryNone;
        self.airFuel.accessoryType = UITableViewCellAccessoryCheckmark;
    
        self.sensorType = @"AirFuel";
    }
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
        
        if([self.sensorType isEqualToString:@"Temperature"])
        {
            [configuration setSensorType:Temperature];
            
            if([self.maxValueField.text length] != 0)
            {
                [configuration setMaxValue:[self.maxValueField.text intValue]];
            }
            else
            {
                [configuration setMaxValue:2501];
            }
            
            if([self.minValueField.text length] != 0)
            {
                [configuration setMinValue:[self.minValueField.text intValue]];
            }
            else
            {
                [configuration setMinValue:-346];
            }
        }
        
        else if([self.sensorType isEqualToString:@"Pressure"])
        {
            [configuration setSensorType:Pressure];
            
            if([self.maxValueField.text length] != 0)
            {
                [configuration setMaxValue:[self.maxValueField.text intValue]];
            }
            else
            {
                [configuration setMaxValue:100];
            }
            
            if([self.minValueField.text length] != 0)
            {
                [configuration setMinValue:[self.minValueField.text intValue]];
            }
            else
            {
                [configuration setMinValue:-100];
            }
        }
        
        else if([self.sensorType isEqualToString:@"RPM"])
        {
            [configuration setSensorType:RPM];
            
            if([self.maxValueField.text length] != 0)
            {
                [configuration setMaxValue:[self.maxValueField.text intValue]];
            }
            else
            {
                [configuration setMaxValue:8400];
            }
            
            if([self.minValueField.text length] != 0)
            {
                [configuration setMinValue:[self.minValueField.text intValue]];
            }
            else
            {
                [configuration setMinValue:0];
            }
        }
        
        else if([self.sensorType isEqualToString:@"AirFuel"])
        {
            [configuration setSensorType:AirFuel];
            
            if([self.maxValueField.text length] != 0)
            {
                double max = [self.maxValueField.text doubleValue];
                max *= 100;
                [configuration setMaxValue:(int)max];
            }
            else
            {
                [configuration setMaxValue:14875];
            }
            
            if([self.minValueField.text length] != 0)
            {
                double min = [self.minValueField.text doubleValue];
                min *= 100;
                [configuration setMinValue:(int)min];
            }
            else
            {
                [configuration setMinValue:-712];
            }
        }
        
        // Active Switch
        [configuration setActive:self.activeSwitch.isOn];
        
        [[[ConfigurationModelMap instance:NO] configurationMap] addObject:configuration];
        [[ConfigurationModelMap instance:NO] archive];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
