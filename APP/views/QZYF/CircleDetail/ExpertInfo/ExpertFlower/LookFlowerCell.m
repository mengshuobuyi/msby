//
//  LookFlowerCell.m
//  wenYao-store
//
//  Created by Yang Yuexia on 16/1/24.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "LookFlowerCell.h"
#import "CircleModel.h"
#import "NSString+WPAttributedMarkup.h"
#import "UIImageView+WebCache.h"

@implementation LookFlowerCell

- (void)UIGlobal
{
    [super UIGlobal];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.separatorLine.hidden = YES;
    
    self.headerIcon.layer.cornerRadius = 26.0;
    self.headerIcon.layer.masksToBounds = YES;
    
    self.attentionLabel.layer.cornerRadius = 3.0;
    self.attentionLabel.layer.masksToBounds = YES;
    
    self.cancelAttentionLabel.layer.cornerRadius = 3.0;
    self.cancelAttentionLabel.layer.masksToBounds = YES;
    
    self.expertBrandLabel.layer.cornerRadius = 4.0;
    self.expertBrandLabel.layer.masksToBounds = YES;
}

#pragma mark ---- 查看鲜花 ----
- (void)setUpData:(id)data
{
    CircleMaserlistModel *model = (CircleMaserlistModel *)data;
        
    if (StrIsEmpty(model.id))
    {
        //游客
        //头像
        [self.headerIcon setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"expert_ic_people"]];
        
        //姓名 logo 地址
        self.lvlBgView.hidden = YES;
        self.name.text = @"游客";
        self.name_layout_width.constant = 100;
        
        //文章 帖子 数
        NSString *str = @"文章 0   回帖 0";
        NSMutableAttributedString *AttributedStr1 = [[NSMutableAttributedString alloc]initWithString:str];
        NSRange range1 = [[AttributedStr1 string]rangeOfString:@"文章"];
        NSRange range2 = [[AttributedStr1 string]rangeOfString:@"回帖"];
        [AttributedStr1 addAttribute:NSFontAttributeName
                               value:fontSystem(kFontS5)
                               range:range1];
        [AttributedStr1 addAttribute:NSForegroundColorAttributeName
                               value:RGBHex(qwColor8)
                               range:range1];
        [AttributedStr1 addAttribute:NSFontAttributeName
                               value:fontSystem(kFontS5)
                               range:range2];
        [AttributedStr1 addAttribute:NSForegroundColorAttributeName
                               value:RGBHex(qwColor8)
                               range:range2];
        self.number.attributedText = AttributedStr1;
        
        
        //关注按钮
        self.attentionLabel.hidden = YES;
        self.cancelAttentionLabel.hidden = YES;
        self.masterLabel.hidden = YES;
        self.attentionButton.hidden = YES;
        self.attentionButton.enabled = NO;
        
        self.expertLogoLabel.hidden = YES;
        self.expertBrandLabel.hidden = YES;
    }else
    {
        //头像
        [self.headerIcon setImageWithURL:[NSURL URLWithString:model.headImageUrl] placeholderImage:[UIImage imageNamed:@"expert_ic_people"]];
        
        //姓名 logo 地址
        NSString *name = model.nickName;
        if (model.userType == 3 || model.userType == 4)
        {
            
            self.lvlBgView.hidden = YES;
            self.name_layout_width.constant = APP_W-150;
            NSString *logoName;
            NSString *store;
            if (model.userType == 3)
            {
                //药师 标识显示药师logo及所属商家
                store = model.groupName;
                logoName = @"药师";
            }else if (model.userType == 4)
            {
                //营养师 标识显示营养师logo及“营养师”
                store = @"";
                logoName = @"营养师";
            }
            
            CGSize nameSize = [name sizeWithFont:fontSystem(15) constrainedToSize:CGSizeMake(APP_W-85, CGFLOAT_MAX)];
            self.name_layout_width.constant = nameSize.width+2;
            CGSize brandSize = [store sizeWithFont:fontSystem(12) constrainedToSize:CGSizeMake(APP_W-85-nameSize.width-13, CGFLOAT_MAX)];
            
            self.expertBrand_layout_width.constant = brandSize.width+7;
            self.name.text = name;
            self.expertLogoLabel.text = logoName;
            
            if (StrIsEmpty(store)) {
                self.expertBrandLabel.hidden = YES;
            }else{
                self.expertBrandLabel.hidden = NO;
                self.expertBrandLabel.text = store;
            }
        }else{
            
            //普通用户 标识显示用户当前等级
            self.name.text = name;
            CGSize size=[name sizeWithFont:fontSystem(15) constrainedToSize:CGSizeMake(APP_W-150, CGFLOAT_MAX)];
            self.name_layout_width.constant = size.width+2;
            self.lvlBgView.hidden = NO;
            self.lvlLabel.text = [NSString stringWithFormat:@"V%d",model.mbrLvl];
            
            self.expertLogoLabel.hidden = YES;
            self.expertBrandLabel.hidden = YES;
        }
        
        
        //文章 帖子 数
        NSString *str = [NSString stringWithFormat:@"文章 %d   回帖 %d",model.postCount,model.replyCount];
        NSMutableAttributedString *AttributedStr1 = [[NSMutableAttributedString alloc]initWithString:str];
        NSRange range1 = [[AttributedStr1 string]rangeOfString:@"文章"];
        NSRange range2 = [[AttributedStr1 string]rangeOfString:@"回帖"];
        [AttributedStr1 addAttribute:NSFontAttributeName
                               value:fontSystem(kFontS5)
                               range:range1];
        [AttributedStr1 addAttribute:NSForegroundColorAttributeName
                               value:RGBHex(qwColor8)
                               range:range1];
        [AttributedStr1 addAttribute:NSFontAttributeName
                               value:fontSystem(kFontS5)
                               range:range2];
        [AttributedStr1 addAttribute:NSForegroundColorAttributeName
                               value:RGBHex(qwColor8)
                               range:range2];
        self.number.attributedText = AttributedStr1;
        
        
        //关注按钮
        if (model.userType == 3 || model.userType == 4) {
            if (model.id && QWGLOBALMANAGER.configure.passPort && [model.id isEqualToString:QWGLOBALMANAGER.configure.passPort]) {
                
                //若点赞用户是登录专家本身，不显示关注按键
                self.attentionLabel.hidden = YES;
                self.cancelAttentionLabel.hidden = YES;
                self.masterLabel.hidden = YES;
                self.attentionButton.hidden = YES;
                self.attentionButton.enabled = NO;
            }else{
                
                self.attentionButton.hidden = NO;
                self.attentionButton.enabled = YES;
                
                if (model.isAttnFlag) { //已经关注，显示取消关注
                    self.cancelAttentionLabel.layer.cornerRadius = 4.0;
                    self.cancelAttentionLabel.layer.masksToBounds = YES;
                    self.cancelAttentionLabel.hidden = NO;
                    self.attentionLabel.hidden = YES;
                    self.masterLabel.hidden = YES;
                }else{//未关注，显示关注
                    self.attentionLabel.layer.cornerRadius = 4.0;
                    self.attentionLabel.layer.masksToBounds = YES;
                    self.attentionLabel.hidden = NO;
                    self.cancelAttentionLabel.hidden = YES;
                    self.masterLabel.hidden = YES;
                }
            }
        }else{
            //普通用户
            self.attentionLabel.hidden = YES;
            self.cancelAttentionLabel.hidden = YES;
            self.masterLabel.hidden = YES;
            self.attentionButton.hidden = YES;
            self.attentionButton.enabled = NO;
        }
    }
    
}


@end
