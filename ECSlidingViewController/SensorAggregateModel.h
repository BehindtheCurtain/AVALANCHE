//
//  SensorAggregateModel.h
//  JASidePanels
//
//  Created by BehindTheCurtain on 3/5/13.
//
//

#import <Foundation/Foundation.h>
#import "SensorSnapshotModel.h"

/*
 * SensorAggregateModel contains an array of SensorSnapshotModels as well as the associated metadata; name of sensor,
 * type of sensor, sensorID, and whether the sensor is actively being processed; for that sensor.
 */
@interface SensorAggregateModel: NSObject
{
}

// Instance properties.

// Array to hold all snapshots. New snapshots are added at the end of the array.
@property NSMutableArray* snapshots;

// Instance properties.
@property (copy) NSString* sensorName;
@property (copy) NSString* sensorType;
@property (copy) NSDate* initialTimeStamp;
@property (assign) int transformConstant;
@property (assign) int sensorID;
@property (assign) BOOL isActive;


//Initialize SensorAggregateModel with inputted metadata.
-(id) initWithName:(NSString*) name
          withType:(NSString*) type
     withTransform:(int)transform
      withSensorID:(int) ID
          isActive:(BOOL) active;

-(void) serialize:(NSString*) file;

-(id) initFromFile:(NSString*) file;

- (void)addSnapshot:(SensorSnapshotModel*) snapshot;

@end
