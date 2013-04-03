//
//  FtpTestController.h
//  ECSlidingViewController
//
//  Created by BehindTheCurtain on 4/2/13.
//
//

#import <UIKit/UIKit.h>
#import <CFNetwork/CFNetwork.h>

@interface FtpTestController : UIViewController <NSStreamDelegate>

@property NSInputStream* istream;
@property NSOutputStream* ostream;

@property (weak, nonatomic) IBOutlet UIButton *sendButton;
- (IBAction)send:(id)sender;

@end
