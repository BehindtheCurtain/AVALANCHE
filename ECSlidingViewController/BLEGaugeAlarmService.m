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
    while(![[[self brsp] peekString:3] isEqualToString:@"NEW"])
    {
        // Flush until we get "NEW".
        [[self brsp] flushInputBuffer:1];
    }
    /*
    NSString* new = [[self brsp] readString:3];
    
    NSData* data = [[self brsp] readBytes];
    UInt8* rawData = [data bytes];
    
    UInt8 value0 = CFSwapInt16LittleToHost((UInt8)(rawData[0]));
    UInt8 value1 = CFSwapInt16BigToHost((UInt8)(rawData[1]));
    UInt8 value2 = (UInt8)(rawData[2]);
    UInt8 value3 = (UInt8)(rawData[3]);
    UInt8 value4 = (UInt8)(rawData[4]);
    UInt8 value5 = (UInt8)(rawData[5]);
    UInt8 value6 = (UInt8)(rawData[6]);
    UInt8 value7 = (UInt8)(rawData[7]);
    UInt8 value8 = (UInt8)(rawData[8]);
    UInt8 value9 = (UInt8)(rawData[9]);
    UInt8 value10 = (UInt8)(rawData[10]);
    UInt8 value11 = (UInt8)(rawData[11]);
    UInt8 value12 = (UInt8)(rawData[12]);
    
    unsigned int timestamp = value3;
    timestamp= (timestamp << 8) + value2;
    timestamp = (timestamp << 8) + value1;
    timestamp = (timestamp << 8) + value0;
    
    unsigned int messageID = value4;
    
    unsigned int sensor0 = value5;
    sensor0 = ((sensor0 << 8) + value6);
    
    unsigned int sensor1 = value7;
    sensor1 = ((sensor1 << 8) + value8);
    
    unsigned int sensor2 = value9;
    sensor2 = ((sensor2 << 8) + value10);
    
    unsigned int sensor3 = value11;
    sensor3 = ((sensor3 << 8) + value12);
    
    
    int test = nil;
     */
    
    
    // Flush "NEW".
    [[self brsp] flushInputBuffer:3];
    
    UInt8* messageIDArray = (UInt8*)[[[self brsp] readBytes:1] bytes];
    UInt8 messageID = messageIDArray[0];

    NSMutableArray* sensorData = [[NSMutableArray alloc]initWithCapacity:4];
    
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
    
    [RealTimeBuilder snapshotCreation:sensorData withMessageType:messageID];
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
