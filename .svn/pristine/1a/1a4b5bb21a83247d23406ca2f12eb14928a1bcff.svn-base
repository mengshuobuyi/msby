//
//  ConsultCouponTableViewCell.m
//  APP
//
//  Created by 李坚 on 15/8/18.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "ConsultCouponTableViewCell.h"
#import "UIImageView+WebCache.h"

//已领取
#define Picked          [UIImage imageNamed:@"img_bg_receive_224"]
//已领完
#define PickOver        [UIImage imageNamed:@"img_bg_receiveover_224"]

@implementation ConsultCouponTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.mainScrollView.frame = CGRectMake(0, 0, APP_W, self.mainScrollView.frame.size.height);
    self.mainScrollView.backgroundColor = RGBHex(qwColor11);
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setScrollView:(NSArray *)array{
    
    if(array == nil || array.count == 0)
        return;
    
    float couponX = 5;
    dataArray = array;
    for(int i = 0;i < array.count;i ++){
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CouponView"owner:self options:nil];
        CouponView *view = [nib objectAtIndex:0];
        view.frame = CGRectMake(couponX, 0, 143, 77);
        view.tag = i;
        view.delegate = self;
        couponX += 143;
        pharmacyCouponQuan *quan = array[i];
        
        view.couponTag.text = quan.couponTag;
        
        view.couponValue.adjustsFontSizeToFitWidth = YES;
        
        view.couponMark.text = quan.tag;
        
        switch ([quan.scope intValue]) {
            case 1://普通券
            {
                view.couponValue.text = [NSString stringWithFormat:@"%@元",quan.couponValue];
                [view.giftImage removeFromSuperview];
            }
                break;
            case 2://慢病券
            {
                view.couponValue.text = [NSString stringWithFormat:@"%@元",quan.couponValue];
                [view.giftImage removeFromSuperview];
            }
                break;
            case 4://礼品券
            {
                view.couponValue.text = [NSString stringWithFormat:@"价值%@元",quan.couponValue];
                [view.giftImage setImageWithURL:[NSURL URLWithString:quan.giftImgUrl] placeholderImage:[UIImage imageNamed:@"img_bg_gift_ticket"]];
            }
                break;
            case 5://商品券
            {
                view.couponValue.text = [NSString stringWithFormat:@"%@元",quan.couponValue];
                [view.giftImage removeFromSuperview];
            }
                break;
            case 6://折扣券
            {
                view.couponValue.text = [NSString stringWithFormat:@"%@折",quan.couponValue];
                [view.giftImage removeFromSuperview];
            }
                break;
            case 7://优惠商品券
            {
//                view.couponValue.text = [NSString stringWithFormat:@"价值%@元",quan.couponValue];
                view.couponValue.text=quan.priceInfo;
                [view.giftImage setImageWithURL:[NSURL URLWithString:quan.giftImgUrl] placeholderImage:[UIImage imageNamed:@"img_bg_gift_ticket"]];
            }
                break;
            default:{
                view.couponValue.text = [NSString stringWithFormat:@"%@元",quan.couponValue];
                [view.giftImage removeFromSuperview];
            }
                break;
        }

        view.statusImage.image = nil;
        if([quan.pick intValue] == 1){//是否已领取
            view.statusImage.image = Picked;
        } else {
            if([quan.over intValue] == 1){//是否已领完
                view.statusImage.image = PickOver;
            }
        }
        
        [self.mainScrollView addSubview:view];
    }
    self.mainScrollView.contentSize = CGSizeMake(couponX + 15, 77);
    
}

- (BOOL)isValidateNumber:(NSString *)number {
    
    NSString *emailRegex = @"^[0-9]*[1-9][0-9]*$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:number];
    
}

- (void)didSelectedAtIndex:(NSInteger)index{
    
    if(self.delegate){
        [self.delegate didSelectedCouponView:dataArray[index]];
    }
}

@end
