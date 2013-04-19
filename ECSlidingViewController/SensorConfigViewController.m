//
//  SensorConfigViewController.m
//  ECSlidingViewController
//
//  Created by BehindTheCurtain on 3/26/13.
//
//

#import "SensorConfigViewController.h"
#define NUMBERS @"1234567890"

@interface SensorConfigViewController () <UITextFieldDelegate>

@end

@implementation SensorConfigViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.configuration = [[ConfigurationModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.sensorNameField setDelegate:self];
    //[self.transformConstantField setDelegate:self];
    
    self.navigationItem.title = [self.configuration getType];
	
    [self.sensorNameField setText: [self.configuration name]];
    [self.transformConstantField setText: [NSString stringWithFormat:@"%d", [self.configuration transformConstant]]];
    
    if([[self.configuration getType] isEqualToString:@"AirFuel"])
    {
        [self.maxValueField setText:[NSString stringWithFormat:@"%.2f", (float)[self.configuration maxValue] / 100]];
        [self.minValueField setText:[NSString stringWithFormat:@"%.2f", (float)[self.configuration minValue] / 100]];
    }
    else
    {
        [self.maxValueField setText:[NSString stringWithFormat:@"%d", [self.configuration maxValue]]];
        [self.minValueField setText:[NSString stringWithFormat:@"%d", [self.configuration minValue]]];
    }
    
    [self.activeSwitch setOn:[self.configuration active]];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.configuration setName: [self.sensorNameField text]];
    [self.configuration setTransformConstant: [[self.transformConstantField text] intValue]];
    
    if([[self.configuration getType] isEqualToString:@"AirFuel"])
    {
        float max = [[self.maxValueField text] floatValue];
        float min = [[self.minValueField text] floatValue];
        
        [self.configuration setMaxValue:(int)(max * 100)];
        [self.configuration setMinValue:(int)(min * 100)];
    }
    else
    {
        [self.configuration setMaxValue:[[self.maxValueField text] intValue]];
        [self.configuration setMinValue:[[self.minValueField text] intValue]];
    }
    [self.configuration setActive:[self.activeSwitch isOn]];
    
    [[ConfigurationModelMap instance:NO] archive];
    
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

@end
