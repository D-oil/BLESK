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


- (void)setSymbol:(temperatureSymbol)symbol {
    NSArray *temArray;
    if (symbol == temperatureSymbolF) {
        temArray = @[@"125℉",@"136℉",@"143℉",@"150℉",@"158℉",@"185℉"];
    } else {
        temArray = @[@"52℃",@"57℃",@"62℃",@"66℃",@"70℃",@"85℃"];
    }
    self.rareItem.temLabel.text = temArray[0];
    self.mediumRareItem.temLabel.text = temArray[1];
    self.mediumItem.temLabel.text = temArray[2];
    self.mediumDoneItem.temLabel.text = temArray[3];
    self.wellDoneItem.temLabel.text = temArray[4];
    self.slowDoneItem.temLabel.text = temArray[5];
   
}
@end
