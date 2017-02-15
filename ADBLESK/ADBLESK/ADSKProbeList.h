//
//  ADSKProbeList.h
//  ADBLESK
//
//  Created by 董安东 on 2017/1/23.
//  Copyright © 2017年 andong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADSKProbe.h"

@interface ADSKProbeList : NSObject

@property (nonatomic,strong,readonly) NSMutableArray *probes;

- (void)setProbeConnectedWithIndex:(NSUInteger)index;

- (void)setProbeDisconnectedWithIndex:(NSUInteger)index;


//返回一个未连接设备的ID，如果全部连接了，返回0
- (NSInteger)getOneDisConnectedProbeID;
//获取已连接成功的设备的数量
- (NSUInteger)getNumofConnectedProbe;

@end
