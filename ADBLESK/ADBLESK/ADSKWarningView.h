//
//  ADSKWarningView.h
//  ADBLESK
//
//  Created by 董安东 on 2017/2/19.
//  Copyright © 2017年 andong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADSKWarningView : UIView

@property (nonatomic,weak) IBOutlet UIView *MessageView;

@property (nonatomic,weak) IBOutlet UILabel *messageLabel;

@property (nonatomic,weak) IBOutlet UIButton *okButton;


- (void)warningViewHidden:(BOOL)hidden withString:(NSString *)message;


@end
