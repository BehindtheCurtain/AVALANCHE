//
//  ConnectionController.m
//  sampleterm
//
//  Created by Michael Testa on 11/1/12.
//  Copyright (c) Blueradios, Inc. All rights reserved.
//

#import "ConnectionController.h"

//Make this number larger or smaller to see more or less output in the textview
#define MAX_TEXT_VIEW_CHARACTERS 800

@implementation ConnectionController

@synthesize textView;
@synthesize inputText = _inputText;
@synthesize buttonChangeMode;
@synthesize buttonSend100;
@synthesize buttonGetSettings;
@synthesize brspObject;

#pragma mark BrspDelegate

- (void)brsp:(Brsp*)brsp OpenStatusChanged:(BOOL)isOpen {
//    NSLog(@"OpenStatusChanged == %d", isOpen);
    if (isOpen) {
        //The BRSP object is ready to be used
        [self enableButtons];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //Print the security level of the brsp service to console
        NSLog(@"BRSP Security Level is %d", brspObject.securityLevel);
    } else {
        //brsp object has been closed
    }
}
- (void)brsp:(Brsp*)brsp SendingStatusChanged:(BOOL)isSending {
    //This is a good place to change BRSP mode
    //If we are on the last command in the queue and we are no longer sending, change the mode back to previous value
    if (isSending == NO && _commandQueue.count == 1)
    {
        if (_lastMode == brspObject.brspMode)
            return;  //Nothing to do here
        //Change mode back to previous setting
        NSError *error = [brspObject changeBrspMode:_lastMode];
        if (error)
            NSLog(@"%@", error);
    }
}
- (void)brspDataReceived:(Brsp*)brsp {
    //If there are items in the _commandQueue array, assume this data is part of a command response
    if (_commandQueue.count > 0)
    {
        //The data incomming is in response to a sent command.
        NSString *response = [self parseFullCommandResponse];
        if (!response)
            return; //Buffer doesn't contain a full command reponse yet;
        
        NSString *responseData = [self parseCommandData:response];
        [self outputCommandWithResponse:responseData];
        
        [_commandQueue removeObjectAtIndex:0]; //Remove last sent command from our queue array
        //Remove the full response from the brsp input buffer
        [brspObject flushInputBuffer:response.length];
        
        if (_commandQueue.count > 0)
            //Send the next command
            [self sendCommand:[_commandQueue objectAtIndex:0]];
        else
        {
            //Done sending commands...
            [self enableButtons];
            //Print a footer
            [self outputToScreen:@"_________________________________________"];
        }
    }
    else
    {
        //The data comming in is not from a sent command
        //Just output the response to screen and remove from the input buffer using a readString
        [self outputToScreen:[brspObject readString]];
    }
}
- (void)brsp:(Brsp*)brsp ErrorReceived:(NSError*)error {
    NSLog(@"%@", error.description);   
}
- (void)brspModeChanged:(Brsp*)brsp BRSPMode:(BrspMode)mode {
//    NSLog(@"BRSP Mode changed to %d", mode);
    switch (mode) {
        case BrspModeData:
            [self.buttonChangeMode setTitle:[NSString stringWithFormat:@"Data"] forState:UIControlStateNormal];
            break;
        case BrspModeRemoteCommand:
            [self.buttonChangeMode setTitle:[NSString stringWithFormat:@"Command"] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }    
}

#pragma mark CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    //call the open function to prepare the brsp service
    [self.brspObject open];
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [AppDelegate app].activePeripheral.name;
    [_inputText setDelegate:self];
    _allCommands = [NSMutableArray new];
    [self loadCommandArray];
    _lastMode = BrspModeData; //Default brsp mode
}

-(void)loadCommandArray {
    _allCommands = [NSArray arrayWithObjects:
                    @"ATMT?",
                    @"ATV?",
                    @"ATA?",
                    @"ATSN?",
                    @"ATSZ?",
                    @"ATSFC?",
                    @"ATSCL?",
                    @"ATSRM?",
                    @"ATSDIF?",
                    @"ATSPL?",
                    @"ATSUART?",
                    @"ATSPIO?,0",
                    @"ATSPIO?,1",
                    @"ATSPIO?,2",
                    @"ATSPIO?,3",
                    @"ATSPIO?,4",
                    @"ATSPIO?,5",
                    @"ATSPIO?,6",
                    @"ATSPIO?,7",
                    @"ATSPIO?,8",
                    @"ATSPIO?,9",
                    @"ATSPIO?,10",
                    @"ATSPIO?,11",
                    @"ATSPIO?,12",
                    @"ATSPIO?,13",
                    @"ATSPIO?,14",
                    @"ATSLED?,0",
                    @"ATSLED?,1",
                    @"ATSSP?",
                    @"ATSPK?",
                    @"ATSDBLE?",
                    @"ATSBRSP?",
                    @"ATSDSLE?",
                    @"ATSDSTLE?",
                    @"ATSDILE?",
                    @"ATSDITLE?",
                    @"ATSDMTLE?",
                    @"ATSDCP?",
                    @"ATSPLE?",
                    //D2 Modules only
//                    @"ATS?",
//                    @"ATLCA?",
//                    @"ATSP?",
//                    @"ATSCOD?",
                    nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self disableButtons];
    [AppDelegate app].cbCentral.delegate = self;
    
    //init the object with default buffer sizes of 1024 bytes
//    self.brspObject = [[Brsp alloc] initWithPeripheral:[AppDelegate app].activePeripheral];
    //init with custom buffer sizes
    self.brspObject = [[Brsp alloc] initWithPeripheral:[AppDelegate app].activePeripheral InputBufferSize:512 OutputBufferSize:512];
    
    //It is important to set this delegate before calling [Brsp open]
    self.brspObject.delegate = self;
    //Use CBCentral Manager to connect this peripheral
    [[AppDelegate app].cbCentral connectPeripheral:[AppDelegate app].activePeripheral options:nil];
    _outputText = [NSMutableString stringWithCapacity:MAX_TEXT_VIEW_CHARACTERS];
    [super viewWillAppear:animated];    
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)viewWillDisappear:(BOOL)animated {
    //call close to disable notifications etc (Not required)
    [brspObject close];
    //Use CBCentralManager to close the connection to this peripheral
    [[AppDelegate app].cbCentral cancelPeripheralConnection:[AppDelegate app].activePeripheral];
	[super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    switch(interfaceOrientation)
    {
        case UIInterfaceOrientationLandscapeLeft:
            return NO;
        case UIInterfaceOrientationLandscapeRight:
            return NO;
        default:
            return YES;
    }
}

#pragma mark - UITextFieldDelegate methods
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    //Write whatever user typed in textfield to brsp peripheral
    NSError *error = [self.brspObject writeString:[NSString stringWithFormat:@"%@\r", textField.text]];
    if (error)
        NSLog(@"%@", error.description);
    textField.text = @"";
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self animateTextField:textField up: YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self animateTextField:textField up: NO];
}

- (void) animateTextField:(UITextField*)textField up:(BOOL)up {
    const int movementDistance = 170; //will only work on iPhones
    const float movementDuration = 0.3f; //
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

#pragma mark - UI
- (IBAction)send10Button:(id)sender {
    //Save the brsp mode so it can be switched back when this process is complete
    _lastMode = self.brspObject.brspMode;
    if (brspObject.brspMode != BrspModeData)
        [self.brspObject changeBrspMode:BrspModeData]; //change brsp mode to data
    for (int i=1; i <= 10; i++) {
        //Write numbers 1-10 to the device
        NSError *error = [self.brspObject writeString:[NSString stringWithFormat:@"%i\r\n", i%10]];
        if (error)
            NSLog(@"%@", error.description);
    }
}

//Runs all commands in the _allCommands array
- (IBAction)getSettings:(id)sender {
    //Save the brsp mode so it can be switched back when this process is complete
    _lastMode = self.brspObject.brspMode;
    if (brspObject.brspMode != BrspModeRemoteCommand) {
        //Switch to remote command mode
        NSError *modeChangeError = [brspObject changeBrspMode:BrspModeRemoteCommand];
        if (modeChangeError)
            NSLog(@"%@", modeChangeError);
    }
    //Disable buttons
    [self disableButtons];
    //load a command queue
    _commandQueue = [NSMutableArray arrayWithArray:_allCommands];
    //send first command
    [self sendCommand:[_commandQueue objectAtIndex:0]];
}

//Flips the brsp mode between data and remote command
- (IBAction)changeMode:(id)sender {
    BrspMode newMode = (self.brspObject.brspMode==BrspModeData) ? BrspModeRemoteCommand : BrspModeData;
    
    NSError *error = [brspObject changeBrspMode:newMode];
    if (error)
        NSLog(@"%@", error);
}

- (void)enableButtons {
    [self enableButton:self.buttonChangeMode];
    [self enableButton:self.buttonGetSettings];
    [self enableButton:self.buttonSend100];
    [self.inputText setEnabled:YES];
}
- (void)disableButtons {
    [self disableButton:self.buttonChangeMode];
    [self disableButton:self.buttonGetSettings];
    [self disableButton:self.buttonSend100];    
    [self.inputText setEnabled:NO];
}
- (void)enableButton:(UIButton*)butt {
    butt.enabled = YES;
    butt.alpha = 1.0;
}
- (void)disableButton:(UIButton*)butt {
    butt.enabled = NO;
    butt.alpha = 0.5;   
}

//Returns the full command string or nil.  (Up to and including the 4th "\r\n")
-(NSString*)parseFullCommandResponse {
    //Peek at the entire brsp input buffer and see if it contains a full AT command response
    NSString *tmp = [brspObject peekString];
    NSUInteger crlfcount = 0, length = [tmp length];
    NSRange range = NSMakeRange(0, length);

    while(range.location != NSNotFound && crlfcount != 4) {
        range = [tmp rangeOfString: @"\r\n" options:0 range:range];
        if(range.location != NSNotFound) {
            range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
            crlfcount++;
        }
    }
    
    if (crlfcount==4)
    {
        return [tmp substringWithRange:NSMakeRange(0, range.location)];
    }
    else
    {
        return nil;
    }
}

//Returns the data portion from a command response string.  (String between the 3rd and 4th "\r\n"
-(NSString*)parseCommandData:(NSString*)fullCommandResponse {
    NSArray *array = [fullCommandResponse componentsSeparatedByString:@"\r\n"];
    if (array && array.count > 3)
        return [array objectAtIndex:3];
    else
        return @"";
}

//Outputs the next command in the _sentCommands array with the response to the screen and removes it from the array
-(void)outputCommandWithResponse:(NSString*)response {
    NSString *commandName = (NSString *)[_commandQueue objectAtIndex:0];
    [self outputToScreen:[NSString stringWithFormat:@"%@=%@\r", commandName, response]];
}

-(void)sendCommand:(NSString *)str {
    if (![[str substringFromIndex:str.length-1] isEqualToString:@"\r"])
        str = [NSString stringWithFormat:@"%@\r", str];  //Append a carriage return
    //Write as string 
    NSError *writeError = [self.brspObject writeString:str];
    if (writeError)
        NSLog(@"%@", writeError.description);
}

-(void)outputToScreen:(NSString *)str {
    if (!str || !str.length) return;  //Nothing to output
    
    NSInteger outputTextSize = _outputText.length;
    [_outputText appendString:str];
    if (outputTextSize > MAX_TEXT_VIEW_CHARACTERS)
        [_outputText deleteCharactersInRange:NSMakeRange(0, outputTextSize - MAX_TEXT_VIEW_CHARACTERS)];
    self.textView.text = _outputText;
    
    CGPoint bottomOffset = CGPointMake(0, [self.textView contentSize].height - self.textView.frame.size.height);
    
    if (bottomOffset.y > 0)
        [self.textView setContentOffset: bottomOffset animated: YES];
}

@end
