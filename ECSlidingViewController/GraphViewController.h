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

@property (retain) NSString* filepath;
@property (retain) NSString* sensor;
@property (retain) NSString* label;

- (void)commonInit;

@end
