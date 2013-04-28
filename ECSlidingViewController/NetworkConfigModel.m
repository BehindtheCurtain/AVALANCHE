//
//  NetworkConfigModel.m
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/22/13.
//
//

#import "NetworkConfigModel.h"

@implementation NetworkConfigModel

@synthesize serverIP;
@synthesize ftpUser;
@synthesize ftpPassword;

+ (NetworkConfigModel*)instance:(BOOL)reset
{
    static NetworkConfigModel* instance;
    
    @synchronized(self)
    {
        if(instance == nil || reset)
        {
            NSUserDefaults* currentDefaults = [NSUserDefaults standardUserDefaults];
            NSData* data = [currentDefaults objectForKey:@"serverConfig"];
            
            instance = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            if(instance == nil)
            {
                instance = [[NetworkConfigModel alloc] init];
            }
            
            
            if([[instance serverIP] length] == 0)
            {
                [instance setServerIP:@"129.107.132.24"];
            }
            
            if([[instance ftpUser] length] == 0)
            {
                [instance setFtpUser:@"nobody"];
            }
            
            if([[instance ftpPassword] length] == 0)
            {
                [instance setFtpPassword:@"lampp"];
            }
            
            [instance archive];
        }
        
        return instance;
    }
}

- (NSString*)ftpURL
{
    return [NSString stringWithFormat:@"ftp://%@:21/webalizer/btcserver/", self.serverIP];
}

- (NSString*)httpURL
{
    return [NSString stringWithFormat:@"http://%@:8080", self.serverIP];
}

- (void)archive
{
    NSUserDefaults* currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [currentDefaults setObject:data forKey:@"serverConfig"];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.serverIP forKey:@"serverIP"];
    [aCoder encodeObject:self.ftpUser forKey:@"ftpUser"];
    [aCoder encodeObject:self.ftpPassword forKey:@"ftpPassword"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.serverIP = [aDecoder decodeObjectForKey:@"serverIP"];
        self.ftpUser = [aDecoder decodeObjectForKey:@"ftpUser"];
        self.ftpPassword = [aDecoder decodeObjectForKey:@"ftpPassword"];
    }
    
    return self;
}

- (id)init
{
    if(self = [super init])
    {
        self.serverIP = [[NSString alloc] init];
        self.ftpUser = [[NSString alloc] init];
        self.ftpPassword = [[NSString alloc] init];
    }
    
    return self;
}

@end
