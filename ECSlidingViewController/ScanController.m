//
//  ScanController.m
//  sampleterm
//
//  Created by Michael Testa on 11/1/12.
//  Copyright (c) Blueradios, Inc. All rights reserved.
//

#import "ScanController.h"

@implementation ScanController

@synthesize deviceTableView = _deviceTableView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    _peripherals = [NSMutableArray new];
    self.navigationItem.title = @"Select Device";
    [self disableButton:_scanButton];
    [AppDelegate app].cbCentral = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [AppDelegate app].cbCentral.delegate = self;
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.deviceTableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

#pragma mark - Table options

//**********************************************************************************************************************************************************
//Table Options 
//**********************************************************************************************************************************************************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)TableView numberOfRowsInSection:(NSInteger)section {
    return _peripherals.count; 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	// Configure the cell.
    
    CBPeripheral *peripheral = [_peripherals objectAtIndex:indexPath.row];
    
    cell.textLabel.text = peripheral.name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self stopScanButton:nil];
    
    [AppDelegate app].activePeripheral = [_peripherals objectAtIndex:indexPath.row];
    [self.deviceTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController* connection = [self.storyboard instantiateViewControllerWithIdentifier:@"Gauge View Controller"];
    
    [self.navigationController pushViewController:connection animated:YES];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {return NO;}

#pragma mark - UI 

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (void) startScanButton:(id)sender {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [_peripherals removeAllObjects];
    [self.deviceTableView reloadData];
    [self disableButton:_scanButton];
    [[AppDelegate app].cbCentral scanForPeripheralsWithServices:[NSArray arrayWithObject:[Brsp brspServiceUUID]] options:nil];
}

- (void) stopScanButton:(id)sender {
    [[AppDelegate app].cbCentral stopScan];
    [self enableButton:_scanButton];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)enableButton:(UIButton*)butt {
    butt.enabled = YES;
    butt.alpha = 1.0;
}

- (void)disableButton:(UIButton*)butt {
    butt.enabled = NO;
    butt.alpha = 0.5;   
}

#pragma mark - CBCentralManagerDelegate

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
}
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
}
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
}
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    if (![_peripherals containsObject:peripheral]) {
        [_peripherals addObject:peripheral];
        [self.deviceTableView reloadData];
    }
}
-(void)retrieveConnectedPeripherals {
}

- (void)centralManager:(CBCentralManager *)central didRetrieveConnectedPeripherals:(NSArray *)peripheralslist {
}

- (void)centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray *)peripherals {
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    printf("Status of CoreBluetooth central manager changed %d \r\n",central.state);
    if (central.state==CBCentralManagerStatePoweredOn) {
        [self enableButton:_scanButton];
    }
}
@end
