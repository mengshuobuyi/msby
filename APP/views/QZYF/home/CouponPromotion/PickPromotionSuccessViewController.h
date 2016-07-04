//
//  PickPromotionSuccessViewController.h
//  APP
//
//  Created by 李坚 on 15/8/26.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseVC.h"
#import "Promotion.h"
typedef void (^PromotionCallback)(BOOL success);
@interface PickPromotionSuccessViewController : QWBaseVC

@property (nonatomic, strong) NSString *proDrugId;
@property (nonatomic, strong) PromotionCallback extCallback;
@end
