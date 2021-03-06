//
//  MedicinePromotionTableViewCell.m
//  APP
//
//  Created by 李坚 on 16/2/18.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "MedicinePromotionTableViewCell.h"


@implementation MedicinePromotionTableViewCell

+ (CGFloat)getCellHeight{
    
    return 44.0f;
}

- (void)setCell:(BranchProductPromotionVo *)VO{
    
    NSString *PImage;
    NSString *PTitle;
    
    //3.0 --> 1.买赠 2.折扣 3.立减 4.特价 5.抢购 6.礼品
    //3.1 --> 999.套餐 888.换购
    
    switch ([VO.type intValue]) {
        case 5:{
            PImage = @"iocn_rob_shoppingsmall";
            PTitle = VO.rushTitle;
        }
            break;
        case 999:{
            PImage = @"iocn_cover_detailssmall";
            PTitle = VO.title;
        }
            break;
        case 888:{
            PImage = @"iocn_exchange_shoppingsmall";
            PTitle = VO.title;
        }
            break;
        default:{
            PImage = @"iocn_kindness_detailssmall";
            PTitle = VO.title;
            
        }
            break;
    }

    self.promotionImage.image = [UIImage imageNamed:PImage];
    self.promotionLabel.text = PTitle;
    [self layoutIfNeeded];
}


- (void)setComboVoCell:(CartComboVoModel *)VO{
    
    NSString *PImage;
    NSString *PTitle;

    PImage = @"iocn_cover_detailssmall";
    PTitle = VO.desc;

    
    self.promotionImage.image = [UIImage imageNamed:PImage];
    self.promotionLabel.text = PTitle;
    [self layoutIfNeeded];
}

- (void)awakeFromNib {
    // Initialization code
    self.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
