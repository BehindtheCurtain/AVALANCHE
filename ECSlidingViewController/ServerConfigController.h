//
//  ServerConfigController.h
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/22/13.
//
//

#import <UIKit/UIKit.h>
#import "NetworkConfigModel.h"

@interface ServerConfigController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *ipField;

@end
