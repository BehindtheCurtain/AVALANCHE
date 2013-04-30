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
    [df setDateFormat:@"yyyy-MM-dd_hh:mm:ss.SS_a"];
    
    self.runName = [df stringFromDate:self.startTimeStamp];
    
    NSString* applicationDocumentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* runDirectory = [applicationDocumentsDir stringByAppendingPathComponent:@"runs"];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:runDirectory])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:runDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    self.endTimeStamp = [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]];
    
    
    NSMutableString* json = [[NSMutableString alloc] init];
    [json appendString:@"{\n"];
    [json appendString:@"\t\"run\": {\n"];
    [json appendFormat:@"\t\t\"name\": \"%@\",\n", self.runName];
    [json appendFormat:@"\t\t\"startTime\": \"%ld\",\n", (time_t)[self.startTimeStamp timeIntervalSince1970]];
    [json appendFormat:@"\t\t\"endTime\": \"%ld\",\n", (time_t)[self.endTimeStamp timeIntervalSince1970]];
    [json appendString:@"\t\t\"sensors\": {\n"];
    [json appendFormat:@"\t\t\t\"sensor\": [\n"];
    
    NSString* filePath = [runDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json", self.runName]];
    
    for(NSString* key in sensorAggregateModelMap)
    {
        SensorAggregateModel* sensorAggregate = [sensorAggregateModelMap objectForKey:key];
        [json appendString:[sensorAggregate serialize]];
    }
    
    [json deleteCharactersInRange:NSMakeRange([json length]-2, 1)];
    [json appendString:@"\n"];
    
    [json appendFormat:@"\t\t\t]\n"];
    [json appendString:@"\t\t}\n"];
    [json appendString:@"\t}\n"];
    [json appendString:@"}\n\n"];
    
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:[json dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    
    RunModel* run = [[RunModel alloc] init];
    
    [run setRunName:runName];
    [run setDirectory:runDirectory];
    [run setFilePath:filePath];
    [run setUploaded:NO];
    
    [[[RunListModel instance:NO] runList] addObject:run];
    [[RunListModel instance:NO] archive];
    
    [GaugeModel instance:YES];
}

-(id) initFromFile:(NSString *)file
{
    if([super init])
    {
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd_hh:mm:ss.SS_a"];
        
        NSString* fileContents = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
        
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
