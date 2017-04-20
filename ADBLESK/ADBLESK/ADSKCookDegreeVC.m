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
    [self.cookDegreeSelectView setTagTemperatureArrayWithTag:([self.tag intValue] +1) andTemperatureSymbol:shareDelegate.symbol];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageNameList = @[@"",@"Beef暗红",@"Veal暗红",@"Lamb暗红",@"Venison暗红",@"Pork暗红",@"Chicken暗红",@"Duck暗红",@"Fish暗红",@"Hamburger暗红"];
    self.foodNameList = @[@"",@"Beef",@"Veal",@"Lamb",@"Venison",@"Pork",@"Chicken",@"Duck",@"Fish",@"Hamburger"];
    
    
    [self loadImageWithTag:self.tag];

    AppDelegate *shareDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.cookDegreeSelectView setTagTemperatureArrayWithTag:([self.tag intValue] +1) andTemperatureSymbol:shareDelegate.symbol];

    //默认选项
    UIButton *button = [[UIButton alloc]init];
    NSInteger num = [self.tag integerValue];
    if (num == 0) {
        button.tag = 0;
    } else if (num == 2 || num == 3 ){
        button.tag = 1;
    } else if (num == 1 || num == 4) {
        button.tag = 2;
    } else {
        button.tag = 3;
    }
    [self cookDegreeItemAction:button];
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
    self.targetTem = self.selectedItem.tem;
    [self.currentTemLabel setText:self.selectedItem.temLabel.text];
    [self.currentDegreeLabel setText:self.selectedItem.rareLabel.text];
    
    [self.cookDegreeSelectView selectItemWithHighted:self.selectedItem];
    
}

- (IBAction)StartAction:(UIButton *)sender {
    
    foodDegree foodDegree = [ADSKProbe getFoodDegreeFromString:self.selectedItem.rareLabel.text];
    foodType foodType = [ADSKProbe getFoodTypeFromString:self.foodTypeLabel.text];
    
    [self.probe setTargetTem:self.targetTem];
    [self.probe setFoodType:foodType];
    [self.probe setFoodDegree:foodDegree];


    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
