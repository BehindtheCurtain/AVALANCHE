//
//  ConfigurationModel.m
//  ECSlidingViewController
//
//  Created by BehindTheCurtain on 3/9/13.
//
//

#import "ConfigurationModel.h"

@implementation ConfigurationModel

@synthesize name;
@synthesize sensorType;
@synthesize sensorID;
@synthesize active;
@synthesize transformConstant;
@synthesize maxValue;
@synthesize minValue;

- (NSString*)getType
{
    NSString* type;
    
    switch(sensorType)
    {
        case Temperature:
        {
            type = @"Temperature";
            break;
        }
        case Oxygen:
        {
            type = @"Oxygen";
            break;
        }
        case Pressure:
        {
            type = @"Pressure";
            break;
        }
        case Voltage:
        {
            type = @"Voltage";
            break;
        }
        case PulseCount:
        {
            type = @"PulseCount";
            break;
        }
        case RPM:
        {
            type = @"RPM";
            break;
        }
        case AirFuel:
        {
            type = @"AirFuel";
            break;
        }
    }
    
    return type;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInt:self.sensorType forKey:@"type"];
    [aCoder encodeInt:self.sensorID forKey:@"sensorID"];
    [aCoder encodeInt:self.maxValue forKey:@"maxValue"];
    [aCoder encodeInt:self.minValue forKey:@"minValue"];
    [aCoder encodeBool:self.active forKey:@"active"];
    [aCoder encodeInt:self.transformConstant forKey:@"transformConstant"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.sensorType = [aDecoder decodeIntForKey:@"type"];
        self.sensorID = [aDecoder decodeIntForKey:@"sensorID"];
        self.maxValue = [aDecoder decodeIntForKey:@"maxValue"];
        self.minValue = [aDecoder decodeIntForKey:@"minValue"];
        self.active = [aDecoder decodeBoolForKey:@"active"];
        self.transformConstant = [aDecoder decodeIntForKey:@"transformConstant"];
    }
    
    return self;
}

@end
