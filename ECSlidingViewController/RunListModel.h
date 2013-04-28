//
//  RunListModel.h
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/12/13.
//
//

#import <Foundation/Foundation.h>
#import "RunModel.h"

@interface RunListModel : NSObject

@property (retain) NSMutableArray* runList;

+ (RunListModel*)instance:(BOOL)reset;
- (void)archive;
- (NSArray*)runNames;
- (NSArray*)notUploadedRunNames;
- (NSArray*)notUploadedRuns;

@end
