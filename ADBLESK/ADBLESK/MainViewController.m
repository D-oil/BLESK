//
//  ViewController.m
//  ADBLESK
//
//  Created by 董安东 on 2017/1/19.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "MainViewController.h"

//view
#import "ADSKMainViewNavItem.h"
#import "ADSKGaugeView.h"
#import "ADSKBottomView.h"
#import "ADSKBLEConnectionTabel.h"
//model
#import "ADSKProbeList.h"

//临时添加
#import "ADSKBLETableViewCell.h"

@interface MainViewController ()

//view
@property (weak, nonatomic) IBOutlet ADSKMainViewNavItem *navItem;
@property (weak, nonatomic) IBOutlet ADSKGaugeView *gaugeView;
@property (weak, nonatomic) IBOutlet ADSKBottomView *bottomView;
@property (weak, nonatomic) IBOutlet ADSKBLEConnectionTabel *connectionTabel;


@property (weak, nonatomic) IBOutlet UIButton *allProbesButton;
@property (weak, nonatomic) IBOutlet UIButton *recipeAddionButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

//model
@property (nonatomic,strong) ADSKProbeList *probelist;
@property (nonatomic,strong) ADSKProbe *currentProbe;

//test
@property (nonatomic,strong) ADSKBLETableViewCell *willDisConnectedCell;

@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    AppDelegate *shareDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (shareDelegate.symbol == temperatureSymbolF) {
        [self.gaugeView changeToTemSymbol:temperatureSymbolF];
    } else {
        [self.gaugeView changeToTemSymbol:temperatureSymbolC];
    }
    
}

- (IBAction)ItemNumButtonAction:(ADSKNavItemButton *)sender {
    self.currentProbe = self.probelist.probes[sender.tag];
    [self updateUIWithProbe:self.currentProbe];
    [self updateBottomViewWithProbe:self.currentProbe];
    [self.navItem selectedNumButton:sender];
}

- (void)selectedNumButton:(UIButton *)button
{
    NSInteger selectedTag = button.tag;
    NSMutableArray *buttonArray =[@[self.navItem.oneButton,self.navItem.twoButton,self.navItem.threeButton,self.navItem.fourButton] mutableCopy];
    
    for (UIButton *sender in buttonArray) {
        if (sender.tag != selectedTag) {
            
        }
    }
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Add allNotificationCenter Observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(probeNotification:) name:kConnectionChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(probeNotification:) name:kBatteryLowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(probeNotification:) name:kFoodTypeChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(probeNotification:) name:kFoodDegreeChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(probeNotification:) name:ktargetTemperatureNotification object:nil];
    //初始化所有model
    self.probelist = [[ADSKProbeList alloc] init];
    //默认选择第一个探针model
    [self ItemNumButtonAction:self.navItem.oneButton];    
}


- (void)updateUIWithProbe:(ADSKProbe *)probe
{
        //当前探针已连接
    if (probe.isConnected) {
        [self.gaugeView initGaugeView];
        [self.navItem setItemConnected:YES];
        [self.recipeAddionButton setUserInteractionEnabled:YES];
        [self.bottomView setHidden:NO];
        [self.startButton setHidden:NO];
        [self.allProbesButton setEnabled:YES];
    } else { //探针未连接
        [self.gaugeView disConnectionModel];
        [self.navItem setItemConnected:NO];
        [self.recipeAddionButton setUserInteractionEnabled:NO];
        [self.bottomView setHidden:YES];
        [self.startButton setHidden:YES];
        [self.allProbesButton setEnabled:NO];
    }
}

- (void)updateBottomViewWithProbe:(ADSKProbe *)probe
{
    NSString *foodTypeStr = [ADSKProbe getStringFromFoodType:self.currentProbe.foodType];
    NSString *foodTypeImageStr = [NSString stringWithFormat:@"%@状态图标",foodTypeStr];
    NSString *cookDegreeStr = [ADSKProbe getStringFromFoodDegree:self.currentProbe.foodDegree];
    [self.bottomView setfoodImageStr:foodTypeImageStr foodType:foodTypeStr cookDegreeStr:cookDegreeStr];
    
    AppDelegate *shareDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *tagTemStr;
    if (self.currentProbe.targetTem != -1) {
        if (shareDelegate.symbol == temperatureSymbolF) {
           tagTemStr = [NSString stringWithFormat:@"%d℉",(int)(self.currentProbe.targetTem *1.8) +32];
        } else {
            tagTemStr = [NSString stringWithFormat:@"%ld℃",self.currentProbe.targetTem];
        }
    } else {
        tagTemStr = @"-1";
    }
    [self.bottomView setTagTemLabelText:tagTemStr];
}

- (void)updateGaugeViewWithProbe:(ADSKProbe *)probe
{
    float targerTem = (float)probe.targetTem;
    
    [self.gaugeView.gauge setTagTmpValue:targerTem animated:YES duration:1.0 completion:nil];
//    [self.gaugeView.gauge setValue:targerTem animated:YES];
//    [self.gaugeView.gauge setfoodTmpValue:targerTem -10.0 animated:YES duration:1.0 completion:nil];

}

- (void)probeNotification:(NSNotification *)noti
{
    //这里判断当前选择的对象和接受到通知的对象是否是同一个对象，是，处理通知，非，不处理通知
    if ([noti.object isEqual:self.currentProbe]) {
        if ([noti.name isEqualToString:kConnectionChangeNotification]) {
            [self updateUIWithProbe:noti.object];
        } else if ([noti.name isEqualToString:kBatteryLowNotification]) {
            [self.gaugeView LowBatteryModelOpen:YES];
        } else if ([noti.name isEqualToString:kFoodTypeChangeNotification]
                   || [noti.name isEqualToString:kFoodDegreeChangeNotification]
                   || [noti.name isEqualToString:ktargetTemperatureNotification])
        {
            [self updateBottomViewWithProbe:self.currentProbe];
            [self updateGaugeViewWithProbe:self.currentProbe];
        }
    } else {
        
    }
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"recipeSegue"]) {
        id recipeVC = [segue destinationViewController];
        [recipeVC setValue:self.currentProbe forKey:@"probe"];
    }
}

- (IBAction)BLEAction:(UIButton *)sender {
    [UIView animateWithDuration:1 animations:^{
        [self.connectionTabel setAlpha:1];
    }];
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

//tableView部分，先这样写，以后优化

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ADSKBLETableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BLECell"];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selsct row at %ld",indexPath.row);
    ADSKBLETableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    
    if (cell.isConnected){ //条件：且点击了已选择的cell
        //点击了已连接的cell
        
        [self.connectionTabel showDisconnectViewWith:cell.nameLabel.text];
        self.willDisConnectedCell = cell;
        
    }
    //当前选择设备未连接
    else if (!self.currentProbe.isConnected) {
    
            NSArray *imageStrs = @[@"通道1标志",@"通道2标志",@"通道3标志",@"通道4标志"];
            //如果蓝牙连接成功，走成功流程
            //
            NSUInteger ID = self.currentProbe.ID;
            
            [cell cellConnected:YES withSelectedImageStr:imageStrs[ID] WithIndex:ID];
            
            [self.probelist setProbeConnectedWithIndex:ID];
            
            [self.connectionTabel setTitleWithConnectedNum:[self.probelist getNumofConnectedProbe]];
            
        [self.navItem numButtonStateChange:numButtonTypeSelected_Connected numButton:self.navItem.buttonArray[ID]];

    }

}

- (IBAction)tableViewBackButtonAction:(UIButton *)button
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.connectionTabel setAlpha:0];
    }];
}

- (IBAction)messageViewButtonAction:(UIButton *)sender {
    
    //点击确认断开链接
    if (sender.tag) {
        
        [self.navItem numButtonStateChange:numButtonTypeSelected_Disconnected numButton:self.navItem.buttonArray[self.willDisConnectedCell.index]];
        
        [self.probelist setProbeDisconnectedWithIndex:self.willDisConnectedCell.index];
        
        [self.willDisConnectedCell cellConnected:NO withSelectedImageStr:nil WithIndex:0];
        
        [self.connectionTabel setTitleWithConnectedNum:[self.probelist getNumofConnectedProbe]];
        
    }
    
    [self.connectionTabel hideDisconnectView];
}


@end
