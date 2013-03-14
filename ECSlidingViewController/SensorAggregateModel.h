//
//  SensorAggregateModel.h
//  JASidePanels
//
//  Created by BehindTheCurtain on 3/5/13.
//
//

#import <Foundation/Foundation.h>
#import "SensorSnapshotModel.h";

/*
 * SensorAggregateModel contains an array of SensorSnapshotModels as well as the associated metadata; name of sensor,
 * type of sensor, sensorID, and whether the sensor is actively being processed; for that sensor.
 */
@interface SensorAggregateModel: NSObject <NSCoding>
{
}

// Instance properties.

// Array to hold all snapshots. New snapshots are added at the end of the array.
@property NSMutableArray* snapshots;

// Instance properties.
@property NSString* sensorName;
@property NSString* sensorType;
@property int sensorID;
@property BOOL isActive;

//Initialize SensorAggregateModel with inputted metadata.
-(id) initWithName: 	(NSString*) name
          withType: 		(NSString*) type
      withSensorID: 	(int) ID
          isActive: 		(BOOL) active;
@end
