//
//  ADSKBLEConnectionTabel.h
//  ADBLESK
//
//  Created by 董安东 on 2017/2/7.
//  Copyright © 2017年 andong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ADSKBLEConnectionTabelDelegate <NSObject>

- (void)disConnectedProbesButtonAction:(UIButton *)sender;


@end

@interface ADSKBLEConnectionTabel : UIView

@property (nonatomic,weak)  id <ADSKBLEConnectionTabelDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIView *backGroundView;
@property (nonatomic,weak) IBOutlet UITableView *tableView;

@property (nonatomic,weak) IBOutlet UILabel  *numOfConnectedLabel;

@property (nonatomic,weak) IBOutlet UIView *disConnectView;
@property (nonatomic,weak) IBOutlet UILabel *disConnectMessageLabel;


- (void)setTitleWithConnectedNum:(NSUInteger) connectedNum;

- (void)showDisconnectViewWith:(NSString *)BLEName;

- (void)hideDisconnectView;

+ (NSArray *)getItemImageStrs;

@end
