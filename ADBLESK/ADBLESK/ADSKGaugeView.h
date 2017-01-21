//
//  ADSKGaugeView.h
//  ADBLESK
//
//  Created by 董安东 on 2017/1/21.
//  Copyright © 2017年 andong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMGaugeView.h"

@interface ADSKGaugeView : UIView

@property (nonatomic,weak) IBOutlet WMGaugeView *gauge;

-(void)initGaugeView;

@end
