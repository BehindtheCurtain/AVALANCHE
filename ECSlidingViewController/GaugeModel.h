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
#import "RunListModel.h"

@interface GaugeModel : NSObject

// Instance properties.
@property NSDate* startTimeStamp;
@property NSDate* endTimeStamp;
@property NSMutableDictionary* sensorAggregateModelMap;
@property NSString* runName;

// Public class methods.
+ (GaugeModel*)instance:(BOOL)reset;

// Public instance methods.
- (void)serialize;
- (id)initFromFile:(NSString*)file;

@end
