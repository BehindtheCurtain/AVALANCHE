//
//  BLEGaugeAlarmService.m
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/4/13.
//
//

#import "BLEGaugeAlarmService.h"

#define BYTES_PER_MESSAGE 16;

@implementation BLEGaugeAlarmService

@synthesize brsp;

#pragma mark Instance Accessor
+ (BLEGaugeAlarmService*)instance
{
    static BLEGaugeAlarmService* instance;
    
    @synchronized(self)
    {
        if(instance == nil)
        {
            instance = [[BLEGaugeAlarmService alloc] init];
            
            [AppDelegate app].cbCentral.delegate = instance;
            
            [instance setBrsp:[[Brsp alloc] initWithPeripheral:[AppDelegate app].activePeripheral]];
            
            [instance brsp].delegate = instance;
            [[AppDelegate app].cbCentral connectPeripheral:[AppDelegate app].activePeripheral options:nil];
        }
    }
    
    return instance;
}


#pragma mark BrspDelegate
- (void)brsp:(Brsp*)brsp OpenStatusChanged:(BOOL)isOpen
{
    
}

- (void)brsp:(Brsp*)brsp SendingStatusChanged:(BOOL)isSending
{
    
}

- (void)brspDataReceived:(Brsp*)brsp
{
    while(![[[self brsp] peekString:3] isEqualToString:@"NEW"])
    {
        // Flush until we get "NEW".
        [[self brsp] flushInputBuffer:1];
    }
    
    // Flush "NEW".
    [[self brsp] flushInputBuffer:3];
    
    int metaDataSize;
    
    // Stall until the timestamp and message id are on the buffer.
    while([[self brsp] inputBufferCount] < 5);
    
    unsigned long timestamp = [[self brsp] readBytes:4];
    unsigned char messageID = [[self brsp] readBytes:1];

    NSMutableArray* sensorData = [[NSMutableArray alloc]initWithCapacity:4];
    
    // Read the buffer until the start of the next message.
    while(![[[self brsp] peekString:3] isEqualToString:@"NEW"])
    {
        // Make sure atleast one message is on the buffer.
        if([[self brsp] inputBufferCount] >=2)
        {
            NSData* data = [[self brsp] readBytes:2];
            
            [sensorData addObject:data];
        }
    }
    
    
    [RealTimeBuilder snapshotCreation:sensorData withMessageID:messageID withTimeStamp:timestamp];
}

#pragma mark CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    //call the open function to prepare the brsp service
    [self.brsp open];
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
}

@end
