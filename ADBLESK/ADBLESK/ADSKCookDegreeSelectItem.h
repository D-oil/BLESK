//
//  ADSKCookDegreeSelectItem.h
//  ADBLESK
//
//  Created by 董安东 on 2017/1/29.
//  Copyright © 2017年 andong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ADSKCookDegreeSelectItem : UIView


@property (nonatomic,weak) IBOutlet UIImageView *selectImageView;

@property (nonatomic,weak) IBOutlet UILabel *temLabel;

@property (nonatomic,weak) IBOutlet UILabel *rareLabel;

@property (nonatomic,weak) IBOutlet UIButton *actionButton;

@property (nonatomic,assign)NSInteger tem;

- (void)setItemHighlighted:(BOOL)highLighted;

@end
