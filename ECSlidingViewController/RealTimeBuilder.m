//
//  RealTimeBuilder.m
//  JASidePanels
//
//  Created by BehindTheCurtain on 3/5/13.
//
//

#import "RealTimeBuilder.h"

#define DEFAULT_NUM_SENSORS 12
#define TIME_BETWEEN_TIMESTAMP 10

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
		BOOL active = [configuration active];
		
		if(active)
		{
            SensorAggregateModel* sensorAggregateModel = [[SensorAggregateModel alloc] initWithName:sensorName withType:sensorType withTransform:transform withSensorID:sensorID isActive:active];
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
+ (void)snapshotCreation:(NSMutableArray *)data withMessageType:(unsigned char)messageType withTimeStamp:(unsigned long)timestamp
{
    NSMutableDictionary* sensorAggregateModelMap = [[GaugeModel instance:NO] sensorAggregateModelMap];
    
    NSString* type;
    
    switch (messageType)
    {
        case 0:
        {
            type = @"Temperature";
            break;
        }
        case 1:
        {
            type = @"Pressure";
            break;
        }
        case 2:
        {
            type = @"PulseRate";
            break;
        }
        case 3:
        {
            type = @"PulseCount";
            break;
        }
        case 4:
        {
            type = @"Voltage";
            break;
        }
        case 5:
        {
            type = @"AirFuel";
            break;
        }
    }
    
    for(NSNumber* dataPoint in data)
    {
        int sensorID = [data indexOfObject:dataPoint] + 1;
        unsigned int sensorData = [dataPoint unsignedIntValue];
        
        NSString* key = [type stringByAppendingFormat:@"%d", sensorID];
        SensorAggregateModel* aggregate = [sensorAggregateModelMap objectForKey:key];
        
        sensorData = [RealTimeBuilder transformSensorData:sensorData ofSensorType:type withID:sensorID withTransform:[aggregate transformConstant]];
        
        NSDate* time = [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]];
        
        SensorSnapshotModel* snapshot = [[SensorSnapshotModel alloc] initWithTimeStamp:time withType:type withSensorID:sensorID withData:sensorData];
        
        [aggregate addSnapshot:snapshot];
    }
    
}

// Transform the raw sensor data into formatted readable sensor data.
+ (int)transformSensorData:(int)sensorData ofSensorType:(NSString *)sensorType withID:(int)sensorID withTransform:(int)transformConstant
{
    int transformedData = sensorData;
    
    if([sensorType isEqualToString:@"tachometer"])
    {
        // # of ticks / ticks per revolution * 8 hertz * 60 sec per min. = revolutions per minute.
        transformedData = (sensorData / transformConstant) * 8 * 60;
    }
    else if([sensorType isEqualToString:@"spedometer"])
    {
        // Convert tix/8th second to tix/hour. Divide that by tix per mile. gives miles/hour.
        //transformedData = (sensorData * 8 * 60 * 60) / (8 * tixPer8thOfMile);
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
        transformedData = sensorData / 10; // Sensor value off of CAN BUS is PSI * 10
    }
    else if([sensorType isEqualToString:@"Voltage"])
    {
        transformedData = sensorData;
    }
    else if([sensorType isEqualToString:@"AirFuel"])
    {
        transformedData = sensorData;
    }
    
    return transformedData;
}

           
           
@end