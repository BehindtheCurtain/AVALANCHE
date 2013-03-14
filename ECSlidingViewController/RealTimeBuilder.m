//
//  RealTimeBuilder.m
//  JASidePanels
//
//  Created by BehindTheCurtain on 3/5/13.
//
//

#import "RealTimeBuilder.h"


// Class variables
static ConfigurationModelMap* configurationMap;
static const int DEFAULT_NUM_SENSORS = 12;
static BOOL processing = NO;

@interface RealTimeBuilder()

// Private class methods.

// Creates SensorSnapshotModel objects.
+(SensorSnapshotModel*) sensorSnapshotModelFactory: (long) timeStamp
                                          withName: (NSString*) sensorName
                                          withType: (NSString*) sensorType
                                      withSensorID: (int) sensorID
                                          withData: (int) sensorData;

// Creates SensorAggregateModel objects.
+(SensorAggregateModel*) sensorAggregateModelFactory: (NSString*) sensorName
                                            withType: (NSString*) sensorType
                                        withSensorID: (int) sensorID
                                            isActive: (BOOL) active;

// Transform sensor data into readable form.
+(int) transformSensorData: (int) sensorID
              ofSensorType: (NSString*) sensorType
                    withID:	(int) sensorID;

@end

@implementation RealTimeBuilder
//Public class methods.

// Create a new GaugeModel singleton instance.
+(void) gaugeModelFactory
{
	// Make a map with a capacity for all sensors.
	NSMutableArray* sensorAggregateModelMap = [NSMutableArray arrayWithCapacity: DEFAULT_NUM_SENSORS];
	
    /*
	// Use configuration data to set up SensorAggregateModels
	for(ConfigurationModel* configuration in [[[GaugeModel getInstance] getConfigurationModelMap] getMap])
	{
		NSString* sensorName = [configuration getSensorName];
		NSString* sensorType = [configuration getSensorType];
		NSString* sensorID = [configuration getSensorType];
		BOOL active = [configuration isActive];
		
		if(active)
		{
			SensorAggregateModel* sensorAggregateModel = [self SensorAggregateModelFactory: sensorName withType: sensorType withSensorID: isActive: active];
			
			[SensorAggregateModelMap insertObject: SensorAggregateModel atIndex: sensorID];
		}
	}
     
	
	// If there is an instance reset the instance
	if([GaugeModel != nill])
	{
		[GaugeModel resetInstance];
	}
	
	[[GaugeModel getInstance] setSensorAggregateModelMap];
     */
}

// Set configuration map.
+(void) setConfigurationMap: (ConfigurationModelMap*) configurationMap
{
	self.configurationMap = configurationMap;
}

// Called when user begins run. Tells model to start saving data being pulled in from Bluetooth connection.
+(void) beginProcessing
{
	processing = YES;
}

// Called when user ends run. Serializes the GaugeModel, saving the run in local storage, and turns off processing.
+(void) endProcessing
{
    /*
	[GaugeModel serialize];
	
	processing = NO;
     */
}

// Creates a SensorSnapshotModel for each active sensor and adds each snapshot to their related SensorAggregateModel.
+(void) snapshotCreation: (Byte[]) data
{
	if(processing)
	{
        /*
		long timeStamp = [getTimeStamp];
		for(int i = 0; i < [data size]; i++)
		{
			SensorAggregateModel* aggregate = [GaugeModel getInstance] getAggregateAtIndex: i];
			NSString* sensorName = [aggregate getSensorName];
			NSString* sensorType = [aggregate getSensorType];
			BOOL active = [aggregate isActive];
			
			if(acive)
			{
				SensorSnapshotModel* snapShotModel = [self sensorSnapshotModelFactory: timeStamp withSensorName: sensorName
                                                                      withSensoryType: sensorType withSensorID: i];
				[aggregate addObject: snapShotModel];
			}
		}
         */
	}
}

//Private class methods.

// Validates SensorSnapshotModel parameters and then creates and returns that object.
+(SensorSnapshotModel*) sensorSnapshotModelFactory:	(long) timeStamp
                                          withName:	(NSString*) sensorName
                                          withType:	(NSString*) sensorType
                                      withSensorID:	(int) sensorID
                                          withData:	(int) sensorData
{
    /*
	Validate parameters
	
	sensorData = [self transformSensorData: sensorData ofType: sensorType withID: sensorID];
	
	return([SensorSnapshotModel initWithTimeStamp: timeStamp withName: sensorName withType: sensorType withSensorID: sensorID withData: sensorData]);
     */
}

// Transform the raw sensor data into formatted readable sensor data.
+(int) transformSensorData: (int) sensorData
                    ofType: (NSString*) sensorType
                    withID: (int) sensorID;
{
    /*
	int transformConstant = [[configurationMap objectAtIndex: sensorID] getTransformConstant];
	
	switch(sensorType)
	{
            // Transform sensorData based on formula for each data type.
		case "tachometer":
		{
			// # of ticks / ticks per revolution * 8 hertz * 60 sec per min. = revolutions per minute.
			return (sensorData / transformConstant) * 8 * 60;
		}
            
		case "spedometer":
		{
			// Convert tix/8th second to tix/hour. Divide that by tix per mile. gives miles/hour.
			return (sensorData * 8 * 60 * 60) / (8 * tixPer8thOfMile);
		}
			
		case "temp":
		{
			return sensorData / 10; // Sensor value off of CAN BUS is degrees celcius * 10
		}
            
		case "pressure":
		{
			return sensorData / 10; // Sensor value off of CAN BUS is PSI * 10
		}
            
		case "voltage":
		{
			return sensorData;
		}
            
		case "oxygen":
		{
			return sensorData;
		}
     
	}
     */
}

// Validates SensorAggregateModel parameters and then creates and returns that object.
+(SensorAggregateModel*) sensorAggregateModelFactory:   (NSString*) sensorName
                                            withType:   (NSString*) sensorType
                                        withSensorID:	(int) sensorID
                                            isActive:	(BOOL) active;
{
    /*
	Validate parameters
	
	return([SensorAggregateModel initWithName: sensorName withType: sensorType withSensorID: sensorID isActive: active];
     */
}
           
           
           @end
