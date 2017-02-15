//
//  ADSKTemperatureVC.m
//  ADBLESK
//
//  Created by 董安东 on 2017/2/8.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADSKTemperatureVC.h"

@interface ADSKTemperatureVC ()
@property (weak, nonatomic) IBOutlet UILabel *temparetureLabel;
@property (weak, nonatomic) IBOutlet UITemperatureSlider *temparetureView;

@end

@implementation ADSKTemperatureVC
- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.temparetureView addTarget:self action:@selector(updateProgress:) forControlEvents:UIControlEventValueChanged];
    [self.temparetureView addTarget:self action:@selector(sliderTouchedDown:) forControlEvents:UIControlEventTouchDown];
    [self.temparetureView addTarget:self action:@selector(sliderTouchedUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.temparetureView addTarget:self action:@selector(sliderTouchedUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
    self.temparetureView.continuous = YES;
    
    AppDelegate *shareDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (shareDelegate.symbol == temperatureSymbolC) {
        self.temparetureView.temSymbol = temperatureSymbolC;
        self.temparetureLabel.text = @"0℃";
    } else {
        self.temparetureView.temSymbol = temperatureSymbolF;
        self.temparetureLabel.text = @"32℉";
    }
}

- (IBAction)updateProgress:(UISlider *)sender {
    
    NSLog(@"-----%f----=",self.temparetureView.value);
    NSString *temText;
    if (self.temparetureView.temSymbol == temperatureSymbolF)
    {
        temText = [NSString stringWithFormat:@"%d℉",(int)((self.temparetureView.value *85) *1.8) +32];
    } else if (self.temparetureView.temSymbol == temperatureSymbolC)
    {
        temText = [NSString stringWithFormat:@"%d℃",(int)(self.temparetureView.value *85)];
    }
    self.temparetureLabel.text = temText;
}

- (IBAction)sliderTouchedDown:(id)sender {
    //self.view.backgroundColor = [UIColor grayColor];
}

- (IBAction)sliderTouchedUpInside:(id)sender {
    //self.view.backgroundColor = [UIColor lightGrayColor];
}
- (IBAction)sliderTouchedUpOutside:(id)sender {
    //self.view.backgroundColor = [UIColor greenColor];
}

- (IBAction)TemparetureStrat:(UIButton *)sender {
    NSInteger tagTem = (int)(self.temparetureView.value *85);
    self.probe.targetTem = tagTem;
    self.probe.foodDegree = foodType_Null;
    self.probe.foodType = foodType_Tempareture;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
