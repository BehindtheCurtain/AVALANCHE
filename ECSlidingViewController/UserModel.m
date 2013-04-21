//
//  UserModel.m
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/21/13.
//
//

#import "UserModel.h"

@implementation UserModel

@synthesize userName;
@synthesize password;

+ (UserModel*)instance:(BOOL)reset
{
    static UserModel* instance;
    
    @synchronized(self)
    {
        if(instance == nil || reset)
        {
            instance = [[UserModel alloc] init];
            
            NSUserDefaults* currentDefaults = [NSUserDefaults standardUserDefaults];
            NSData* data = [currentDefaults objectForKey:@"credentials"];
            
            
            instance = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            [instance archive];            
        }
        
        return instance;
    }
}

- (void)archive
{
    NSUserDefaults* currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [currentDefaults setObject:data forKey:@"credentials"];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.password forKey:@"password"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
    }
    
    return self;
}

- (id)init
{
    if(self = [super init])
    {
        self.userName = [[NSString alloc] init];
        self.password = [[NSString alloc] init];
    }
    
    return self;
}


@end
