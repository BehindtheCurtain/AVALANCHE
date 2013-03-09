//
//  GaugeModel.m
//  ECSlidingViewController
//
//  Created by BehindTheCurtain on 3/9/13.
//
//

#import "GaugeModel.h"

@interface GaugeModel()

-(id) init;

@end

static GaugeModel* gaugeModelInstance;
static const int DEFUALT_NUM_SENSORS = 12;

@implementation GaugeModel

@synthesize startTimeStamp;
@synthesize endTimeStamp;
@synthesize sensorAggregateModelMap;

+(GaugeModel*) getInstance
{
	if(gaugeModelInstance == nil)
	{
		gaugeModelInstance = [[GaugeModel alloc] init];
	}
	
	return(gaugeModelInstance);
}

+(void) resetInstance
{
	gaugeModelInstance = nil;
}

-(SensorAggregateModel*) getAggregateAtIndex: (int) index
{
	if(sensorAggregateModelMap == nil)
	{
		return nil;
	}
	else
	{
		return([sensorAggregateModelMap objectAtIndex: index]);
	}
}

-(id) init
{
	self = [super init];
	[self.startTimeStamp timeIntervalSince1970];
    
	return self;
}

@end
