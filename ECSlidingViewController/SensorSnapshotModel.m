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
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd_hh:mm:ss.SS_a"];
    
    NSString* time = [df stringFromDate:self.timeStamp];
    
    NSMutableString* data = [[NSMutableString alloc] init];
    [data appendString:time];
    [data appendString:@","];
    [data appendString:[NSString stringWithFormat:@"%d", self.sensorData]];
    
    return [NSString stringWithString:data];
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
