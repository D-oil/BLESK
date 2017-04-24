//
//  ViewController.m
//  ADBLESK
//
//  Created by 董安东 on 2017/1/19.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"

//view
#import "ADSKMainViewNavItem.h"
#import "ADSKGaugeView.h"
#import "ADSKBottomView.h"
#import "ADSKBLEConnectionTabel.h"
#import "ADSKWarningView.h"
#import "ADSKStartButton.h"

#import "MBProgressHUD.h"
//model
#import "ADSKProbeList.h"

#import "LxxSoundPlay.h"


//临时添加
#import "ADSKBLETableViewCell.h"



@interface MainViewController () <BLEManagerDelegate,ADSKBLEConnectionTabelDelegate>

//view
@property (weak, nonatomic) IBOutlet ADSKMainViewNavItem *navItem;
@property (weak, nonatomic) IBOutlet ADSKGaugeView *gaugeView;
@property (weak, nonatomic) IBOutlet ADSKBottomView *bottomView;
@property (weak, nonatomic) IBOutlet ADSKBLEConnectionTabel *connectionTabel;

@property (weak, nonatomic) IBOutlet ADSKWarningView *warningView;


@property (weak, nonatomic) IBOutlet UIButton *allProbesButton;

@property (weak, nonatomic) IBOutlet UIButton *recipeAddionButton;
@property (weak, nonatomic) IBOutlet ADSKStartButton *startButton;

//model
@property (nonatomic,strong) ADSKProbeList *probelist;
@property (nonatomic,strong) ADSKProbe *currentProbe;
@property (nonatomic,strong) CBPeripheral *disconnectedPeripheral;
//ble
@property (nonatomic,strong)BLEManager *bleManager;
//扫描到的设备
@property (nonatomic,strong)NSMutableArray *AllCBPeripherals;

//播放声音和振动
@property (nonatomic,strong) LxxSoundPlay *soundPlay ;


//test
@property (nonatomic,strong) ADSKBLETableViewCell *willDisConnectedCell;

//test can delete
@property (nonatomic,assign) float tem;



@end

@implementation MainViewController

- (LxxSoundPlay *)soundPlay {
    if (_soundPlay == nil) {
        _soundPlay = [[LxxSoundPlay alloc] init];
    }
    return _soundPlay;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    AppDelegate *shareDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (shareDelegate.symbol == temperatureSymbolF) {
        [self.gaugeView setTemSymbol:temperatureSymbolF];
        
    } else {
        [self.gaugeView setTemSymbol:temperatureSymbolC];
    }
    
    [self updateUIWithGrillTemperature:self.currentProbe.grillTem];
    [self updateUIWithFoodTemperature:self.currentProbe.foodTem];
    [self updateUIWithTargetTemperature:self.currentProbe.targetTem];
    
    if (self.tag != -1) {
        [self ItemNumButtonAction:self.navItem.buttonArray [self.tag]];
    }
}




- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.bleManager = [[BLEManager alloc] init];
    self.bleManager.delegate = self;
    
    self.connectionTabel.tableView.delegate = self;
    self.connectionTabel.tableView.dataSource = self;
    self.connectionTabel.delegate = self;
    
    //Add allNotificationCenter Observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(probeNotification:) name:kConnectionChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(probeNotification:) name:kBatteryLowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(probeNotification:) name:kFoodTypeChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(probeNotification:) name:kFoodDegreeChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(probeNotification:) name:ktargetTemperatureNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(probeNotification:) name:kfoodTemperatureNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(probeNotification:) name:kgrillTemperatureNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(probeNotification:) name:ktimeChangedNotification object:nil];
    //warning
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(probeNotification:) name:kBBQfinishedWarningNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(probeNotification:) name:kgrillTemperatureWarningNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(probeNotification:) name:kfoodTemperatureWarningNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(probeNotification:) name:kBBQTimeOutWarningNotification object:nil];

    //初始化所有model
    self.probelist = [[ADSKProbeList alloc] init];
    //默认选择第一个探针model

    [self ItemNumButtonAction:self.navItem.oneButton];
    
    self.currentProbe.isConnected =YES;
//
//    ADSKProbe *pro = self.probelist.probes[1];
//    pro.isConnected = YES;
    //
    self.tag = -1;
    

    
//    self.currentProbe.time = 20;
    
//    [self.currentProbe startTimer];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.currentProbe.time = 30;
//    });
    
    

}
#pragma mark - updateUI
//更新
- (void)updateUIWithConnectionState:(BOOL)connectionState
{
        //当前探针已连接
    if (connectionState) {
        [self.gaugeView initGaugeView];
        [self.navItem setItemConnected:YES];
        [self.allProbesButton setEnabled:YES];
        [self.allProbesButton setBackgroundColor:[UIColor colorWithRed:46/255.0 green:25/255.0 blue:18/255 alpha:1]];
        [self.recipeAddionButton setUserInteractionEnabled:YES];
        
        [self.bottomView setHidden:NO];
        [self.startButton setHidden:NO];

    } else { //探针未连接
        [self.gaugeView disConnectionModel];
        [self.navItem setItemConnected:NO];
        [self.allProbesButton setEnabled:NO];
        [self.allProbesButton setBackgroundColor:[UIColor colorWithRed:108/255.0 green:101/255.0 blue:100/255 alpha:1]];
        [self.recipeAddionButton setUserInteractionEnabled:NO];
        [self.bottomView setHidden:YES];
        [self.startButton setHidden:YES];
    }
    [self.connectionTabel.tableView reloadData];
}

//更新目标温度，bottom and gaugeView
- (void)updateUIWithTargetTemperature:(NSInteger)TargetTemperature
{
    //设置tagTem
    NSString *tagTemStr;
    if (TargetTemperature != -1) {
        if ([AppDelegate sharedDelegate].symbol == temperatureSymbolF) {
            tagTemStr = [NSString stringWithFormat:@"%d℉",(int)(TargetTemperature *1.8) +32];
        } else {
            tagTemStr = [NSString stringWithFormat:@"%ld℃",TargetTemperature];
        }
    } else {
        tagTemStr = @"-1";
    }
    [self.bottomView setTagTemLabelText:tagTemStr];
    
    float targerTem = (float)TargetTemperature;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.gaugeView setTagTemperature:targerTem];
    });
}
//更新foodtype and fooddegree ， bottom
- (void)updateUIWithFoodType:(foodType)foodType foodDegree:(foodDegree)foodDegree
{
    NSString *foodTypeStr = [ADSKProbe getStringFromFoodType:foodType];
    NSString *foodTypeImageStr = [NSString stringWithFormat:@"%@状态图标",foodTypeStr];
    NSString *cookDegreeStr = [ADSKProbe getStringFromFoodDegree:foodDegree];
    [self.bottomView setfoodImageStr:foodTypeImageStr foodType:foodTypeStr cookDegreeStr:cookDegreeStr];
}
//更新食物温度UI， gaugeView
- (void)updateUIWithFoodTemperature:(float)foodTemperature
{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.gaugeView setCurrentTemperature:foodTemperature];
//    });
}
//更新烤炉温度，bottom and gaugeView
- (void)updateUIWithGrillTemperature:(float)grillTemperature
{
    NSString *grillTemStr;
    if (grillTemperature != -1) {
        if ([AppDelegate sharedDelegate].symbol == temperatureSymbolF) {
            grillTemStr = [NSString stringWithFormat:@"%d℉",(int)(grillTemperature *1.8) +32];
        } else {
            grillTemStr = [NSString stringWithFormat:@"%d℃",(int)grillTemperature];
        }
    } else {
        grillTemStr = @"-1";
    }
    [self.bottomView setGrillTemLabelText:grillTemStr];
    
    [self.gaugeView setgrillTemperature:grillTemperature];
}

- (void)updateStartButtonWith:(BOOL)isOpen
{
    if (isOpen) {
        [self.startButton setStopOrStart:NO];
    } else {
        [self.startButton setStopOrStart:YES];
    }
}

//处理所有Noti
- (void)probeNotification:(NSNotification *)noti
{
    //这里判断当前选择的对象和接受到通知的对象是否是同一个对象，是，处理通知，非，不处理通知
    if ([noti.object isEqual:self.currentProbe]) {
        if ([noti.name isEqualToString:kConnectionChangeNotification])
        {
            [self updateUIWithConnectionState:self.currentProbe.isConnected];
        }
        else if ([noti.name isEqualToString:kBatteryLowNotification])
        {
            [self.gaugeView LowBatteryModelOpen:YES];
        }
        else if ([noti.name isEqualToString:ktargetTemperatureNotification])
        {
            [self updateUIWithTargetTemperature:self.currentProbe.targetTem];
        }
        else if ([noti.name isEqualToString:kFoodDegreeChangeNotification])
        {
            [self updateUIWithFoodType:self.currentProbe.foodType foodDegree:self.currentProbe.foodDegree];
        }
        else if ([noti.name isEqualToString:kfoodTemperatureNotification])
        {
            [self updateUIWithFoodTemperature:self.currentProbe.foodTem];
        }
        else if ([noti.name isEqualToString:kgrillTemperatureNotification])
        {
            [self updateUIWithGrillTemperature:self.currentProbe.grillTem];
        }
        else if([noti.name isEqualToString:ktimeChangedNotification])
        {
            
            [self.gaugeView setTimeLabelWithTime:self.currentProbe.time];
            
            if (self.currentProbe.foodType == foodType_Timer && self.currentProbe.isTimerFire == NO) {
                
//                [self.currentProbe startRemainingTimeWithTime:self.currentProbe.time completion:^(BOOL finished) {
//                    if (finished) {
//                        
//                        [self.warningView warningViewHidden:NO withString:@"烧烤时间到"];
//                        [self startButtonAction:nil];
//                         [self.soundPlay startWarning];
//                        [self alertMessageWithIdentifier:@"timeOut" title:@"烧烤时间到" subTitle:@"" body:@"您的食物已经烤熟"];
//                        
//                    }
//                }];
                
            }
        } else if ([noti.name isEqualToString:kFoodTypeChangeNotification]) {
            //foodType的变化要作为页面返回开始变了烧烤的模式标志
            
            [self startButtonAction:nil];
            switch (self.currentProbe.foodType) {
                case foodType_Null:
                    break;
                case foodType_Beef:
                case foodType_Veal:
                case foodType_Lamb:
                case foodType_Venison:
                case foodType_Pork:
                case foodType_Chicker:
                case foodType_Duck:
                case foodType_Fish:
                case foodType_Hamburger:
                    break;
                case foodType_Tempareture:
                    break;
                case foodType_Timer:
                    break;
                
                
            }
        }
    }
    
    
    
    
    //这里要处理所有的报警事件
    if ([noti.name isEqualToString:kfoodTemperatureWarningNotification]){
        //处理当前探针的警告
        [self showWaningViewWithIdentifier:@"foodTemWarning" Title:@"食物高温报警" subTitle:nil body:nil];
        [self.gaugeView startFoodTemHighlightModel];
        
        
    } else if ([noti.name isEqualToString:kgrillTemperatureWarningNotification]){

        [self showWaningViewWithIdentifier:@"grillTemWarning" Title:@"炉温报警" subTitle:nil body:nil];
        [self.bottomView startGrillTemHighlightModel];
    } else if ([noti.name isEqualToString:kBBQfinishedWarningNotification]){
        
        [self showWaningViewWithIdentifier:@"bbqfinished" Title:@"烧烤时间到" subTitle:nil body:@"您的食物已经烤熟"];
        [self startButtonAction:nil];
        
    } else if ([noti.name isEqualToString:kBBQTimeOutWarningNotification]) {
        
        [self showWaningViewWithIdentifier:@"timeOut" Title:@"烧烤时间到" subTitle:nil body:@"您的食物已经烤熟"];
        [self startButtonAction:nil];
        
    }
    
     
}

- (void)showWaningViewWithIdentifier:(NSString *)identifier Title:(NSString *)message subTitle:(NSString *)subTitle  body:(NSString *)body {
    
    [self.warningView warningViewHidden:NO withString:message];
    [self.soundPlay startWarning];
    [self alertMessageWithIdentifier:identifier title:message subTitle:subTitle body:body];

}

- (IBAction)warningViewOKButtonAction:(UIButton *)sender {
    [self.gaugeView stopFoodTemHighlightModel];
    [self.bottomView stopGrillTemHighlightModel];
    [self.warningView warningViewHidden:YES withString:nil];
    [self.soundPlay stopWarning];
}


- (void)alertMessageWithIdentifier:(NSString *)identifier title:(NSString *)tltle subTitle:(NSString *)subTitle  body:(NSString *)body
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = tltle;
    content.subtitle = subTitle;
    content.body = body;
    content.badge = @0;
    content.sound = [UNNotificationSound defaultSound];
    
    //    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
    
    UNNotificationRequest *localNot = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:nil];
    [[UNUserNotificationCenter currentNotificationCenter]addNotificationRequest:localNot withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"本地推送完成！");
    }];
    
}


#pragma mark - All Action
- (IBAction)ItemNumButtonAction:(ADSKNavItemButton *)sender {
    
    if (self.connectionTabel.alpha || self.warningView.alpha) {
        return;
    }
    
    self.currentProbe = self.probelist.probes[sender.tag];
    [self updateUIWithTargetTemperature:self.currentProbe.targetTem];
    [self updateUIWithGrillTemperature:self.currentProbe.grillTem];
    [self updateUIWithFoodType:self.currentProbe.foodType foodDegree:self.currentProbe.foodDegree];
    [self updateUIWithFoodTemperature:self.currentProbe.foodTem];
    [self updateStartButtonWith:self.currentProbe.isOpen];
    [self.gaugeView setTimeLabelWithTime:self.currentProbe.time];
    [self updateUIWithConnectionState:self.currentProbe.isConnected];
    
    [self.navItem selectedNumButton:sender];
    
}

- (IBAction)BLEAction:(UIButton *)sender {
    
    if ( self.connectionTabel.alpha || self.warningView.alpha) {
        return;
    }
    
    //提示打开蓝牙开关
    if(self.bleManager.state != CBManagerStatePoweredOn){
        MBProgressHUD *openBLEHUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        // Set the text mode to show only text.
        openBLEHUD.mode = MBProgressHUDModeText;
        openBLEHUD.label.text = NSLocalizedString(@"Please_open_BLE", nil);
        // Move to bottm center.
        openBLEHUD.offset = CGPointMake(0.f, MBProgressMaxOffset);
        [openBLEHUD hideAnimated:YES afterDelay:3.f];
        return;
    }
    
    MBProgressHUD *scanHUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    scanHUD.label.text = NSLocalizedString(@"Bluetooth_scanning_Please_wait", nil);
   
    [self.bleManager startScanOnceWithDelay:3 withFinishedBlock:^(BOOL success, NSMutableArray <CBPeripheral *> *CBPeripherals) {

        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        
        self.AllCBPeripherals = CBPeripherals ;
        [self.connectionTabel.tableView reloadData];
        [UIView animateWithDuration:1 animations:^{
            [self.connectionTabel setAlpha:1];
//            [self.navigationController.view addSubview:self.connectionTabel];
            
        }];
    }];
}

- (IBAction)recipeButtonAction:(id)sender {
    if (self.currentProbe.isOpen == YES || self.connectionTabel.alpha || self.warningView.alpha) {
        return;
    }
    [self performSegueWithIdentifier:@"recipeSegue" sender:nil];
}

- (IBAction)settingsAction:(id)sender {
    [self performSegueWithIdentifier:@"settingSegue" sender:nil];
}

- (IBAction)allProbesAction:(UIButton *)sender {
    [self performSegueWithIdentifier:@"allProbesSegue" sender:nil];
}

- (IBAction)startButtonAction:(id)sender
{
    if ((self.currentProbe.foodType == foodType_Null && self.currentProbe.foodType != foodType_Timer) /*|| (self.currentProbe.foodTem >= self.currentProbe.targetTem && self.currentProbe.foodType != foodType_Timer) */ ) {
        return;
    }
    
    if (!self.currentProbe.isOpen) {  //
        
        if(self.currentProbe.foodType != foodType_Timer) {
            self.currentProbe.time = (self.currentProbe.targetTem - self.currentProbe.foodTem) *15;
        }
        
        self.currentProbe.lastCalculateFoodTem = self.currentProbe.foodTem;
        
        [self.currentProbe startTimer];
        [self.startButton setStopOrStart:NO];
        [self.recipeAddionButton setUserInteractionEnabled:NO];
        [self.navItem.tintButton setHighlighted:YES];
        [self.navItem.backgroundButton setUserInteractionEnabled:NO];
        self.currentProbe.isOpen = YES;
        
    } else {
        [self.currentProbe stopTimer];
        [self.startButton setStopOrStart:YES];
        self.currentProbe.isOpen = NO;
        [self.recipeAddionButton setUserInteractionEnabled:YES];
        [self.navItem.backgroundButton setUserInteractionEnabled:YES];
        [self.navItem.tintButton setHighlighted:NO];
        //如果是定时模式，要暂停定时
//        if(self.currentProbe.foodType == foodType_Timer) {
//            [self.currentProbe stopRemainingTime];
//            [self.gaugeView setTimeLabelWithTime:-1];
//        }
    
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"recipeSegue"]) {
        id recipeVC = [segue destinationViewController];
        [recipeVC setValue:self.currentProbe forKey:@"probe"];
    } else if ([segue.identifier isEqualToString:@"allProbesSegue"]) {
        id allprobesVC = [segue destinationViewController];
        [allprobesVC setValue:self.probelist forKey:@"probeList"];
        [allprobesVC setValue:self forKey:@"MainVC"];
    }
}
#pragma mark - BLEManager Delegate
- (void)peripheral:(CBPeripheral *)peripheral receiveInfoWithFoodTemperature:(NSInteger)foodTem grillTemperature:(NSInteger)grillTem timeInfo:(NSInteger)timeInfo
{
    NSLog(@"peripheral %@ receiveInfoWithTemperatureCharacteristic call",peripheral);
    for (ADSKProbe *probe in self.probelist.probes) {
        if ([probe.UUID isEqualToString:peripheral.identifier.UUIDString]) {
            //当前设备UUID与当前模型对应，复制数据
            
            probe.foodTem  = foodTem;
            probe.grillTem  = grillTem;

            if (probe.isOpen && probe.foodType != foodType_Timer) {
                if ((probe.foodTem - probe.lastCalculateFoodTem) >= 5 ) {
                    [probe calculateNewTime:probe.foodTem];
                } else {
                    probe.lastCalculateToNowTime = probe.lastCalculateToNowTime + timeInfo;
                    
                }
            }
        }
    }
//    if ([self.currentProbe.UUID isEqualToString:peripheral.identifier.UUIDString]) {
//        //当前设备UUID与当前模型对应，复制数据
//        self.tem = self.tem + 0.5;
//        self.currentProbe.foodTem  = self.tem;
//        self.currentProbe.grillTem  = 200;
//    }
    
}
- (void)peripheral:(CBPeripheral *)peripheral receiveInfoWithStatusCharacteristic:(NSString *)receiveInfo
{
    NSLog(@"peripheral %@ receiveInfoWithStatusCharacteristic call",peripheral);
}

//tableView部分，先这样写，以后优化
#pragma mark - tableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.AllCBPeripherals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ADSKBLETableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BLECell"];
    
//    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"ADSKBLETableViewCell" owner:nil options:nil];
        cell = [nibs lastObject];
//    }

    CBPeripheral *peripheral = self.AllCBPeripherals[indexPath.row];
    if (peripheral.state == CBPeripheralStateConnected) {
        for (ADSKProbe *probe in self.probelist.probes) {
            if ([probe.UUID isEqualToString:peripheral.identifier.UUIDString]) {
                 [cell cellConnected:YES withSelectedImageStr:[ADSKBLEConnectionTabel getItemImageStrs][probe.ID] WithIndex:probe.ID];
            }
        }
    }
    cell.nameLabel.text = peripheral.name;
    
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
        
        CBPeripheral *currentPeripheral = self.AllCBPeripherals[indexPath.row];
        [self.bleManager connectPeripheral:currentPeripheral withFinshedBlock:^(BOOL success, CBPeripheral *peripheral) {
            //如果蓝牙连接成功，走成功流程
            if (success) {
                self.currentProbe.peripheral = currentPeripheral;
               
                
                NSUInteger ID = self.currentProbe.ID;
                
                [self updateUIWithTargetTemperature:self.currentProbe.targetTem];
                [self updateUIWithGrillTemperature:self.currentProbe.grillTem];
                [self updateUIWithFoodType:self.currentProbe.foodType foodDegree:self.currentProbe.foodDegree];
                [self updateUIWithFoodTemperature:self.currentProbe.foodTem];
                [self updateStartButtonWith:self.currentProbe.isOpen];
                [self.gaugeView setTimeLabelWithTime:self.currentProbe.time];
                [self updateUIWithConnectionState:self.currentProbe.isConnected];
                
                [self.bleManager openPeripheral:currentPeripheral open:YES];
                
                self.currentProbe.UUID = currentPeripheral.identifier.UUIDString;
                
                [cell cellConnected:YES withSelectedImageStr:[ADSKBLEConnectionTabel getItemImageStrs][ID] WithIndex:ID];
                
                [self.probelist setProbeConnectedWithIndex:ID];
                
                [self.connectionTabel setTitleWithConnectedNum:[self.probelist getNumofConnectedProbe]];
                
                [self.navItem numButtonStateChange:numButtonTypeSelected_Connected numButton:self.navItem.buttonArray[ID]];
            } else {
                //失败
                NSLog(@"ble断开连接！");
                
                ADSKProbe *disconnectProbe = nil;
                for (ADSKProbe *probe in self.probelist.probes) {
                    if ([probe.UUID isEqualToString:peripheral.identifier.UUIDString]) {
                        disconnectProbe = probe;
                        disconnectProbe.isConnected = NO;
                        [disconnectProbe stopTimer];
                    }
                }
                //检测是否是当前的探针
                if ([self.currentProbe isEqual:disconnectProbe]) {
                    [self.navItem numButtonStateChange:numButtonTypeSelected_Disconnected numButton:self.navItem.buttonArray[disconnectProbe.ID]];
                    [self.probelist setProbeDisconnectedWithIndex:disconnectProbe.ID];
                 
                    
                    [self.AllCBPeripherals removeObject:disconnectProbe];
                } else {
                    [self.navItem numButtonStateChange:numButtonTypeNoSelected_Disconnected numButton:self.navItem.buttonArray[disconnectProbe.ID]];
                    [self.AllCBPeripherals removeObject:disconnectProbe];
        
                    
                }

                
                
            }
        }];


    }

}

- (void)disConnectedProbesButtonAction:(UIButton *)sender {
    [self messageViewButtonAction:sender];
}


- (void)messageViewButtonAction:(UIButton *)sender {
    
    //点击确认断开链接
    if (sender.tag) {
    
        CBPeripheral *disConnectedPeripheral = self.AllCBPeripherals[[self.connectionTabel.tableView indexPathForCell:self.willDisConnectedCell].row];
        [self.bleManager disconnectPeripheral:disConnectedPeripheral withFinshedBlock:^(BOOL success, CBPeripheral *CBPeripheral) {
            
//            self.currentProbe.peripheral = nil;
            [self.AllCBPeripherals removeObject:disConnectedPeripheral];
            
            [self.navItem numButtonStateChange:numButtonTypeSelected_Disconnected numButton:self.navItem.buttonArray[self.willDisConnectedCell.index]];
            
            [self.probelist setProbeDisconnectedWithIndex:self.willDisConnectedCell.index];
            
            [self.willDisConnectedCell cellConnected:NO withSelectedImageStr:nil WithIndex:0];
            
            [self.connectionTabel setTitleWithConnectedNum:[self.probelist getNumofConnectedProbe]];
            [self.connectionTabel.tableView reloadData];
            
        }];
    }
    
    [self.connectionTabel hideDisconnectView];
}


                 
@end
