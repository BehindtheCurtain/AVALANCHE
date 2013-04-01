//
//  SensorConfigViewController.m
//  ECSlidingViewController
//
//  Created by BehindTheCurtain on 3/26/13.
//
//

#import "SensorConfigViewController.h"
#define NUMBERS @"1234567890"

@interface SensorConfigViewController () <UITextFieldDelegate, UIActionSheetDelegate>

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
    
    self.navigationItem.title = @"Sensor Configuration";
	
    [self.sensorNameField setText: [self.configuration name]];
    [self.transformConstantField setText: [NSString stringWithFormat:@"%d", [self.configuration transformConstant]]];
    [self.activeSwitch setOn:[self.configuration active]];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.configuration setName: [self.sensorNameField text]];
    [self.configuration setTransformConstant: [[self.transformConstantField text] intValue]];
    [self.configuration setActive:[self.activeSwitch isOn]];
    
    [ConfigurationModelMap archive];
    
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
    
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField selectAll:nil];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // Delete button clicked.
    if(buttonIndex == 0)
    {
        NSMutableArray* configMap = [[ConfigurationModelMap instance] configurationMap];
        [configMap removeObjectAtIndex:[configMap indexOfObject:self.configuration]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)deleteConfig:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Confirm Deletion" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete" otherButtonTitles:nil, nil];
    
    [actionSheet showFromRect:[self.view bounds] inView:self.view  animated:NO];
    
    [super viewDidLoad];
}
@end
