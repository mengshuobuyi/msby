//
//  IndentCell.m
//  APP
//
//  Created by qw_imac on 15/12/29.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "IndentCell.h"
#import "UIImageView+WebCache.h"

@implementation IndentCell

- (void)awakeFromNib {
    self.consigneeBtn.layer.cornerRadius = 3.0;
    self.consigneeBtn.layer.borderWidth = 0.5;
    self.consigneeBtn.layer.borderColor = RGBHex(qwColor2).CGColor;
    [self.consigneeBtn setTitleColor:RGBHex(qwColor2) forState:UIControlStateNormal];
    self.consigneeBtn.layer.masksToBounds = YES;
    
    self.checkPostBtn.layer.cornerRadius = 3.0;
    self.checkPostBtn.layer.borderColor = RGBHex(qwColor7).CGColor;
    self.checkPostBtn.layer.borderWidth = 0.5;
    [self.checkPostBtn setTitleColor:RGBHex(qwColor7) forState:UIControlStateNormal];
    self.checkPostBtn.layer.masksToBounds = YES;
}
+(CGFloat)setHeight {
    return 210.0;
}

-(void)cellSetWith:(MicroMallOrderVO *)vo {
    [self.checkPostBtn removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [self.consigneeBtn removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    self.line.hidden = NO;
    self.storeNameLabel.text = vo.branchName;
    /**
     *  comment by perry
     *  Workaround for the bug that AFNetWoking framework will give the wrong decimals on 54.56
     *  Refrence on http://stackoverflow.com/questions/8581212/removing-characters-after-the-decimal-point-for-a-double
     */
    float finalAmount = [vo.finalAmount floatValue];
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterRoundFloor;
    [formatter setMaximumFractionDigits:2];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",[formatter stringFromNumber:[NSNumber numberWithFloat:finalAmount]]];
    self.height.constant = 42.0;
    switch ([vo.deliver intValue]) {
        case 1:
            self.postStyleLabel.text = @"到店取货";
            self.messageLabel.text = [NSString stringWithFormat:@"营业时间: %@-%@",vo.workStart,vo.workEnd];
            break;
        case 2:
            self.postStyleLabel.text = @"送货上门";
            self.messageLabel.text = [NSString stringWithFormat:@"营业时间: %@-%@",vo.deliverStart,vo.deliverEnd];
            break;
        case 3:
            self.postStyleLabel.text = @"同城快递";
            if (vo.deliverLast) {
                self.messageLabel.text = [NSString stringWithFormat:@"%@前下单,当天发货",vo.deliverLast];
            }else {
                self.messageLabel.text = @"";
            }
            break;
    }
    switch ([vo.orderStatus intValue]) {
        case 1:
            self.stateLabel.text = @"已提交";
            self.consigneeBtn.hidden = YES;
            self.checkPostBtn.hidden = NO;
            self.space.constant = 7.0;
            if ([vo.payType integerValue] == 2) {
                [self.checkPostBtn setTitle:@"申请取消" forState:UIControlStateNormal];
            }else {
                [self.checkPostBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            }
            break;
        case 2:
            self.stateLabel.text = @"待配送";
            self.consigneeBtn.hidden = YES;
            self.checkPostBtn.hidden = NO;
            self.space.constant = 7.0;
            if([vo.payType integerValue] == 1){
                [self.checkPostBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            }else {
                [self.checkPostBtn setTitle:@"申请取消" forState:UIControlStateNormal];
            }
            break;
        case 3:
            self.stateLabel.text = @"配送中";
            self.consigneeBtn.hidden = NO;
            if ([vo.deliver integerValue] == 3) {
                self.checkPostBtn.hidden = NO;
                [self.checkPostBtn setTitle:@"查看物流" forState:UIControlStateNormal];
            }else {
                self.checkPostBtn.hidden = YES;
            }
            self.space.constant = 94;
            [self.consigneeBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            break;
        case 6:
            self.stateLabel.text = @"待取货";
            self.consigneeBtn.hidden = NO;
            self.checkPostBtn.hidden = NO;
            self.space.constant = 94;
            [self.consigneeBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            if([vo.payType integerValue] == 1){
                [self.checkPostBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            }else {
                [self.checkPostBtn setTitle:@"申请取消" forState:UIControlStateNormal];
            }
            break;
        case 8:
            self.stateLabel.text = @"已取消";
            self.consigneeBtn.hidden = YES;
            self.checkPostBtn.hidden = NO;
            self.space.constant = 7.0;
            [self.checkPostBtn setTitle:@"删除订单" forState:UIControlStateNormal];
            break;
        case 9:
            self.stateLabel.text = @"已收货";
            if ([vo.appraiseStatus intValue] == 1) {//待评价
                self.space.constant = 94;
                self.consigneeBtn.hidden = NO;
                [self.consigneeBtn setTitle:@"我要评价" forState:UIControlStateNormal];
                if ([vo.deliver integerValue] == 3) {//送货方式为快递才能查看物流
                    self.checkPostBtn.hidden = NO;
                    [self.checkPostBtn setTitle:@"查看物流" forState:UIControlStateNormal];
                }else {
                    self.checkPostBtn.hidden = YES;
                }
            }else {                 //已评价
                self.consigneeBtn.hidden = YES;
                self.space.constant = 7.0;
                if ([vo.deliver integerValue] == 3) {//送货方式为快递才能查看物流
                    self.checkPostBtn.hidden = NO;
                    [self.checkPostBtn setTitle:@"查看物流" forState:UIControlStateNormal];
                }else {
                    self.checkPostBtn.hidden = YES;
                    self.line.hidden = YES;
                    self.height.constant = 0.0;
                }
            }
            
            break;
        case 10:
            self.stateLabel.text = @"待付款";
            self.consigneeBtn.hidden = NO;
            self.checkPostBtn.hidden = NO;
            self.space.constant = 94;
            [self.consigneeBtn setTitle:@"去付款" forState:UIControlStateNormal];
            [self.checkPostBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            break;
            default:
                self.consigneeBtn.hidden = YES;
                self.checkPostBtn.hidden = YES;
               // self.postStyleLabel.text = @"状态错误";
            break;
    }
    NSArray *imgList = vo.microMallOrderDetailVOs;
    switch (imgList.count) {
        case 0:
            self.firstDrugImg.hidden = YES;
            self.secondDrugImg.hidden = YES;
            self.thirdDrugImg.hidden = YES;
            self.lastDrugImg.hidden = YES;
            break;
        case 1:
            self.firstDrugImg.hidden = NO;
            self.secondDrugImg.hidden = YES;
            self.thirdDrugImg.hidden = YES;
            self.lastDrugImg.hidden = YES;
            break;
        case 2:
            self.firstDrugImg.hidden = NO;
            self.secondDrugImg.hidden = NO;
            self.thirdDrugImg.hidden = YES;
            self.lastDrugImg.hidden = YES;
            break;
        case 3:
            self.firstDrugImg.hidden = NO;
            self.secondDrugImg.hidden = NO;
            self.thirdDrugImg.hidden = NO;
            self.lastDrugImg.hidden = YES;
            break;
        default:
            self.firstDrugImg.hidden = NO;
            self.secondDrugImg.hidden = NO;
            self.thirdDrugImg.hidden = NO;
            self.lastDrugImg.hidden = NO;
            break;
    }
    NSArray *drugImgArray = @[self.firstDrugImg,self.secondDrugImg,self.thirdDrugImg,self.lastDrugImg];
    for (int i = 0; i < (imgList.count<4 ? imgList.count:4 ); i++) {
        MicroMallOrderDetailVO *orderVo = imgList[i];
        UIImageView *imgView = drugImgArray[i];
        [imgView setImageWithURL:[NSURL URLWithString:orderVo.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
