//
//  CenterCouponDetailViewController.h
//  APP
//
//  Created by PerryChen on 11/10/15.
//  Copyright © 2015 carret. All rights reserved.
//

#import "QWBaseVC.h"
#import "Coupon.h"
typedef void (^CouponDetailSlowCallback)(BOOL success);
@interface CenterCouponDetailViewController : QWBaseVC

@property (nonatomic, strong) CouponDetailSlowCallback extCallback;

@property (nonatomic, strong) NSString *mktgId;

@property (strong, nonatomic) NSString *couponId;//优惠券Id

@property (nonatomic,strong)OnlineCouponVoModel *centerModel;

@end
