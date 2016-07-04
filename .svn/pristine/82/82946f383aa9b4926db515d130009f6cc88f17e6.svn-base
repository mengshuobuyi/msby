//
//  MoreConsultViewController.h
//  APP
//
//  Created by 李坚 on 15/8/24.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseVC.h"
#import "Coupon.h"

typedef enum{
    
    Enum_Consult_ComeFromUserCenterQuan = 0,     //从我的优惠券跳入
    Enum_Coupon_StoreList = 1,                   //直接传入数组展示

    Enum_Consult_ComeFromUserCenterPromotion = 2,//从我的活动商品跳入
    
}Consult_Type;

@interface MoreConsultViewController : QWBaseVC


@property (assign, nonatomic) Consult_Type *consultType;

//直接传入数组
@property (strong, nonatomic) NSMutableArray *dataArray;

//我的优惠活动跳入传入
@property (strong, nonatomic) NSString *pid;

//我的优惠券跳入传入
@property (strong, nonatomic) MyCouponDetailVoListModel *couponDetail;

@end
