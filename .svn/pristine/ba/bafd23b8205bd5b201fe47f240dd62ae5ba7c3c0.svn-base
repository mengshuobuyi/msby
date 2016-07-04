//
//  CouponPromotionTableViewCell.m
//  APP
//
//  Created by 李坚 on 15/8/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "MyMutableMorePromotionTableViewCell.h"
#import "ActivityModel.h"
#import "UIImageView+WebCache.h"
#import "Coupon.h"
@implementation MyMutableMorePromotionTableViewCell

+(CGFloat)getCellHeight:(id)data{
    
    CGFloat height=0.0f;
    ChannelProductVo *vo = (ChannelProductVo *)data;
    
    CGSize size =[GLOBALMANAGER sizeText:vo.proName font:fontSystem(kFontS1) limitWidth:APP_W-101];
    
    if(vo.spellFlag){
        return  41 + size.height + 18 + (19 * vo.promotionList.count);
    }else{
        if(vo.promotionList.count > 1){
            return  91.0f + height + 20;
        }else{
            return  91.0f + height;
        }
    }
}


- (void)awakeFromNib {
   
    [self.spellBtn addTarget:self action:@selector(spellCell:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setupCell:(ChannelProductVo *)data {
    
    ChannelProductVo *vo = data;
    
    self.proName.text = vo.proName;
    self.spec.text = vo.spec;
    
    [self.ImagUrl setImageWithURL:[NSURL URLWithString:vo.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
    
    self.statusImage.image = nil;
    
    if(speratorLine == nil){
        speratorLine = [[UIView alloc]initWithFrame:CGRectMake(0, [MyMutableMorePromotionTableViewCell getCellHeight:vo] - 0.5, APP_W, 0.5)];
        speratorLine.backgroundColor = RGBHex(qwColor10);
        [self addSubview:speratorLine];
    }else{
        speratorLine.frame = CGRectMake(0, [MyMutableMorePromotionTableViewCell getCellHeight:vo] - 0.5, APP_W, 0.5);
    }
    
    [self setupPromotionUI:vo.promotionList andSpellFlag:vo.spellFlag];
    
    
    
    //处理活动UI
    if(vo.promotionList.count > 2){
    
        self.spellImage.hidden = NO;
        
        if(vo.spellFlag){
            self.activityCountLabel.text = @"收起";
        }else{
            self.activityCountLabel.text = @"展开";
        }

        //self.activityCountLabel.text = [NSString stringWithFormat:@"%d个活动",(int)vo.promotionList.count];
        
        self.spellBtn.enabled = YES;
        
    }else{
        
        self.spellImage.hidden = YES;
        self.activityCountLabel.text = @"";
        self.spellBtn.enabled = NO;
    }
}

#pragma mark - 处理活动展开收起UI
- (void)setupPromotionUI:(NSArray *)promotionArray andSpellFlag:(BOOL)flag{
    
    
    if(flag){
        self.spellImage.image = [UIImage imageNamed:@"btn_img_spelled"];
    }else{
        self.spellImage.image = [UIImage imageNamed:@"btn_img_unSpell"];
    }
    
    for(UIView *view in self.promotionView.subviews){
        [view removeFromSuperview];
    }
    
    if(flag){//展开状态，所有活动全部显示
        
        CGFloat viewY = 9.0f;
        //遍历数组，图片+Label一行展示一个
        for(ActivityCategoryVo *vo in promotionArray){
            
            [self setImageAndName:vo andFrame:CGRectMake(0, viewY, self.promotionView.frame.size.width, self.promotionView.frame.size.height)];
            viewY += 19.0f;
        }
        
    }else{//收起状态,展示第一个活动，其他缩略展示
        
        CGFloat viewY = 9.0f;
        CGFloat viewX = 0.0f;
        
        //遍历数组，全部展示第一个优惠活动，剩余的缩略展示
        for(ActivityCategoryVo *vo in promotionArray){
            
            if([vo isEqual:promotionArray[0]]){
                [self setImageAndName:vo andFrame:CGRectMake(0, viewY, self.promotionView.frame.size.width, self.promotionView.frame.size.height)];
                viewY += 19.0f;
            }else{
                UIImageView *actView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX, viewY, 15, 15)];
                [self promoionImage:actView andType:vo.activityType];
                [self.promotionView addSubview:actView];
                
                viewX += 19;
            }
        }
    }
}



#pragma mark - 点击展开按钮Delegate回调
- (void)spellCell:(id)sender {
    
    if(self.SpellDelegate){

        [self.SpellDelegate didSepllCellAtIndexPath:self.selectedCell];
    }
}

#pragma mark - 生成Image+Label
-(void)setImageAndName:(ActivityCategoryVo *)activity andFrame:(CGRect)Frame{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(Frame.origin.x, Frame.origin.y, 15, 15)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Frame.origin.x + 19, Frame.origin.y, Frame.size.width - 19, 15)];
    
    label.font = fontSystem(kFontS6);
    label.textColor = RGBHex(qwColor8);
    
    [self promoionImage:imageView andType:activity.activityType];
    
    label.text=activity.actvityName;

    [self.promotionView addSubview:imageView];
    [self.promotionView addSubview:label];
    
}

#pragma mark - 根据activityType设置赠/折/抵/特图片
- (void)promoionImage:(UIImageView *)imageView andType:(id)activityType{
    
    switch ([activityType intValue]) {
        case 1:
        {
            [imageView setImage:[UIImage imageNamed:@"img_label_gift"]];
            break;
        }
        case 2:
        {
            [imageView setImage:[UIImage imageNamed:@"img_label_fold"]];
            break;
        }
        case 3:
        {
            [imageView setImage:[UIImage imageNamed:@"img_label_forNow"]];
            break;
        }
        case 4:
        {
            [imageView setImage:[UIImage imageNamed:@"img_label_specialOffer"]];
            break;
        }
            break;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
