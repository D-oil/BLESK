//
//  ADSKSmallGaugeView.h
//  ADBLESK
//
//  Created by 董安东 on 2017/1/30.
//  Copyright © 2017年 andong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMGaugeView.h"
#import "AppDelegate.h"

@interface ADSKSmallGaugeView : UIView

@property (nonatomic,weak) IBOutlet WMGaugeView *guaue;

@property (nonatomic,weak) IBOutlet UIImageView *lowBatteryImageView;

@property (nonatomic,weak) IBOutlet UILabel *timeLabel;

@property (nonatomic,weak) IBOutlet UILabel *temperatureLabel;

@property (nonatomic,weak) IBOutlet UIButton *numButton;

@property (nonatomic,weak) IBOutlet UIView *bottomView;

@property (nonatomic,weak) IBOutlet UIImageView *foodTypeImageView;
@property (nonatomic,weak) IBOutlet UILabel *foodTypeLabel;
@property (nonatomic,weak) IBOutlet UILabel *cookDegreeLabel;

@property (nonatomic,weak) IBOutlet UIImageView *targetImageView;
@property (nonatomic,weak) IBOutlet UILabel *tatgetLabel;
@property (nonatomic,weak) IBOutlet UILabel *targetTemLabel;

@property (nonatomic,weak) IBOutlet UIImageView *grillImageView;
@property (nonatomic,weak) IBOutlet UILabel *grillLabel;
@property (nonatomic,weak) IBOutlet UILabel *grillTemLabel;

- (void)isOnlineStatus:(BOOL)online;
- (void)LowBatteryModelOpen:(BOOL)open;

- (void)setfoodTypeImageStr:(NSString *)foodTypeImageStr foodTypeStr:(NSString *)foodTypeStr cookDegreeStr:(NSString *)cookTypeStr;

- (void)setTagTemperatureWith:(int)tagTem WithTemSymbol:(temperatureSymbol)symbol;
- (void)setFoodTemperatureWith:(int)foodTem WithTemSymbol:(temperatureSymbol)symbol;
- (void)setGrillTemperatureWith:(int)grillTem WithTemSymbol:(temperatureSymbol)symbol;


@end
