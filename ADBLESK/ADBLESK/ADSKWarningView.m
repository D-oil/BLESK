//
//  ADSKWarningView.m
//  ADBLESK
//
//  Created by 董安东 on 2017/2/19.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADSKWarningView.h"

@implementation ADSKWarningView

- (void)warningViewHidden:(BOOL)hidden withString:(NSString *)message
{
    if (hidden) {
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 0;
        }];
        
    } else {
        self.messageLabel.text = message;
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 1;
        }];
    }
    
}

@end
