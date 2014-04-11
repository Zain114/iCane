//
//  MDLCBPeripheralManager.h
//  iCane
//
//  Created by Luffy on 3/26/14.
//  Copyright (c) 2014 Dumbass inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface MDLCBPeripheralManager : NSObject < CBPeripheralManagerDelegate>
{
    CBPeripheralManager *peripheralManager;
    CBMutableCharacteristic *peripheralCharacteristics;
    NSData *data;
    NSInteger dataIndex;
    NSString *dataString;
}

@property (strong, nonatomic) CBPeripheralManager *peripheralManager;
@property (strong, nonatomic) CBMutableCharacteristic *peripheralCharacteristics;
@property (strong, nonatomic) NSData *data;
@property (nonatomic, readwrite) NSInteger dataIndex;
@property (strong, nonatomic) NSString *dataString;

extern NSString *SERVICES_UUID();
extern NSString *CHARACTERISTICS_UUID();

- (MDLCBPeripheralManager *) initWithData:(NSString *) data;

@end
