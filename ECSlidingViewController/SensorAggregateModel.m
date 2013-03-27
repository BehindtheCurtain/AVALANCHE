//
//  SensorAggregateModel.m
//  JASidePanels
//
//  Created by BehindTheCurtain on 3/5/13.
//
//

#import "SensorAggregateModel.h"

static const int DEFAULT_NUM_SENSORS = 12;
static NSString* DELIM = @"\n";

@implementation SensorAggregateModel

// Generates getter and setter methods for all properties.
@synthesize snapshots;
@synthesize sensorName;
@synthesize sensorType;
@synthesize sensorID;
@synthesize isActive;

// Init with metadata.
-(id) initWithName: (NSString*) name
          withType: (NSString*) type
      withSensorID: (int)ID
          isActive: (BOOL) active;
{
	self = [super init];
	
	self.sensorName = name;
	self.sensorType = type;
	self.sensorID = ID;
	self.isActive = active;
	
	return self;
}

-(void) serialize:(NSString*)file
{
    NSMutableString* serialString = [[NSMutableString alloc] init];
    [serialString appendString:self.sensorName];
    [serialString appendString:DELIM];
    [serialString appendString:self.sensorType];
    [serialString appendString:DELIM];
    [serialString appendString:[NSString stringWithFormat:@"%d", self.sensorID]];
    [serialString appendString:DELIM];
    [serialString appendString:[NSString stringWithFormat:@"%d", self.isActive]];
    [serialString appendString:DELIM];
    
    for(SensorSnapshotModel* snapshot in snapshots)
    {
        [serialString appendString:[snapshot serialize]];
        [serialString appendString:DELIM];
    }
    
    NSFileHandle* fileHandle = [NSFileHandle fileHandleForWritingAtPath:file];
    [fileHandle writeData:[[NSString stringWithString:serialString] dataUsingEncoding:NSUTF16StringEncoding]];
}



-(id) initFromFile:(NSString*)file
{
    if(self = [super init])
    {
        NSString* fileContents = [NSString stringWithContentsOfFile:file encoding:NSUTF16StringEncoding error:nil];
        
        NSArray* fileByLine = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:DELIM]];
        
        self.sensorName = [fileByLine objectAtIndex:0];
        self.sensorType = [fileByLine objectAtIndex:1];
        self.sensorID = [[fileByLine objectAtIndex:2] intValue];
        self.isActive = [[fileByLine objectAtIndex:3] boolValue];
        
        for(int i = 4; i < [fileByLine count]; i++)
        {
            NSString* line = [fileByLine objectAtIndex:i];
            
            SensorSnapshotModel* snapshot = [[SensorSnapshotModel alloc] initFromDataString:line withSensorName:self.sensorName withSensorType:self.sensorType withSensorID:self.sensorID];
            
            [snapshots setObject:snapshot atIndexedSubscript:(i-4)];
        }
    }
    
    return self;
}


/*
-(void) encodeWithCoder:(NSCoder *)aCoder
{
    // Get current time stamp.
    NSDate* timeStamp = [[NSDate alloc] init];
    [timeStamp timeIntervalSince1970];
    
    // Setup up date formatter that will turn the timestamp into a string.
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setTimeStyle:NSDateFormatterFullStyle];
    
    // Create filename by appending timestamp to sensor name.
    NSMutableString* file;
    file = [self.sensorName copy];
    [file appendString:[formatter stringFromDate:timeStamp]];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    snapshotsFile = [documentsDirectory stringByAppendingPathComponent:file];
    
    [NSKeyedArchiver archiveRootObject:snapshots toFile:snapshotsFile];
    
    [aCoder encodeObject:self.sensorName forKey:@"sensorName"];
    [aCoder encodeObject:self.sensorType forKey:@"sensorType"];
    [aCoder encodeInt:self.sensorID forKey:@"sensorID"];
    [aCoder encodeBool:self.isActive forKey:@"isActive"];
    [aCoder encodeObject:self.snapshotsFile forKey:@"snapshotsFile"];
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.sensorName = [aDecoder decodeObjectForKey:@"sensorName"];
        self.sensorType = [aDecoder decodeObjectForKey:@"sensorType"];
        self.sensorID = [aDecoder decodeIntForKey:@"sensorID"];
        self.isActive = [aDecoder decodeBoolForKey:@"isActive"];
        self.snapshotsFile = [aDecoder decodeObjectForKey:@"snapshotsFile"];
        
        snapshots = [NSKeyedUnarchiver unarchiveObjectWithFile:snapshotsFile];
    }
    
    return self;
}
 */


@end