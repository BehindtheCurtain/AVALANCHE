//
//  ServerRunsController.m
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/27/13.
//
//

#import "ServerRunsController.h"

@interface ServerRunsController ()

@end

@implementation ServerRunsController

@synthesize runs;
@synthesize runName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.runs = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)init
{
    if(self = [super init])
    {
        self.runs = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSURL* url = [NSURL URLWithString:[[NetworkConfigModel instance:NO] httpURL]];
    
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    
    [request setRequestMethod:@"POST"];
    
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:[[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"<query>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"\t<username>%@</username>\n", [[UserModel instance:NO] userName]] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"\t<password>%@</password>\n", [[UserModel instance:NO] password]] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"</query>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"<?>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setPostBody:postBody];
    [request setTimeOutSeconds:60];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    int response = [request responseStatusCode];
    
    if(response == 200)
    {
        NSRange index = [responseString rangeOfString:@"<?xml"];
        NSString *xml = [responseString substringFromIndex:index.location];
        
        NSData* xmlData = [xml dataUsingEncoding:NSUTF8StringEncoding];
        
        [self setRuns:[[NSMutableArray alloc] init]];
        
        NSXMLParser* parser = [[NSXMLParser alloc] initWithData:xmlData];
        [parser setDelegate:self];
        [parser parse];
    }
    else if(response == 201)
    {
        NSRange index = [responseString rangeOfString:@"<?xml"];
        NSString *xml = [responseString substringFromIndex:index.location];
        NSString* applicationDocumentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString* runDirectory = [applicationDocumentsDir stringByAppendingPathComponent:@"runs"];
        NSString* filePath = [runDirectory stringByAppendingFormat:@"%@.xml", [self runName]];
        
        RunModel* run = [[RunModel alloc] init];
        [run setRunName:[self runName]];
        [run setDirectory:runDirectory];
        [run setFilePath:filePath];
        
        [[[RunListModel instance:NO] runList] addObject:run];
        
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:[xml dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Success"
                              message: @"Run Downloaded."
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        
        [alert show];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [self setRunName:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"run"])
    {
        [[self runs] addObject:self.runName];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    [self.tableView reloadData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"Failure"
                          message: @"Cannot download run."
                          delegate: nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    
    [alert show];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidLoad];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.navigationItem.title = @"Select Run to Download";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellIdentifier = @"serverRun";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [[self runs] objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return  [self.runs count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setRunName:[[self runs] objectAtIndex:indexPath.row]];
    NSURL* url = [NSURL URLWithString:[[NetworkConfigModel instance:NO] httpURL]];
    
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    
    BOOL downloaded = NO;
    
    for(NSString* name in [[RunListModel instance:NO] runNames])
    {
        if([self.runName isEqualToString:name])
        {
            downloaded = YES;
        }
    }
    
    if(!downloaded)
    {
        NSMutableData* postBody = [NSMutableData data];
        [postBody appendData:[[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"<download>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"\t<runname>%@</runname>\n", [self runName]] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"\t<username>%@</username>\n", [[UserModel instance:NO] userName]] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"\t<password>%@</password>\n", [[UserModel instance:NO] password]] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"</download>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"<?>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request setPostBody:postBody];
        [request setRequestMethod:@"POST"];
        [request setTimeOutSeconds:60];
        [request setDelegate:self];
        [request startAsynchronous];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Alert"
                              message: @"Run already downloaded."
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        
        [alert show];
    }
}

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

@end
