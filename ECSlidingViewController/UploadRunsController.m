//
//  UploadRunsController.m
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/27/13.
//
//

#import "UploadRunsController.h"

@interface UploadRunsController ()

@end

@implementation UploadRunsController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Select Run";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    RunListModel* runListModel = [RunListModel instance:NO];
    int runNum = [[runListModel notUploadedRunNames] count];
    
    return  runNum;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellIdentifier = @"runCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [[[RunListModel instance:NO] notUploadedRunNames] objectAtIndex:indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RunModel* run = [[[RunListModel instance:NO] notUploadedRuns] objectAtIndex:indexPath.row];
    NSString* filePath = [run filePath];
    
    NSURL* url = [NSURL URLWithString:[[NetworkConfigModel instance:NO] httpURL]];
    
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    
    ASIHTTPRequest* login = [ASIHTTPRequest requestWithURL:url];
    
    [login setRequestMethod:@"POST"];
    [login addRequestHeader:@"Content-Type" value:@"text/xml"];
    [login useSessionPersistence];
    NSMutableData *post = [NSMutableData data];
    [post appendData:[[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [post appendData:[[NSString stringWithFormat:@"<login>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [post appendData:[[NSString stringWithFormat:@"\t<username>%@</username>\n", [[UserModel instance:NO] userName]] dataUsingEncoding:NSUTF8StringEncoding]];
    [post appendData:[[NSString stringWithFormat:@"\t<password>%@</password>\n", [[UserModel instance:NO] password]] dataUsingEncoding:NSUTF8StringEncoding]];
    [post appendData:[[NSString stringWithFormat:@"</login>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [post appendData:[[NSString stringWithFormat:@"<?>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [login setTimeOutSeconds:60];
    [login setPostBody:post];
    [login startSynchronous];
    
    NSError* error = [request error];
    NSString* response = nil;
    int statusCode = -1;
    if (!error)
    {
        statusCode = [login responseStatusCode];
        response = [login responseString];
    }
    
    if(statusCode == 202)
    {
        self.runModel = run;
        [self.tableView reloadData];
        
        NSString* runString = [NSString stringWithFormat:@"++\n%@\n", [self.runModel runName]];
        NSString* userString = [NSString stringWithFormat:@"<<\n%@\n", [[UserModel instance:NO] userName]];
        NSString* escape = @"<?>\n";
        
        NSString* fileContents = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        NSMutableData *postBody = [NSMutableData data];
        [postBody appendData:[@"json\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[fileContents dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[userString dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[runString dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[escape dataUsingEncoding:NSUTF8StringEncoding]];
        [request setPostBody:postBody];
        [request addRequestHeader:@"Content-Type" value:@"application/json"];
        [request setRequestMethod:@"POST"];
        [request setTimeOutSeconds:60];
        [request setDelegate:self];
        [request startAsynchronous];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Please Try Again."
                              message: @"Cannot login."
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [self.runModel setUploaded:YES];
    [self.tableView reloadData];
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"Success"
                          message: @"Run Uploaded."
                          delegate: nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    
    [alert show];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"Failure"
                          message: @"Run cannot be uploaded."
                          delegate: nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    
    [alert show];
}

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}
@end
