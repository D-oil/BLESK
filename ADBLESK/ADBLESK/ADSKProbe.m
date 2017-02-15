//
//  ADSKProbe.m
//  ADBLESK
//
//  Created by 董安东 on 2017/1/21.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADSKProbe.h"

NSString *const kConnectionChangeNotification = @"kConnectionChangeNotification";
NSString *const kBatteryLowNotification = @"kBatteryLowNotification";
NSString *const kFoodTypeChangeNotification = @"kFoodTypeChangeNotification";
NSString *const kFoodDegreeChangeNotification = @"kFoodDegreeChangeNotification";
NSString *const ktargetTemperatureNotification = @"ktargetTemperatureNotification";

@interface ADSKProbe ()

@property (nonatomic,strong) NSArray *foodTypes;
@property (nonatomic,strong) NSArray *foodDegrees;

@end

@implementation ADSKProbe

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


#pragma mark - setter
-(void)setBatteryLevel:(NSUInteger)batteryLevel
{
    if (batteryLevel == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kBatteryLowNotification object:self];
    }
    _batteryLevel = batteryLevel;
}

- (void)setFoodType:(foodType)foodType
{
    if (_foodType != foodType) {
        _foodType = foodType;
        [[NSNotificationCenter defaultCenter] postNotificationName:kFoodTypeChangeNotification object:self];
    }
}

- (void)setIsConnected:(BOOL)isConnected
{
    if (_isConnected != isConnected) {
        _isConnected = isConnected;
       [[NSNotificationCenter defaultCenter] postNotificationName:kConnectionChangeNotification object:self];
    }
}

- (void)setFoodDegree:(foodDegree)foodDegree
{
    if (_foodDegree != foodDegree) {
        _foodDegree = foodDegree;
        [[NSNotificationCenter defaultCenter] postNotificationName:kFoodDegreeChangeNotification object:self];
    }
}

- (void)setTargetTem:(NSInteger)targetTem
{
    if (_targetTem != targetTem) {
        _targetTem = targetTem;
        [[NSNotificationCenter defaultCenter] postNotificationName:ktargetTemperatureNotification object:self];
    }
}

#pragma mark - Tools
+ (foodDegree)getFoodDegreeFromString:(NSString *)string
{
    if ([string isEqualToString:@""]) {
        return foodDegree_Null;
    } else if ([string isEqualToString:@"Rare"]) {
        return foodDegree_Rare;
    } else if ([string isEqualToString:@"Medium Rare"]) {
        return foodDegree_MediumRare;
    } else if ([string isEqualToString:@"Medium"]) {
        return foodDegree_Medium;
    } else if ([string isEqualToString:@"Medium Done"]) {
        return foodDegree_MediumDone;
    } else if ([string isEqualToString:@"Well Done"]) {
        return foodDegree_WellDone;
    } else if ([string isEqualToString:@"Slow Done"]) {
        return foodDegree_SlowDone;
    } else {
        NSLog(@"FoodDegree 字符串匹配错误！");
        return 0;
    }
}

+ (foodType)getFoodTypeFromString:(NSString *)string
{
    if ([string isEqualToString:@""]) {
        return foodType_Null;
    } else if ([string isEqualToString:@"Beef"]) {
        return foodType_Beef;
    } else if ([string isEqualToString:@"Veal"]) {
        return foodType_Veal;
    } else if ([string isEqualToString:@"Lamb"]) {
        return foodType_Lamb;
    } else if ([string isEqualToString:@"Venison"]) {
        return foodType_Venison;
    } else if ([string isEqualToString:@"Pork"]) {
        return foodType_Pork;
    } else if ([string isEqualToString:@"Chicken"]) {
        return foodType_Chicker;
    } else if ([string isEqualToString:@"Duck"]) {
        return foodType_Duck;
    } else if ([string isEqualToString:@"Fish"]) {
        return foodType_Fish;
    } else if ([string isEqualToString:@"Hamburger"]) {
        return foodType_Hamburger;
    } else if ([string isEqualToString:@"Timer"]) {
        return foodType_Timer;
    } else if ([string isEqualToString:@"Temperature"]) {
        return foodType_Tempareture;
    } else  {
        NSLog(@"FoodType 字符串匹配错误！");
        return 0;
    }
}

+ (NSString *)getStringFromFoodDegree:(foodDegree)foodDegree
{
    switch (foodDegree) {
        case foodDegree_Null:
            return @"";
        case foodDegree_Rare:
            return @"Rare";
        case foodDegree_MediumRare:
            return @"MediumRare";
        case foodDegree_Medium:
            return @"Medium";
        case foodDegree_MediumDone:
            return @"MediumDone";
        case foodDegree_WellDone:
            return @"WellDone";
        case foodDegree_SlowDone:
            return @"SlowDone";
    }
}

+ (NSString *)getStringFromFoodType:(foodType)foodType
{
    switch (foodType) {
        case foodType_Null:
            return @"";
        case foodType_Beef:
            return @"Beef";
        case foodType_Veal:
            return @"Veal";
        case foodType_Lamb:
            return @"Lamb";
        case foodType_Venison:
            return @"Venison";
        case foodType_Pork:
            return @"Pork";
        case foodType_Chicker:
            return @"Chicker";
        case foodType_Duck:
            return @"Duck";
        case foodType_Fish:
            return @"Fish";
        case foodType_Hamburger:
            return @"Hamburger";
        case foodType_Timer:
            return @"Timer";
        case foodType_Tempareture:
            return @"Temperature";
    }
}

@end
