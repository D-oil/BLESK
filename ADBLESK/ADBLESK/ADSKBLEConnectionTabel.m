//
//  ADSKBLEConnectionTabel.m
//  ADBLESK
//
//  Created by 董安东 on 2017/2/7.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADSKBLEConnectionTabel.h"

@implementation ADSKBLEConnectionTabel

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSArray *loadedViews = [mainBundle loadNibNamed:@"ADSKBLEConnectionTabel" owner:self options:nil];
        ADSKBLEConnectionTabel *loadedSubview = [loadedViews firstObject];
        
        [self addSubview:loadedSubview];
        
        loadedSubview.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addConstraint:[self pin:loadedSubview attribute:NSLayoutAttributeTop]];
        [self addConstraint:[self pin:loadedSubview attribute:NSLayoutAttributeLeft]];
        [self addConstraint:[self pin:loadedSubview attribute:NSLayoutAttributeBottom]];
        [self addConstraint:[self pin:loadedSubview attribute:NSLayoutAttributeRight]];
    }
    return self;
}

- (NSLayoutConstraint *)pin:(id)item attribute:(NSLayoutAttribute)attribute
{
    return [NSLayoutConstraint constraintWithItem:self
                                        attribute:attribute
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:item
                                        attribute:attribute
                                       multiplier:1.0
                                         constant:0.0];
}

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

- (IBAction)disConnectedButtonAction:(UIButton *)sender {
    
    if ( [self.delegate respondsToSelector:@selector(disConnectedProbesButtonAction:) ] ) {
        [self.delegate disConnectedProbesButtonAction:sender ];
    }
}


- (IBAction)tableViewBackButtonAction:(UIButton *)button
{
    [UIView animateWithDuration:0.3 animations:^{
        [self setAlpha:0];
    }];
}

@end
