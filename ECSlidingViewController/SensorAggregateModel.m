//
//  SensorAggregateModel.m
//  JASidePanels
//
//  Created by BehindTheCurtain on 3/5/13.
//
//

#import "SensorAggregateModel.h"

#define DELIM @"\n"

static const int DEFAULT_NUM_SENSORS = 12;

@implementation SensorAggregateModel

// Generates getter and setter methods for all properties.
@synthesize snapshots;
@synthesize sensorName;
@synthesize sensorType;
@synthesize initialTimeStamp;
@synthesize transformConstant;
@synthesize sensorID;
@synthesize isActive;

// Init with metadata.
-(id) initWithName:(NSString*) name
          withType:(NSString*) type
     withTransform:(int)transform
      withSensorID:(int)ID
          isActive:(BOOL) active;
{
    self.snapshots = [[NSMutableArray alloc] init];
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
    [serialString appendString:[NSString stringWithFormat:@"%d", self.transformConstant]];
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
    
    [[NSFileManager defaultManager] createFileAtPath:file contents:[serialString dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
}



-(id) initFromFile:(NSString*)file
{
    if(self = [super init])
    {
        self.snapshots = [[NSMutableArray alloc] init];
        
        NSString* fileContents = [NSString stringWithContentsOfFile:file encoding:NSUTF16StringEncoding error:nil];
        
        NSArray* fileByLine = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:DELIM]];
        
        self.sensorName = [fileByLine objectAtIndex:0];
        self.sensorType = [fileByLine objectAtIndex:1];
        self.transformConstant = [[fileByLine objectAtIndex:2] intValue];
        self.sensorID = [[fileByLine objectAtIndex:3] intValue];
        self.isActive = [[fileByLine objectAtIndex:4] boolValue];
        
        for(int i = 5; i < [fileByLine count]; i++)
        {
            NSString* line = [fileByLine objectAtIndex:i];
            
            SensorSnapshotModel* snapshot = [[SensorSnapshotModel alloc] initFromDataString:line withSensorType:self.sensorType withSensorID:self.sensorID];
            
            [snapshots addObject:snapshot];
        }
    }
    
    return self;
}

- (void)addSnapshot:(SensorSnapshotModel*)snapshot
{
    NSIndexSet* set = [[NSIndexSet alloc] initWithIndex:[self.snapshots count]];
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:set forKey:@"snapshots"];
    [self.snapshots addObject:snapshot];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:set forKey:@"snapshots"];
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
