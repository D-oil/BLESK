//
//  BLEManager.h
//  BLEDemo
//
//  Created by 董安东 on 2017/2/15.
//  Copyright © 2017年 andong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>



#define TRANSFER_SERVICE_UUID @"0000fb00-0000-1000-8000-00805f9b34fb"
#define TEMPERATURE_SERVICE_UUID @"0000fb02-0000-1000-8000-00805f9b34fb"

typedef void(^connectFinished)(BOOL success,CBPeripheral *CBPeripheral);

@interface BLEManager : NSObject

@property (nonatomic,assign)CBManagerState state;
@property (nonatomic,strong,readonly)NSMutableArray <CBPeripheral *>* CBPeripherals;


- (void)startScanOnceWithDelay:(NSInteger)second withFinishedBlock:(void (^)(BOOL success, NSArray <CBPeripheral *>* CBPeripherals))finishedBlock;

- (void)connectPeripheral:(CBPeripheral *)peripheral withFinshedBlock:(connectFinished)finishedBlock;

- (void)disconnectPeripheral:(CBPeripheral *)peripheral withFinshedBlock:(connectFinished)finishedBlock;



@end
