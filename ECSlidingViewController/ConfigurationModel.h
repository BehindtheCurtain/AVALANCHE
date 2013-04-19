//
//  ConfigurationModel.h
//  ECSlidingViewController
//
//  Created by BehindTheCurtain on 3/9/13.
//
//

#import <Foundation/Foundation.h>

@interface ConfigurationModel : NSObject <NSCoding>

typedef enum
{
    Temperature,
    Oxygen,
    Pressure,
    Voltage,
    RPM,
    PulseCount,
    AirFuel
} SensorTypes;

@property (copy) NSString* name;
@property (assign) SensorTypes sensorType;
@property (assign) int sensorID;
@property (assign) BOOL active;
@property (assign) int transformConstant;
@property (assign) int maxValue;
@property (assign) int minValue;

- (NSString*) getType;

@end
