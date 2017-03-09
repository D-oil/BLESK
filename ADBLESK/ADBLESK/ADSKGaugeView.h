//
//  ADSKGaugeView.h
//  ADBLESK
//
//  Created by 董安东 on 2017/1/21.
//  Copyright © 2017年 andong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMGaugeView.h"
#import "AppDelegate.h"


@interface ADSKGaugeView : UIView

@property (nonatomic,weak) IBOutlet WMGaugeView *gauge;

@property (nonatomic,weak) IBOutlet UILabel *minTemLabel;
@property (nonatomic,weak) IBOutlet UILabel *maxTemLabel;

@property (nonatomic,weak) IBOutlet UIImageView *lowBatteryImageView;

@property (nonatomic,weak) IBOutlet UILabel *currentTemValueLabel;
@property (nonatomic,weak) IBOutlet UILabel *leftTimeValueLabel;

@property (nonatomic,assign) temperatureSymbol temSymbol;

//画出仪表盘的指针
- (void)initGaugeView;

- (void)setTimeLabelWithTime:(NSUInteger)time;

//compeleted
- (void)LowBatteryModelOpen:(BOOL)open;
//set Temperature
- (void)setCurrentTemperature:(float)currentTem;
- (void)setTagTemperature:(float)tagTem;
- (void)setgrillTemperature:(float)grillTem;
//no implementation

//building
- (void)disConnectionModel;


@end
