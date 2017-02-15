//
//  ADSKCookDegreeSelectItem.m
//  ADBLESK
//
//  Created by 董安东 on 2017/1/29.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADSKCookDegreeSelectItem.h"

@implementation ADSKCookDegreeSelectItem

- (void)setItemHighlighted:(BOOL)highLighted
{
    [self.selectImageView setHighlighted:highLighted];
    if (highLighted) {
        [self.temLabel setTextColor:[UIColor colorWithRed:254/255.0 green:214/255.0 blue:130/255.0 alpha:1.0]];
        [self.rareLabel setTextColor:[UIColor colorWithRed:254/255.0 green:214/255.0 blue:130/255.0 alpha:1.0]];
    } else {
        [self.temLabel setTextColor:[UIColor orangeColor]];
        [self.rareLabel setTextColor:[UIColor orangeColor]];
    }
}


@end
