//
//  RunModel.m
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/18/13.
//
//

#import "RunModel.h"

@implementation RunModel

@synthesize runName;
@synthesize directory;
@synthesize filePath;

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.runName forKey:@"runName"];
    [aCoder encodeObject:self.directory forKey:@"directory"];
    [aCoder encodeObject:self.filePath forKey:@"filePath"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.runName = [aDecoder decodeObjectForKey:@"runName"];
        self.directory = [aDecoder decodeObjectForKey:@"directory"];
        self.filePath = [aDecoder decodeObjectForKey:@"filePath"];
    }
    
    return self;
}

- (id)init
{
    if(self = [super init])
    {
        self.runName = [[NSString alloc] init];
        self.directory = [[NSString alloc] init];
        self.filePath = [[NSString alloc] init];
    }
    
    return self;
}

@end
