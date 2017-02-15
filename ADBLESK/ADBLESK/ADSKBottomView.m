//
//  ADSKBottomView.m
//  ADBLESK
//
//  Created by 董安东 on 2017/1/21.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADSKBottomView.h"

@implementation ADSKBottomView

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


@end
