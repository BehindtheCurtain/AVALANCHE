//
//  RealTimeBuilder.h
//  JASidePanels
//
//  Created by BehindTheCurtain on 3/5/13.
//
//

#import <Foundation/Foundation.h>
#import "ConfigurationModelMap.h"
#import "RealTimeBuilder.h"
#import "SensorSnapshotModel.h"
#import "SensorAggregateModel.h"
#import "ConfigurationModel.h"

@interface RealTimeBuilder: NSObject
{
}

// Public class methods.

// Create a new GaugeModel singleton instance.
+(void) gaugeModelFactory;

// Set configuration map.
+(void) setConfigurationMap: (ConfigurationModelMap*) configurationMap;

// Turn on processing.
+(void) beginProcessing;

// Turn off processing.
+(void) endProcessing;

// Create all snapshots for all active sensors.
+(void) snapshotCreation: (Byte[]) data;

@end;