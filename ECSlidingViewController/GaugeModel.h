//
//  GaugeModel.h
//  ECSlidingViewController
//
//  Created by BehindTheCurtain on 3/9/13.
//
//

#import <Foundation/Foundation.h>
#import "SensorAggregateModel.h"
#import "SensorSnapshotModel.h"

@interface GaugeModel : NSObject <NSCoding>

// Instance properties.
@property NSDate* startTimeStamp;
@property NSDate* endTimeStamp;
@property NSMutableArray* sensorAggregateModelMap;
@property NSString* runName;

// Public class methods.
+(GaugeModel*) getInstance;
+(void) resetInstance;

// Public instance methods.
-(SensorAggregateModel*) getAggregateAtIndex:(int) index;
-(void) serialize:(NSString*) path;
-(id) initFromFile:(NSString*) file;

@end
