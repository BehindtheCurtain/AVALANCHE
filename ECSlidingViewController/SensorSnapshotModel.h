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
@property (copy) NSString* sensorName;
@property (copy) NSString* sensorType;
@property (assign) int sensorID;
@property (assign) int sensorData;

// Public instance methods.
-(id) initWithTimeStamp:(NSDate*) timeStamp
               withName:(NSString *)sensorName
               withType:(NSString *)sensorType
           withSensorID:(int)sensorID
               withData:(int)sensorData;

-(NSString*) serialize;

-(id) initFromDataString:(NSString*)data
          withSensorName:(NSString*)sensorName
          withSensorType:(NSString*)sensorType
            withSensorID:(int)sensorID;


@end
