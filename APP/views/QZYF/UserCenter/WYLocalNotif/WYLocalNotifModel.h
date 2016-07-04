//
//  WYLocalNotifModel.h
//  wenyao
//
//  Created by Yan Qingyang on 15/4/3.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "BaseModel.h"

@interface WYLocalNotifModel : BaseModel
@property (nonatomic) NSString *productId; //药品id
@property (nonatomic) NSString *productName; //药品名字
@property (nonatomic) NSString *productUser; //用药人

@property (nonatomic) NSString *drugCycle;//用药周期 每日，每2日。。。
@property (nonatomic) NSString *numCycle;//用药周期数字 1，2.。。

@property (nonatomic) NSString *beginDate;//开始时间
@property (nonatomic) NSString *remark;
@property (nonatomic) NSMutableArray *listTimes; //每天用药时间点 09:10 12:15 ...

@property (assign) BOOL clockEnabled;

@property (nonatomic) NSString *type; //通知类型
@property (nonatomic) NSString *hashValue;
@property (nonatomic) NSString *uid;
//暂时不需要
@property (nonatomic) NSString *drugTime; //每天次数
@property (nonatomic) NSString *perCount; //每次数量
@end
