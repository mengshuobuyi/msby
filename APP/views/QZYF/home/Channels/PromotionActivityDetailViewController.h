//
//  PromotionActivityDetailViewController.h
//  APP
//
//  Created by 李坚 on 15/8/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseVC.h"
#import "Promotion.h"

@interface PromotionActivityDetailViewController : QWBaseVC

@property (strong, nonatomic) ChannelProductVo *vo;

@property (strong, nonatomic) NSString *branchId;//药店的Id

@property (strong, nonatomic) NSString *sourceType;//来源是首页的优惠商品



@end
