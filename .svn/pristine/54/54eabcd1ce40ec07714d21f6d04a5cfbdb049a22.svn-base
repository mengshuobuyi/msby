//
//  CouponPromotionTableViewCell.m
//  APP
//
//  Created by 李坚 on 15/8/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "MutableMorePromotionTableViewCell.h"
#import "ActivityModel.h"
#import "UIImageView+WebCache.h"
#import "Coupon.h"
@implementation MutableMorePromotionTableViewCell

+(CGFloat)getCellHeight:(id)data{
    CGFloat height=0.0f;
    ChannelProductVo *vo = (ChannelProductVo *)data;
    CGSize size =[GLOBALMANAGER sizeText:vo.proName font:fontSystem(kFontS1) limitWidth:APP_W-101];
    if(size.height>18){
        height=size.height/18*20-18;
    }
    if(vo.promotionList.count>1){
        return  91.0f+height+20;
    }else{
        return  91.0f+height;
    }
}


- (void)awakeFromNib {
   
    self.gift.layer.masksToBounds = YES;
    self.gift.layer.cornerRadius = 5.0f;
    self.discount.layer.masksToBounds = YES;
    self.discount.layer.cornerRadius = 5.0f;
}

-(void)setupCell:(id)data {
    ChannelProductVo *vo = (ChannelProductVo *)data;
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, [MutableMorePromotionTableViewCell getCellHeight:vo] - 0.5, APP_W, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [self addSubview:line];
    
    
    [self.ImagUrl setImageWithURL:[NSURL URLWithString:vo.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
    self.proName.text = vo.proName;
    self.spec.text = vo.spec;
    if(vo.promotionList.count==0){
        self.doteline.hidden=YES;
    }else{
        self.doteline.hidden=NO;
    }
    
    if (vo.promotionList.count < 3) {
        self.activityCountLabel.hidden = YES;
    }else {
        self.activityCountLabel.hidden = NO;
       self.activityCountLabel.text = [NSString stringWithFormat:@"%lu个活动",(unsigned long)vo.promotionList.count];
    }
    int k=vo.promotionList.count>2?2:vo.promotionList.count;
    for(int i=0;i<k;i++){
        ActivityCategoryVo *activity = vo.promotionList[i];
        NSArray *arrayImage=@[self.gift,self.discount];
        NSArray *array=@[self.giftLabel,self.discountLabel];
        
        [self setImageAndName:activity withLable:array[i] withImage:arrayImage[i]];
    }
    
}

-(void)setImageAndName:(ActivityCategoryVo *)activity withLable:(UILabel*)lableText withImage:(UIImageView*)imageText{
    
    switch ([activity.activityType intValue]) {
        case 1:
        {
            [imageText setImage:[UIImage imageNamed:@"img_label_gift"]];
            lableText.text=activity.actvityName;
             break;
        }
        case 2:
        {
            [imageText setImage:[UIImage imageNamed:@"img_label_fold"]];
            lableText.text=activity.actvityName;
             break;
        }
        case 3:
        {
            [imageText setImage:[UIImage imageNamed:@"img_label_forNow"]];
            lableText.text=activity.actvityName;
            break;
        }
        case 4:
        {
            [imageText setImage:[UIImage imageNamed:@"img_label_specialOffer"]];
            lableText.text=activity.actvityName;
            break;
        }
            break;
            
            
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
