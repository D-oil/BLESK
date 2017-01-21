//
//  ADSKGaugeView.m
//  ADBLESK
//
//  Created by 董安东 on 2017/1/21.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADSKGaugeView.h"

@implementation ADSKGaugeView

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
    self.gauge.TagValue = 0;
    self.gauge.foodValue = 0;
    self.gauge.grillValue = 0;
}
         
@end
