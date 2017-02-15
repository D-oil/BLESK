//
//  BLEManager.m
//  BLEDemo
//
//  Created by 董安东 on 2017/2/15.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "BLEManager.h"

@interface BLEManager () <CBCentralManagerDelegate,CBPeripheralDelegate>

@property (nonatomic,strong) CBCentralManager *centralManager;

@property (nonatomic,strong,readwrite)NSMutableArray <CBPeripheral *>* connectedCBPeripherals;

@property (nonatomic,strong,readwrite)NSMutableArray <CBPeripheral *>* CBPeripherals;

@property (nonatomic,strong)connectFinished connectFinishedBlock;

@end


@implementation BLEManager
#pragma mark - property
- (NSMutableArray *)CBPeripherals
{
    if (_CBPeripherals == nil) {
        _CBPeripherals = [NSMutableArray array];
    }
    return _CBPeripherals;
}

- (NSMutableArray *)connectedCBPeripherals
{
    if (_connectedCBPeripherals == nil) {
        _connectedCBPeripherals = [NSMutableArray array];
    }
    return _connectedCBPeripherals;
}

#pragma mark - init
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], CBCentralManagerOptionShowPowerAlertKey, nil];
        self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:options];
    }
    return self;
}

#pragma mark - scan
//scan扫描设备
- (void)startScanOnceWithDelay:(NSInteger)second withFinishedBlock:(void (^)(BOOL success, NSArray <CBPeripheral *>* CBPeripherals))finishedBlock

{
    self.CBPeripherals = nil;
    [self.centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:TEMPERATURE_SERVICE_UUID]] /**/ options:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        finishedBlock(YES,self.CBPeripherals);
        [self stopScan];
    });
}

- (void)stopScan
{
    if (self.centralManager.isScanning) {
        [self.centralManager stopScan];
    }
}

- (void)openPeripheral:(CBPeripheral *)peripheral open:(BOOL)isOpen
{
    for (CBService *service in peripheral.services) {
        for (CBCharacteristic *characteristic in service.characteristics) {
            NSLog(@"Discovered characteristic %@", characteristic);
            //对不同的characteristic执行不同的操作,有的通知状态设为YES
            if ([characteristic.UUID.UUIDString isEqualToString:TEMPERATURE_SERVICE_TEMPERATURE_CHARACTERISTIC_NOTIFY] ||
                [characteristic.UUID.UUIDString isEqualToString:TEMPERATURE_SERVICE_STATUS_CHARACTERISTIC_READ_NOTIFY] ){
                [peripheral setNotifyValue:isOpen forCharacteristic:characteristic];
            }
        }
    }
}

- (void)readStatusCharacteristicFromPeripheral:(CBPeripheral *)peripheral
{
    for (CBService *service in peripheral.services) {
        for (CBCharacteristic *characteristic in service.characteristics) {
            NSLog(@"Discovered characteristic %@", characteristic);
            //对不同的characteristic执行不同的操作,有的通知状态设为YES
            if ([characteristic.UUID.UUIDString isEqualToString:TEMPERATURE_SERVICE_STATUS_CHARACTERISTIC_READ_NOTIFY] ){
                [peripheral readValueForCharacteristic:characteristic];
            }
        }
    }
}

#pragma mark - connected
- (void)connectPeripheral:(CBPeripheral *)peripheral withFinshedBlock:(connectFinished)finishedBlock
{
    [self.centralManager connectPeripheral:peripheral options:nil];
    self.connectFinishedBlock = finishedBlock;
}

- (void)disconnectPeripheral:(CBPeripheral *)peripheral withFinshedBlock:(connectFinished)finishedBlock
{
    [self.centralManager cancelPeripheralConnection:peripheral];
    self.connectFinishedBlock = finishedBlock;
}

#pragma mark - Delegate
-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    self.state = central.state;
    NSLog(@"centralManagerDidUpdateState call %ld",(long)central.state);
}
//scan
- (void)centralManager:(CBCentralManager *)central
 didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary *)advertisementData
                  RSSI:(NSNumber *)RSSI
{
    [self.CBPeripherals addObject:peripheral];
}
//connect
- (void)centralManager:(CBCentralManager *)central
  didConnectPeripheral:(CBPeripheral *)peripheral
{
    [self.connectedCBPeripherals addObject:peripheral];
    peripheral.delegate = self;
    [peripheral discoverServices:@[[CBUUID UUIDWithString:TEMPERATURE_SERVICE_UUID]]];
}
- (void)centralManager:(CBCentralManager *)central
didFailToConnectPeripheral:(CBPeripheral *)peripheral
                 error:(nullable NSError *)error
{
    
    self.connectFinishedBlock(NO,peripheral);
    self.connectFinishedBlock = nil;
}
//disconnected
- (void)centralManager:(CBCentralManager *)central
didDisconnectPeripheral:(CBPeripheral *)peripheral
                 error:(nullable NSError *)error
{
    [self.connectedCBPeripherals removeObject:peripheral];
    if (error) {
        self.connectFinishedBlock(NO,peripheral);
    } else {
        self.connectFinishedBlock(YES,peripheral);
    }
    self.connectFinishedBlock = nil;
}

//discover server
- (void)peripheral:(CBPeripheral *)peripheral
didDiscoverServices:(NSError *)error
{
    NSLog(@"didDiscoverServices call");
    for (CBService *server in peripheral.services) {
        [peripheral discoverCharacteristics:nil forService:server];
    }
    
}
- (void)peripheral:(CBPeripheral *)peripheral
didDiscoverCharacteristicsForService:(CBService *)service
             error:(NSError *)error
{
    
    self.connectFinishedBlock(YES,peripheral);
    self.connectFinishedBlock = nil;
//    for (CBCharacteristic *characteristic in service.characteristics) {
//        NSLog(@"Discovered characteristic %@", characteristic);
//        //对不同的characteristic执行不同的操作,有的通知状态设为YES
//         if ([characteristic.UUID.UUIDString isEqualToString:TEMPERATURE_SERVICE_TEMPERATURE_CHARACTERISTIC_NOTIFY] ||
//             [characteristic.UUID.UUIDString isEqualToString:TEMPERATURE_SERVICE_STATUS_CHARACTERISTIC_READ_NOTIFY] ){
//            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
//        }
//    }
    
}

//读取到设备的数据
- (void)peripheral:(CBPeripheral *)peripheral
didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error {
    
    NSData *data = characteristic.value;
    NSString *stringFromData = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    NSLog(@"%@---%@",characteristic,stringFromData);
    
    if ([characteristic.UUID.UUIDString isEqualToString:TEMPERATURE_SERVICE_TEMPERATURE_CHARACTERISTIC_NOTIFY] ) {
        if ([_delegate respondsToSelector:@selector(peripheral:receiveInfoWithTemperatureCharacteristic:)]) {
            [self.delegate peripheral:peripheral receiveInfoWithTemperatureCharacteristic:stringFromData];
        }
    } else if ([characteristic.UUID.UUIDString isEqualToString:TEMPERATURE_SERVICE_STATUS_CHARACTERISTIC_READ_NOTIFY] ) {
        if ([_delegate respondsToSelector:@selector(peripheral:receiveInfoWithStatusCharacteristic:)]) {
            [self.delegate peripheral:peripheral receiveInfoWithStatusCharacteristic:stringFromData];
        }
    }

    
}

//更新了通知状态，这个也可以不实现，无所谓
- (void)peripheral:(CBPeripheral *)peripheral
didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error {
    
    if (error) {
        NSLog(@"Error changing notification state: %@",
              [error localizedDescription]);
    }

}
@end
