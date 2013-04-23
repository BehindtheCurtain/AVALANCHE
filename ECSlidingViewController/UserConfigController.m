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

- (IBAction)loginAction:(id)sender
{
    NSString* user = self.userNameField.text;
    NSString* password = self.passwordField.text;
    password = [UserConfigController createSHA512:password];
    
    if([[[UserModel instance:NO] userName] isEqualToString:user] && [[[UserModel instance:NO] password] isEqualToString:password])
    {
        NSURL* url = [NSURL URLWithString:[[NetworkConfigModel instance:NO] httpURL]];
        ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
        [request setRequestMethod:@"POST"];
        
        NSMutableData *postBody = [NSMutableData data];
        [postBody appendData:[[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"<login>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"\t<username>%@</username>\n", user] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"\t<password>%@</password>\n", password] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"</login>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"<?>"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request startSynchronous];
        NSError* error = [request error];
        NSString* response = nil;
        if (!error)
        {
            response = [request responseString];
        }
        
        
    }
}

- (IBAction)createAction:(id)sender
{
    NSString* user = self.userNameField.text;
    NSString* password = self.passwordField.text;
    password = [UserConfigController createSHA512:password];
    
    NSURL* url = [NSURL URLWithString:[[NetworkConfigModel instance:NO] httpURL]];
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:[[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"<create>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"\t<username>%@</username>\n", user] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"\t<password>%@</password>\n", password] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"</create>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"<?>"] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setTimeOutSeconds:1];
    [request setPostBody:postBody];
    [request startSynchronous];
    NSError* error = [request error];
    NSString* response = nil;
    if (!error)
    {
        response = [request responseString];
    }
    
    if([response isEqualToString:@""])
    {
        
    }
    else if([response isEqualToString:@""])
    {
        
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

@end
