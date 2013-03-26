//
//  BluetoothControllerViewController.h
//  ECSlidingViewController
//
//  Created by BehindTheCurtain on 3/26/13.
//
//

#import <UIKit/UIKit.h>
#import "Brsp.h"
#import "AppDelegate.h"

@interface BluetoothViewController : UIViewController <UITextFieldDelegate, BrspDelegate, CBCentralManagerDelegate>
{
    UITextField *_inputText;
    NSMutableString *_outputText;   //used as string data for textView to make string concatenations more efficient
    NSArray *_allCommands;          //All commands sent by the get settings button
    NSMutableArray *_commandQueue;  //An array of commands queued for sending
    BrspMode _lastMode;
}

@property (strong, nonatomic) Brsp *brspObject;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UITextField *inputText;

@property (strong, nonatomic) IBOutlet UIButton *buttonChangeMode;
@property (strong, nonatomic) IBOutlet UIButton *buttonGetSettings;
@property (strong, nonatomic) IBOutlet UIButton *buttonSend100;

- (IBAction)send10Button:(id)sender;
- (IBAction)getSettings:(id)sender;
- (IBAction)changeMode:(id)sender;
- (void)animateTextField:(UITextField*)textField up:(BOOL)up;

- (void)enableButtons;
- (void)disableButtons;
- (void)enableButton:(UIButton*)butt;
- (void)disableButton:(UIButton*)butt;

- (void)outputToScreen:(NSString *)str;
- (void)sendCommand:(NSString *)str;
- (NSString*)parseFullCommandResponse;
- (NSString*)parseCommandData:(NSString*)fullCommandResponse;
- (void)outputCommandWithResponse:(NSString*)response;

@end
