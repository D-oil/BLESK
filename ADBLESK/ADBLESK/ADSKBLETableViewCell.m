//
//  ADSKBLETableViewCell.m
//  ADBLESK
//
//  Created by 董安东 on 2017/2/7.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADSKBLETableViewCell.h"

@interface ADSKBLETableViewCell ()

@property (nonatomic,assign,readwrite) BOOL isConnected;


@end

@implementation ADSKBLETableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)cellConnected:(BOOL)isConnected withSelectedImageStr:(NSString *)selectedImageStr WithIndex:(NSUInteger)index;
{
    if (isConnected) {
        [self.nameLabel setTextColor:[UIColor redColor]];
        [self.wifiImageView setHidden:NO];
        if (selectedImageStr !=nil) {
            [self.selectedImageView setHidden:NO];
            [self.selectedImageView setImage:[UIImage imageNamed:selectedImageStr]];
        }
        
    } else {
        [self.nameLabel setTextColor:[UIColor colorWithRed:0/255 green:104/255 blue:255/255 alpha:1]];
        [self.wifiImageView setHidden:YES];
        [self.selectedImageView setHidden:YES];
    }
    
    self.isConnected = isConnected;
    self.index = index;
}

@end
