//
//  ADSKProbe.h
//  ADBLESK
//
//  Created by 董安东 on 2017/1/21.
//  Copyright © 2017年 andong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLEManager.h"

extern  NSString *const kConnectionChangeNotification;
extern  NSString *const kBatteryLowNotification;

extern  NSString *const kFoodTypeChangeNotification;
extern  NSString *const kFoodDegreeChangeNotification;

extern  NSString *const ktargetTemperatureNotification;
extern  NSString *const kfoodTemperatureNotification;
extern  NSString *const kgrillTemperatureNotification;

extern  NSString *const ktimeChangedNotification;

extern NSString *const kBBQfinishedWarningNotification;
extern NSString *const kBBQTimeOutWarningNotification;
extern NSString *const kgrillTemperatureWarningNotification;
extern NSString *const kfoodTemperatureWarningNotification;

extern NSString *const kgrillTemperatureHightNotification ;
extern NSString *const kgrillTemperatureLowNotification ;
extern NSString *const kfoodTemperatureHightNotification ;
extern NSString *const kfoodTemperatureLowNotification ;

typedef NS_ENUM(NSUInteger, foodType) {
    foodType_Null,      //空
    foodType_Beef,      //🐂
    foodType_Veal,      //小🐂
    foodType_Lamb,      //🐑
    foodType_Venison,   //🦌
    foodType_Pork,      //🐷
    foodType_Chicker,   //🐔
    foodType_Duck,      //鸭
    foodType_Fish,      //🐟
    foodType_Hamburger, //🍔
    foodType_Timer,     //⏱️
    foodType_Tempareture//🌡️
};
typedef NS_ENUM(NSUInteger, foodDegree) {
    foodDegree_Null,
    foodDegree_Rare,
    foodDegree_MediumRare,
    foodDegree_Medium,
    foodDegree_MediumDone,
    foodDegree_WellDone,
    foodDegree_SlowDone
};

typedef void(^timeRemainningfinishedBlock)(BOOL finished);

@interface ADSKProbe : NSObject
//探针对应的编号
@property (nonatomic,strong) NSString *UUID;

@property (nonatomic,assign) NSUInteger ID;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,assign) BOOL isConnected;

//定义为摄氏度
@property (nonatomic,assign) NSInteger targetTem;
@property (nonatomic,assign) float grillTem;
@property (nonatomic,assign) float foodTem;
@property (nonatomic,assign) NSUInteger batteryLevel;
//食物类型
@property (nonatomic,assign) foodType foodType;
//生熟程度
@property (nonatomic,assign) foodDegree foodDegree;

//剩余完成时间
@property (nonatomic,assign) NSInteger time;

//是否开启了烧烤模式
@property (nonatomic,assign) BOOL isOpen;

//探针正在报警状态
@property (nonatomic,assign) BOOL isAlarm;

//计时器是否正在运行
@property (nonatomic,assign) BOOL isTimerFire;

@property (nonatomic,strong) CBPeripheral *peripheral;

@property (nonatomic,assign) NSInteger lastCalculateFoodTem;
@property (nonatomic,assign) NSInteger lastCalculateToNowTime;

//tools
+ (foodDegree)getFoodDegreeFromString:(NSString *)string;
+ (foodType)getFoodTypeFromString:(NSString *)string;

+ (NSString *)getStringFromFoodDegree:(foodDegree)foodDegree;
+ (NSString *)getStringFromFoodType:(foodType)foodType;

+ (foodDegree)getFoodDegreeFromfoodType:(foodType)foodType TagTem:(NSInteger)tagTem;

- (void)startTimer;
- (void)stopTimer;

- (NSData *)getBLETransmissionData;
- (void)setProbeInfoFrom:(NSData *)BLEData;

- (NSUInteger)calculateNewTime:(NSUInteger) currentFoodTem;


+ (NSArray *)getTemWithTag:(NSInteger)tag;
@end
