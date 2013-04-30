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
@synthesize sensorType;
@synthesize sensorID;
@synthesize sensorData;

// Constructor method that sets all of the snapshots data.
-(id) initWithTimeStamp:(NSDate*)_timeStamp
               withType:(NSString *)_sensorType
           withSensorID:(int)_sensorID
               withData:(unsigned int)_sensorData;
{
	self = [super init];
    
	
	self.timeStamp = _timeStamp;
	self.sensorType = _sensorType;
	self.sensorID = _sensorID;
	self.sensorData = _sensorData;
	
	return self;
}

-(NSString*) serialize
{
    NSMutableString* json = [[NSMutableString alloc] init];
    [json appendFormat:@"\t\t\t\t\t\t\t\t\"time\": \"%lld\",\n", (long long)([self.timeStamp timeIntervalSince1970] * 1000)];
    if([self.sensorType isEqualToString:@"Pressure"])
    {
        double data = self.sensorData;
        data /= 10;
        [json appendFormat:@"\t\t\t\t\t\t\t\t\"data\": \"%.1f\"\n", data];
    }
    else if([self.sensorType isEqualToString:@"AirFuel"])
    {
        double data = self.sensorData;
        data /= 100;
        [json appendFormat:@"\t\t\t\t\t\t\t\t\"data\": \"%.2f\"\n", data];
    }
    else
    {
        [json appendFormat:@"\t\t\t\t\t\t\t\t\"data\": \"%df\"\n", self.sensorData];
    }
    
    return json;
}

-(id) initFromDataString:(NSString*)data
          withSensorType:(NSString*)type
            withSensorID:(int)ID
{
    if(self = [super init])
    {
        NSString* delimiters = @" ";
        NSArray* snapshotData = [data componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:delimiters]];
        
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd_hh:mm:ss.SS_a"];
        NSDate* time = [df dateFromString:[snapshotData objectAtIndex:0]];
        
        self.timeStamp = time;
        self.sensorType = type;
        self.sensorID = ID;
        self.sensorData = (unsigned int)[snapshotData objectAtIndex:1];
     }
     
    return self;
}


-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.timeStamp forKey:@"timeStamp"];
    [aCoder encodeObject:self.sensorType forKey:@"sensorType"];
    [aCoder encodeInt:self.sensorID forKey:@"sensorID"];
    [aCoder encodeInt:self.sensorData forKey:@"sensorData"];
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.timeStamp = [aDecoder decodeObjectForKey:@"timeStamp"];
        self.sensorType = [aDecoder decodeObjectForKey:@"sensorType"];
        self.sensorID = (int)[aDecoder decodeObjectForKey:@"sensorID"];
        self.sensorData = (int)[aDecoder decodeObjectForKey:@"sensorData"];
    }
    
    return self;
}



@end
