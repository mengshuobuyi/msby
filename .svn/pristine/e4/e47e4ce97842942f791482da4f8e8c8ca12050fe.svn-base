//
//  CouponPromotionTableViewCell.h
//  APP
//
//  Created by 李坚 on 15/8/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseCell.h"
#import "ActivityModel.h"

@interface MutableMorePromotionTableViewCell : QWBaseCell

@property (weak, nonatomic) IBOutlet UIImageView *doteline;

@property (weak, nonatomic) IBOutlet UIImageView *ImagUrl;
@property (weak, nonatomic) IBOutlet UILabel *proName;
@property (weak, nonatomic) IBOutlet UILabel *spec;

@property (weak, nonatomic) IBOutlet UIImageView *discount;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;

@property (weak, nonatomic) IBOutlet UIImageView *gift;
@property (weak, nonatomic) IBOutlet UILabel *giftLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityCountLabel;

@property (nonatomic,strong)  NSIndexPath *selectedCell;

+ (CGFloat)getMallBranchHeight:(ChannelProductVo *)data;

- (void)setupCell:(id)data;


@end
