//
//  BranchPromotionTableViewCell.h
//  APP
//
//  Created by 李坚 on 16/5/11.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultStoreModel.h"

@interface BranchPromotionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *proImage;
@property (weak, nonatomic) IBOutlet UILabel *proNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *specLabel;
@property (weak, nonatomic) IBOutlet UILabel *promotionLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *promotionTagLabel;
@property (weak, nonatomic) IBOutlet UIView *promotionView;
@property (weak, nonatomic) IBOutlet UILabel *secondPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *secondPriceView;

+ (CGFloat)getCellHeight;

//优惠商品
- (void)setPromotionCell:(BranchProductVo *)data;
//换购
- (void)setRedemptionCell:(RedemptionVo *)data;
//药品分类二维数组
- (void)setCategoryCell:(BranchProductVo *)data;

@end
