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
#import "NetworkConstants.h"

@interface UserConfigController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate, ASIHTTPRequestDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)loginAction:(id)sender;

- (IBAction)createAction:(id)sender;

+ (NSString *)createSHA512:(NSString *)source;

@end
