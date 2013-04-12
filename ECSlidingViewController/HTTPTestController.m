//
//  HTTPTestController.m
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/8/13.
//
//

#import "HTTPTestController.h"

@interface HTTPTestController ()

@end

@implementation HTTPTestController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)requestAction:(id)sender
{
    NSString *urlString = [NSString stringWithFormat:@"http://129.107.132.24:8110"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    //set headers
    NSString *contentType = [NSString stringWithFormat:@"text/xml"];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    //create the body
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:[[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"<put>"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"<username>jason</username>"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"<password>password</password>"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"<run>run</run>"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"</put>"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //post
    [request setHTTPBody:postBody];
    
    //get response
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"Response Code: %d", [urlResponse statusCode]);
    if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300) {
        NSLog(@"Response: %@", result);
        
        //here you get the response
        
    }
}
@end
