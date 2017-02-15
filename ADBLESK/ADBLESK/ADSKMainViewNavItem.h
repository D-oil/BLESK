//
//  ADSKMainViewNavItem.h
//  ADBLESK
//
//  Created by 董安东 on 2017/1/30.
//  Copyright © 2017年 andong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADSKNavItemButton.h"




@interface ADSKMainViewNavItem : UINavigationItem

@property (nonatomic,weak) IBOutlet UIView *middleView;
@property (nonatomic,strong) NSArray *buttonArray;
@property (nonatomic,weak) IBOutlet ADSKNavItemButton *oneButton;
@property (nonatomic,weak) IBOutlet ADSKNavItemButton *twoButton;
@property (nonatomic,weak) IBOutlet ADSKNavItemButton *threeButton;
@property (nonatomic,weak) IBOutlet ADSKNavItemButton *fourButton;


@property (nonatomic,weak) IBOutlet UIBarButtonItem *recipeBarButtonItem;
@property (nonatomic,weak) IBOutlet UIButton *backgroundButton;
@property (nonatomic,weak) IBOutlet UIButton *tintButton;


@property (nonatomic,weak) IBOutlet UIBarButtonItem *BLEButtonItem;
@property (nonatomic,weak) IBOutlet UIButton *BLEConnectionButton;

//用于改变button状态
- (void)numButtonStateChange:(numButtonType)buttonType numButton:(ADSKNavItemButton *)numButton;

//用于点选button
- (void)selectedNumButton:(ADSKNavItemButton *)numButton ;


- (void)setItemConnected:(BOOL)isConnected;

@end
