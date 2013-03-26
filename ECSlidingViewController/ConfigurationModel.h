//
//  ConfigurationModel.h
//  ECSlidingViewController
//
//  Created by BehindTheCurtain on 3/9/13.
//
//

#import <Foundation/Foundation.h>

@interface ConfigurationModel : NSObject <NSCoding>

@property (copy) NSString* name;
@property (assign) int sensorID;
@property (assign) BOOL active;
@property (assign) int transformConstant;

@end
