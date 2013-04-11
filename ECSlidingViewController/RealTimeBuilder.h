//
//  RealTimeBuilder.h
//  JASidePanels
//
//  Created by BehindTheCurtain on 3/5/13.
//
//

#import <Foundation/Foundation.h>
#import "ConfigurationModelMap.h"
#import "SensorSnapshotModel.h"
#import "SensorAggregateModel.h"
#import "ConfigurationModel.h"
#import "GaugeModel.h"

@interface RealTimeBuilder: NSObject
{
}

#pragma mark Class variable accessors
+ (BOOL)processing;


#pragma mark Public class methods.

// Create a new GaugeModel singleton instance.
+ (void)gaugeModelFactory;

// Turn on processing.
+ (void)beginProcessing;

// Turn off processing.
+ (void)endProcessing;

// Create all snapshots for all active sensors.
+ (void)snapshotCreation:(NSMutableArray*)data
           withMessageType:(unsigned char)messageType
           withTimeStamp:(unsigned long)timestamp;

// Transform sensor data into readable form.
+ (int)transformSensorData:(int)sensorData
              ofSensorType:(NSString*)sensorType
                    withID:(int)sensorID
             withTransform:(int)transformConstant;

@end;