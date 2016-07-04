//
//  ActivityModelR.h
//  APP
//
//  Created by Meng on 15/3/19.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseModel.h"

@interface ActivityModelR : BaseModel



@end

@interface BranchActivityModelR : BaseModel

@property (nonatomic ,strong) NSString *branchId;

@end

@interface ChannelHomeModelR : BaseModel

@property (nonatomic ,strong) NSString *city;

@end


@interface checkActivityList : ActivityModelR

@property (nonatomic ,strong) NSString *groupId;
@property (nonatomic ,strong) NSNumber *currPage;
@property (nonatomic ,strong) NSNumber *pageSize;

@end


@interface GrabActivityHomePageModelR : BaseModel

@property (nonatomic ,strong) NSString *cityName;

@end


@interface QueryActivityModelR : ActivityModelR

@property (nonatomic ,strong) NSString *activityId;
@property (nonatomic ,strong) NSString *groupId;

@end


@interface GetBranchPromotionR : ActivityModelR

@property (nonatomic ,strong) NSString *branchId;
@property (nonatomic ,strong) NSNumber *currPage;
@property (nonatomic ,strong) NSNumber *pageSize;

@end

@interface GrabActivityModelR : BaseModel
@property (nonatomic ,strong) NSString *cityName;
@property (nonatomic ,strong) NSString *token;
@property (nonatomic ,strong) NSString *grabActivityId;
@end

@interface PurchaseGrabProductR : BaseModel
@property (nonatomic ,strong) NSString *cityName;
@property (nonatomic ,strong) NSString *token;
//@property (nonatomic ,strong) NSString *activityId;
@property (nonatomic ,strong) NSString *pid;
@property (nonatomic ,assign) NSInteger channel;
@end

@interface ChannelProductListR : BaseModel
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *channelId;
@property (nonatomic,assign) NSInteger page;    //当前页数
@property (nonatomic,assign) NSInteger pageSize;//每页个数
@end

@interface ActivityPurchListR : BaseModel

@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *pid;
@property (nonatomic,strong) NSString *proId;
@property (nonatomic,strong) NSString *branchId;

@end

@interface QueryWonAwardsR : BaseModel           //请求中奖纪录
@property (nonatomic,strong) NSString *mobile;      //用户手机号
@property (nonatomic,strong) NSString *token;
@end
//3.0开通微商
@interface QueryRushProductR : BaseModel
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *grabActivityId;
@end