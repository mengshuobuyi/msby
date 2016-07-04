//
//  CouponTicketDetailViewController.h
//  APP
//
//  Created by PerryChen on 11/10/15.
//  Copyright © 2015 carret. All rights reserved.
//

#import "QWBaseVC.h"
#import "Coupon.h"
typedef void (^CouponDetailSlowCallback)(BOOL success);
@interface CouponTicketDetailViewController : QWBaseVC

@property (nonatomic, strong) CouponDetailSlowCallback extCallback;

@property (nonatomic,strong) OnlineCouponVoModel *couponVoModel;

@property (nonatomic, strong) NSString *mktgId;

@property (nonatomic, strong) NSString *typeMall;//类型1.未开通微商 2.社会药房 3.微商药房
@property (nonatomic, strong) NSString *isComefrom;     // 1 领券中心  2 药房详情

// isShowPhars 是否展示适用药房   isShowDrugs 是否展示适用商品
- (void)setupCouponTicketDetailWithCouponId:(NSString *)couponID showSuitablePhar:(BOOL)isShowPhars;

@end
