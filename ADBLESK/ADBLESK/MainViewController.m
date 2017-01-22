//
//  ViewController.m
//  ADBLESK
//
//  Created by 董安东 on 2017/1/19.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "MainViewController.h"
#import "ADSKGaugeView.h"


@interface MainViewController ()

@property (weak, nonatomic) IBOutlet ADSKGaugeView *gaugeView;



@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    

    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.gaugeView initGaugeView];
    [self.gaugeView changeToTemSymbol:1];
}

- (IBAction)recipeButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"recipeSegue" sender:nil];
}


- (IBAction)settingsAction:(id)sender {
    [self performSegueWithIdentifier:@"settingSegue" sender:nil];
}


- (IBAction)allProbesAction:(UIButton *)sender {
    [self performSegueWithIdentifier:@"allProbesSegue" sender:nil];
    
}

@end
