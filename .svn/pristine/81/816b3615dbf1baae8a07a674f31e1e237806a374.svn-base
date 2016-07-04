//
//  CouponDrugListViewController.h
//  APP
//
//  Created by 李坚 on 15/8/23.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseVC.h"

typedef enum  CouponQuanType {
    Enum_CouponQuan_HasPicked = 0,                   //已领取
    Enum_CouponQuan_HasUsed = 1,                     //已使用
    Enum_CouponQuan_HasOverdDate = 2,                //已过期
}Quan_Type;

@interface MyCouponDrugListViewController : QWBaseVC

@property (strong, nonatomic) UINavigationController *navigationController;
@property (assign, nonatomic) Quan_Type type;

- (void)restData;
- (void)loadCouponDrugData;

@end
