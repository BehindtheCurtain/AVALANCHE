//
//  NetworkConfigModel.h
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/22/13.
//
//

#import <Foundation/Foundation.h>

@interface NetworkConfigModel : NSObject <NSCoding>

@property (retain) NSString* serverIP;
@property (retain) NSString* ftpPassword;
@property (retain) NSString* ftpUser;

+ (NetworkConfigModel*)instance:(BOOL)reset;
- (void)archive;

- (NSString*)ftpURL;
- (NSString*)httpURL;

@end
