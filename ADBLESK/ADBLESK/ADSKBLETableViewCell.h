//
//  ADSKBLETableViewCell.h
//  ADBLESK
//
//  Created by 董安东 on 2017/2/7.
//  Copyright © 2017年 andong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADSKBLETableViewCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel *nameLabel;

@property (nonatomic,weak) IBOutlet UIImageView *wifiImageView;

@property (nonatomic,weak) IBOutlet UIImageView *selectedImageView;

@property (nonatomic,assign) NSUInteger index;

@property (nonatomic,assign,readonly) BOOL isConnected;

- (void)cellConnected:(BOOL)isConnected withSelectedImageStr:(NSString *)selectedImageStr WithIndex:(NSUInteger)index;



@end
