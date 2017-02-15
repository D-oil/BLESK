//
//  ADSKCookDegreeVC.h
//  ADBLESK
//
//  Created by 董安东 on 2017/1/22.
//  Copyright © 2017年 andong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADSKCookDegreeSelectView.h"
#import "ADSKProbe.h"

@interface ADSKCookDegreeVC : UIViewController

@property (nonatomic,strong) ADSKProbe *probe;

@property (nonatomic,strong) NSNumber *tag;

@property (weak, nonatomic) IBOutlet ADSKCookDegreeSelectView *cookDegreeSelectView;


@end
