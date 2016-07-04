//
//  CouponPromotionTableViewCell.m
//  APP
//
//  Created by 李坚 on 15/8/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "MutableActivityPromotionTableViewCell.h"
#import "ActivityModel.h"
#import "UIImageView+WebCache.h"
#import "Coupon.h"
@implementation MutableActivityPromotionTableViewCell

+ (CGFloat)getCellHeight:(id)data{
    CGFloat height=0.0f;
    ChannelProductVo *vo = (ChannelProductVo *)data;
    CGSize size =[GLOBALMANAGER sizeText:vo.proName font:fontSystem(kFontS1) limitWidth:APP_W-101];
    if(size.height>18){
        height=size.height/18*20-18;
    }
    if(vo.promotionList.count==2){
        return  91.0f+height+20;
    }else if(vo.promotionList.count==3){
        if(vo.isSelect){
            return  91.0f+height+40;
        }else{
            return  91.0f+height+20;
        }
    }else if(vo.promotionList.count==4){
        if(vo.isSelect){
            return  91.0f+height+60;
        }else{
            return  91.0f+height+20;
        }
    }else{
        return  91.0f+height;
    }
}

//+(float)getStoreCellHeight:(id)data{
//    CGFloat height=0.0f;
//    BranchPromotionProVO *vo = (BranchPromotionProVO *)data;
//    CGSize size =[GLOBALMANAGER sizeText:vo.proName font:fontSystem(kFontS1) limitWidth:APP_W-101];
//    if(size.height>18){
//        height=size.height/18*20-18;
//    }
//    if(vo.categorys.count==2){
//        return  91.0f+height+20;
//    }else if(vo.categorys.count==3){
//        if(vo.isSelect){
//            return  91.0f+height+40;
//        }else{
//            return  91.0f+height+20;
//        }
//    }else if(vo.categorys.count==4){
//        if(vo.isSelect){
//            return  91.0f+height+60;
//        }else{
//            return  91.0f+height+20;
//        }
//    }else{
//        return  91.0f+height;
//    }
//
//}

- (void)awakeFromNib {
   
    self.gift.layer.masksToBounds = YES;
    self.gift.layer.cornerRadius = 5.0f;
    self.discount.layer.masksToBounds = YES;
    self.discount.layer.cornerRadius = 5.0f;
    self.voucher.layer.masksToBounds = YES;
    self.voucher.layer.cornerRadius = 5.0f;
    self.special.layer.masksToBounds = YES;
    self.special.layer.cornerRadius = 5.0f;
}

-(void)setupCell:(id)data {
    ChannelProductVo *vo = (ChannelProductVo *)data;
    if(vo.isSelect){
        [self.UpDownImg setImage:[UIImage imageNamed:@"icon_arrow_upward"]];
        self.voucher.hidden=NO;
        self.voucherLabel.hidden=NO;
        self.special.hidden=NO;
        self.specialLabel.hidden=NO;
    }else{
        [self.UpDownImg setImage:[UIImage imageNamed:@"icon_arrow_down"]];
        self.voucher.hidden=YES;
        self.voucherLabel.hidden=YES;
        self.special.hidden=YES;
        self.specialLabel.hidden=YES;
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, [MutableActivityPromotionTableViewCell getCellHeight:vo] - 0.5, APP_W, 0.5)];
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
        self.UpDownImg.hidden = YES;
        self.spreadBtn.enabled = NO;
        self.spreadBtn.hidden = YES;
    }else {
        self.activityCountLabel.hidden = NO;
        self.UpDownImg.hidden = NO;
        self.spreadBtn.enabled = YES;
        self.spreadBtn.hidden = NO;
       self.activityCountLabel.text = [NSString stringWithFormat:@"%lu个活动",(unsigned long)vo.promotionList.count];
    }
    for(int i=0;i<vo.promotionList.count;i++){
        ActivityCategoryVo *activity = vo.promotionList[i];
        NSArray *arrayImage=@[self.gift,self.discount,self.voucher,self.special];
        NSArray *array=@[self.giftLabel,self.discountLabel,self.voucherLabel,self.specialLabel];
        
        [self setImageAndName:activity withLable:array[i] withImage:arrayImage[i]];
    }
    
}

//-(void)setstoreCell:(id)data {
//    BranchPromotionProVO *vo = (BranchPromotionProVO *)data;
//    if(vo.isSelect){
//        [self.UpDownImg setImage:[UIImage imageNamed:@"icon_arrow_upward"]];
//        self.voucher.hidden=NO;
//        self.voucherLabel.hidden=NO;
//        self.special.hidden=NO;
//        self.specialLabel.hidden=NO;
//    }else{
//        [self.UpDownImg setImage:[UIImage imageNamed:@"icon_arrow_down"]];
//        self.voucher.hidden=YES;
//        self.voucherLabel.hidden=YES;
//        self.special.hidden=YES;
//        self.specialLabel.hidden=YES;
//    }
//    
//    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, [MutableActivityPromotionTableViewCell getStoreCellHeight:vo] - 0.5, APP_W, 0.5)];
//    line.backgroundColor = RGBHex(qwColor10);
//    [self addSubview:line];
//    
//    
//    [self.ImagUrl setImageWithURL:[NSURL URLWithString:vo.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
//    self.proName.text = vo.proName;
//    self.spec.text = vo.spec;
//    if(vo.categorys.count==0){
//        self.doteline.hidden=YES;
//    }else{
//        self.doteline.hidden=NO;
//    }
//    
//    if (vo.categorys.count < 3) {
//        self.activityCountLabel.hidden = YES;
//        self.UpDownImg.hidden = YES;
//        self.spreadBtn.enabled = NO;
//        self.spreadBtn.hidden = YES;
//    }else {
//        self.activityCountLabel.hidden = NO;
//        self.UpDownImg.hidden = NO;
//        self.spreadBtn.enabled = YES;
//        self.spreadBtn.hidden = NO;
//        self.activityCountLabel.text = [NSString stringWithFormat:@"%lu个活动",(unsigned long)vo.categorys.count];
//    }
//    for(int i=0;i<vo.categorys.count;i++){
//        ActivityCategoryVo *activity = vo.categorys[i];
//        NSArray *arrayImage=@[self.gift,self.discount,self.voucher,self.special];
//        NSArray *array=@[self.giftLabel,self.discountLabel,self.voucherLabel,self.specialLabel];
//        
//        [self setImageAndName:activity withLable:array[i] withImage:arrayImage[i]];
//    }
//    
//}
- (IBAction)expandAction:(id)sender {
    
    
    [self.expandDele expandCell:self.selectedCell];

    
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

    // Configure the view for the selected state
}

@end
