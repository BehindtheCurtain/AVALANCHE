//
//  GuageDisplayModel.h
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/25/13.
//
//

#import <Foundation/Foundation.h>

@interface GaugeDisplayModel : NSObject <NSCoding>

@property (retain) NSMutableArray* sensors;

- (id)initwithPage:(int)page;
- (void)archive:(int)page;

@end
