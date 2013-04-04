//
//  BLEGaugeAlarmService.h
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/4/13.
//
//

#import <UIKit/UIKit.h>
#import "Brsp.h"
#import "AppDelegate.h"
#import "RealTimeBuilder.h"

@interface BLEGaugeAlarmService : NSObject <BrspDelegate, CBCentralManagerDelegate>

@property (strong) Brsp* brsp;

+ (BLEGaugeAlarmService*)instance;

@end
