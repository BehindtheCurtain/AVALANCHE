//
//  RunListModel.m
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/12/13.
//
//

#import "RunListModel.h"

@implementation RunListModel

@synthesize runList;

+ (RunListModel*)instance:(BOOL)reset
{
    static RunListModel* instance;
    
    @synchronized(self)
    {
        if(instance == nil || reset)
        {
            instance = [[RunListModel alloc] init];
            
            NSUserDefaults* currentDefaults = [NSUserDefaults standardUserDefaults];
            NSData* data = [currentDefaults objectForKey:@"runList"];
            
            [instance setRunList:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
            
            if([instance runList] == nil || reset)
            {
                [instance setRunList:[[NSMutableArray alloc] init]];
            }
            
            [instance archive];
        }
        
        return instance;
    }
}

- (NSArray*)runNames
{
    NSMutableArray* names = [[NSMutableArray alloc] init];
    
    for(RunModel* run in self.runList)
    {
        [names addObject:[run runName]];
    }
    
    return names;
}

- (void)archive
{
    NSUserDefaults* currentDefualts = [NSUserDefaults standardUserDefaults];
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:self.runList];
    [currentDefualts setObject:data forKey:@"runList"];
}

- (id)init
{
    if(self = [super init])
    {
        self.runList = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
