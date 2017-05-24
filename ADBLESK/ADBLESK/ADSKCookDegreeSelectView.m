//
//  ADSKCookDegreeSelectView.m
//  ADBLESK
//
//  Created by 董安东 on 2017/1/29.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADSKCookDegreeSelectView.h"

@implementation ADSKCookDegreeSelectView

- (NSArray *)itemArray {
    if (_itemArray == nil) {
        _itemArray =@[self.rareItem,
                      self.mediumRareItem,
                      self.mediumItem,
                      self.mediumDoneItem,
                      self.wellDoneItem,
                      self.slowDoneItem];
    }
    return _itemArray;
}

- (void) selectItemWithHighted:(ADSKCookDegreeSelectItem *)item
{
    
    
    for (ADSKCookDegreeSelectItem *foritem in self.itemArray) {
        if ([foritem isEqual:item]) {
            [foritem setItemHighlighted:YES];
        } else {
            [foritem setItemHighlighted:NO];
        }
    }
}

- (void)setTagTemperatureArrayWithTag:(NSInteger)tag andTemperatureSymbol:(temperatureSymbol)symbol
{

    NSArray *foodTemArray = [ADSKProbe getTemWithTag:tag-1];
    
    [foodTemArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull foodTem, NSUInteger idx, BOOL * _Nonnull stop) {
        ADSKCookDegreeSelectItem *item = self.itemArray[idx];
        if ([foodTem isEqualToString:@""]) {
            [item setHidden:YES];
        } else {
            [item setHidden:NO];
            NSString * fooTemStr ;
            if (symbol == temperatureSymbolC) {
                fooTemStr = [NSString stringWithFormat:@"%@℃",foodTemArray[idx]];
            } else {
                fooTemStr = [NSString stringWithFormat:@"%d℉", (int)([foodTemArray[idx] integerValue]*1.8) +32];
            }
            item.temLabel.text =fooTemStr;
            item.tem = [foodTemArray[idx] integerValue];
        }
    }];
}






@end
