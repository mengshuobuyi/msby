//
//  CouponPharmacyDeailViewController.h
//  APP
//
//  Created by 李坚 on 15/8/21.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseVC.h"
#import "ActivityModel.h"
#define GHeight 47.0
#define kSectionHeaderSpaceHeight 9.0


@interface CouponPharmacyDeailViewController : QWBaseVC

@property (strong, nonatomic) NSString *storeImgUrl;
@property (strong, nonatomic) NSString *storeId;//药店ID
@property (strong, nonatomic) NSString *activityId;//活动ID


@end
