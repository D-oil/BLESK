//
//  ADSKProbe.m
//  ADBLESK
//
//  Created by 董安东 on 2017/1/21.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADSKProbe.h"

NSString *const kConnectionChangeNotification = @"kConnectionChangeNotification";

NSString *const kFoodTypeChangeNotification = @"kFoodTypeChangeNotification";
NSString *const kFoodDegreeChangeNotification = @"kFoodDegreeChangeNotification";

NSString *const ktargetTemperatureNotification = @"ktargetTemperatureNotification";
NSString *const kfoodTemperatureNotification = @"kfoodTemperatureNotification";
NSString *const kgrillTemperatureNotification = @"kgrillTemperatureNotification";

NSString *const ktimeChangedNotification = @"ktimeChangedNotification";

//warning
NSString *const kBBQfinishedWarningNotification = @"kBBQfinishedWarningNotification";
NSString *const kBBQTimeOutWarningNotification = @"kBBQTimeOutWarningNotification";
NSString *const kgrillTemperatureWarningNotification = @"kgrillTemperatureWarningNotification";
NSString *const kfoodTemperatureWarningNotification = @"kfoodTemperatureWarningNotification";

NSString *const kBatteryLowNotification = @"kBatteryLowNotification";

@interface ADSKProbe ()

@property (nonatomic,strong) NSArray *foodTypes;
@property (nonatomic,strong) NSArray *foodDegrees;
@property (nonatomic,strong) NSTimer *timeLabelTimer;

@property (nonatomic,strong) timeRemainningfinishedBlock block;

@property (nonatomic,strong) NSTimer *timer;



@end

@implementation ADSKProbe

- (NSTimer *)timeLabelTimer {
    if (_timeLabelTimer == nil) {
        _timeLabelTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeRemaining) userInfo:nil repeats:YES];
        [_timeLabelTimer fire];
    }
    return _timeLabelTimer;
}


- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeMinu) userInfo:nil repeats:YES];
    }
    return _timer;
}

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
        _foodType = foodType;
        [[NSNotificationCenter defaultCenter] postNotificationName:kFoodTypeChangeNotification object:self];
}

- (void)setIsConnected:(BOOL)isConnected
{
        _isConnected = isConnected;
       [[NSNotificationCenter defaultCenter] postNotificationName:kConnectionChangeNotification object:self];

}

- (void)setFoodDegree:(foodDegree)foodDegree
{
        _foodDegree = foodDegree;
        [[NSNotificationCenter defaultCenter] postNotificationName:kFoodDegreeChangeNotification object:self];

}

- (void)setTargetTem:(NSInteger)targetTem
{

        _targetTem = targetTem;
        [[NSNotificationCenter defaultCenter] postNotificationName:ktargetTemperatureNotification object:self];

}
- (void)setFoodTem:(float)foodTem
{
    if (_foodTem != foodTem) {
        if (foodTem == 85) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kfoodTemperatureWarningNotification object:self];
        }
    }

    _foodTem = foodTem;
    [[NSNotificationCenter defaultCenter] postNotificationName:kfoodTemperatureNotification object:self];
    if (foodTem ==  _targetTem) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kBBQfinishedWarningNotification object:self];
    }
    

}

- (void)setGrillTem:(float)grillTem
{
    if (_grillTem != grillTem) {
        if (grillTem == 275 || grillTem == 276) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kgrillTemperatureWarningNotification object:self];
        }
    }

    _grillTem = grillTem;
    [[NSNotificationCenter defaultCenter] postNotificationName:kgrillTemperatureNotification object:self];
    
}

- (void)setTime:(NSInteger)time
{
    _time = time;
    [[NSNotificationCenter defaultCenter] postNotificationName:ktimeChangedNotification object:self];
    if (self.foodType == foodType_Timer && time == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kBBQTimeOutWarningNotification object:self];
    }
}


#pragma mark - Tools
+ (foodDegree)getFoodDegreeFromString:(NSString *)string
{
    if ([string isEqualToString:NSLocalizedString(@"cookDegree_null", nil)]) {
        return foodDegree_Null;
    } else if ([string isEqualToString:NSLocalizedString(@"cookDegree_rare", nil)]) {
        return foodDegree_Rare;
    } else if ([string isEqualToString:NSLocalizedString(@"cookDegree_MediumRare", nil)]) {
        return foodDegree_MediumRare;
    } else if ([string isEqualToString:NSLocalizedString(@"cookDegree_Medium", nil)]) {
        return foodDegree_Medium;
    } else if ([string isEqualToString:NSLocalizedString(@"cookDegree_MediumDone", nil)]) {
        return foodDegree_MediumDone;
    } else if ([string isEqualToString:NSLocalizedString(@"cookDegree_wellDone", nil)]) {
        return foodDegree_WellDone;
    } else if ([string isEqualToString:NSLocalizedString(@"cookDegree_slowCook", nil)]) {
        return foodDegree_SlowDone;
    } else {
        NSLog(@"FoodDegree 字符串匹配错误！");
        return 0;
    }
}



+ (foodType)getFoodTypeFromString:(NSString *)string
{
    if ([string isEqualToString:NSLocalizedString(@"foodType_null", nil)]) {
        return foodType_Null;
    } else if ([string isEqualToString:NSLocalizedString(@"foodType_beef", nil)]) {
        return foodType_Beef;
    } else if ([string isEqualToString:NSLocalizedString(@"foodType_veal", nil)]) {
        return foodType_Veal;
    } else if ([string isEqualToString:NSLocalizedString(@"foodType_lamb", nil)]) {
        return foodType_Lamb;
    } else if ([string isEqualToString:NSLocalizedString(@"foodType_venison", nil)]) {
        return foodType_Venison;
    } else if ([string isEqualToString:NSLocalizedString(@"foodType_pork", nil)]) {
        return foodType_Pork;
    } else if ([string isEqualToString:NSLocalizedString(@"foodType_chicken", nil)]) {
        return foodType_Chicker;
    } else if ([string isEqualToString:NSLocalizedString(@"foodType_duck", nil)]) {
        return foodType_Duck;
    } else if ([string isEqualToString:NSLocalizedString(@"foodType_fish", nil)]) {
        return foodType_Fish;
    } else if ([string isEqualToString:NSLocalizedString(@"foodType_hamburger", nil)]) {
        return foodType_Hamburger;
    } else if ([string isEqualToString:NSLocalizedString(@"foodType_timer", nil)]) {
        return foodType_Timer;
    } else if ([string isEqualToString:NSLocalizedString(@"foodType_temperature", nil)]) {
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
            return NSLocalizedString(@"cookDegree_null", nil);
        case foodDegree_Rare:
            return NSLocalizedString(@"cookDegree_rare", nil);
        case foodDegree_MediumRare:
            return NSLocalizedString(@"cookDegree_MediumRare", nil);
        case foodDegree_Medium:
            return NSLocalizedString(@"cookDegree_Medium", nil);
        case foodDegree_MediumDone:
            return NSLocalizedString(@"cookDegree_MediumDone", nil);
        case foodDegree_WellDone:
            return NSLocalizedString(@"cookDegree_wellDone", nil);
        case foodDegree_SlowDone:
            return NSLocalizedString(@"cookDegree_slowCook", nil);
    }
}



+ (NSString *)getStringFromFoodType:(foodType)foodType
{
    switch (foodType) {
        case foodType_Null:
            return NSLocalizedString(@"foodType_null", nil);
        case foodType_Beef:
            return NSLocalizedString(@"foodType_beef", nil);
        case foodType_Veal:
            return NSLocalizedString(@"foodType_veal", nil);
        case foodType_Lamb:
            return NSLocalizedString(@"foodType_lamb", nil);
        case foodType_Venison:
            return NSLocalizedString(@"foodType_venison", nil);
        case foodType_Pork:
            return NSLocalizedString(@"foodType_pork", nil);
        case foodType_Chicker:
            return NSLocalizedString(@"foodType_chicken", nil);
        case foodType_Duck:
            return NSLocalizedString(@"foodType_duck", nil);
        case foodType_Fish:
            return NSLocalizedString(@"foodType_fish", nil);
        case foodType_Hamburger:
            return NSLocalizedString(@"foodType_hamburger", nil);
        case foodType_Timer:
            return NSLocalizedString(@"foodType_timer", nil);
        case foodType_Tempareture:
            return NSLocalizedString(@"foodType_temperature", nil);
    }
}




- (NSUInteger)calculateNewTime:(NSUInteger) currentFoodTem
{
//    if (!self.lastCalculateToNowTime) {
//        return 0;
//    }
    if (self.targetTem > currentFoodTem) {
        self.time = ((self.targetTem - currentFoodTem) * self.lastCalculateToNowTime ) /(currentFoodTem - self.lastCalculateFoodTem);
        self.lastCalculateFoodTem = currentFoodTem;
        self.lastCalculateToNowTime = 0;
    }
    return self.time;
     
}

- (void)startTimer
{
    [self.timer fire];
}


-(void)timeMinu {
    if (self.time> 0) {
        if (self.time == 1 && self.foodTem < self.targetTem) {
            self.time += 3;
        }
        self.time -- ;
        
    } else {
        [self stopTimer];
    }
}


- (void)stopTimer
{
    self.time = -1;
    [self.timer invalidate];
    self.timer  = nil;
}


@end
