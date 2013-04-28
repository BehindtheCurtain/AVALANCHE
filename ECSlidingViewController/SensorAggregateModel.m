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
	
	return self;
}

- (NSString*)serialize
{
    NSMutableString* xml = [[NSMutableString alloc] init];
    [xml appendFormat:@"\t\t<sensor name=\"%@\">\n", self.sensorName];
    [xml appendFormat:@"\t\t\t<type>%@</type>\n", self.sensorType];
    [xml appendFormat:@"\t\t\t<transform>%d</transform>\n", self.transformConstant];
    [xml appendFormat:@"\t\t\t<sensorID>%d</sensorID>\n", self.sensorID];
    [xml appendFormat:@"\t\t\t<active>%d</active>\n", self.isActive];
    
    if([self.sensorType isEqualToString:@"Pressure"])
    {
        double minimum = self.min;
        double maximum = self.max;
        double avg = self.average;
        
        minimum /= 10;
        maximum /= 10;
        avg /= 10;
        [xml appendFormat:@"\t\t\t<min>%.1f</min>\n", minimum];
        [xml appendFormat:@"\t\t\t<max>%.1f</max>\n", maximum];
        [xml appendFormat:@"\t\t\t<average>%.1f</average>\n", avg];
    }
    else if([self.sensorType isEqualToString:@"AirFuel"])
    {
        double minimum = self.min;
        double maximum = self.max;
        double avg = self.average;
        
        minimum /= 100;
        maximum /= 100;
        avg /= 100;
        [xml appendFormat:@"\t\t\t<min>%.2f</min>\n", minimum];
        [xml appendFormat:@"\t\t\t<max>%.2f</max>\n", maximum];
        [xml appendFormat:@"\t\t\t<average>%.2f</average>\n", avg];
    }
    else
    {
        [xml appendFormat:@"\t\t\t<min>%d</min>\n", self.min];
        [xml appendFormat:@"\t\t\t<max>%d</max>\n", self.max];
        [xml appendFormat:@"\t\t\t<average>%d</average>\n", self.average];
    }

    [xml appendString:@"\t\t\t<snapshots>\n"];
    
    int index = 0;
    for(SensorSnapshotModel* snapshot in snapshots)
    {
        [xml appendFormat:@"\t\t\t\t<snapshot id=\"%d\">\n", index];
        [xml appendString:[snapshot serialize]];
        [xml appendString:@"\t\t\t\t</snapshot>\n"];
        index++;
    }
    
    [xml appendString:@"\t\t\t</snapshots>\n"];
    [xml appendString:@"\t\t</sensor>\n"];
    
    return xml;
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
