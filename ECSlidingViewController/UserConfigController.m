
//
//  UserConfigController.m
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/21/13.
//
//

#import "UserConfigController.h"

@interface UserConfigController ()

@end

@implementation UserConfigController

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
    
    self.userNameField.text = [[UserModel instance:NO] userName];
    
    self.navigationItem.title = @"Enter Username and Password";
	// Do any additional setup after loading the view.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.userNameField && [self.userNameField isFirstResponder])
    {
        [self.userNameField resignFirstResponder];
    }
    else if(textField == self.passwordField && [self.passwordField isFirstResponder])
    {
        [self.passwordField resignFirstResponder];
    }
    
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField selectAll:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginAction
{
    NSString* user = self.userNameField.text;
    NSString* password = self.passwordField.text;
    password = [UserConfigController createSHA512:password];
    
    NSURL* url = [NSURL URLWithString:[[NetworkConfigModel instance:NO] httpURL]];
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:[[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"<login>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"\t<username>%@</username>\n", user] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"\t<password>%@</password>\n", password] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"</login>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"<?>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setTimeOutSeconds:60];
    [request addRequestHeader:@"Content-Type" value:@"text/xml"];
    [request setPostBody:postBody];
    [request startSynchronous];
    
    NSError* error = [request error];
    NSString* response = nil;
    int statusCode = -1;
    if (!error)
    {
        statusCode = [request responseStatusCode];
        response = [request responseString];
    }
    else
    {
        NSLog(@"%@", error);
        statusCode = [request responseStatusCode];
    }
    
    if(statusCode == 202)
    {
        [[UserModel instance:NO] setLoggedOn:YES];
        [[UserModel instance:NO] setUserName:user];
        [[UserModel instance:NO] setPassword:password];
        [[UserModel instance:NO] archive];
        
        NSString* message = [NSString stringWithFormat:@"Welcome back %@.", user];
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Logged In"
                              message:message
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if(statusCode == 401)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Please Try Again."
                              message: @"Username or password is incorrect."
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)createAction
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Create New Account" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Create" otherButtonTitles:nil, nil];
    
    [actionSheet showFromRect:[self.view bounds] inView:self.view  animated:NO];
    
    [super viewDidLoad];
}

- (void)changeAction
{
    NSString* user = self.userNameField.text;
    NSString* password = self.passwordField.text;
    password = [UserConfigController createSHA512:password];
    
    NSURL* url = [NSURL URLWithString:[[NetworkConfigModel instance:NO] httpURL]];
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:[[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"<change>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"\t<username>%@</username>\n", user] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"\t<password>%@</password>\n", [[UserModel instance:NO] password]] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"\t<newpassword>%@</newpassword>\n", password] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"</change>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"<?>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [request addRequestHeader:@"Content-Type" value:@"text/xml"];
    [request setTimeOutSeconds:60];
    [request setPassword:password];
    [request setUsername:user];
    [request setPostBody:postBody];
    [request setValidatesSecureCertificate:NO];
    [request startSynchronous];
    
    NSError* error = [request error];
    NSString* response = nil;
    int statusCode = -1;
    if (!error)
    {
        statusCode = [request responseStatusCode];
        response = [request responseString];
    }
    else
    {
        statusCode = [request responseStatusCode];
    }
    
    if(statusCode == 202)
    {
        [[UserModel instance:NO] setLoggedOn:YES];
        [[UserModel instance:NO] setUserName:user];
        [[UserModel instance:NO] setPassword:password];
        [[UserModel instance:NO] archive];
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Success"
                              message: @"User account password changed."
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if(statusCode == 401)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Please Try Again."
                              message: @"Cannot change password."
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

-( NSString *)salt
{
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: 15];
    
    for (int i=0; i<15; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    
    return randomString;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // Create button clicked.
    if(buttonIndex == 0)
    {
        NSString* user = self.userNameField.text;
        NSString* password = self.passwordField.text;
        NSString* salt = [self salt];
        password = [UserConfigController createSHA512:password];
        
        NSURL* url = [NSURL URLWithString:[[NetworkConfigModel instance:NO] httpURL]];
        ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
        [request setRequestMethod:@"POST"];
        [request addRequestHeader:@"Content-Type" value:@"text/xml"];
        
        NSMutableData *postBody = [NSMutableData data];
        [postBody appendData:[[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"<create>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"\t<username>%@</username>\n", user] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"\t<password>%@</password>\n", password] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"\t<salt>%@</salt>\n",salt] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"</create>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"<?>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [request setTimeOutSeconds:60];
        [request setPostBody:postBody];
        [request startSynchronous];
        NSError* error = [request error];
        NSString* response = nil;
        int statusCode = -1;
        if (!error)
        {
            statusCode = [request responseStatusCode];
            response = [request responseString];
        }
        else
        {
            statusCode = [request responseStatusCode];
        }
        
        if(statusCode == 201)
        {
            [[UserModel instance:NO] setUserName:user];
            [[UserModel instance:NO] setPassword:password];
            [[UserModel instance:NO] setLoggedOn:YES];
            [[UserModel instance:NO] archive];
            
            NSString* message = [NSString stringWithFormat:@"Welcome %@.", user];
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"Logged In"
                                  message:message
                                  delegate: nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if(statusCode == 409)
        {
            [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"Please Try Again."
                                  message: @"User account name is already taken."
                                  delegate: nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
        }
        else if(statusCode == 401)
        {
            [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"Please Try Again."
                                  message: @"Username or password is incorrect."
                                  delegate: nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
        }
    }
}

+ (NSString *)createSHA512:(NSString *)source
{
    
    const char *s = [source cStringUsingEncoding:NSASCIIStringEncoding];
    
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA512_DIGEST_LENGTH] = {0};
    
    CC_SHA512(keyData.bytes, keyData.length, digest);
    
    NSData *out = [NSData dataWithBytes:digest length:CC_SHA512_DIGEST_LENGTH];
    
    NSString* ret = [out description];
    
    ret = [ret stringByReplacingOccurrencesOfString:@"<" withString:@""];
    ret = [ret stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    return ret;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if(cell == self.create)
    {
        [self createAction];
    }
    else if(cell == self.change)
    {
        [self changeAction];
    }
    else if(cell == self.login)
    {
        [self loginAction];
    }
}

@end
