//
//  ShareContentModel.h
//  APP
//
//  Created by PerryChen on 6/3/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "BaseModel.h"
typedef NS_ENUM(NSInteger, UMengShareType) {
    ShareTypeMedicine = 1,                 // 分享药品
    ShareTypeDisease ,             // 分享疾病
    ShareTypeSymptom ,             // 分享症状
    ShareTypePharmacy ,            // 分享药房
    ShareTypeInfo ,                // 分享资讯
    ShareTypeRecommendFriends ,    // 邀请好友
    ShareTypePharmacyWithActivity ,// 药房详情-优惠活动分享
    ShareTypeMedicineWithPromotion ,// 药品详情-有优惠
    ShareTypeGetCouponList ,              // 领券中心列表分享
    ShareTypeSubject ,                // 专题正文的分享
    ShareTypeDivision ,               // 专区索引分享
    ShareTypeSlowDiseaseCoupon ,               // 慢病优惠券分享
    ShareTypeMyCoupon ,               // 我的－优惠券详情的分享（使用前)
    ShareTypeMyDrug ,               // 我的－优惠商品详情的分享（使用前)
    ShareTypeOuterLink ,          // 分享外链
    ShareTypeHealthMeasurement ,  // 分享健康自测
    ShareTypeHealthCheckDetail ,  // 分享健康自测详情
    ShareTypeCommonActivity ,     // 分享门店海报（原生）
    ShareTypeFanPai,                // 分享翻牌
    ShareTypePostDetail,            // 分享帖子详情
    ShareTypeIntegralProDetail,     // 分享积分商城商品详情
    ShareTypeActivityList,          // 分享活动列表
    ShareTypeWechatProduct,         // 微商商品详情分享
};

typedef NS_ENUM(NSInteger, UMengSharePlatForm) {
    SharePlatformSina = 0x00000001,
    SharePlatformQQ = 0x00000001 << 1,
    SharePlatformWechatSession = 0x00000001 << 2,
    SharePlatformWechatTimeline = 0x00000001 << 3,
};

@interface ShareSaveLogModel : BaseModel
@property (nonatomic, strong) NSString *shareObj;           // 分享对象类型(1: 优惠券 2: 优惠商品 3: 商家优惠活动)
@property (nonatomic, strong) NSString *shareObjId;         // 分享对象ID
@property (nonatomic, strong) NSString *province;           // 省
@property (nonatomic, strong) NSString *city;               // 市
@property (nonatomic, strong) NSString *token;              // token
@end

@interface ShareContentModel : BaseModel
@property (nonatomic, assign) UMengShareType typeShare;     // 分享类型                   ###必须
@property (nonatomic, assign) UMengSharePlatForm platform;  // 分享平台                   ###必须
@property (nonatomic, strong) NSString *shareID;            // 分享的药房id, 症状ID等      ###必须
@property (nonatomic, strong) NSString *title;              // 分享的药方名称，症状名称等    ###必须
@property (nonatomic, strong) NSString *content;            // 资讯详情，其余可写nil
@property (nonatomic, strong) NSString *imgURL;             // 分享的图片URL
@property (nonatomic, strong) NSString *shareLink;          // 分享的点击后链接地址
@property (nonatomic, strong) ShareSaveLogModel *modelSavelog;      // 分享统计的Model
@property (nonatomic, strong) NSString *typeCome;      // 从那个页面的邀请好友，分享成功后要刷新积分
@end



