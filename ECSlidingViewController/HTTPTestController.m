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

@synthesize istream;
@synthesize ostream;

static NSMutableData* responseData;

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
    NSString *urlString = [HTTPURL stringByAppendingString:@":8080"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    //set headers
    NSString *contentType = [NSString stringWithFormat:@"text/xml"];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    //create the body
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:[[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"<put>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"\t<username>jason</username>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"\t<password>password</password>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"\t<run>run</run>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"</put>\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setTimeoutInterval:60];
    
    //post
    [request setHTTPBody:postBody];
    
    /*
    //get response
    NSHTTPURLResponse* urlResponse = nil;
    NSData* result = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:nil];
    
    NSString* resultString = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    
    NSLog(@"Response Code: %d", [urlResponse statusCode]);
    if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300) {
        NSLog(@"Response: %@", result);
    }
     */

    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [connection scheduleInRunLoop:[NSRunLoop mainRunLoop]
                          forMode:NSDefaultRunLoopMode];
    [connection start];

    if(connection != nil)
    {
        responseData = [[NSMutableData alloc] init];
    }
    
}


- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSString *failureMessage = [NSString stringWithFormat:@"Connection failed: %@", [error description]];
    NSLog(@"%@", failureMessage);
}


- (void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    NSString* response = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    int i = 0;
}



- (IBAction)socketAction:(id)sender
{
    NSURL* url = [NSURL URLWithString:HTTPURL];
    
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    
    CFStringRef host = (__bridge CFStringRef)([url host]);
    
    CFStreamCreatePairWithSocketToCFHost(NULL, host, 8110, &readStream, &writeStream);
    
    NSInputStream *inputStream = (__bridge_transfer NSInputStream *)readStream;
    NSOutputStream *outputStream = (__bridge_transfer NSOutputStream *)writeStream;
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    [outputStream open];
    
    self.istream = inputStream;
    self.ostream = outputStream;
}


- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    switch(eventCode)
    {
        case NSStreamEventOpenCompleted:
        {
            NSLog(@"%@", @"Stream opened.");
            break;
        }
        case NSStreamEventHasBytesAvailable:
        {
            if (aStream == self.istream)
            {
                
                uint8_t buffer[1024];
                int len;
                
                while ([istream hasBytesAvailable]) {
                    len = [istream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0) {
                        
                        NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
                        
                        if (nil != output)
                        {
                            NSLog(@"server said: %@", output);
                        }
                    }
                }
            }
            else if(aStream == self.ostream)
            {
                NSString * str = [NSString stringWithFormat:
                                  @"GET / HTTP/1.0\r\n\r\n"];
                const uint8_t * rawstring =
                (const uint8_t *)[str UTF8String];
                [self.ostream write:rawstring maxLength:strlen(rawstring)];
                [self.ostream close];

            }
            break;
        }
        default:
            break;
    }
}


@end
