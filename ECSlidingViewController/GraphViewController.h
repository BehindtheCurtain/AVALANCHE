//
//  GraphViewController.h
//  AVALANCHE
//
//  Created by Austen Herbst on 4/11/13.
//
//

#import <UIKit/UIKit.h>

@interface GraphViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *customWebView;

- (IBAction)alertBox:(id)sender;

@end
