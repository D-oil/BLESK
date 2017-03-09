//
//  ADSKSmallGaugeView.m
//  ADBLESK
//
//  Created by 董安东 on 2017/1/30.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADSKSmallGaugeView.h"

@interface ADSKSmallGaugeView ()

@property (nonatomic,strong)NSTimer *lowBatteryTimer;

@end

@implementation ADSKSmallGaugeView

- (NSTimer *)lowBatteryTimer
{
    if (_lowBatteryTimer == nil) {
        _lowBatteryTimer = [NSTimer timerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [UIView animateWithDuration:0.5 animations:^{
                self.lowBatteryImageView.alpha = self.lowBatteryImageView.alpha ? 0 : 1;
            }];
        }];
        [[NSRunLoop mainRunLoop] addTimer:_lowBatteryTimer forMode:NSRunLoopCommonModes];
    }
    return _lowBatteryTimer;
}

- (void)isOnlineStatus:(BOOL)online
{
    if (online) {
        [self.bottomView setHidden:NO];
        [self.numButton setEnabled:YES];
        [self.numButton setTitleColor:[UIColor colorWithRed:166/255.0 green:0/255.0 blue:30/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self initGauge];
    } else {
        [self.bottomView setHidden:YES];
        [self.guaue deallocAllNeedle];
        [self.numButton setEnabled:NO];
        [self.numButton setTitleColor:[UIColor colorWithRed:108/255.0 green:101/255.0 blue:100/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.temperatureLabel setText:@"__ __"];
        [self.timeLabel setText:@"__ __"];
    }
}

- (void)initGauge
{
    self.guaue.style = [WMGaugeViewStyleFlatThin new];
    self.guaue.maxValue = 300.0;
    self.guaue.showInnerRim = YES;
    self.guaue.scaleDivisions = 10;
    self.guaue.scaleSubdivisions = 5;
    self.guaue.scaleStartAngle = 30;
    self.guaue.scaleEndAngle = 330;
    self.guaue.showScaleShadow = NO;
    self.guaue.scaleFont = [UIFont fontWithName:@"AvenirNext-UltraLight" size:0.065];
    self.guaue.scalesubdivisionsAligment = WMGaugeViewSubdivisionsAlignmentCenter;
    self.guaue.scaleSubdivisionsWidth = 0.004;
    self.guaue.scaleSubdivisionsLength = 0.004;
    self.guaue.scaleDivisionsWidth = 0.004;
    self.guaue.scaleDivisionsLength = 0.004;
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

- (void)setfoodTypeImageStr:(NSString *)foodTypeImageStr foodTypeStr:(NSString *)foodTypeStr cookDegreeStr:(NSString *)cookTypeStr
{
    [self.foodTypeImageView setImage:[UIImage imageNamed:foodTypeImageStr]];
    [self.foodTypeLabel setText:foodTypeStr];
    [self.cookDegreeLabel setText:cookTypeStr];
}

- (void)setTagTemperatureWith:(int)tagTem WithTemSymbol:(temperatureSymbol)symbol
{
    [self.guaue setfoodTmpValue:(float)tagTem animated:YES duration:1.0 completion:^(BOOL finished) {}];
    if (tagTem == -1) {
        [self.targetTemLabel setHidden:YES];
        [self.tatgetLabel setHidden:YES];
        [self.targetImageView setHidden:YES];
    } else {
        [self.targetTemLabel setHidden:NO];
        [self.tatgetLabel setHidden:NO];
        [self.targetImageView setHidden:NO];
    }
    
    if (symbol == temperatureSymbolC) {
        self.targetTemLabel.text = [NSString stringWithFormat:@"%d℃",tagTem];
    } else {
        self.targetTemLabel.text = [NSString stringWithFormat:@"%d℉",(int)(tagTem * 1.8) +32];
    }
}

- (void)setFoodTemperatureWith:(int)foodTem WithTemSymbol:(temperatureSymbol)symbol
{
    [self.guaue setTagTmpValue:(float)foodTem animated:YES duration:1.0 completion:^(BOOL finished) {}];
    if (symbol == temperatureSymbolC) {
        self.temperatureLabel.text = [NSString stringWithFormat:@"%d℃",foodTem];
    } else {
        self.temperatureLabel.text = [NSString stringWithFormat:@"%d℉",(int)(foodTem * 1.8) +32];
    }
}

- (void)setGrillTemperatureWith:(int)grillTem WithTemSymbol:(temperatureSymbol)symbol
{
    [self.guaue setValue:(float)grillTem animated:YES duration:1.0 completion:^(BOOL finished) {}];
    if (symbol == temperatureSymbolC) {
        self.grillTemLabel.text = [NSString stringWithFormat:@"%d℃",grillTem];
    } else {
        self.grillTemLabel.text = [NSString stringWithFormat:@"%d℉",(int)(grillTem * 1.8) +32];
    }
}

@end
