//
//  ADSKTimerView.h
//  ADBLESK
//
//  Created by 董安东 on 2017/2/8.
//  Copyright © 2017年 andong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICircularSlider.h"
@interface ADSKTimerView : UIView

@property (nonatomic,weak) IBOutlet UICircularSlider *circularSlider;

@property (nonatomic,weak) IBOutlet UIButton *zeroHour;
@property (nonatomic,weak) IBOutlet UIButton *oneHour;
@property (nonatomic,weak) IBOutlet UIButton *twoHour;

@property (nonatomic,weak) IBOutlet UILabel *timeLabel;

- (void)updateTimeLabelAfterchooseHoursButton:(UIButton *)hoursButton;

- (void)updateTimeLabelAfterSliderBar;

@end
