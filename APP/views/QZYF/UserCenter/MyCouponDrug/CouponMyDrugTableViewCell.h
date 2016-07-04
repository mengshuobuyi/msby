//
// 
//  APP
//
//  Created by 李坚 on 15/8/23.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseCell.h"


@interface CouponMyDrugTableViewCell : QWBaseCell

@property (weak, nonatomic) IBOutlet UILabel *proName;
@property (weak, nonatomic) IBOutlet UIView *seperator;
@property (weak, nonatomic) IBOutlet UILabel *spec;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *expiredSoonImageView;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (assign, nonatomic) NSInteger drugStatus;//1表示已领取，2表示已使用，3表示已过期

+ (CGFloat)getCellHeight:(id)data;

- (void)setCell:(id)data;


@end
