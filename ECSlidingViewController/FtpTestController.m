//
//  FtpTestController.m
//  ECSlidingViewController
//
//  Created by BehindTheCurtain on 4/2/13.
//
//

#import "FtpTestController.h"




@interface FtpTestController ()

@end

const int SENDBUFF = 32768;

@implementation FtpTestController

@synthesize ostream;
@synthesize istream;

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

- (IBAction)send:(id)sender
{
    NSURL* url = [NSURL URLWithString:@"ftp://kyle:strawhatluffy87@129.107.132.24:21/webalizer/btcserver"];
    
    NSString *applicationDocumentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString* path = [applicationDocumentsDir stringByAppendingPathComponent:@"test.txt"];
    
    NSString* testContents = @"Test";
    
    [[NSFileManager defaultManager] createFileAtPath:path contents:[testContents dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
    
        self.istream = [NSInputStream inputStreamWithFileAtPath:path];
        [self.istream open];
        
        self.ostream = CFBridgingRelease(CFWriteStreamCreateWithFTPURL(NULL, (__bridge CFURLRef) url));
        
        self.ostream.delegate = self;
//        [self.ostream setProperty:@"kyle" forKey:(id)kCFStreamPropertyFTPUserName];
//        [self.ostream setProperty:@"strawhatluffy87" forKey:(id)kCFStreamPropertyFTPPassword];
        
        
        
        [self.ostream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        [self.ostream open];
    }
    
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    switch (eventCode)
    {
        case NSStreamEventEndEncountered:
            break;
        case NSStreamEventHasSpaceAvailable:
        {
            uint8_t* buffer = nil;
            
            [self.istream read:buffer maxLength:SENDBUFF];
            
            [self.ostream write:buffer maxLength:SENDBUFF];
            break;
        }
        case NSStreamEventErrorOccurred:
        {
            NSError *theError = [aStream streamError];
            NSLog(@"%@", theError);
            [aStream close];
            break;
        }
        case NSStreamEventOpenCompleted:
        {
            NSLog(@"%@", @"Connected");
            break;
        }
        default:
            break;
    }
}

@end
