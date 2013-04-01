//
//  ConfigurationModelMap.h
//  JASidePanels
//
//  Created by BehindTheCurtain on 3/5/13.
//
//

#import <Foundation/Foundation.h>
#import "ConfigurationModel.h"

@interface ConfigurationModelMap : NSObject

@property (retain) NSMutableArray* configurationMap;


+ (ConfigurationModelMap*)instance;
+ (void)archive;
- (NSArray*)sensorNames;
- (void)save;


@end
