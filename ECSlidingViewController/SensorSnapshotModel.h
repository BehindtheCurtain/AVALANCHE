//
//  SensorSnapshotModel.h
//  JASidePanels
//
//  Created by BehindTheCurtain on 3/5/13.
//
//

#import <Foundation/Foundation.h>

@interface SensorSnapshotModel : NSObject <NSCoding>

// SensorSnapshotModel properties.
@property (copy) NSDate* timeStamp;
@property (copy) NSString* sensorType;
@property (assign) int sensorID;
@property (assign) unsigned int sensorData;

// Public instance methods.
-(id) initWithTimeStamp:(long)timeStamp
               withType:(NSString*)sensorType
           withSensorID:(int)sensorID
               withData:(unsigned int)sensorData;

-(NSString*) serialize;

-(id) initFromDataString:(NSString*)data
          withSensorType:(NSString*)sensorType
            withSensorID:(int)sensorID;


@end
