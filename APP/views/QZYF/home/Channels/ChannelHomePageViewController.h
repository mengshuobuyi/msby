//
//  CouponPromotionHomePageViewController.h
//  APP
//
//  Created by 李坚 on 15/8/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseVC.h"

@interface ChannelHomePageViewController : QWBaseVC
@property (nonatomic,strong) NSString *channelId;
@property (nonatomic,strong) NSString *channelName;
@property (nonatomic,assign) NSInteger channelTag;
@end
