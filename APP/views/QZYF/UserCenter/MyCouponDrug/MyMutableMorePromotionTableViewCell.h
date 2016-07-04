//
//  CouponPromotionTableViewCell.h
//  APP
//
//  Created by 李坚 on 15/8/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseCell.h"

//优惠券状态图片:
//已领取
#define Picked          [UIImage imageNamed:@"img_bg_receive_224"]
//快过期
#define FastExpired     [UIImage imageNamed:@"img_bg_fastexpired_224"]
//未评价
#define DisEvaluated    [UIImage imageNamed:@"img_bg_waitevaluate_224"]
//已评价
#define Evaluated       [UIImage imageNamed:@"img_bg_rated_224"]
//已过期
#define Expired         [UIImage imageNamed:@"img_bg_expired_224"]
//已领完
#define PickOver        [UIImage imageNamed:@"img_bg_receiveover_224"]

@protocol MyMutableMorePromotionTableViewCellDelegate <NSObject>

@required

- (void)didSepllCellAtIndexPath:(NSIndexPath *)path;

@end


@interface MyMutableMorePromotionTableViewCell : QWBaseCell{
    UIView *speratorLine;
}
@property (weak, nonatomic) IBOutlet UIView *promotionView;

@property (weak, nonatomic) IBOutlet UIImageView *statusImage;
@property (weak, nonatomic) IBOutlet UIButton *spellBtn;
@property (weak, nonatomic) IBOutlet UIImageView *spellImage;

@property (weak, nonatomic) IBOutlet UIImageView *doteline;

@property (weak, nonatomic) IBOutlet UIImageView *ImagUrl;
@property (weak, nonatomic) IBOutlet UILabel *proName;
@property (weak, nonatomic) IBOutlet UILabel *spec;
@property (weak, nonatomic) IBOutlet UILabel *activityCountLabel;

@property (nonatomic,strong)  NSIndexPath *selectedCell;

@property (nonatomic, assign) id<MyMutableMorePromotionTableViewCellDelegate>SpellDelegate;

- (void)setupCell:(id)data;

@end
