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

-(SensorAggregateModel*) getAggregateWithKey:(NSString*)key
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

-(void) serialize
{
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy/MM/dd-hh:mm:ss.SS-a"];
    
    self.runName = [df stringFromDate:self.startTimeStamp];
    
    NSString* applicationDocumentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* runDirectory = [applicationDocumentsDir stringByAppendingPathComponent:runName];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:runDirectory])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:runDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    self.endTimeStamp = [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]];
    
    
    
    
    
    NSMutableString* propertyList = [[NSMutableString alloc] init];
    [propertyList appendString:self.runName];
    [propertyList appendString:@"\n"];
    [propertyList appendString:[df stringFromDate:self.startTimeStamp]];
    [propertyList appendString:@"\n"];
    [propertyList appendString:[df stringFromDate:self.endTimeStamp]];
    [propertyList appendString:@"\n"];
    
    NSString* filePath = [runDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt", self.runName]];
    
    for(NSString* key in sensorAggregateModelMap)
    {
        SensorAggregateModel* sensorAggregate = [sensorAggregateModelMap objectForKey:key];
        NSString* aggregateFile = [runDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.dat", [sensorAggregate sensorName]]];
        [propertyList appendString:aggregateFile];
        [propertyList appendString:@"\n"];
        [sensorAggregate serialize:aggregateFile];
    }
    
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:[propertyList dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    
    [[[RunListModel instance:NO] runList] addObject:runName];
    
    [GaugeModel instance:YES];
}

-(id) initFromFile:(NSString *)file
{
    if([super init])
    {
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy/MM/dd-hh:mm:ss.SS-a"];
        
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
