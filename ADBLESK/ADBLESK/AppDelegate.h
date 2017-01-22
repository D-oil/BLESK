//
//  AppDelegate.h
//  ADBLESK
//
//  Created by 董安东 on 2017/1/19.
//  Copyright © 2017年 andong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

extern  NSString *const kApptempertureSymbolChangeNotification;

#define KtemperatureSymbol @"KtemperatureSymbol"

typedef NS_ENUM(NSUInteger, temperatureSymbol) {
    temperatureSymbolC,
    temperatureSymbolF,
};

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

//温度符号类型
@property (nonatomic,assign)temperatureSymbol symbol;

- (void)saveContext;


@end

