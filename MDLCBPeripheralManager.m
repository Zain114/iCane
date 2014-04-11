//
//  MDLCBPeripheralManager.m
//  iCane
//
//  Created by Luffy on 3/26/14.
//  Copyright (c) 2014 Dumbass inc. All rights reserved.
//

#import "MDLCBPeripheralManager.h"

@interface MDLCBPeripheralManager ()

@end

@implementation MDLCBPeripheralManager

@synthesize peripheralManager;
@synthesize peripheralCharacteristics;
@synthesize data;
@synthesize dataIndex;
@synthesize dataString;

NSString * SERVICES_UUID()
{
    NSString *s = @"114";
    return s;
}

NSString * CHARACTERISTICS_UUID()
{
    NSString *s = @"2114";
    return s;
}

- (MDLCBPeripheralManager *) initWithData:(NSString *)data
{
    //initialize perihperal manager
    peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    [peripheralManager startAdvertising:@{ CBAdvertisementDataServiceUUIDsKey: @[[CBUUID UUIDWithString:SERVICES_UUID()]] }];
    return self;
}


- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    if(peripheral.state != CBPeripheralManagerStatePoweredOn)
    {
        return;
    }
    
    if(peripheral.state == CBPeripheralManagerStatePoweredOn)
    {
        //configure characteristic
        peripheralCharacteristics = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString:CHARACTERISTICS_UUID()] properties:CBCharacteristicPropertyNotify value:nil permissions:CBAttributePermissionsReadable];
        
        //configure service
        CBMutableService *service = [[CBMutableService alloc] initWithType:[CBUUID UUIDWithString:SERVICES_UUID()] primary:YES];
        
        service.characteristics = @[peripheralCharacteristics];
        
        //add service to manager
        [peripheralManager addService:service];
    }
}

- (void) peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic
{
    //retrieve data
    data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    
    dataIndex = 0;
    
    [self sendData];
    
}

- (void) sendData
{
    static BOOL sendEOM = NO;
    
    //end of message?
    if(sendEOM)
    {
        BOOL didSend = [peripheralManager updateValue:[@"EOM" dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:peripheralCharacteristics onSubscribedCentrals:nil];
        if(didSend)
        {
            sendEOM = NO;
        }
        return;
    }
    
    //sending data, any left?
    if(dataIndex >= data.length)
    {
        return;
    }
    
    BOOL didSend = YES;
    
    //loop to send data
    while(didSend)
    {
        //get chunk size
        NSInteger chunkSize = data.length - dataIndex;
        
        if(chunkSize > 20)
        {
            chunkSize = 20;
        }
        
        //form chunk from data and append index at end
        NSData *chunk = [NSData dataWithBytes:data.bytes + dataIndex length:chunkSize];
        //try to send the data
        didSend = [peripheralManager updateValue:chunk forCharacteristic:peripheralCharacteristics onSubscribedCentrals:nil];
        
        if(!didSend)
        {
            return;
        }
    
        NSString *sentData = [[NSString alloc] initWithData:chunk encoding:NSUTF8StringEncoding];
        NSLog(@"Sent: %@", sentData);
        
        //update index
        dataIndex += chunkSize;
        
        if(dataIndex >= data.length)
        {
            sendEOM = YES;
            
            BOOL sentEOM = [peripheralManager updateValue:[@"EOM" dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:peripheralCharacteristics onSubscribedCentrals:nil];
            if(sentEOM)
            {
                sendEOM = NO;
                NSLog(@"Sent EOM");
            }
            return;
        }
    }
}

- (void)peripheralManagerIsReadyToUpdateSubscribers:(CBPeripheralManager *)peripheral
{
    [self sendData];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //make sure update from right key
    if([keyPath isEqualToString:@"directionsString"])
    {
        //new data available, trigger a send somehow
    }
}

@end
