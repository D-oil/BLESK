//
//  ADSKTimerView.m
//  ADBLESK
//
//  Created by 董安东 on 2017/2/8.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADSKTimerView.h"

@implementation ADSKTimerView

- (void)updateTimeLabelAfterchooseHoursButton:(UIButton *)hoursButton
{
    if (hoursButton.tag == 0) {
        [self.zeroHour setSelected:YES];
        [self.oneHour setSelected:NO];
        [self.twoHour setSelected:NO];
    } else if (hoursButton.tag ==1) {
        [self.zeroHour setSelected:NO];
        [self.oneHour setSelected:YES];
        [self.twoHour setSelected:NO];
    } else if (hoursButton.tag ==2) {
        [self.zeroHour setSelected:NO];
        [self.oneHour setSelected:NO];
        [self.twoHour setSelected:YES];
    }
    NSInteger minute = [[[self.timeLabel.text componentsSeparatedByString:@":"] lastObject] integerValue];
    self.timeLabel.text = [NSString stringWithFormat:@"%ld:%02ld",hoursButton.tag,minute];
     self.time = [self compuertTime];
}
- (void)updateTimeLabelAfterSliderBar
{
    NSInteger hour = [[[self.timeLabel.text componentsSeparatedByString:@":"] firstObject] integerValue];
    NSInteger minute = 60 * self.circularSlider.value;
    self.timeLabel.text = [NSString stringWithFormat:@"%ld:%02ld",hour,minute];
    self.time = [self compuertTime];
}

- (NSUInteger)compuertTime{
    NSInteger hour = [[[self.timeLabel.text componentsSeparatedByString:@":"] firstObject] integerValue];
    NSInteger minute = [[[self.timeLabel.text componentsSeparatedByString:@":"] lastObject] integerValue];
    return  hour * 3600 + minute *60;
}
@end
