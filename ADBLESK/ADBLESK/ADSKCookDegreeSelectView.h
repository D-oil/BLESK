//
//  ADSKCookDegreeSelectView.h
//  ADBLESK
//
//  Created by 董安东 on 2017/1/29.
//  Copyright © 2017年 andong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADSKCookDegreeSelectItem.h"




@interface ADSKCookDegreeSelectView : UIView

@property (nonatomic,strong) NSArray *itemArray;

@property (nonatomic,weak) IBOutlet ADSKCookDegreeSelectItem *rareItem;

@property (nonatomic,weak) IBOutlet ADSKCookDegreeSelectItem *mediumRareItem;

@property (nonatomic,weak) IBOutlet ADSKCookDegreeSelectItem *mediumItem;

@property (nonatomic,weak) IBOutlet ADSKCookDegreeSelectItem *mediumDoneItem;

@property (nonatomic,weak) IBOutlet ADSKCookDegreeSelectItem *wellDoneItem;

@property (nonatomic,weak) IBOutlet ADSKCookDegreeSelectItem *slowDoneItem;




- (void) selectItemWithHighted:(ADSKCookDegreeSelectItem *)item;
- (void)setTagTemperatureArrayWithTag:(NSInteger)tag andTemperatureSymbol:(temperatureSymbol)symbol;
@end
