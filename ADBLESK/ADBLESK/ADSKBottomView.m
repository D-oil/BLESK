//
//  ADSKBottomView.m
//  ADBLESK
//
//  Created by 董安东 on 2017/1/21.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADSKBottomView.h"

@interface ADSKBottomView ()

@property (nonatomic,strong) NSTimer *grillTemHighlightTiemr;

@end

@implementation ADSKBottomView

- (NSTimer *)grillTemHighlightTiemr {
    if (_grillTemHighlightTiemr == nil) {
        _grillTemHighlightTiemr = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(grillTemShowOrHide) userInfo:nil repeats:YES];
    }
    return _grillTemHighlightTiemr;
}

- (void)setfoodImageStr:(NSString *)imageStr foodType:(NSString *)foodTypeStr cookDegreeStr:(NSString *)cookDegreeStr
{
    [self.foodTypeImageView setImage:[UIImage imageNamed:imageStr]];
    [self.foodNameLabel setText:foodTypeStr];
    [self.cookDegreeLabel setText:cookDegreeStr];
    
}
- (void)setTagTemLabelText:(NSString *)tagTem
{
    if ([tagTem containsString:@"-1"]) {
        [self.targetImageView setHidden:YES];
        [self.targetLabel setHidden:YES];
        [self.taggetTemLabel setHidden:YES];
    } else {
        [self.targetImageView setHidden:NO];
        [self.targetLabel setHidden:NO];
        [self.taggetTemLabel setHidden:NO];
        [self.taggetTemLabel setText:tagTem];
    }
    
}
- (void)setGrillTemLabelText:(NSString *)grillTem
{
    [self.grillTemLabel setText:grillTem];
}


- (void)startGrillTemHighlightModel {
    [self.grillTemHighlightTiemr fire];
}

- (void)grillTemShowOrHide {
    [UIView animateWithDuration:0.5 animations:^{
        self.grillTemLabel.alpha = self.grillTemLabel.alpha ? 0 : 1;
    }];
}

- (void)stopGrillTemHighlightModel {
    [self.grillTemHighlightTiemr invalidate];
    self.grillTemHighlightTiemr = nil;
    self.grillTemLabel.alpha = 1;
}

@end
