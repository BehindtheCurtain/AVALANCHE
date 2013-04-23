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
    
    NSURL* url = [NSURL URLWithString:[[NetworkConfigModel instance:NO] httpURL]];
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:[[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"<put>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"\t<username>jason</username>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"\t<password>password</password>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"\t<run>run</run>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"</put>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"<?>"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setTimeOutSeconds:120];
    [request setDelegate:self];
    [request setPostBody:postBody];
    [request startAsynchronous];
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    
    // Use when fetching binary data
    NSData *responseData = [request responseData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@", error);
}


@end
