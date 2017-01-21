
//
//  ADSKSettingVC.m
//  ADBLESK
//
//  Created by 董安东 on 2017/1/20.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADSKSettingVC.h"

@interface ADSKSettingVC ()

@end

@implementation ADSKSettingVC

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.versionLabel setText:[NSString stringWithFormat:NSLocalizedString(@"settingVC_version", nil),[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]];
}

- (IBAction)ConnectionNumAction:(UIButton *)sender {
}

- (IBAction)temperatureUnitAction:(UIButton *)sender {
}


- (IBAction)AlarmSelect:(UIButton *)sender {
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"settingVC_selectAlarmTitle", nil) message:NSLocalizedString(@"settingVC_selectAlarmMessage", nil) preferredStyle:UIAlertControllerStyleActionSheet];

        UIAlertAction *soundAndVibration= [UIAlertAction actionWithTitle:NSLocalizedString(@"settingVC_selectSoundAndVibrationAction", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
        }];
        UIAlertAction *Vibration= [UIAlertAction actionWithTitle:NSLocalizedString(@"settingVC_selectVibrationAction", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *Sound= [UIAlertAction actionWithTitle:NSLocalizedString(@"settingVC_selectSoundAction", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
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
