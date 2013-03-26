//
//  ConfigurationModel.m
//  ECSlidingViewController
//
//  Created by BehindTheCurtain on 3/9/13.
//
//

#import "ConfigurationModel.h"

@implementation ConfigurationModel

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInt:self.sensorID forKey:@"sensorID"];
    [aCoder encodeBool:self.active forKey:@"active"];
    [aCoder encodeInt:self.transformConstant forKey:@"transformConstant"];
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.sensorID = [aDecoder decodeIntForKey:@"sensorID"];
        self.active = [aDecoder decodeBoolForKey:@"active"];
        self.transformConstant = [aDecoder decodeIntForKey:@"transformConstant"];
    }
    
    return self;
}

@end
