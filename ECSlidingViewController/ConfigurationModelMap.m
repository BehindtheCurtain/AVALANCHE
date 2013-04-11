//
//  ConfigurationModelMap.m
//  JASidePanels
//
//  Created by BehindTheCurtain on 3/5/13.
//
//

#import "ConfigurationModelMap.h"

const int DEFAULT_SENSORS = 14;

@implementation ConfigurationModelMap

@synthesize configurationMap;

+ (ConfigurationModelMap*)instance:(BOOL)reset
{
    static ConfigurationModelMap* instance;
    
    @synchronized(self)
    {
        if(instance == nil || reset)
        {
            instance = [[ConfigurationModelMap alloc] init];

            NSUserDefaults* currentDefaults = [NSUserDefaults standardUserDefaults];
            NSData* data = [currentDefaults objectForKey:@"sensorConfig"];
            

            [instance setConfigurationMap:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
            
            if([instance configurationMap] == nil || reset)
            {
                [instance setConfigurationMap:[[NSMutableArray alloc] init]];
                
                for(int i = 1; i <= DEFAULT_SENSORS; i++)
                {
                    ConfigurationModel* config = [[ConfigurationModel alloc] init];
                    
                    NSMutableString* name = [[NSMutableString alloc] init];
                    [name appendString:@"Sensor"];
                    [name appendString:[NSString stringWithFormat:@" %d", i]];
                    
                    [config setName:name];
                    [config setSensorID:i];
                    [config setActive:YES];
                    [config setSensorType:Tachometer];
                    [config setTransformConstant:0];
                    
                    [[instance configurationMap] addObject:config];
                }
                
                [[ConfigurationModelMap instance:NO] archive];
            }
            
        }
        
        return instance;
    }
}

- (void)archive
{
    
    NSUserDefaults* currentDefaults = [NSUserDefaults standardUserDefaults];;
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:self.configurationMap];
    [currentDefaults setObject:data forKey:@"sensorConfig"];
}

- (id)init
{
    if(self = [super init])
    {
        self.configurationMap = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSArray*)sensorNames
{
    NSMutableArray* names = [[NSMutableArray alloc] init];
    
    for(ConfigurationModel* config in self.configurationMap)
    {
        [names addObject:[config name]];
    }
    
    return names;
}

@end
