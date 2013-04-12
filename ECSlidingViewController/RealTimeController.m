//
//  RealTimeController.m
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/10/13.
//
//

#import "RealTimeController.h"

@interface RealTimeController ()

@end

static void * const temp1Context = (void*)&temp1Context;
static void * const temp2Context = (void*)&temp2Context;
static void * const temp3Context = (void*)&temp3Context;
static void * const temp4Context = (void*)&temp4Context;

@implementation RealTimeController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [RealTimeBuilder gaugeModelFactory];
    
    [[[[GaugeModel instance:NO] sensorAggregateModelMap] objectForKey:@"Temperature0"] addObserver:self forKeyPath:@"snapshots" options:NSKeyValueObservingOptionNew context:temp1Context];
    [[[[GaugeModel instance:NO] sensorAggregateModelMap] objectForKey:@"Temperature1"] addObserver:self forKeyPath:@"snapshots" options:NSKeyValueObservingOptionNew context:temp2Context];
    [[[[GaugeModel instance:NO] sensorAggregateModelMap] objectForKey:@"Temperature2"] addObserver:self forKeyPath:@"snapshots" options:NSKeyValueObservingOptionNew context:temp3Context];
    [[[[GaugeModel instance:NO] sensorAggregateModelMap] objectForKey:@"Temperature3"] addObserver:self forKeyPath:@"snapshots" options:NSKeyValueObservingOptionNew context:temp4Context];
    
    [BLEGaugeAlarmService instance];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSIndexSet* set = [change objectForKey:NSKeyValueChangeIndexesKey];
    SensorSnapshotModel* snapshot = [[object snapshots] objectAtIndex:[set firstIndex]];
    
    if(context == temp1Context)
    {
        self.temp0Label.text = [NSString stringWithFormat:@"EGT1: %d° F", [snapshot sensorData]];
    }
    else if(context == temp2Context)
    {
        self.temp1Label.text = [NSString stringWithFormat:@"EGT2: %d° F", [snapshot sensorData]];
    }
    else if(context == temp3Context)
    {
        self.temp2Label.text = [NSString stringWithFormat:@"EGT3: %d° F", [snapshot sensorData]];
    }
    else if(context == temp4Context)
    {
        self.temp3Label.text = [NSString stringWithFormat:@"EGT4: %d° F", [snapshot sensorData]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)serializeAction:(id)sender
{
    [[GaugeModel instance:NO] setStartTimeStamp: [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]]];
    [[GaugeModel instance:NO] serialize];
    
    NSString* applicationDocumentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* runDirectory = [applicationDocumentsDir stringByAppendingPathComponent:@"test"];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:runDirectory])
    {
        NSString* fileName = [runDirectory stringByAppendingPathComponent:@"test.txt"];
        if([[NSFileManager defaultManager] fileExistsAtPath:fileName])
        {
            self.serializationLabel.text = @"YES";
        }
        else
        {
            self.serializationLabel.text = @"NO";
        }
    }
    else
    {
        self.serializationLabel.text = @"NO";
    }
}
@end
