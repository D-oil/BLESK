//
//  ADSKTimerVC.m
//  ADBLESK
//
//  Created by 董安东 on 2017/2/8.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADSKTimerVC.h"

@interface ADSKTimerVC ()

@property (nonatomic,assign)NSUInteger time;

@end

@implementation ADSKTimerVC

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.timerView.circularSlider addTarget:self action:@selector(updateProgress:) forControlEvents:UIControlEventValueChanged];
    [self.timerView.circularSlider addTarget:self action:@selector(sliderTouchedDown:) forControlEvents:UIControlEventTouchDown];
    [self.timerView.circularSlider addTarget:self action:@selector(sliderTouchedUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.timerView.circularSlider addTarget:self action:@selector(sliderTouchedUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
    self.timerView.circularSlider.minimumValue = 0;
    self.timerView.circularSlider.maximumValue = 0.99;
    self.timerView.circularSlider.continuous = YES;
}

- (IBAction)updateProgress:(UISlider *)sender {
    
//    float progress = translateValueFromSourceIntervalToDestinationInterval(sender.value, sender.minimumValue, sender.maximumValue, 0.0, 1.0);
    [self.timerView updateTimeLabelAfterSliderBar];
    self.time = self.timerView.time;
}

- (IBAction)sliderTouchedDown:(id)sender {

}

- (IBAction)sliderTouchedUpInside:(id)sender {

}

- (IBAction)sliderTouchedUpOutside:(id)sender {
    
}
- (IBAction)TimerStrat:(UIButton *)sender {
    
    self.probe.foodType = foodType_Timer;
    self.probe.foodDegree = foodType_Null;
    self.probe.targetTem = -1;
    self.probe.time = self.time;
    [self.navigationController popToRootViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)chooseHourAction:(UIButton *)sender {
    [self.timerView updateTimeLabelAfterchooseHoursButton:sender];
}



@end
