//
//  SensorSnapshotModel.m
//  JASidePanels
//
//  Created by BehindTheCurtain on 3/5/13.
//
//

#import "SensorSnapshotModel.h"

@implementation SensorSnapshotModel

// Generate setter and getter methods.
@synthesize timeStamp;
@synthesize sensorName;
@synthesize sensorType;
@synthesize sensorID;
@synthesize sensorData;

// Constructor method that sets all of the snapshots data.
-(id) initWithTimeStamp: 	(NSDate*) timeStamp
               withName: 				(NSString *)sensorName
               withType: 				(NSString *)sensorType
           withSensorID: 			(int)sensorID
               withData:			 	(int)sensorData;
{
	self = [super init];
	
	self.timeStamp = timeStamp;
	self.sensorName = sensorName;
	self.sensorType = sensorType;
	self.sensorID = sensorID;
	self.sensorData = sensorData;
	
	return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.timeStamp forKey:@"timeStamp"];
    [aCoder encodeObject:self.sensorName forKey:@"sensorName"];
    [aCoder encodeObject:self.sensorType forKey:@"sensorType"];
    [aCoder encodeInt:self.sensorID forKey:@"sensorID"];
    [aCoder encodeInt:self.sensorData forKey:@"sensorData"];
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.timeStamp = [aDecoder decodeObjectForKey:@"timeStamp"];
        self.sensorName = [aDecoder decodeObjectForKey:@"sensorName"];
        self.sensorType = [aDecoder decodeObjectForKey:@"sensorType"];
        self.sensorID = [aDecoder decodeObjectForKey:@"sensorID"];
        self.sensorData = [aDecoder decodeObjectForKey:@"sensorData"];
    }
    
    return self;
}


@end
