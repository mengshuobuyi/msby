//
//  SelectFlagModel.h
//  APP
//
//  Created by 李坚 on 15/12/30.
//  Copyright © 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum Enum_Transport{
    Enum_Default = 0,   //不限
    Enum_GetDoor = 1,   //送货上门
    Enum_SameCity = 2,  //同城快递
}TransportType;

@interface SelectFlagModel : NSObject

@property (nonatomic, assign) TransportType transportType;
@property (nonatomic, assign) BOOL transCostEnable;//配送费
@property (nonatomic, assign) BOOL startCostEnable;//起送价
@property (nonatomic, assign) BOOL couponEnable;//优惠活动

@end
