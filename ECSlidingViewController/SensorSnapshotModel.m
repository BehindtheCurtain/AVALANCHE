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
-(id) initWithTimeStamp: 	(NSDate*)_timeStamp
               withName: 				(NSString *)_sensorName
               withType: 				(NSString *)_sensorType
           withSensorID: 			(int)_sensorID
               withData:			 	(int)_sensorData;
{
	self = [super init];
	
	self.timeStamp = _timeStamp;
	self.sensorName = _sensorName;
	self.sensorType = _sensorType;
	self.sensorID = _sensorID;
	self.sensorData = _sensorData;
	
	return self;
}

-(NSString*) serialize
{
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
    NSString* time = [df stringFromDate:self.timeStamp];
    
    NSMutableString* data = [[NSMutableString alloc] init];
    [data appendString:time];
    [data appendString:@","];
    [data appendString:[NSString stringWithFormat:@"%d", self.sensorData]];
    
    return [NSString stringWithString:data];
}

-(id) initFromDataString:(NSString*)data
          withSensorName:(NSString*)name
          withSensorType:(NSString*)type
            withSensorID:(int)ID
{
    if(self = [super init])
    {
        NSString* delimiters = @",";
        NSArray* snapshotData = [data componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:delimiters]];
        
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
        NSDate* time = [df dateFromString:[snapshotData objectAtIndex:0]];
        
        self.timeStamp = time;
        self.sensorName = name;
        self.sensorType = type;
        self.sensorID = ID;
        self.sensorData = [snapshotData objectAtIndex:1];
     }
     
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
