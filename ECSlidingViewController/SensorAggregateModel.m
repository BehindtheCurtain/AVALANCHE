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
@synthesize pressureTear;
@synthesize min;
@synthesize max;
@synthesize average;
@synthesize first;
@synthesize count;
@synthesize warningHigh;
@synthesize warningLow;

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
    self.transformConstant = transform;
	
	return self;
}

- (NSString*)serialize
{
    NSMutableString* json = [[NSMutableString alloc] init];

    [json appendFormat:@"\t\t\t\t{\n"];
    [json appendFormat:@"\t\t\t\t\t\"name\": \"%@\",\n", self.sensorName];
    [json appendFormat:@"\t\t\t\t\t\"type\": \"%@\",\n", self.sensorType];
    [json appendFormat:@"\t\t\t\t\t\"transform\": \"%d\",\n", self.transformConstant];
    [json appendFormat:@"\t\t\t\t\t\"sensorID\": \"%d\",\n", self.sensorID];
    [json appendFormat:@"\t\t\t\t\t\"active\": \"%d\",\n", self.isActive];
    
    if([self.sensorType isEqualToString:@"Pressure"])
    {
        double minimum = self.min;
        double maximum = self.max;
        double avg = self.average;
        
        minimum /= 10;
        maximum /= 10;
        avg /= 10;
        [json appendFormat:@"\t\t\t\t\t\"min\": \"%.1f\",\n", minimum];
        [json appendFormat:@"\t\t\t\t\t\"max\": \"%.1f\",\n", maximum];
        [json appendFormat:@"\t\t\t\t\t\"average\": \"%.1f\",\n", avg];
    }
    else if([self.sensorType isEqualToString:@"AirFuel"])
    {
        double minimum = self.min;
        double maximum = self.max;
        double avg = self.average;
        
        minimum /= 100;
        maximum /= 100;
        avg /= 100;
        [json appendFormat:@"\t\t\t\t\t\"min\": \"%.2f\",\n", minimum];
        [json appendFormat:@"\t\t\t\t\t\"max\": \"%.2f\",\n", maximum];
        [json appendFormat:@"\t\t\t\t\t\"average\": \"%.2f\",\n", avg];
    }
    else
    {
        [json appendFormat:@"\t\t\t\t\t\"min\": \"%d\",\n", self.min];
        [json appendFormat:@"\t\t\t\t\t\"max\": \"%d\",\n", self.max];
        [json appendFormat:@"\t\t\t\t\t\"average\": \"%d\",\n", self.average];
    }

    [json appendString:@"\t\t\t\t\t\"snapshots\": {\n"];
    [json appendFormat:@"\t\t\t\t\t\t\"snapshot\": [\n"];
    
    int index = 0;
    for(SensorSnapshotModel* snapshot in snapshots)
    {
        
        [json appendFormat:@"\t\t\t\t\t\t\t{\n"];
        [json appendFormat:@"\t\t\t\t\t\t\t\t\"id\": \"%d\",\n", index];
        [json appendString:[snapshot serialize]];
        if(index < [snapshots count] -1)
        {
            [json appendFormat:@"\t\t\t\t\t\t\t},\n"];
        }
        else
        {
            [json appendFormat:@"\t\t\t\t\t\t\t}\n"];
        }
        index++;
    }
    
    [json appendFormat:@"\t\t\t\t\t\t]\n"];
    [json appendFormat:@"\t\t\t\t\t}\n"];
    [json appendFormat:@"\t\t\t\t},\n"];
    
    return json;
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


@end
