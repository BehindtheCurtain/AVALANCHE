//
//  ServerConfigController.m
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/22/13.
//
//

#import "ServerConfigController.h"

@interface ServerConfigController ()

@end

@implementation ServerConfigController

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
	
    self.navigationItem.title = @"Configure Server Settings";
    
    [self.ipField setText:[[NetworkConfigModel instance:NO] serverIP]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NetworkConfigModel instance:NO] setServerIP:[self.ipField text]];
    [[NetworkConfigModel instance:NO] archive];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.ipField && [self.ipField isFirstResponder])
    {
        [self.ipField resignFirstResponder];
    }
    
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField selectAll:nil];
}

@end
