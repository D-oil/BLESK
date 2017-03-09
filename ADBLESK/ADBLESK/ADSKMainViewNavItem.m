//
//  ADSKMainViewNavItem.m
//  ADBLESK
//
//  Created by 董安东 on 2017/1/30.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADSKMainViewNavItem.h"

@interface ADSKMainViewNavItem ()



@property (nonatomic,strong) NSArray *OffLineMins;
@property (nonatomic,strong) NSArray *OffLineMaxs;
@property (nonatomic,strong) NSArray *OnLineMins;
@property (nonatomic,strong) NSArray *OnLineMaxs;
@property (nonatomic,strong) NSArray *AlarmMins;
@property (nonatomic,strong) NSArray *AlarmMaxs;


@end

@implementation ADSKMainViewNavItem

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.OffLineMins = @[@"小1_未连接",@"小2_未连接",@"小3_未连接",@"小4_未连接"];
    self.OffLineMaxs = @[@"大1_未连接",@"大2_未连接",@"大3_未连接",@"大4_未连接"];
    
    self.OnLineMins = @[@"小1_正常",@"小2_正常",@"小3_正常",@"小4_正常"];
    self.OnLineMaxs = @[@"大1_当前",@"大2_当前",@"大3_当前",@"大4_当前"];
    
    self.AlarmMins = @[@"小1_报警",@"小2_报警",@"小3_报警",@"小4_报警"];
    self.AlarmMaxs = @[@"大1_当前报警",@"大2_当前报警",@"大3_当前报警",@"大4_当前报警"];
    
    self.buttonArray = @[self.oneButton,self.twoButton,self.threeButton,self.fourButton] ;
    

}

- (void)numButtonStateChange:(numButtonType)buttonType numButton:(ADSKNavItemButton *)numButton
{
    
    switch (buttonType) {
        case numButtonTypeNoSelected_Disconnected:
            [numButton setImage:[UIImage imageNamed:self.OffLineMins[numButton.tag]] forState:UIControlStateNormal];
            break;
        case numButtonTypeNoSelected_Connected:
            [numButton setImage:[UIImage imageNamed:self.OnLineMins[numButton.tag]] forState:UIControlStateNormal];
            break;
        case numButtonTypeSelected_Disconnected:
            [numButton setImage:[UIImage imageNamed:self.OffLineMaxs[numButton.tag]] forState:UIControlStateNormal];
            break;
        case numButtonTypeSelected_Connected:
            [numButton setImage:[UIImage imageNamed:self.OnLineMaxs[numButton.tag]] forState:UIControlStateNormal];
            break;
        case numButtonTypeNoselected_Alarm:
            [numButton setImage:[UIImage imageNamed:self.AlarmMins[numButton.tag]] forState:UIControlStateNormal];
            break;
        case numButtonTypeSelected_Alarm:
            [numButton setImage:[UIImage imageNamed:self.AlarmMaxs[numButton.tag]] forState:UIControlStateNormal];
            break;
       
    }
    numButton.type = buttonType;
    
}
- (void)selectedNumButton:(ADSKNavItemButton *)numButton
{
    //选中的button
    switch (numButton.type) {
        case numButtonTypeNoSelected_Disconnected:
            [self numButtonStateChange:numButtonTypeSelected_Disconnected numButton:numButton];
            
            break;
        case numButtonTypeNoSelected_Connected:
            [self numButtonStateChange:numButtonTypeSelected_Connected numButton:numButton];
            break;
        case numButtonTypeNoselected_Alarm:
            [self numButtonStateChange:numButtonTypeSelected_Alarm numButton:numButton];
            break;
    }
    
    NSMutableArray *otherButton = [self.buttonArray mutableCopy];
    [otherButton removeObject:numButton];
    //除了选中的button以外的button
    for (ADSKNavItemButton *navButton in otherButton) {
        switch (navButton.type) {
            case numButtonTypeSelected_Disconnected:
                [self numButtonStateChange:numButtonTypeNoSelected_Disconnected numButton:navButton];
                break;
            case numButtonTypeSelected_Connected:
                [self numButtonStateChange:numButtonTypeNoSelected_Connected numButton:navButton];
                break;
            case numButtonTypeSelected_Alarm:
                [self numButtonStateChange:numButtonTypeNoselected_Alarm numButton:navButton];
                break;
                
            }
    }

    
}

//- (void)selectedNumButton:(UIButton *)selectedButton
//           oneButtonState:(numbuttonState)onebuttonState
//           twoButtonState:(numbuttonState)twobuttonState
//         threeButtonState:(numbuttonState)threebuttonState
//          fourButtonState:(numbuttonState)fourbuttonState
//{
//    for (UIButton *button in self.buttonArray) {
//        if ([button isEqual:selectedButton]) {
//            
//        } else {
//            
//        }
//    }
//}

- (void)setItemConnected:(BOOL)isConnected
{
    if (isConnected) {
        [self.tintButton setHighlighted:NO];
        [self.backgroundButton setUserInteractionEnabled:YES];
        [self.BLEConnectionButton setImage:[UIImage imageNamed:@"蓝牙连接图标"] forState:UIControlStateNormal];
        [self.BLEConnectionButton setImage:[UIImage imageNamed:@"蓝牙连接图标"] forState:UIControlStateHighlighted];
        
    } else {
        [self.tintButton setHighlighted:YES];
        [self.BLEConnectionButton setImage:[UIImage imageNamed:@"蓝牙断开图标"] forState:UIControlStateNormal];
        [self.BLEConnectionButton setImage:[UIImage imageNamed:@"蓝牙断开图标"] forState:UIControlStateHighlighted];
        [self.backgroundButton setUserInteractionEnabled:NO];
    }
}

@end
