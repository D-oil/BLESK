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

@end

@implementation ADSKGaugeView

#pragma mark - properties
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.gauge setValue:0.0 animated:YES];
        [self.gauge setTagTmpValue:0.0 animated:YES duration:1 completion:nil];
        [self.gauge setfoodTmpValue:0.0 animated:YES duration:1 completion:nil];
    });

}

- (void)changeToTemSymbol:(temperatureSymbol)symbol
{
    if (symbol == temperatureSymbolC) {
        self.minTemLabel.text = @"0℃";
        self.maxTemLabel.text = @"300℃";
    } else if (symbol == temperatureSymbolF) {
        self.minTemLabel.text = @"32℉";
        self.maxTemLabel.text = @"572℉";
    }
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
    [self.lowBatteryImageView setAlpha:1];
    
    [self.leftTimeValueLabel setText:@"_ _ _ _"];
    [self.currentTemValueLabel setText:@"_ _"];
 
    //　去掉表盘上的指针
    [self.gauge deallocAllNeedle];
    
}


@end
