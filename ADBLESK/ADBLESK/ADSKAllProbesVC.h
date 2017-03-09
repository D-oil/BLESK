//
//  ADSKAllProbesVC.h
//  ADBLESK
//
//  Created by 董安东 on 2017/1/21.
//  Copyright © 2017年 andong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADSKProbeList.h"

@class MainViewController;
@interface ADSKAllProbesVC : UIViewController

@property (nonatomic,strong) MainViewController *MainVC;
@property (nonatomic,strong) ADSKProbeList *probeList;

@end
