//
//  CreditModel.h
//  APP
//
//  Created by Martin.Liu on 15/12/4.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "BaseAPIModel.h"
/*
 绑定
 LOGIN   登录
 TRADE   购物
 SIGN    签到
 SHARE   分享
 FULL    完善资料
 INVITE  邀请好友
 VIP1    等级一级
 VIP2
 VIP3
 VIP4
 VIP5
 VIP6
 */
extern NSString *const CreditTaskKey_Bind;
extern NSString *const CreditTaskKey_Login;
extern NSString *const CreditTaskKey_Trade;
extern NSString *const CreditTaskKey_Sign;
extern NSString *const CreditTaskKey_Share;
extern NSString *const CreditTaskKey_Full;
extern NSString *const CreditTaskKey_Invite;
extern NSString *const CreditTaskKey_VIP1;
extern NSString *const CreditTaskKey_VIP2;
extern NSString *const CreditTaskKey_VIP3;
extern NSString *const CreditTaskKey_VIP4;
extern NSString *const CreditTaskKey_VIP5;
extern NSString *const CreditTaskKey_VIP6;
extern NSString *const CreditTaskKey_MonthlyTip; // 等级为0时候，接口没有返回每月提示的任务，所以需要弹出每月奖励提示（客户端写的）
extern NSString *const CreditTaskKey_Appraise;     // 评价
extern NSString *const CreditTaskKey_SNS_Post;     // 发帖
extern NSString *const CreditTaskKey_SNS_Reply;    // 回帖
extern NSString *const CreditTaskKey_SNS_Zan;      // 点赞
extern NSString *const CreditTaskKey_CareCirlce;   // 首次关注圈子
extern NSString *const CreditTaskKey_CareExpert;   // 首次关注专家

@class CreditTaskRule;
@interface CreditModel : BaseAPIModel
@property (nonatomic, assign) NSInteger mbrScore;
@property (nonatomic, assign) NSInteger level;
//@property (nonatomic, strong) NSArray *taskListVO;

@property (nonatomic, strong) NSArray *onceTasks;
@property (nonatomic, strong) NSArray *dailyTasks;
@property (nonatomic, strong) NSArray *monthlyTasks;
@property (nonatomic, strong) NSArray *teamTasks;
@end

@interface CreditTaskModel : BaseAPIModel
@property (nonatomic, strong) NSString *taskName;       // 任务名
@property (nonatomic, strong) NSString *taskId;         // 任务id
@property (nonatomic, assign) NSInteger rewardScore;    // 奖励分数
@property (nonatomic, assign) NSInteger taskType;       // 任务类型，1：日常任务，2：一次性任务，3：每月任务,
@property (nonatomic, assign) NSInteger needStep;       // 完成任务所需步骤数,
@property (nonatomic, assign) NSInteger finishStep;     // 已完成步骤,
@property (nonatomic) BOOL finish;
@property (nonatomic, strong) NSString *taskKey;        // 任务key
@end

@interface CreditRecordsModel : BaseAPIModel
@property (nonatomic, strong) NSArray* list;
@end

@interface CreditRecordModel : BaseAPIModel
@property (nonatomic, strong) NSString *taskType;       // 任务类型
@property (nonatomic, strong) NSString *operate;        // 操作动作
@property (nonatomic, assign) NSInteger oprType;        // 操作类型，1：获取，2：消耗,
@property (nonatomic, assign) NSInteger score;          // 分值
@property (nonatomic, strong) NSString *date;           // 时间
@end

@interface CreditTaskRulesModel : BaseAPIModel<NSCoding>
@property (nonatomic, strong) NSArray* rules;

- (NSInteger)rewardScoreWithTaskKey:(NSString*)taskKey;
- (CreditTaskRule*)creditTaskRuleWithTaskKey:(NSString*)taskKey;
@end

@interface CreditTaskRule : BaseAPIModel
@property (nonatomic, strong) NSString* taskKey;        // 任务key
@property (nonatomic, assign) NSInteger rewardScore;    // 奖励积分
@property (nonatomic, assign) NSInteger rewardGrowth;   // 奖励成长值
@end

@interface SignModel : BaseAPIModel
@property (nonatomic,strong)NSNumber *rewardScore; //本次获得积分
@property (nonatomic,strong)NSNumber *rewardGrowth;//本次获得成长值
@property (nonatomic,strong)NSNumber *score;        //总积分
@property (nonatomic,strong)NSNumber *growth;       //总成长值
@property (nonatomic,assign)BOOL upgrade;           //是否升级
@property (nonatomic,strong)NSNumber *level;        //当前等级

@end

@interface MyLevelDetailVo : BaseAPIModel
@property (nonatomic,strong)NSNumber *level;        //当前等级
@property (nonatomic,assign)BOOL claim;             //是否已领取等级奖励
@property (nonatomic,strong)NSNumber *nextLevel;     //下一等级
@property (nonatomic,strong)NSNumber *needShopCount;    //升级所需购物次数
@property (nonatomic,strong)NSNumber *needGrowthValue;  //升级所需成长值
@property (nonatomic,strong)NSArray *upgradeRules;
@property (nonatomic,strong)NSString *growth;
@end

@interface BaseTaskVo : BaseAPIModel
@property (nonatomic,strong)NSNumber *rewardScore;
@property (nonatomic,strong)NSNumber *rewardGrowth;
@property (nonatomic,strong)NSNumber *score;
@property (nonatomic,strong)NSNumber *growth;
@property (nonatomic,assign)BOOL upgrade;
@property (nonatomic,strong)NSNumber *level;
@end
