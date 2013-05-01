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

@interface UserConfigController : UITableViewController <UITextFieldDelegate, UIActionSheetDelegate, ASIHTTPRequestDelegate, UIAlertViewDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UITableViewCell *create;
@property (weak, nonatomic) IBOutlet UITableViewCell *change;
@property (weak, nonatomic) IBOutlet UITableViewCell *login;

- (void)loginAction;

- (void)createAction;

- (void)changeAction;

- (NSString*)salt;

+ (NSString *)createSHA512:(NSString *)source;

@end
