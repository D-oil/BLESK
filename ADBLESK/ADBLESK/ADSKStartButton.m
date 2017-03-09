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
        [self setTitle:@"START" forState:UIControlStateNormal];
        [self setTitle:@"START" forState:UIControlStateHighlighted];
    } else {
        [self setTitle:@"STOP" forState:UIControlStateNormal];
        [self setTitle:@"STOP" forState:UIControlStateHighlighted];
    }
    
}

@end
