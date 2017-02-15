//
//  ADSKRecipeVC.m
//  ADBLESK
//
//  Created by 董安东 on 2017/1/21.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADSKRecipeVC.h"

@interface ADSKRecipeVC ()

@end

@implementation ADSKRecipeVC

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{
    if ([segue.identifier isEqualToString:@"cookDegreeSegue"]) {
        id cookDegreeVC = [segue destinationViewController];
        [cookDegreeVC setValue:self.probe forKey:@"probe"];
        [cookDegreeVC setValue:[NSNumber numberWithInteger:sender.tag] forKey:@"tag"];
    } else if ([segue.identifier isEqualToString:@"TimerSegue"]){
        id timerVC = [segue destinationViewController];
        [timerVC setValue:self.probe forKey:@"probe"];
    } else if ([segue.identifier isEqualToString:@"TemperatureSegue"]){
        id temperature = [segue destinationViewController];
        [temperature setValue:self.probe forKey:@"probe"];
    }
}
- (IBAction)foodAction:(UIButton *)sender {
    [self performSegueWithIdentifier:@"cookDegreeSegue" sender:sender];
}
- (IBAction)timerAction:(UIButton *)sender {
    [self performSegueWithIdentifier:@"TimerSegue" sender:nil];
}
- (IBAction)TemperatureAction:(UIButton *)sender {
    [self performSegueWithIdentifier:@"TemperatureSegue" sender:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

@end
