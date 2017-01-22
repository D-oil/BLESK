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


- (IBAction)foodAction:(id)sender {
    [self performSegueWithIdentifier:@"cookDegreeSegue" sender:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
