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
@synthesize testArray;

#pragma mark Instance Accessor
+ (BLEGaugeAlarmService*)instance:(BOOL)reset
{
    static BLEGaugeAlarmService* instance;
    
    @synchronized(self)
    {
        if(instance == nil || reset)
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

#pragma mark Connection Management
- (void)disconnect
{
    [self.brsp close];
    [[AppDelegate app].cbCentral cancelPeripheralConnection:[AppDelegate app].activePeripheral];
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
    if([[self brsp] inputBufferCount] >= 30)
    {

        while(![[[self brsp] peekString:3] isEqualToString:@"NEW"])
        {
            // Flush until we get "NEW".
            [[self brsp] flushInputBuffer:1];
        }

        // Flush "NEW".
        [[self brsp] flushInputBuffer:3];

        NSMutableArray* sensorData = [[NSMutableArray alloc]init];
        
        // Read the buffer until the start of the next message.
        while(![[[self brsp] peekString:3] isEqualToString:@"END"])
        {
            // Make sure atleast one message is on the buffer.
            if([[self brsp] inputBufferCount] >=2)
            {
                UInt8* dataArray = (UInt8*)[[[self brsp] readBytes:2] bytes];
                unsigned int sensor = dataArray[0];
                sensor = ((sensor << 8) + dataArray[1]);
                
                NSNumber* data = [NSNumber numberWithUnsignedInt:sensor];
                
                [sensorData addObject:data];
            }
        }
        
        //Flush END
        [[self brsp] flushInputBuffer:3];
        
        [RealTimeBuilder snapshotCreation:sensorData];
        
    }
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
