//
//  UserModel.h
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/21/13.
//
//

#import <Foundation/Foundation.h>


@interface UserModel : NSObject <NSCoding>

@property (copy) NSString* userName;
@property (copy) NSString* password;
@property (assign) BOOL loggedOn;

+ (UserModel*)instance:(BOOL)reset;
- (void)archive;
@end
