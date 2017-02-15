//
//  ADSKTimerVC.h
//  ADBLESK
//
//  Created by 董安东 on 2017/2/8.
//  Copyright © 2017年 andong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADSKProbe.h"
#import "ADSKTimerView.h"
@interface ADSKTimerVC : UIViewController

@property (nonatomic,strong) ADSKProbe *probe;

@property (nonatomic,weak) IBOutlet ADSKTimerView *timerView;

@end
