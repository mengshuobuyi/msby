//
//  RedemptionCartTableViewCell.m
//  APP
//
//  Created by garfield on 16/3/24.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "RedemptionCartTableViewCell.h"
#import "MallCartModel.h"
#import "UIImageView+WebCache.h"


@implementation RedemptionCartTableViewCell

+ (CGFloat)getCellHeight:(id)data
{
    return 109.0f;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.productNum.layer.borderWidth = 1.0;
    self.productNum.layer.borderColor = RGB(210, 210, 210).CGColor;

}

- (void)setCell:(id)data
{
    CartRedemptionVoModel *model = (CartRedemptionVoModel *)data;
    [_productImage setImageWithURL:[NSURL URLWithString:model.proImgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
    _productNameLabel.text = model.proName;
    _productPrice.text = [NSString stringWithFormat:@"￥%.2f",model.salePrice];
    _promotionLabel.text = [NSString stringWithFormat:@"订单满%.2f元,已减%.2f元",model.limitPrice,model.price - model.salePrice];
    _increaseButton.enabled = NO;
    _decreaseButton.enabled = NO;
    _increaseBigButton.enabled = NO;
    _decreaseBigButton.enabled = NO;
    [self.chooseButton setImage:[UIImage imageNamed:@"icon_shopping_selected"] forState:UIControlStateNormal];
}

@end
