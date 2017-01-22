//
//  ADSKProbes.h
//  ADBLESK
//
//  Created by 董安东 on 2017/1/21.
//  Copyright © 2017年 andong. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef NS_ENUM(NSUInteger, foodType) {
    foodType_Beef,      //🐂
    foodType_Veal,      //小🐂
    foodType_lamb,      //🐑
    foodType_Venison,   //🦌
    foodType_Pork,      //🐷
    foodType_Chicker,   //🐔
    foodType_Duck,      //鸭
    foodType_Fish,      //🐟
    foodType_Hamburger, //🍔
};
typedef NS_ENUM(NSUInteger, foodDegree) {
    foodDegree_Rare,
    foodDegree_MediumRare,
    foodDegree_Medium,
    foodDegree_MediumDone,
    foodDegree_WellDone,
    foodDegree_SlowDone
};


@interface ADSKProbes : NSObject

@property (nonatomic,strong) NSString *name;
//定义为摄氏度
@property (nonatomic,assign) NSUInteger targetTem;
@property (nonatomic,assign) NSUInteger grillTem;
@property (nonatomic,assign) NSUInteger foodTem;
@property (nonatomic,assign) NSUInteger batteryLevel;
//食物类型
@property (nonatomic,assign) foodType foodType;
//生熟程度
@property (nonatomic,assign) foodDegree foodDegree;

@end
