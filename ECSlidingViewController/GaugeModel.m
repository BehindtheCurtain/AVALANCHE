//
//  GaugeModel.m
//  ECSlidingViewController
//
//  Created by BehindTheCurtain on 3/9/13.
//
//

#import "GaugeModel.h"

@interface GaugeModel()

-(id) init;

@end


static const int DEFUALT_NUM_SENSORS = 12;

static NSString* DELIM = @"\n";

@implementation GaugeModel

@synthesize startTimeStamp;
@synthesize endTimeStamp;
@synthesize sensorAggregateModelMap;
@synthesize runName;

+ (GaugeModel*)instance:(BOOL)reset
{
    static GaugeModel* gaugeModelInstance;
    
	if(gaugeModelInstance == nil && reset)
	{
		gaugeModelInstance = [[GaugeModel alloc] init];
	}
	
	return(gaugeModelInstance);
}

-(SensorAggregateModel*) getAggregateWithKey:(NSString*)key;
{
	if(sensorAggregateModelMap == nil)
	{
		return nil;
	}
	else
	{
		return([sensorAggregateModelMap objectForKey:key]);
	}
}

-(void) serialize:(NSString *)path
{
    [self.endTimeStamp timeIntervalSince1970];
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
    
    NSMutableString* propertyList = [[NSMutableString alloc] init];
    [propertyList appendString:runName];
    [propertyList appendString:@"\n"];
    [propertyList appendString:[df stringFromDate:startTimeStamp]];
    [propertyList appendString:@"\n"];
    [propertyList appendString:[df stringFromDate:endTimeStamp]];
    [propertyList appendString:@"\n"];
    
    NSMutableString* filePath = [[NSMutableString alloc] init];
    [filePath appendString:path];
    [filePath appendString:@"\\"];
    [filePath appendString:runName];
    
    [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:nil];
    
    
    for(SensorAggregateModel* sensorAggregate in sensorAggregateModelMap)
    {
        NSMutableString* aggregateFile = [[NSMutableString alloc] init];
        [aggregateFile appendString:filePath];
        [aggregateFile appendString:@"\\"];
        [aggregateFile appendString:[sensorAggregate sensorName]];
        [aggregateFile appendString:@".dat"];
        
        [propertyList appendString:aggregateFile];
        [propertyList appendString:@"\n"];
         
        [sensorAggregate serialize:aggregateFile];
    }
    
    [filePath appendString:runName];
    [filePath appendString:@".dat"];
    
    NSFileHandle* fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    [fileHandle writeData:[[NSString stringWithString:propertyList] dataUsingEncoding:NSUTF16StringEncoding]];
    
    [GaugeModel instance:YES];
}

-(id) initFromFile:(NSString *)file
{
    if([super init])
    {
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
        
        NSString* fileContents = [NSString stringWithContentsOfFile:file encoding:NSUTF16StringEncoding error:nil];
        
        NSArray* fileByLine = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:DELIM]];
        
        runName = [fileByLine objectAtIndex:0];
        startTimeStamp = [df dateFromString:[fileByLine objectAtIndex:1]];
        endTimeStamp = [df dateFromString:[fileByLine objectAtIndex:2]];
        
        for(int i = 3; i < [fileByLine count]; i++)
        {
            NSString* line = [fileByLine objectAtIndex:i];
            SensorAggregateModel* sensorAggregate = [[SensorAggregateModel alloc] initFromFile:line];
            [self.sensorAggregateModelMap setObject:sensorAggregate forKey:[[sensorAggregate sensorName] stringByAppendingFormat:@"%d", [sensorAggregate sensorID]]];
        }
    }
    
    return self;
}

-(id) init
{
	self = [super init];
	[self.startTimeStamp timeIntervalSince1970];
    
	return self;
}

@end
