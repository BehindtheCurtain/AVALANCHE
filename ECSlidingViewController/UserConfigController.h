//
//  UserConfigController.h
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/21/13.
//
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import "UserModel.h"
#import "ASIHTTPRequest.h"
#import "NetworkConfigModel.h"

@interface UserConfigController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate, ASIHTTPRequestDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;


@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;

- (IBAction)loginAction:(id)sender;

- (IBAction)createAction:(id)sender;

- (IBAction)changeAction:(id)sender;

- (NSString*)salt;

+ (NSString *)createSHA512:(NSString *)source;

@end
