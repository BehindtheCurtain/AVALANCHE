//
//  HTTPTestController.h
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/8/13.
//
//

#import <UIKit/UIKit.h>

#import "NetworkConstants.h"

@interface HTTPTestController : UIViewController <NSURLConnectionDelegate, NSStreamDelegate>

@property (retain) NSInputStream* istream;
@property (retain) NSOutputStream* ostream;

@property (weak, nonatomic) IBOutlet UIButton *requestButton;
- (IBAction)requestAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *socketButton;
- (IBAction)socketAction:(id)sender;
@end
