//
//  ProTableViewCell.m
//  APP
//
//  Created by qw_imac on 15/12/29.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "ProTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation setCellModel
+(setCellModel *)creatSetCellModel:(UserMicroMallOrderDetailVO *)vo {
    setCellModel *model = [setCellModel new];
    model.proImg = vo.imgUrl;
    model.proName = vo.proName?vo.proName:@"";
    model.price = vo.price?vo.price:@"";
    model.actTitle = vo.actTitle?vo.actTitle:@"";
    model.proAmount = vo.proAmount?vo.proAmount:@"";
    model.freeBieQty = vo.freeBieQty?vo.freeBieQty:@"";
    model.freeBieName = vo.freeBieName?vo.freeBieName:@"";
    model.spec = vo.spec?vo.spec:@"";
    model.actDesc = vo.actDesc?vo.actDesc:@"";
    return model;
}
@end
@implementation ProTableViewCell

- (void)awakeFromNib {
    self.giftView.layer.borderWidth = 1.0;
    self.giftView.layer.borderColor = RGBHex(qwColor10).CGColor;
    self.giftView.layer.masksToBounds = YES;
    self.giftView.layer.cornerRadius = 3.0f;
}
-(void)setCell:(setCellModel *)vo {
    [self.proImg setImageWithURL:[NSURL URLWithString:vo.proImg] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
    self.proName.text = vo.proName;
    self.spec.text = vo.spec;
    self.line.hidden = NO;
    switch (vo.type) {
        case CellTypeCombo:
            self.giftView.hidden = YES;
            self.comboView.hidden = YES;
            self.firstInfoView.hidden = YES;
            self.secInfoView.hidden = NO;
            self.line.hidden = YES;
            self.desLabel.text = [NSString stringWithFormat:@"￥%@ *%@",vo.price?vo.price:@"",vo.proAmount?vo.proAmount:@""];
            break;
        case CellTypeComboLast:
            self.giftView.hidden = YES;
            self.comboView.hidden = NO;
            self.firstInfoView.hidden = YES;
            self.secInfoView.hidden = NO;
            self.desLabel.text = [NSString stringWithFormat:@"￥%@ *%@",vo.price?vo.price:@"",vo.proAmount?vo.proAmount:@""];
            self.comboPrice.text = [NSString stringWithFormat:@"套餐价：￥%@",vo.comboPrice?vo.comboPrice:@""];
            self.comboCount.text = [NSString stringWithFormat:@"x%@",vo.comboCount?vo.comboCount:@""];
            break;
        case CellTypeNormal:
            self.comboView.hidden = YES;
            
            self.firstInfoView.hidden = NO;
            self.secInfoView.hidden = YES;
            self.proPrice.text = [NSString stringWithFormat:@"￥%@",vo.price?vo.price:@""];
            self.proNumber.text = [NSString stringWithFormat:@"X%@",vo.proAmount?vo.proAmount:@""];
            if ([vo.freeBieQty intValue] > 0) {
                self.giftView.hidden = NO;
                self.giftName.text = [NSString stringWithFormat:@" 【赠送】%@",vo.freeBieName];
                self.giftNumber.hidden = NO;
                self.giftNumber.text = [NSString stringWithFormat:@"X%@",vo.freeBieQty];
            }else {
                self.giftView .hidden = YES;
            }
            break;
        case CellTypeRedemption:
            self.comboView.hidden = YES;
            self.firstInfoView.hidden = NO;
            self.secInfoView.hidden = YES;
            self.proPrice.text = [NSString stringWithFormat:@"￥%@",vo.price?vo.price:@""];
            self.proNumber.text = [NSString stringWithFormat:@"X%@",vo.proAmount?vo.proAmount:@""];
            self.giftName.text = [NSString stringWithFormat:@" 【换购】%@",vo.actDesc];
            self.giftNumber.hidden = YES;
            break;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
