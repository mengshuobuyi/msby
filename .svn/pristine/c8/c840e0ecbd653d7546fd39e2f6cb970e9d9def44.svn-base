//
//  ConfirmOrderTableViewCell.m
//  APP
//
//  Created by garfield on 16/1/4.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "ConfirmOrderTableViewCell.h"
#import "MallCart.h"
#import "UIImageView+WebCache.h"


@implementation ConfirmOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.giftLabel.layer.borderWidth = 1.0;
    self.giftLabel.layer.borderColor = RGBHex(qwColor10).CGColor;
    self.giftLabel.layer.masksToBounds = YES;
    self.giftLabel.layer.cornerRadius = 3.0f;
}

- (void)UIGlobal{
    [super UIGlobal];
    self.separatorLine.hidden = YES;
    
}

+ (CGFloat)getCellHeight:(id)data
{
    CGFloat height = 85.0f;
    CartProductVoModel *productModel = (CartProductVoModel *)data;
    if( productModel.promotions.count > 0 ) {
        CartPromotionVoModel *promotionModel = productModel.promotions[0];
        if(promotionModel.type == 1) {
            if(productModel.saleStock > promotionModel.unitNum) {
                if(productModel.quantity >= promotionModel.unitNum) {
                    height += 25+12;
                }
            }
        }
    }
    return height;
}

- (void)setCell:(id)data
{
    if([data isKindOfClass:[CartProductVoModel class]]) {
        CartProductVoModel *model = (CartProductVoModel *)data;
        [self.productImage setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
        self.productName.text = model.name;
        self.drugDes.text = model.spec;
        self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
        self.numLabel.text = [NSString stringWithFormat:@"×%d",model.quantity];
        if( model.promotions.count > 0 ) {
            CartPromotionVoModel *promotionModel = model.promotions[0];
            
            NSInteger presentNum = 0;
            if(model.quantity > (model.saleStock + model.stock)) {
                presentNum = floor(model.saleStock / promotionModel.unitNum);
            }else if (model.quantity > model.saleStock) {
                presentNum = floor(model.saleStock / promotionModel.unitNum);
            }else{
                presentNum = floor(model.quantity / promotionModel.unitNum);
            }
            if(promotionModel.type == 1) {
                presentNum = floor(model.quantity / promotionModel.unitNum) * promotionModel.presentNum;
            }
            if(promotionModel.type == 1) {
                _giftLabel.hidden = NO;
                _giftNumLabel.hidden = NO;
                self.giftLabel.text = [NSString stringWithFormat:@"  【赠送】%@",promotionModel.presentName];
                self.giftNumLabel.text = [NSString stringWithFormat:@"×%d",promotionModel.presentTotalNum];
                
            }else{
                _giftNumLabel.hidden = YES;
                _giftLabel.hidden = YES;
            }
        }
        self.combosPriceLabel.hidden = YES;
        self.comboNum.hidden = YES;
        self.line.hidden = NO;
    }else if([data isKindOfClass:[ComboProductVoModel class]]){
        _giftNumLabel.hidden = YES;
        _giftLabel.hidden = YES;
        self.line.hidden = NO;
        self.combosPriceLabel.hidden = NO;
        self.numLabel.hidden = YES;
        ComboProductVoModel *comboProductModel = (ComboProductVoModel *)data;
        self.productName.text = [NSString stringWithFormat:@"%@*%d",comboProductModel.name,comboProductModel.count];
        self.drugDes.text = comboProductModel.spec;
        self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f*%d",comboProductModel.price,comboProductModel.count];
        [self.productImage setImageWithURL:[NSURL URLWithString:comboProductModel.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
//        self.numLabel.text = [NSString stringWithFormat:@"×%d",comboProductModel.quantity];
        if(comboProductModel.showType == 3 || comboProductModel.showType == 4) {
            self.combosPriceLabel.hidden = NO;
            self.comboNum.hidden = NO;
            self.comboNum.text = [NSString stringWithFormat:@"×%d",comboProductModel.quantity];
            self.combosPriceLabel.text = [NSString stringWithFormat:@"套餐价: ￥%.2f",comboProductModel.combosPrice];
        }else{
            self.line.hidden = YES;
            self.combosPriceLabel.hidden = YES;
            self.comboNum.hidden = YES;
        }
    }else if ([data isKindOfClass:[CartRedemptionVoModel class]]) {
        self.line.hidden = NO;
        CartRedemptionVoModel *productModel = (CartRedemptionVoModel *)data;
        self.drugDes.text = productModel.proSpec;
        self.productName.text = [NSString stringWithFormat:@"%@*%d",productModel.proName,1];
        self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",productModel.price];
        [self.productImage setImageWithURL:[NSURL URLWithString:productModel.proImgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
        self.combosPriceLabel.hidden = YES;
        self.comboNum.hidden = YES;
        _giftNumLabel.hidden = YES;
        _giftLabel.hidden = NO;
         self.giftLabel.text = [NSString stringWithFormat:@" 【换购】%@",productModel.desc];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
