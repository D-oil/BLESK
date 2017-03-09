//
//  ADSKAllProbesVC.m
//  ADBLESK
//
//  Created by 董安东 on 2017/1/21.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADSKAllProbesVC.h"
#import "ADSKSmallGaugeView.h"
#import "MainViewController.h"

@interface ADSKAllProbesVC ()

@property (weak, nonatomic) IBOutlet ADSKSmallGaugeView *numOneSmallGaugeView;
@property (weak, nonatomic) IBOutlet ADSKSmallGaugeView *numTwoSmallGaugeView;
@property (weak, nonatomic) IBOutlet ADSKSmallGaugeView *numThreeSmallGaugeView;
@property (weak, nonatomic) IBOutlet ADSKSmallGaugeView *numFourSmallGaugeView;



@end

@implementation ADSKAllProbesVC


- (NSArray *)getGaugeViewArray
{
    return @[self.numOneSmallGaugeView,self.numTwoSmallGaugeView,self.numThreeSmallGaugeView,self.numFourSmallGaugeView];
}

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)numButtonAction:(UIButton *)sender {
    self.MainVC.tag = sender.tag;
    [self back:nil];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    AppDelegate *shareDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.probeList.probes enumerateObjectsUsingBlock:^(ADSKProbe  * _Nonnull probe, NSUInteger idx, BOOL * _Nonnull stop) {
        ADSKSmallGaugeView *gaugeView = [self getGaugeViewArray][idx];
        
        
        [gaugeView setTagTemperatureWith:(int)probe.targetTem WithTemSymbol:shareDelegate.symbol];
        [gaugeView setGrillTemperatureWith:(int)probe.grillTem WithTemSymbol:shareDelegate.symbol];
        [gaugeView setFoodTemperatureWith:(int)probe.foodTem WithTemSymbol:shareDelegate.symbol];
        
        NSString *foodTypeStr = [ADSKProbe getStringFromFoodType:probe.foodType];
        NSString *foodTypeImageStr = [NSString stringWithFormat:@"%@状态图标",foodTypeStr];
        NSString *cookDegreeStr = [ADSKProbe getStringFromFoodDegree:probe.foodDegree];
        [gaugeView setfoodTypeImageStr:foodTypeImageStr foodTypeStr:foodTypeStr cookDegreeStr:cookDegreeStr];
        
        [gaugeView isOnlineStatus:probe.isConnected];
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Add allNotificationCenter Observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(probeNotification:) name:kConnectionChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(probeNotification:) name:kBatteryLowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(probeNotification:) name:kfoodTemperatureNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(probeNotification:) name:kgrillTemperatureNotification object:nil];
}


- (void)probeNotification:(NSNotification *)noti
{
    ADSKProbe *probe = noti.object;
    ADSKSmallGaugeView *gaugeView = [self getGaugeViewArray][probe.ID];
    
    if ([noti.name isEqualToString:kConnectionChangeNotification]) {
        [gaugeView isOnlineStatus:probe.isConnected];
    } else if ([noti.name isEqualToString:kBatteryLowNotification]) {
        [gaugeView LowBatteryModelOpen:YES];
    } else if ([noti.name isEqualToString:kfoodTemperatureNotification]
            || [noti.name isEqualToString:kgrillTemperatureNotification])
    {
        AppDelegate *shareDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        [gaugeView setFoodTemperatureWith:(int)probe.foodTem WithTemSymbol:shareDelegate.symbol];
        [gaugeView setGrillTemperatureWith:(int)probe.grillTem WithTemSymbol:shareDelegate.symbol];
        
    }
    
}


@end
