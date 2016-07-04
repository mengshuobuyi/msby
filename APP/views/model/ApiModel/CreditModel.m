//
//  CreditModel.m
//  APP
//
//  Created by Martin.Liu on 15/12/4.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "CreditModel.h"

NSString *const CreditTaskKey_Bind = @"BIND";
NSString *const CreditTaskKey_Login = @"LOGIN";
NSString *const CreditTaskKey_Trade = @"TRADE";
NSString *const CreditTaskKey_Sign = @"SIGN";
NSString *const CreditTaskKey_Share = @"SHARE";
NSString *const CreditTaskKey_Full = @"FULL";
NSString *const CreditTaskKey_Invite = @"INVITE";
NSString *const CreditTaskKey_VIP1 = @"VIP1";
NSString *const CreditTaskKey_VIP2 = @"VIP2";
NSString *const CreditTaskKey_VIP3 = @"VIP3";
NSString *const CreditTaskKey_VIP4 = @"VIP4";
NSString *const CreditTaskKey_VIP5 = @"VIP5";
NSString *const CreditTaskKey_VIP6 = @"VIP6";
NSString *const CreditTaskKey_MonthlyTip = @"CreditTaskKey_MonthlyTip"; // 等级为0时候，接口没有返回每月提示的任务，所以需要弹出每月奖励提示（客户端写的）
NSString *const CreditTaskKey_Appraise = @"APPRAISE";   // 评价
NSString *const CreditTaskKey_SNS_Post = @"SNS_POST";   // 发帖
NSString *const CreditTaskKey_SNS_Reply = @"SNS_REPLY"; // 回帖
NSString *const CreditTaskKey_SNS_Zan = @"SNS_ZAN";     // 点赞
NSString *const CreditTaskKey_CareCirlce = @"SNS_ATTN_TEAM_FIRST"; // 首次关注圈子
NSString *const CreditTaskKey_CareExpert = @"SNS_ATTN_EXPERT_FIRST"; // 首次关注专家

@implementation CreditModel

@end

@implementation CreditTaskModel

@end

@implementation CreditRecordsModel

@end

@implementation CreditRecordModel

@end

@implementation CreditTaskRulesModel

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        id obj = [coder decodeObjectForKey:@"creditrules"];
        if ([obj isKindOfClass:[NSArray class]]) {
            _rules = [CreditTaskRule parseArray:obj];
        }
        else
        {
            _rules = obj;
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.rules forKey:@"creditrules"];
}

- (NSInteger)rewardScoreWithTaskKey:(NSString*)taskKey
{
    for (CreditTaskRule* creditTaskRule in self.rules) {
        if ([creditTaskRule isKindOfClass:[CreditTaskRule class]] && [creditTaskRule.taskKey isEqual:taskKey]) {
            return creditTaskRule.rewardScore;
        }
    }
    return 0;
}

- (CreditTaskRule*)creditTaskRuleWithTaskKey:(NSString*)taskKey
{
    for (CreditTaskRule* creditTaskRule in self.rules) {
        if ([creditTaskRule isKindOfClass:[CreditTaskRule class]] && [creditTaskRule.taskKey isEqual:taskKey]) {
            return creditTaskRule;
        }
    }
    return nil;
}

@end

@implementation CreditTaskRule

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    if ([object isKindOfClass:[CreditTaskRule class]]) {
        CreditTaskRule *otherObj = (CreditTaskRule*)object;
        return [self.taskKey isEqualToString:otherObj.taskKey];
    }
    return NO;
}

- (NSUInteger)hash
{
    return [self.taskKey hash];
}

@end

@implementation SignModel

@end
@implementation MyLevelDetailVo

@end
@implementation BaseTaskVo

@end