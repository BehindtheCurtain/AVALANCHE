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
@property NSDate* timeStamp;
@property NSString* sensorName;
@property NSString* sensorType;
@property int sensorID;
@property int sensorData;

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
