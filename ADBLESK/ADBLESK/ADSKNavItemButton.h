//
//  ADSKNavItemButton.h
//  ADBLESK
//
//  Created by 董安东 on 2017/2/13.
//  Copyright © 2017年 andong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, numButtonType) {
    numButtonTypeNoSelected_Disconnected,
    numButtonTypeNoSelected_Connected,
    numButtonTypeNoselected_Alarm,
    numButtonTypeSelected_Disconnected,
    numButtonTypeSelected_Connected,
    numButtonTypeSelected_Alarm
};

@interface ADSKNavItemButton : UIButton

@property (nonatomic,assign) numButtonType type;

@end
