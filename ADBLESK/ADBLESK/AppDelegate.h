//
//  AppDelegate.h
//  ADBLESK
//
//  Created by 董安东 on 2017/1/19.
//  Copyright © 2017年 andong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <UserNotifications/UserNotifications.h>
#import "UMMobClick/MobClick.h"


extern  NSString *const kApptempertureSymbolChangeNotification;

#define KtemperatureSymbol @"KtemperatureSymbol"
#define KringType          @"KringType"

typedef NS_ENUM(NSUInteger, temperatureSymbol) {
    temperatureSymbolC,
    temperatureSymbolF,
};

typedef NS_ENUM(NSUInteger, ringType) {
    ringTypeRing,
    ringTypeVibration,
    ringTypeRingAndVibration
};

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)sharedDelegate;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

//温度符号类型
@property (nonatomic,assign)temperatureSymbol symbol;
@property (nonatomic,assign)ringType ringType;

- (void)saveContext;

+ (NSUInteger)getTemperatureWithCurrentSymbol:(NSUInteger) tem;
@end

