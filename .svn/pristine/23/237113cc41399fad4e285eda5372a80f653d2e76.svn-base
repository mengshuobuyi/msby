//
//  SingleTaskTableCell.m
//  APP
//  我的积分页面用到的cell，用来展示一次性任务、圈子任务、每月等级任务
//  Created by Martin.Liu on 15/11/30.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "SingleTaskTableCell.h"
#import "AppDelegate.h"
@implementation SingleTaskTableCell

- (void)awakeFromNib {
    self.contentLabel.font = [UIFont systemFontOfSize:kFontS1];
    self.contentLabel.textColor = RGBHex(qwColor6);
    
    self.creditCountLabel.font = [UIFont systemFontOfSize:kFontS1];
    self.creditCountLabel.textColor = RGBHex(qwColor3);
    
    self.actionBtn.layer.masksToBounds = YES;
    self.actionBtn.layer.cornerRadius = 3;
    [self.actionBtn setTitleColor:RGBHex(qwColor4) forState:UIControlStateNormal];
    [self.actionBtn setTitleColor:RGBHex(qwColor8) forState:UIControlStateDisabled];
    self.actionBtn.titleLabel.font = [UIFont systemFontOfSize:kFontS4];
    // Initialization code
}

- (void)setCell:(CreditTaskModel *)model
{
    _taskModel = model;
    
    self.actionBtn.hidden = NO;
    if (![_taskModel isKindOfClass:[CreditTaskModel class]] || _taskModel == nil) {
        self.contentLabel.text = nil;
        self.creditCountLabel.text = nil;
        self.actionBtn.hidden = YES;
    }
    
    // 邀请好友 数量与分数动态
    if ([CreditTaskKey_Invite isEqualToString:model.taskKey]) {
        if (model.finish) {
            self.contentLabel.text = model.taskName;
            NSInteger sumScore = model.rewardScore * model.needStep;
            self.creditCountLabel.text = [NSString stringWithFormat:@"+ %ld", (long)sumScore];
        }
        else
        {
            
            self.contentLabel.text = [NSString stringWithFormat:@"%@ ( %ld/%ld )", model.taskName, (long)model.finishStep, (long)model.needStep];
            
            NSString* countString = [NSString stringWithFormat:@"+ %ld", (long)model.rewardScore];
            NSString* perBodyString = @"/人";
            NSString* creditCountLabelString = [countString stringByAppendingString:perBodyString];
            
            NSMutableAttributedString* attributeString = [[NSMutableAttributedString alloc] initWithString:creditCountLabelString];
            [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kFontS1] range:NSMakeRange(0, attributeString.length)];
            [attributeString addAttribute:NSForegroundColorAttributeName value:RGBHex(qwColor3) range:NSMakeRange(0, countString.length)];
            [attributeString addAttribute:NSForegroundColorAttributeName value:RGBHex(qwColor8) range:NSMakeRange(attributeString.length - perBodyString.length, perBodyString.length)];
            self.creditCountLabel.attributedText = attributeString;
            
//             self.creditCountLabel.text = [NSString stringWithFormat:@"+ %ld", model.rewardScore];
        }
    }
    else
    {
        self.contentLabel.text = model.taskName;
        if (model.rewardScore > 0) {
            if ([@[CreditTaskKey_SNS_Post, CreditTaskKey_SNS_Reply, CreditTaskKey_SNS_Zan] containsObject:model.taskKey]) {
                self.contentLabel.text = [NSString stringWithFormat:@"%@（ %ld/%ld ）", model.taskName, (long)model.finishStep, (long)model.needStep];
                self.creditCountLabel.text = [NSString stringWithFormat:@"+ %ld/次", (long)model.rewardScore];
            }
            else
                self.creditCountLabel.text = [NSString stringWithFormat:@"+ %ld", (long)model.rewardScore];
        }
    }
    NSString* btnTitle = nil;
    self.actionBtn.enabled = YES;
    self.actionBtn.backgroundColor = RGBHex(qwColor1);
    
    if (model.finish) {
        btnTitle = @"已完成";
        // 如果是圈子任务  显示 “今日已完成”
        if ([@[CreditTaskKey_Sign, CreditTaskKey_Share, CreditTaskKey_Trade, CreditTaskKey_Appraise,CreditTaskKey_SNS_Post, CreditTaskKey_SNS_Reply, CreditTaskKey_SNS_Zan] containsObject:model.taskKey]) {
            btnTitle = @"今日已完成";
        }
        self.actionBtn.enabled = NO;
        self.actionBtn.backgroundColor = [UIColor clearColor];
    }
    // 一次性任务
    else if ([CreditTaskKey_Bind isEqualToString:model.taskKey]) {
        btnTitle = @"去绑定";
    }
    else if ([CreditTaskKey_Full isEqualToString:model.taskKey])
    {
        btnTitle = @"去完善";
    }
    else if ([CreditTaskKey_CareCirlce isEqualToString:model.taskKey])
    {
        btnTitle = @"去关注";
    }
    else if ([CreditTaskKey_CareExpert isEqualToString:model.taskKey])
    {
        btnTitle = @"去关注";
    }
//    else if ([@[@"VIP1", @"VIP2", @"VIP3", @"VIP4", @"VIP5", @"VIP6"] containsObject:model.taskKey])
    else if ([model.taskKey hasPrefix:@"VIP"])
    {
        btnTitle = @"去领取";
    }
    else if ([CreditTaskKey_Invite isEqualToString:model.taskKey])
    {
        btnTitle = @"去邀请";
    }
    // 圈子任务
    else if ([CreditTaskKey_SNS_Post isEqualToString:model.taskKey])
    {
        btnTitle = @"去发帖";
    }
    else if ([CreditTaskKey_SNS_Reply isEqualToString:model.taskKey])
    {
        btnTitle = @"去回帖";

    }
    else if ([CreditTaskKey_SNS_Zan isEqualToString:model.taskKey])
    {
        btnTitle = @"去点赞";
    }
    
    // 如果任务没有完成，而且在营销屏，数组中的任务将隐藏行为按钮
    if(!model.finish && ![APPDelegate isMainTab] && [@[CreditTaskKey_SNS_Post,CreditTaskKey_SNS_Reply,CreditTaskKey_SNS_Zan,CreditTaskKey_CareCirlce,CreditTaskKey_CareExpert] containsObject:model.taskKey])
    {
        btnTitle = nil;
    }
    [self.actionBtn setTitle:btnTitle forState:UIControlStateNormal];
    self.actionBtn.hidden = StrIsEmpty(btnTitle);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
