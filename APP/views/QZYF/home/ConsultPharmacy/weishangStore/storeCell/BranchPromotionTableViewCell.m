//
//  BranchPromotionTableViewCell.m
//  APP
//
//  Created by 李坚 on 16/5/11.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "BranchPromotionTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation BranchPromotionTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.promotionView.layer.masksToBounds = YES;
    self.promotionView.layer.cornerRadius = 2.5f;
    self.promotionView.layer.borderWidth = 0.5f;
    self.promotionView.layer.borderColor = RGBHex(qwColor3).CGColor;
    self.proImage.image = [UIImage imageNamed:@"药品默认图片"];
}

+ (CGFloat)getCellHeight{
    
    return 132.0f;
}

//优惠商品
- (void)setPromotionCell:(BranchProductVo *)data{
    
    self.proNameLabel.text = data.name;
    self.specLabel.text = data.spec;

    [self.proImage setImageWithURL:[NSURL URLWithString:data.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
    
    if(data.promotions.count > 0){
        self.promotionView.hidden = NO;
        BranchProductPromotionVo *VO = data.promotions[0];
        //showType 展示活动类型:1.券 2.惠 3.抢 (普通商品只会有这三种)
        switch ([VO.showType integerValue]) {
            case 1://1.券
                self.promotionTagLabel.text = @"券";
                break;
            case 2://2.惠
                self.promotionTagLabel.text = @"惠";
                break;
            case 3://3.抢
                self.promotionTagLabel.text = @"抢";
                break;
            default:
                break;
        }
        
        //如果是特价或抢购，则需显示原价和销售价格，并划掉原价
        //Add by lijian At V3.2.0
        if([VO.type intValue] == 4 || [VO.showType intValue] == 3){
            self.secondPriceLabel.hidden = NO;
            self.secondPriceView.hidden = NO;
            self.priceLabel.text = [NSString stringWithFormat:@"￥%@",data.salePrice];
            self.secondPriceLabel.text = [NSString stringWithFormat:@"￥%@",data.price];
        }else{
            self.secondPriceLabel.hidden = YES;
            self.secondPriceView.hidden = YES;
            self.priceLabel.text = [NSString stringWithFormat:@"￥%@",data.price];
        }
        
        self.promotionLabel.text = [NSString stringWithFormat:@" %@ ",VO.title];
        
        self.promotionLabel.textColor = RGBHex(qwColor3);
        self.promotionTagLabel.backgroundColor = RGBHex(qwColor3);
        self.promotionView.layer.borderColor = RGBHex(qwColor3).CGColor;
    }else{
        self.promotionView.hidden = YES;
    }
    
}

//换购
- (void)setRedemptionCell:(RedemptionVo *)data{
    
    self.proNameLabel.text = data.proName;
    self.specLabel.text = data.proSpec;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.1f",[data.salePrice doubleValue]];
    self.secondPriceLabel.hidden = NO;
    self.secondPriceView.hidden = NO;
    self.secondPriceLabel.text = [NSString stringWithFormat:@"￥%.1f",[data.price doubleValue]];
    [self.proImage setImageWithURL:[NSURL URLWithString:data.proImgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
    
    self.promotionView.hidden = NO;
    self.promotionTagLabel.text = @"换";
    self.promotionLabel.text = [NSString stringWithFormat:@" 订单满%.0f换购 ",[data.limitPrice  doubleValue]];
    self.promotionLabel.textColor = RGBHex(qwColor14);
    self.promotionTagLabel.backgroundColor = RGBHex(qwColor14);
    self.promotionView.layer.borderColor = RGBHex(qwColor14).CGColor;
}

//药品分类二维数组
- (void)setCategoryCell:(BranchProductVo *)data{
    
    self.proNameLabel.text = data.name;
    self.specLabel.text = data.spec;
    self.secondPriceLabel.hidden = YES;
    self.secondPriceView.hidden = YES;
    self.promotionView.hidden = YES;
    
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.1f",[data.price doubleValue]];
    [self.proImage setImageWithURL:[NSURL URLWithString:data.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
