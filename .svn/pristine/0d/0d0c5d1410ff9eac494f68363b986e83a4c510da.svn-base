//
//  VFourCouponQuanTableViewCell.m
//  APP
//
//  Created by 李坚 on 15/12/2.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "VFourCouponQuanTableViewCell.h"
#import "Constant.h"
#import "UIImageView+WebCache.h"
#import "QWGlobalManager.h"

@implementation VFourCouponQuanTableViewCell

+ (CGFloat)getCellHeight:(id)data{
    if(IS_IPHONE_6P||IS_IPHONE_6){
        return 118.0f*kAutoScale;
    }else{
        return 118.0f;
    }
    
}

- (void)awakeFromNib {
    [self setupUI];
    self.array=[NSMutableArray array];
    [self changeCon:self.leftView];
    [self changeCon:self.middleView];
    [self changeCon:self.rightView];
    self.giftImage.layer.masksToBounds = YES;
    self.couponValue.adjustsFontSizeToFitWidth = YES;
}

-(void)changeCon:(UIView *)view{
    
    if(![self.array containsObject:view]){
        
        //宽度的约束放大
        if(IS_IPHONE_6P||IS_IPHONE_6){
            NSArray* constrainsPositive = view.constraints;
            for (NSLayoutConstraint* constraint in constrainsPositive) {
                constraint.constant = constraint.constant*kAutoScale;
            }
            [self.array addObject:view];
        }
        
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


#pragma mark - 我的优惠券列表模块CellForRow调用
- (void)setMyCouponQuan:(MyCouponVoModel *)model{
    //右边的标签
    self.couponType.text = model.tag;
    //左边的券使用条件
    self.couponTag.text = model.couponTag;
    self.dateLabel.text = [NSString stringWithFormat:@"%@ - %@",model.begin,model.end];

    if(model.couponRemark.length>10) {
        self.couponBranch.text = [model.couponRemark substringToIndex:10];
    } else {
        self.couponBranch.text = model.couponRemark;
    }
    if([model.scope intValue]==7 ||[model.scope intValue]==8){
     [self setupCouponQuanScopeUI:[model.scope intValue] andCouponValue:model.priceInfo andImageUrl:model.giftImgUrl];
    }else{
     [self setupCouponQuanScopeUI:[model.scope intValue] andCouponValue:model.couponValue andImageUrl:model.giftImgUrl];
    }
   
    [self.contentView layoutIfNeeded];
    self.statusImage.hidden = NO;
    //判断优惠券状态
    switch ([model.status intValue]) {
        case 0://待开始
        {
            self.statusImage.image = nil;
        }
            break;
        case 1://已领取
        {
            self.statusImage.image = nil;
        }
            break;
        case 2://快过期
        {
            self.statusImage.image = FastExpired;
        }
            break;
        case 3://已使用  
        {
            self.statusImage.image = nil;
        }
            break;
        case 4://已过期
        {
            self.statusImage.image = Expired;
        }
            break;
        default:
        {
            self.statusImage.image = nil;
        }
            break;
    }
}

#pragma mark - //我的优惠券详情调用
- (void)setMyCouponDetailQuan:(MyCouponDetailVo *)model{
    //右边的标签
    self.couponType.text = model.tag;
    //左边的券使用条件
    self.couponTag.text = model.couponTag;
    
    if([model.status intValue] == 3){//还有使用了才有消费时间
        self.dateLabel.text = [NSString stringWithFormat:@"消费时间:%@",model.use];
    }else{
        self.dateLabel.text = [NSString stringWithFormat:@"%@ - %@",model.begin,model.end];
    }
    
    if(model.couponRemark.length>10) {
        self.couponBranch.text = [model.couponRemark substringToIndex:10];
    } else {
        self.couponBranch.text = model.couponRemark;
    }
    if([model.scope intValue]==7 ||[model.scope intValue]==8){
        [self setupCouponQuanScopeUI:[model.scope intValue] andCouponValue:model.priceInfo andImageUrl:model.giftImgUrl];
    }else{
        [self setupCouponQuanScopeUI:[model.scope intValue] andCouponValue:model.couponValue andImageUrl:model.giftImgUrl];
    }
    
    [self.contentView layoutIfNeeded];
    self.statusImage.hidden = YES;
    
}

#pragma mark - 领券中心优惠券详情调用
- (void)setTicketCouponQuan:(OnlineCouponDetailVo *)model{
    
    if(model.top){
        self.TicketRightImage.image = [UIImage imageNamed:@"ticket_right_yellow"];
        self.TicketLeftImage.image = [UIImage imageNamed:@"ticket_left_yellow"];
    }else{
        self.TicketRightImage.image = [UIImage imageNamed:@"ticket_right"];
        self.TicketLeftImage.image = [UIImage imageNamed:@"ticket_left"];
    }
    //右边的标签
    self.couponType.text = model.tag;
    self.couponTag.text = model.couponTag;
    self.dateLabel.text = [NSString stringWithFormat:@"%@ - %@",model.begin,model.end];
    
    if(model.couponRemark.length>10) {
        self.couponBranch.text = [model.couponRemark substringToIndex:10];
    } else {
        self.couponBranch.text = model.couponRemark;
    }
    //判断优惠类型
    if([model.scope intValue]==7 || [model.scope intValue]==8){
        [self setupCouponQuanScopeUI:[model.scope intValue] andCouponValue:model.priceInfo andImageUrl:model.giftImgUrl];
    }else{
        [self setupCouponQuanScopeUI:[model.scope intValue] andCouponValue:model.couponValue andImageUrl:model.giftImgUrl];
    }
    [self.contentView layoutIfNeeded];
}

- (void)setCouponChooseQuan:(CartOnlineCouponVoModel *)model suppertOnline:(BOOL)suppertOnline
{
    
    if(model.onlySupportOnlineTrading && !suppertOnline){
        self.TicketRightImage.image = [UIImage imageNamed:@"ticket_right_gray"];
        self.TicketLeftImage.image = [UIImage imageNamed:@"ticket_left_gray"];
        self.userInteractionEnabled = NO;
    }else{
        self.TicketRightImage.image = [UIImage imageNamed:@"ticket_right"];
        self.TicketLeftImage.image = [UIImage imageNamed:@"ticket_left"];
        self.userInteractionEnabled = YES;
    }
    
    
    //右边的标签
    self.couponType.text = model.tag;
    self.couponTag.text = model.couponTag;
    self.dateLabel.text = [NSString stringWithFormat:@"%@ - %@",model.begin,model.end];
    //药房的备注
    if(model.couponRemark.length>10) {
        self.couponBranch.text = [model.couponRemark substringToIndex:10];
    } else {
        self.couponBranch.text = model.couponRemark;
    }
    
    if((int)model.scope==7 || (int)model.scope==8){
        [self setupCouponQuanScopeUI:(int)model.scope andCouponValue:model.priceInfo andImageUrl:model.giftImgUrl];
    }else{
        [self setupCouponQuanScopeUI:(int)model.scope andCouponValue:model.couponValue andImageUrl:model.giftImgUrl];
    }
    
    
    
    [self.contentView layoutIfNeeded];
    if(model.empty){
        self.statusImage.image = PickOver;
    }else{
        if(model.pick){
            //领取过加领取次数为0
            if(model.limitLeftCounts==0){
                self.statusImage.image = Picked;
            }else{
                self.statusImage.image = nil;
            }
        }else{
            self.statusImage.image = nil;
        }
    }
    
}



#pragma mark - 领券中心模块列表CellForRow调用列表
- (void)setCouponCenterQuan:(OnlineCouponVoModel *)model{
    
    if(model.top){
        self.TicketRightImage.image = [UIImage imageNamed:@"ticket_right_yellow"];
        self.TicketLeftImage.image = [UIImage imageNamed:@"ticket_left_yellow"];
    }else{
        self.TicketRightImage.image = [UIImage imageNamed:@"ticket_right"];
        self.TicketLeftImage.image = [UIImage imageNamed:@"ticket_left"];
    }
    
    
    //右边的标签
    self.couponType.text = model.tag;
    self.couponTag.text = model.couponTag;
    self.dateLabel.text = [NSString stringWithFormat:@"%@ - %@",model.begin,model.end];
    //药房的备注
    if(model.couponRemark.length>10) {
        self.couponBranch.text = [model.couponRemark substringToIndex:10];
    } else {
        self.couponBranch.text = model.couponRemark;
    }
    
    if((int)model.scope==7 || (int)model.scope==8){
          [self setupCouponQuanScopeUI:(int)model.scope andCouponValue:model.priceInfo andImageUrl:model.giftImgUrl];
    }else{
          [self setupCouponQuanScopeUI:(int)model.scope andCouponValue:model.couponValue andImageUrl:model.giftImgUrl];
    }
    
  
    
    [self.contentView layoutIfNeeded];
    if(model.empty){
        self.statusImage.image = PickOver;
    }else{
        if(model.pick){
            //领取过加领取次数为0
            if(model.limitLeftCounts==0){
                self.statusImage.image = Picked;
            }else{
                self.statusImage.image = nil;
            }
        }else{
            self.statusImage.image = nil;
        }
    }
    
    
    
}




#pragma mark - 根据优惠券类型构造UI，标注图上不同类型优惠券显示不同逻辑
- (void)setupCouponQuanScopeUI:(int)scope andCouponValue:(NSString *)value andImageUrl:(NSString *)giftImag{
    //1.通用代金券，2.慢病专享代金券，4.礼品券，5.商品券, 6.折扣券, 7.优惠商品券
    self.couponTag.hidden=NO;
    //如果后台配置图片
    if(!StrIsEmpty(giftImag)){
        if(IS_IPHONE_6P||IS_IPHONE_6){
            self.midTagConstant.constant = 12.0f*kAutoScale;
            self.leftTagConstant.constant = 25.0f*kAutoScale;
            self.leftButtomCon.constant = 29.0f*kAutoScale;
            self.leftTopCon.constant = 8.0f*kAutoScale;
        }else{
            self.midTagConstant.constant = 12.0f;
            self.leftTagConstant.constant = 25.0f;
            self.leftButtomCon.constant = 29.0f;
            self.leftTopCon.constant = 8.0f;
        }
        self.couponValue.hidden = YES;//右边的无图片的元被图片遮挡
        self.giftImage.hidden = NO;
        [self.giftImage setImageWithURL:[NSURL URLWithString:giftImag] placeholderImage:[UIImage imageNamed:@"img_bg_gift_ticket"]];
        if(scope==7||scope==8){//优惠商品券没有使用条件
            if(IS_IPHONE_6P||IS_IPHONE_6){
                self.leftButtomCon.constant = 17.0f*kAutoScale;
                self.leftTopCon.constant = 20.0f*kAutoScale;
            }else{
                self.leftButtomCon.constant = 17.0f;
                self.leftTopCon.constant = 20.0f;
            }
            self.couponPrice.text = value;
            self.couponTag.hidden=YES;
        }else{
            if(scope==6){
             self.couponPrice.text =  [NSString stringWithFormat:@"优惠%@折",value];
            }else{
             self.couponPrice.text =  [NSString stringWithFormat:@"价值%@元",value];
            }
        }

    }else{//没有图片
        if(IS_IPHONE_6P||IS_IPHONE_6){
            self.midTagConstant.constant = 22.0f*kAutoScale;
            self.leftTagConstant.constant = 6.0f*kAutoScale;
            self.leftButtomCon.constant = 29.0f*kAutoScale;
            self.leftTopCon.constant = 8.0f*kAutoScale;
        }else{
            self.midTagConstant.constant = 22.0f;
            self.leftTagConstant.constant = 6.0f;
            self.leftButtomCon.constant = 29.0f;
            self.leftTopCon.constant = 8.0f;
        }
        self.couponValue.hidden = NO;
        self.giftImage.hidden = YES;
        self.couponPrice.text = @"";//中间有图片的値在无图片的时候隐藏
        if(scope==6){
            self.couponValue.text = [NSString stringWithFormat:@"%@折",value];
        }else{
            if(scope==7||scope==8){
            self.couponValue.text = value;
            self.couponTag.hidden=YES;
            }else{
            self.couponValue.text = [NSString stringWithFormat:@"%@元",value];
            }
            
        }
       
    }

}






- (void)setupUI{
    
    if(IS_IPHONE_6P||IS_IPHONE_6){
        self.couponValue.font = fontSystem(kFontS8*kAutoScale);
        self.couponTag.font = fontSystem(kFontS4*kAutoScale);
        self.couponPrice.font = fontSystem(kFontS2*kAutoScale);
        self.couponBranch.font = fontSystem(kFontS4*kAutoScale);
        self.dateLabel.font = fontSystem(kFontS6*kAutoScale);
        self.couponType.font = fontSystem(kFontS5*kAutoScale);
        self.giftImage.layer.cornerRadius = 35.0f*kAutoScale;
    }else{
        self.couponValue.font = fontSystem(kFontS8);
        self.couponTag.font = fontSystem(kFontS4);
        self.couponPrice.font = fontSystem(kFontS2);
        self.couponBranch.font = fontSystem(kFontS4);
        self.dateLabel.font = fontSystem(kFontS6);
        self.couponType.font = fontSystem(kFontS5);
        self.giftImage.layer.cornerRadius = 35.0f;
    }
    
    self.couponValue.textColor = RGBHex(qwColor4);
    self.couponTag.textColor = RGBHex(qwColor4);
    self.couponPrice.textColor = RGBHex(qwColor13);
    self.couponBranch.textColor = RGBHex(qwColor8);
    self.dateLabel.textColor = RGBHex(qwColor8);
    self.couponType.textColor = RGBHex(qwColor4);
}
@end
