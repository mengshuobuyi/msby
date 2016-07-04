//
//  PurchaseHeaderView.h
//  APP
//
//  Created by qw_imac on 15/11/9.
//  Copyright © 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum purchaseStatusType{            //抢购是否开始
    PurchaseStatusNotBegin = 1,
    PurchaseStatusBegin,
    PurchaseStatusEnd,
}PurchaseStatusType;

@interface PurchaseHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *backgroudImage;
@property (weak, nonatomic) IBOutlet UILabel *purchaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayTime;
@property (weak, nonatomic) IBOutlet UILabel *hourTime;
@property (weak, nonatomic) IBOutlet UILabel *minuteTime;
@property (weak, nonatomic) IBOutlet UILabel *secTime;


+ (PurchaseHeaderView *)instancePurchaseHeaderView;
- (void)setupPurchaseHeaderView:(PurchaseStatusType)type WithTime:(long long)time;
- (void)updateUI:(long long)time;
@end
