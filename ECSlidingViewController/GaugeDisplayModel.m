//
//  GuageDisplayModel.m
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/25/13.
//
//

#import "GaugeDisplayModel.h"

@implementation GaugeDisplayModel

@synthesize sensors;

- (id)init
{
    if(self = [super init])
    {
        self.sensors = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.sensors = [aDecoder decodeObjectForKey:@"sensors"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:sensors forKey:@"sensors"];
}

- (void)archive:(int)page
{
    NSString* pageKey = [NSString stringWithFormat:@"sensorPage%d", page];
    
    NSUserDefaults* currentDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary* rootObject = [NSMutableDictionary dictionary];
    [rootObject setValue:self forKey:pageKey];
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:rootObject];
    [currentDefaults setObject:data forKey:pageKey];
}

- (id)initwithPage:(int)page
{
    NSString* pageKey = [NSString stringWithFormat:@"sensorPage%d", page];
    
    NSUserDefaults* currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData* data = [currentDefaults objectForKey:pageKey];
    NSMutableDictionary* rootObject = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return [rootObject valueForKey:pageKey];
}


@end
