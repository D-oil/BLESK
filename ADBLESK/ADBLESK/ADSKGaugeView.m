//
//  ADSKGaugeView.m
//  ADBLESK
//
//  Created by 董安东 on 2017/1/21.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADSKGaugeView.h"

@interface ADSKGaugeView ()

@property (nonatomic,strong) NSTimer *lowBatteryTimer;

@property (nonatomic,strong) NSTimer *foodTemHighlightTiemr;

@end

@implementation ADSKGaugeView

#pragma mark - properties
- (NSTimer *)lowBatteryTimer
{
    if (_lowBatteryTimer == nil) {
        _lowBatteryTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(batteryHideOrShow) userInfo:nil repeats:YES];
    }
    return _lowBatteryTimer;
}

- (NSTimer *)foodTemHighlightTiemr {
    if (_foodTemHighlightTiemr == nil) {
        _foodTemHighlightTiemr = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(foodTemShowOrHide) userInfo:nil repeats:YES];
    }
    return _foodTemHighlightTiemr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

 - (void)initGaugeView
{  
    self.gauge.style = [WMGaugeViewStyleFlatThin new];
    self.gauge.maxValue = 300.0;
    self.gauge.showInnerRim = YES;
    self.gauge.scaleDivisions = 10;
    self.gauge.scaleSubdivisions = 5;
    self.gauge.scaleStartAngle = 30;
    self.gauge.scaleEndAngle = 330;
    self.gauge.showScaleShadow = NO;
    self.gauge.scaleFont = [UIFont fontWithName:@"AvenirNext-UltraLight" size:0.065];
    self.gauge.scalesubdivisionsAligment = WMGaugeViewSubdivisionsAlignmentCenter;
    self.gauge.scaleSubdivisionsWidth = 0.004;
    self.gauge.scaleSubdivisionsLength = 0.004;
    self.gauge.scaleDivisionsWidth = 0.004;
    self.gauge.scaleDivisionsLength = 0.004;
    
    [self.lowBatteryImageView setAlpha:0];
}

- (void)setCurrentTemperature:(float)currentTem
{
    if (currentTem != -1) {
        if (self.temSymbol == temperatureSymbolC) {
            self.currentTemValueLabel.text = [NSString stringWithFormat:@"%d℃",(int)currentTem];
        } else if (self.temSymbol == temperatureSymbolF) {
            self.currentTemValueLabel.text = [NSString stringWithFormat:@"%d℉",(int)(currentTem * 1.8) +32];
        }
    } else {
        [self.currentTemValueLabel setText:@"_ _"];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.gauge setTagTmpValue:currentTem animated:YES duration:0.5 completion:^(BOOL finished) {}];
    });

}

- (void)setTagTemperature:(float)tagTem
{
    [self.gauge setfoodTmpValue:tagTem animated:YES duration:0.5 completion:^(BOOL finished) {}];
}
- (void)setgrillTemperature:(float)grillTem
{
    [self.gauge setValue:grillTem animated:YES duration:0.5 completion:^(BOOL finished) {}];
}

- (void)setTimeLabelWithTime:(NSUInteger)time
{
    [self.leftTimeValueLabel setText:[self getTimeStrWithtime:time]];
}

- (NSString *)getTimeStrWithtime:(NSUInteger)time
{
    if (time == -1) {
      return @"_ _ _ _";
    }
    
    
    
    NSUInteger currentTime = time;
    NSUInteger hour = currentTime / 3600;
    NSUInteger min = (currentTime - hour *3600) / 60;
    NSUInteger s   = (currentTime - hour *3600 - min * 60);
    
    NSString *timeStr = [NSString stringWithFormat:@"%02lu:%02lu:%02lu",(unsigned long)hour,(unsigned long)min,(unsigned long)s];
    
    return timeStr;
}

- (void)setTemSymbol:(temperatureSymbol)temSymbol {
    _temSymbol = temSymbol;
    if (temSymbol == temperatureSymbolC) {
        self.minTemLabel.text = @"0℃";
        self.maxTemLabel.text = @"300℃";
    } else if (temSymbol == temperatureSymbolF) {
        self.minTemLabel.text = @"32℉";
        self.maxTemLabel.text = @"572℉";
    }
}

- (void)batteryHideOrShow {
    [UIView animateWithDuration:0.5 animations:^{
        self.lowBatteryImageView.alpha = self.lowBatteryImageView.alpha ? 0 : 1;
    }];
}

- (void)LowBatteryModelOpen:(BOOL)open
{
    if (open) {
        [self.lowBatteryTimer fire];
    } else{
        self.lowBatteryImageView.alpha = 0;
        [self.lowBatteryTimer invalidate];
        self.lowBatteryTimer = nil;
    }
}

- (void)disConnectionModel
{
    //如果低电量定时器还存在，就关闭着定时器任务，断开状态时低电量图片始终显示
    if (self.lowBatteryTimer) {
        [self LowBatteryModelOpen:NO];
    }
//    [self.lowBatteryImageView setAlpha:1];
    
    [self.leftTimeValueLabel setText:@"_ _ _ _"];
    [self setCurrentTemperature:-1];
 
    //　去掉表盘上的指针
    [self.gauge deallocAllNeedle];
    
}

- (void)startFoodTemHighlightModel {
    [self.foodTemHighlightTiemr fire];
}
- (void)foodTemShowOrHide {
    [UIView animateWithDuration:0.5 animations:^{
        self.currentTemValueLabel.alpha = self.currentTemValueLabel.alpha ? 0 : 1;
    }];
}

- (void)stopFoodTemHighlightModel {
    [self.foodTemHighlightTiemr invalidate];
    self.foodTemHighlightTiemr = nil;
    self.currentTemValueLabel.alpha = 1;
}


@end
