//
//  ADSKStartButton.m
//  ADBLESK
//
//  Created by 董安东 on 2017/2/22.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADSKStartButton.h"

@implementation ADSKStartButton

- (void)setStopOrStart:(BOOL)stopOrStart {
    
    if (stopOrStart) {
        [self setTitle:NSLocalizedString(@"button_Start", nil) forState:UIControlStateNormal];
        [self setTitle:NSLocalizedString(@"button_Start", nil) forState:UIControlStateHighlighted];
    } else {
        [self setTitle:NSLocalizedString(@"button_Stop", nil) forState:UIControlStateNormal];
        [self setTitle:NSLocalizedString(@"button_Stop", nil) forState:UIControlStateHighlighted];
    }
    
}

@end
