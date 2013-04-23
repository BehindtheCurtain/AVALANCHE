//
//  HTTPTestController.h
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/8/13.
//
//

#import <UIKit/UIKit.h>

#import "NetworkConfigModel.h"
#import "ASIHTTPRequest.h"

@interface HTTPTestController : UIViewController <ASIHTTPRequestDelegate>

@property (weak, nonatomic) IBOutlet UIButton *requestButton;
- (IBAction)requestAction:(id)sender;

@end
