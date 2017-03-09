
//
//  ADSKSettingVC.m
//  ADBLESK
//
//  Created by 董安东 on 2017/1/20.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADSKSettingVC.h"
#import "AppDelegate.h"
#import "LxxSoundPlay.h"

@interface ADSKSettingVC ()

@property (nonatomic,weak) AppDelegate *shareDelegate;
@end

@implementation ADSKSettingVC

- (AppDelegate *)shareDelegate
{
    if (_shareDelegate == nil) {
        _shareDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return _shareDelegate;
}

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.versionLabel setText:[NSString stringWithFormat:NSLocalizedString(@"settingVC_version", nil),[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]];
    
    if (self.shareDelegate.symbol == temperatureSymbolC) {
        [self isSelectedC:YES];
    } else {
        [self isSelectedC:NO];
    }
    
    [self setRingButtonStr];
    
}

- (IBAction)ConnectionNumAction:(UIButton *)sender {
}

- (IBAction)temperatureUnitAction:(UIButton *)sender {
    if ([sender isEqual:self.Cbutton]) {
        [self.shareDelegate setSymbol:temperatureSymbolC];
        [self isSelectedC:YES];
    } else {
        [self.shareDelegate setSymbol:temperatureSymbolF];
        [self isSelectedC:NO];
    }
}

- (void)isSelectedC:(BOOL)isC
{
    if (isC) {
        [self.Cbutton setSelected:YES];
        [self.Fbutton setSelected:NO];
    } else {
        [self.Fbutton setSelected:YES];
        [self.Cbutton setSelected:NO];
    }
}

- (void)setRingButtonStr
{
    NSArray *ringTypeStrs = @[@"Ring",@"Vibration",@"Ring&Vibration"];
    [self.ringTypeButton setTitle:ringTypeStrs[self.shareDelegate.ringType] forState:UIControlStateNormal];
}

- (IBAction)AlarmSelect:(UIButton *)sender {
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"settingVC_selectAlarmTitle", nil) message:NSLocalizedString(@"settingVC_selectAlarmMessage", nil) preferredStyle:UIAlertControllerStyleActionSheet];

        UIAlertAction *soundAndVibration= [UIAlertAction actionWithTitle:NSLocalizedString(@"settingVC_selectSoundAndVibrationAction", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.shareDelegate setRingType:ringTypeRingAndVibration];
            [[[LxxSoundPlay alloc] init] playwarning];
//            [LxxSoundPlay tapSound];
//            [LxxSoundPlay tapVibration];
            
            [self setRingButtonStr];
        }];
        UIAlertAction *Vibration= [UIAlertAction actionWithTitle:NSLocalizedString(@"settingVC_selectVibrationAction", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
            [self.shareDelegate setRingType:ringTypeVibration];
            [[[LxxSoundPlay alloc] init] playwarning];
            [self setRingButtonStr];
        }];
        UIAlertAction *Sound= [UIAlertAction actionWithTitle:NSLocalizedString(@"settingVC_selectSoundAction", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self.shareDelegate setRingType:ringTypeRing];
            [[[LxxSoundPlay alloc] init] playwarning];
            [self setRingButtonStr];
        }];
    
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:nil];
        [alertC addAction:soundAndVibration];
        [alertC addAction:Vibration];
        [alertC addAction:Sound];
        [alertC addAction:cancelAction];
    [alertC.view setTintColor:[UIColor blackColor]];
    [self presentViewController:alertC animated:YES completion:nil];
    
}




@end
