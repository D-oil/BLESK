//
//  ADSKBLEConnectionTabel.m
//  ADBLESK
//
//  Created by 董安东 on 2017/2/7.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADSKBLEConnectionTabel.h"

@implementation ADSKBLEConnectionTabel


- (void)setTitleWithConnectedNum:(NSUInteger) connectedNum
{
    [self.numOfConnectedLabel setText:[NSString stringWithFormat:@"%ld / 4",connectedNum]];
}

- (void)showDisconnectViewWith:(NSString *)BLEName
{
    
    NSString *message = [NSString stringWithFormat:NSLocalizedString(@"disConnect_message", nil) ,BLEName];
    [self.disConnectMessageLabel setText:message];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         [self.disConnectView setAlpha:1];
                     }];
    
}

- (void)hideDisconnectView
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         [self.disConnectView setAlpha:0];
                     }];
}

+ (NSArray *)getItemImageStrs
{
    return @[@"通道1标志",@"通道2标志",@"通道3标志",@"通道4标志"];
}

@end
