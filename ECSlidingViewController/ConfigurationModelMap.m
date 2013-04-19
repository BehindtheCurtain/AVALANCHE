//
//  ConfigurationModelMap.m
//  JASidePanels
//
//  Created by BehindTheCurtain on 3/5/13.
//
//

#import "ConfigurationModelMap.h"


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
                
                //Temperature Loop
                for(int i = 1; i <= 4; i++)
                {
                    ConfigurationModel* config = [[ConfigurationModel alloc] init];
                    
                    NSMutableString* name = [[NSMutableString alloc] init];
                    [name appendString:@"EGT"];
                    [name appendString:[NSString stringWithFormat:@" %d", i]];
                    
                    [config setName:name];
                    [config setSensorID:i];
                    [config setActive:YES];
                    [config setSensorType:Temperature];
                    [config setTransformConstant:0];
                    [config setMaxValue:2501];
                    [config setMinValue:-346];
                    
                    [[instance configurationMap] addObject:config];
                }
                
                //Pressure Loop
                for(int i = 1; i <= 3; i++)
                {
                    ConfigurationModel* config = [[ConfigurationModel alloc] init];
                    
                    NSMutableString* name = [[NSMutableString alloc] init];
                    [name appendString:@"PSI"];
                    [name appendString:[NSString stringWithFormat:@" %d", i]];
                    
                    [config setName:name];
                    [config setSensorID:i];
                    [config setActive:YES];
                    [config setSensorType:Pressure];
                    [config setTransformConstant:0];
                    [config setMaxValue: -100];
                    [config setMinValue: 100];
                    
                    [[instance configurationMap] addObject:config];
                }
                
                //Pulse Rate Loop
                for(int i = 1; i <= 3; i++)
                {
                    ConfigurationModel* config = [[ConfigurationModel alloc] init];
                    
                    NSMutableString* name = [[NSMutableString alloc] init];
                    [name appendString:@"RPM"];
                    [name appendString:[NSString stringWithFormat:@" %d", i]];
                    
                    [config setName:name];
                    [config setSensorID:i];
                    [config setActive:YES];
                    [config setSensorType:RPM];
                    [config setTransformConstant:0];
                    [config setMaxValue: 8400];
                    [config setMinValue: 0];
                    [[instance configurationMap] addObject:config];
                }
                
                for(int i = 1; i <= 2; i++)
                {
                    ConfigurationModel* config = [[ConfigurationModel alloc] init];
                    
                    NSMutableString* name = [[NSMutableString alloc] init];
                    [name appendString:@"AFR"];
                    [name appendString:[NSString stringWithFormat:@" %d", i]];
                    
                    [config setName:name];
                    [config setSensorID:i];
                    [config setActive:YES];
                    [config setSensorType:AirFuel];
                    [config setTransformConstant:0];
                    [config setMaxValue: 14875];
                    [config setMinValue: 712];
                    [[instance configurationMap] addObject:config];
                }
                
                [instance archive];
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
