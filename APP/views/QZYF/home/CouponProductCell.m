    //
//  CouponProductCell.m
//  APP
//
//  Created by garfield on 16/6/15.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "CouponProductCell.h"
#import "ConsultStoreModel.h"
#import "UIImageView+WebCache.h"


@implementation CouponProductCell

+ (CGFloat)getCellHeight:(id)data
{
    return 305.0f;
}

- (void)setOtherProductCell:(id)data
{
    CategoryVo *dataArray = (CategoryVo *)data;
    self.couponProductLabel.text = dataArray.categoryName;
    _containerSepator.constant = 7.5f;
    _container2Sepator.constant = 7.5f;
    self.couponOneLogo.hidden = YES;
    self.couponOneOriginPriceLabel.hidden = YES;
    self.couponTwoOriginPriceLabel.hidden = YES;
    if(dataArray.products.count >= 1) {
        BranchProductVo *model = dataArray.products[0];
        [self.couponOneImageView setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
        self.couponOneNameLabel.text = model.name;
        self.couponOneSpecLabel.text = model.spec;
        self.couponOneSalePriceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
        NSArray *promotions = model.promotions;
        if(promotions.count > 0) {
            BranchProductPromotionVo *promotion = promotions[0];
            switch ([promotion.showType integerValue]) {
                case 1:
                    self.couponOneLogo.image = [UIImage imageNamed:@"label_vouchers"];
                    break;
                case 2:
                    self.couponOneLogo.image = [UIImage imageNamed:@"iocn_kindness_detailssmall"];
                    break;
                case 3:
                    self.couponOneLogo.image = [UIImage imageNamed:@"iocn_rob_shoppingsmall"];
                    break;
                default:
                    break;
            }
        }
        self.buttonBackgroundOne.obj = model;
    }
    if(dataArray.products.count >= 2) {
        self.containerTwo.hidden = NO;
        BranchProductVo *model = dataArray.products[1];
        [self.couponTwoImageView setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
        self.couponTwoNameLabel.text = model.name;
        self.couponTwoSpecLabel.text = model.spec;
        self.couponTwoSalePriceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
        NSArray *promotions = model.promotions;
        if(promotions.count > 0) {
            BranchProductPromotionVo *promotion = promotions[0];
            switch ([promotion.showType integerValue]) {
                case 1:
                    self.couponTwoLogo.image = [UIImage imageNamed:@"label_vouchers"];
                    break;
                case 2:
                    self.couponTwoLogo.image = [UIImage imageNamed:@"iocn_kindness_detailssmall"];
                    break;
                case 3:
                    self.couponTwoLogo.image = [UIImage imageNamed:@"iocn_rob_shoppingsmall"];
                    break;
                default:
                    break;
            }
        }
        self.buttonBackgroundTwo.obj = model;
    }else{
        self.containerTwo.hidden = YES;
    }
}

- (void)setCouponProductCell:(id)data
{
    self.couponProductLabel.text = @"优惠商品";
    CategoryVo *dataArray = (CategoryVo *)data;
    self.couponOneOriginPriceLabel.hidden = NO;
    self.couponTwoOriginPriceLabel.hidden = NO;
    self.couponOneLogo.hidden = NO;
    _containerSepator.constant = 31.0f;
    _container2Sepator.constant = 31.0f;
    if(dataArray.products.count >= 1) {
        BranchProductVo *model = dataArray.products[0];
        [self.couponOneImageView setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
        self.couponOneNameLabel.text = model.name;
        self.couponOneSpecLabel.text = model.spec;
        self.couponOneSalePriceLabel.text = [NSString stringWithFormat:@"￥%@",model.salePrice];
        self.couponOneOriginPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
        
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:self.couponOneOriginPriceLabel.text];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, attri.length)];
        [attri addAttribute:NSStrikethroughColorAttributeName value:RGBHex(qwColor8) range:NSMakeRange(0, attri.length)];
        [self.couponOneOriginPriceLabel setAttributedText:attri];
        
        NSArray *promotions = model.promotions;
        if(promotions.count > 0) {
            BranchProductPromotionVo *promotion = promotions[0];
            switch ([promotion.showType integerValue]) {
                case 1:
                    self.couponOneLogo.image = [UIImage imageNamed:@"label_vouchers"];
                    break;
                case 2:
                    self.couponOneLogo.image = [UIImage imageNamed:@"label_hui"];
                    break;
                case 3:
                    self.couponOneLogo.image = [UIImage imageNamed:@"label_rob"];
                    break;
                default:
                    break;
            }
        }
        self.buttonBackgroundOne.obj = model;
    }
    if(dataArray.products.count >= 2) {
        self.containerTwo.hidden = NO;
        BranchProductVo *model = dataArray.products[1];
        [self.couponTwoImageView setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
        self.couponTwoNameLabel.text = model.name;
        self.couponTwoSpecLabel.text = model.spec;
        self.couponTwoSalePriceLabel.text = [NSString stringWithFormat:@"￥%@",model.salePrice];
        self.couponTwoOriginPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
        
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:self.couponTwoOriginPriceLabel.text];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, attri.length)];
        [attri addAttribute:NSStrikethroughColorAttributeName value:RGBHex(qwColor8) range:NSMakeRange(0, attri.length)];
        [self.couponTwoOriginPriceLabel setAttributedText:attri];
        
        NSArray *promotions = model.promotions;
        if(promotions.count > 0) {
            BranchProductPromotionVo *promotion = promotions[0];
            switch ([promotion.showType integerValue]) {
                case 1:
                    self.couponTwoLogo.image = [UIImage imageNamed:@"label_vouchers"];
                    break;
                case 2:
                    self.couponTwoLogo.image = [UIImage imageNamed:@"label_hui"];
                    break;
                case 3:
                    self.couponTwoLogo.image = [UIImage imageNamed:@"label_rob"];
                    break;
                default:
                    break;
            }
        }
        self.buttonBackgroundTwo.obj = model;
    }else{
        self.containerTwo.hidden = YES;
    }
}

@end