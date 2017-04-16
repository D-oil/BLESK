//
//  ADSKNavigationBar.m
//  ADBLESK
//
//  Created by 董安东 on 2017/1/20.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADSKNavigationBar.h"

@implementation ADSKNavigationBar

- (CGSize)sizeThatFits:(CGSize)size {
    // Change navigation bar height. The height must be even, otherwise there will be a white line above the navigation bar.
    [super sizeThatFits:size];
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.08);;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect barFrame = self.frame;
    barFrame.size.height = [UIScreen mainScreen].bounds.size.height * 0.08;
    self.frame = barFrame;
    
    for (UINavigationItem *item in self.items) {
        item.titleView.center = CGPointMake(self.bounds.size.width / 2, barFrame.size.height / 2);
    }
    
    // Make items on navigation bar vertically centered.
    int i = 0;
    for (UIView *view in self.subviews) {
        if (i == 0)
            continue;
        float centerY = self.bounds.size.height / 2.0f;
        CGPoint center = view.center;
        center.y = centerY;
        view.center = center;
    }
}

@end
