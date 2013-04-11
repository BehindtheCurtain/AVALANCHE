//
//  GraphViewController.m
//  AVALANCHE
//
//  Created by Austen Herbst on 4/11/13.
//
//

#import "GraphViewController.h"

@implementation GraphViewController
@synthesize customWebView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
     NSString *httpSource = @"http://designwoop.com/";
     NSURL *fullUrl = [NSURL URLWithString:httpSource];
     NSURLRequest *httpRequest = [NSURLRequest requestWithURL:fullUrl];
     [customWebView loadRequest:httpRequest];
     */
    
//    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"uiwebview" ofType:@"html"];
//    NSString *htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
//    [customWebView loadHTMLString:htmlString baseURL:nil];
    
    // Get the path of the resource file
    NSString* path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    // Convert it to the NSURL
    NSURL* address = [NSURL fileURLWithPath:path];
    // Create a request to the resource
    NSURLRequest* request = [NSURLRequest requestWithURL:address] ;
    // Load the resource using the request
    [customWebView loadRequest:request];
    
}

- (void)viewDidUnload
{
    [self setCustomWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
