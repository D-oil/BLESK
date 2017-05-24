//
//  BLEManager.h
//  BLEDemo
//
//  Created by 董安东 on 2017/2/15.
//  Copyright © 2017年 andong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

/*
    coreBluetooth的基本流程
    1 根据设备所提供的服务才能扫描到对应类型的设备。
    2 扫描到设备后，可以连接上该设备，当连接成功设备以后，可以发现设备的所有服务。
    3 发现服务后又可以发现服务下的所有特征，特征和属性差不多，有可读性性和通知性。
    4 通过特性的读写即可完成与设备的通信。
*/
//#define TEMPERATURE_SERVICE_UUID           @"1b7e8251-2877-41c3-b46e-cf057c562023"


#define TEMPERATURE_SERVICE_UUID @"0000fb00-0000-1000-8000-00805f9b34fb"

//#define TEMPERATURE_SERVICE_NAME_CHARACTERISTIC_READWRITE      @"FB01"
#define TEMPERATURE_SERVICE_TEMPERATURE_CHARACTERISTIC_NOTIFY  @"FB02"
#define TEMPERATURE_SERVICE_COMMAND_CHARACTERISTIC_WRITE       @"FB03"
//#define TEMPERATURE_SERVICE_UPLOADTIME_CHARACTERISTIC_NOTIFY   @"FB04"
#define TEMPERATURE_SERVICE_STATUS_CHARACTERISTIC_READ_NOTIFY @"FB05"

typedef void (^connectFinished)(BOOL success,CBPeripheral *peripheral);


@protocol BLEManagerDelegate <NSObject>

- (void)peripheral:(CBPeripheral *)peripheral receiveInfoWithFoodTemperature:(NSInteger)foodTem grillTemperature:(NSInteger) grillTem timeInfo:(NSInteger)timeInfo;
- (void)peripheral:(CBPeripheral *)peripheral receiveInfoWithStatusCharacteristic:(NSData *)receiveInfo;

@end

@interface BLEManager : NSObject
//当前蓝牙状态
@property (nonatomic,assign)CBManagerState state;
//连接成功的BLE设备
@property (nonatomic,strong,readonly)NSMutableArray <CBPeripheral *>* connectedCBPeripherals;
//扫描到的设备，包含已连接和未连接的设备
@property (nonatomic,strong,readonly)NSMutableArray <CBPeripheral *>* CBPeripherals;

@property (nonatomic,weak) id <BLEManagerDelegate> delegate;
//这里扫描设备比较特殊，根据需求，返回的是已连接设备+扫描到的设备的列表，前4项有可能是已连接的设备。
- (void)startScanOnceWithDelay:(NSInteger)second withFinishedBlock:(void (^)(BOOL success, NSMutableArray <CBPeripheral *>* CBPeripherals))finishedBlock;

- (void)connectPeripheral:(CBPeripheral *)peripheral withFinshedBlock:(connectFinished)finishedBlock;

- (void)disconnectPeripheral:(CBPeripheral *)peripheral withFinshedBlock:(connectFinished)finishedBlock;

//连接成功以后，调用这个方法可以开启所有通知
//开启接收通知后，会接收到上面两个delegate方法
- (void)openPeripheral:(CBPeripheral *)peripheral open:(BOOL)isOpen;
//读取电量值,会调用receiveInfoWithStatusCharacteristic 方法
- (void)readStatusCharacteristicFromPeripheral:(CBPeripheral *)peripheral;


- (void)readInfoCharacteristicFromPeripheral:(CBPeripheral *)peripheral;

- (void)writeDataToPeripheral:(CBPeripheral *)peripheral Data:(NSData *)data;


@end
