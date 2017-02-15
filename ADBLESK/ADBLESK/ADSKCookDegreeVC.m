//
//  ADSKCookDegreeVC.m
//  ADBLESK
//
//  Created by 董安东 on 2017/1/22.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADSKCookDegreeVC.h"
#import "AppDelegate.h"

@interface ADSKCookDegreeVC ()

@property (nonatomic,strong) NSArray *imageNameList;
@property (nonatomic,strong) NSArray *foodNameList;
@property (nonatomic,strong) NSArray *TemperatureList;
@property (nonatomic,strong) ADSKCookDegreeSelectItem *selectedItem;

@property (weak, nonatomic) IBOutlet UIButton *foodTypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *foodTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentDegreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTemLabel;
@property (weak, nonatomic) IBOutlet UIButton *StartButton;

@property (nonatomic,assign)NSInteger targetTem;



@end



@implementation ADSKCookDegreeVC

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    AppDelegate *shareDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    if (shareDelegate.symbol == temperatureSymbolF) {
       [self.cookDegreeSelectView setSymbol:temperatureSymbolF];
    } else {
        [self.cookDegreeSelectView setSymbol:temperatureSymbolC];
    }
    //默认0
    [self cookDegreeItemAction:[[UIButton alloc]init]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageNameList = @[@"",@"Beef暗红",@"Veal暗红",@"Lamb暗红",@"Venison暗红",@"Pork暗红",@"Chicken暗红",@"Duck暗红",@"Fish暗红",@"Hamburger暗红"];
    self.foodNameList = @[@"",@"Beef",@"Veal",@"Lamb",@"Venison",@"Pork",@"Chicken",@"Duck",@"Fish",@"Hamburger"];
    self.TemperatureList = @[@52,@57,@62,@66,@70,@85];
    
    [self loadImageWithTag:self.tag];


}

- (void)loadImageWithTag:(NSNumber *)tag
{
    NSUInteger selectdTag = [tag intValue] +1;
    NSString *imageName = self.imageNameList[selectdTag];
    NSString *foodName = self.foodNameList[selectdTag];
    [self.foodTypeImageView setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.foodTypeLabel setText:foodName];
    
}

- (IBAction)cookDegreeItemAction:(UIButton *)sender {

    self.selectedItem = self.cookDegreeSelectView.itemArray[sender.tag];
    
    self.targetTem = [self.TemperatureList[sender.tag] integerValue];
    
    [self.currentTemLabel setText:self.selectedItem.temLabel.text];
    [self.currentDegreeLabel setText:self.selectedItem.rareLabel.text];
    
    [self.cookDegreeSelectView selectItemWithHighted:self.selectedItem];
    
}

- (IBAction)StartAction:(UIButton *)sender {
    
    foodDegree foodDegree = [ADSKProbe getFoodDegreeFromString:self.selectedItem.rareLabel.text];
    foodType foodType = [ADSKProbe getFoodTypeFromString:self.foodTypeLabel.text];
    [self.probe setFoodDegree:foodDegree];
    [self.probe setFoodType:foodType];
    [self.probe setTargetTem:self.targetTem];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
