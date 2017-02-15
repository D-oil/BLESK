//
//  ADSKProbeList.m
//  ADBLESK
//
//  Created by 董安东 on 2017/1/23.
//  Copyright © 2017年 andong. All rights reserved.
//

#import "ADSKProbeList.h"

@interface ADSKProbeList ()

@property (nonatomic,strong,readwrite) NSMutableArray *probes;

@end

@implementation ADSKProbeList

- (NSMutableArray *)createProbes {
    if (_probes == nil) {
        _probes = [NSMutableArray array];
        //初始化4个探针对象
        for (int index = 0; index < 4; index++) {
            ADSKProbe *probe = [[ADSKProbe alloc] init];
            probe.ID = index;
            probe.targetTem = -1;
            [_probes addObject:probe];
        }
    }
    return _probes;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createProbes];
    }
    return self;
}

- (void)setProbeConnectedWithIndex:(NSUInteger)index
{
    ADSKProbe *probe = self.probes[index];
    probe.isConnected = YES;
}

- (void)setProbeDisconnectedWithIndex:(NSUInteger)index
{
    ADSKProbe *probe = self.probes[index];
    probe.isConnected = NO;
}



- (NSInteger)getOneDisConnectedProbeID;
{
    
    for (ADSKProbe *probe in self.probes) {
        if (probe.isConnected == NO) {
            return probe.ID;
        }
    }
    //没有未连接的设备了就返回0
    return -1;
}
- (NSUInteger)getNumofConnectedProbe
{
    NSUInteger num = 0;
    for (ADSKProbe *probe in self.probes) {
        if (probe.isConnected == YES) {
            num++;
        }
    }
    return num;
}

@end
