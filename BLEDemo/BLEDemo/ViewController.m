//
//  ViewController.m
//  BLEDemo
//
//  Created by 董安东 on 2017/2/15.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ViewController.h"
#import "BLEManager.h"

@interface ViewController ()

@property (nonatomic,strong)BLEManager *bleManager;
@property (nonatomic,strong)NSArray *CBPeripherals;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.bleManager = [[BLEManager alloc] init];
}
- (IBAction)scanAction:(UIButton *)sender {
    [self.bleManager startScanOnceWithDelay:2 withFinishedBlock:^(BOOL success, NSArray<CBPeripheral *> *CBPeripherals) {
        self.CBPeripherals = CBPeripherals;
        [self.tableView reloadData];
    }];
}

- (IBAction)disconnectAction:(id)sender {
    [self.bleManager disconnectPeripheral:[self.CBPeripherals firstObject] withFinshedBlock:^(BOOL success, CBPeripheral *CBPeripheral) {
        if (success) {
            NSLog(@"disconnected success!");
        } else {
            NSLog(@"disconnected fail!");
        }
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.CBPeripherals.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    CBPeripheral *peripheral = self.CBPeripherals[indexPath.row];
    
    cell.textLabel.text =  peripheral.name;
    cell.detailTextLabel.text = peripheral.identifier.UUIDString;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.bleManager connectPeripheral:self.CBPeripherals[indexPath.row] withFinshedBlock:^(BOOL success, CBPeripheral *CBPeripheral) {
        if (success) {
            NSLog(@"connected success!");
        } else {
            NSLog(@"connected fail!");
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
