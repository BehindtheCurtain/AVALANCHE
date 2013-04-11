//
//  RealTimeViewController.m
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/4/13.
//
//

#import "RealTimeViewControllerTest.h"

@interface RealTimeViewControllerTest ()

@end

@implementation RealTimeViewControllerTest


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
    
    [RealTimeBuilder gaugeModelFactory];
	
    [[[[GaugeModel instance:NO] sensorAggregateModelMap] objectForKey:@"Tachometer1"] addObserver:self forKeyPath:@"snapshots" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSIndexSet* set = [change objectForKey:NSKeyValueChangeIndexesKey];
    SensorSnapshotModel* snapshot = [[object snapshots] objectAtIndex:[set firstIndex]];
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
    self.timeStampLabel.text = [df stringFromDate:[snapshot timeStamp]];
    self.sensorTypeLabel.text = [snapshot sensorType];
    self.sensorIDLabel.text = [NSString stringWithFormat:@"%d", [snapshot sensorID]];
    self.sensorDataLabel.text = [NSString stringWithFormat:@"%d", [snapshot sensorData]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createAction:(id)sender
{
    static int count = 0;
    
    count++;
    
    SensorAggregateModel* aggregate = [[[GaugeModel instance:NO] sensorAggregateModelMap] objectForKey:@"Tachometer1"];
    SensorSnapshotModel* snapshot = [[SensorSnapshotModel alloc] initWithTimeStamp:count withType:@"Tachometer" withSensorID:count withData:count];
    
    [aggregate addSnapshot:snapshot];
}
@end
