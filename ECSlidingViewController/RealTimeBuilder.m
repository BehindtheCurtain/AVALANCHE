//
//  RealTimeBuilder.m
//  JASidePanels
//
//  Created by BehindTheCurtain on 3/5/13.
//
//

#import "RealTimeBuilder.h"

// Class variables
static BOOL processing = NO;

@interface RealTimeBuilder()

@end

@implementation RealTimeBuilder

#pragma mark Class variable accessors
+ (BOOL)processing
{
    return processing;
}


#pragma mark Public class methods.

// Create a new GaugeModel singleton instance.
+(void) gaugeModelFactory
{
	// Make a map with a capacity for all sensors.
	NSMutableDictionary* sensorAggregateModelMap = [[NSMutableDictionary alloc] init];
	

	// Use configuration data to set up SensorAggregateModels
	for(ConfigurationModel* configuration in [[ConfigurationModelMap instance:NO] configurationMap])
	{
		NSString* sensorName = [configuration name];
		NSString* sensorType = [configuration getType];
        int transform = [configuration transformConstant];
		int sensorID = [configuration sensorID];
        int warnHigh = [configuration maxValue];
        int warnLow = [configuration minValue];
		BOOL active = [configuration active];
		
		if(active)
		{
            SensorAggregateModel* sensorAggregateModel = [[SensorAggregateModel alloc] initWithName:sensorName withType:sensorType withTransform:transform withSensorID:sensorID isActive:active];
            [sensorAggregateModel setPressureTear:-1];
            [sensorAggregateModel setWarningHigh:warnHigh];
            [sensorAggregateModel setWarningLow:warnLow];
            [sensorAggregateModel setFirst:YES];
			NSString* key = [[sensorAggregateModel sensorType] stringByAppendingFormat:@"%d", [sensorAggregateModel sensorID]];
			[sensorAggregateModelMap setObject:sensorAggregateModel forKey:key];
		}
	}
	
	[[GaugeModel instance:YES] setSensorAggregateModelMap:sensorAggregateModelMap];
}

// Called when user begins run. Tells model to start saving data being pulled in from Bluetooth connection.
+ (void)beginProcessing
{
	processing = YES;
    
    NSDate* currentTime = [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]];
    
    [[GaugeModel instance:NO] setStartTimeStamp:[NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]]];
    
    for(NSString* key in [[GaugeModel instance:NO] sensorAggregateModelMap])
    {
        SensorAggregateModel* aggregate = [[[GaugeModel instance:NO] sensorAggregateModelMap] objectForKey:key];
        [aggregate setSnapshots:[[NSMutableArray alloc] init]];
        [aggregate setInitialTimeStamp:currentTime];
    }
}

// Called when user ends run. Serializes the GaugeModel, saving the run in local storage, and turns off processing.
+ (void)endProcessing
{
    [[GaugeModel instance:NO] serialize];
	
	processing = NO;
}

// Creates a SensorSnapshotModel for each active sensor and adds each snapshot to their related SensorAggregateModel.
+ (void)snapshotCreation:(NSMutableArray *)data
{
    NSMutableDictionary* sensorAggregateModelMap = [[GaugeModel instance:NO] sensorAggregateModelMap];
    
    NSDate* time = [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]];
    
    for(int i = 0; i < [data count]; i++)
    {
        NSNumber* dataPoint = [data objectAtIndex:i];
        int sensorID = i + 1;
        NSString* sensorType = nil;
        
        if(i >= 0 && i <= 3)
        {
            sensorType = @"Temperature";
        }
        else if(i >= 4 && i <= 6)
        {
            sensorType = @"Pressure";
            sensorID  -= 4;
        }
        else if(i >= 7 && i <= 9)
        {
            sensorType = @"RPM";
            sensorID -= 7;
        }
        else if(i >= 10 && i <= 11)
        {
            sensorType = @"AirFuel";
            sensorID -= 10;
        }
        
        unsigned int sensorData = [dataPoint unsignedIntValue];
        
        NSString* key = [sensorType stringByAppendingFormat:@"%d", sensorID];
        SensorAggregateModel* aggregate = [sensorAggregateModelMap objectForKey:key];
        sensorData = [RealTimeBuilder transformSensorData:sensorData ofSensorType:sensorType withID:sensorID withTransform:[aggregate transformConstant] withAggregate:aggregate];
        
        SensorSnapshotModel* snapshot = [[SensorSnapshotModel alloc] initWithTimeStamp:time withType:sensorType withSensorID:sensorID withData:sensorData];
        
        [aggregate addSnapshot:snapshot];
    }
    
}

// Transform the raw sensor data into formatted readable sensor data.
+ (int)transformSensorData:(int)sensorData ofSensorType:(NSString *)sensorType withID:(int)sensorID withTransform:(int)transformConstant withAggregate:(SensorAggregateModel *)aggregate
{
    int transformedData = sensorData;
    
    if([sensorType isEqualToString:@"RPM"])
    {
        transformConstant = (transformConstant >= 1) ? transformConstant : 1;
        
        transformedData = (transformedData * 60) / transformConstant;
    }
    else if([sensorType isEqualToString:@"Temperature"])
    {
        transformedData = sensorData * 18; // Sensor value off of CAN BUS is degrees celcius * 10
        transformedData += 50;
        transformedData /= 100;
        transformedData += 32;
    }
    else if([sensorType isEqualToString:@"Pressure"])
    {
        if([aggregate first])
        {
            [aggregate setPressureTear:sensorData];
            
            transformedData = 0;
        }
        else
        {
            transformedData = sensorData - [aggregate pressureTear];
        }
    }
    else if([sensorType isEqualToString:@"AirFuel"])
    {
        transformedData = sensorData;
    }
    
    if([aggregate min] > transformedData)
    {
        [aggregate setMin:transformedData];
    }
    else if([aggregate max] < transformedData)
    {
        [aggregate setMax:transformedData];
    }
    
    if([aggregate first])
    {
        [aggregate setAverage:transformedData];
        [aggregate setCount:1];
        [aggregate setMin:transformedData];
        [aggregate setMax:transformedData];
        [aggregate setFirst:NO];
    }
    else
    {
        int count = [aggregate count] + 1;
        [aggregate setCount:count];
        int average = [aggregate average];
        average = average + ((transformedData - average) / count);
        [aggregate setAverage:average];
    }
    
    return transformedData;
}

           
           
@end