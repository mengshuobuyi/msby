//
//  mbr.h
//  APP
//
//  Created by qw on 15/3/3.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HttpClient.h"
#import "mbrModel.h"
#import "MbrModelR.h"

@class MbrInviterCheckR;
@class MbrInviterR;

typedef enum OperationType{
    GetCodeTypeRegister = 1,
    GetCodeTypeBind = 2,
    GetCodeTypeForgetPassword = 3,
}GetCodeType;


@interface Mbr : NSObject

//用户登录
+ (void)loginWithParams:(mbrLogin *)param
                success:(void(^)(id DFUserModel))success
                failure:(void(^)(HttpException * e))failure;
//第三方登陆
+ (void)tpaLoginWithParams:(mbrTPALogin *)param
                   success:(void(^)(id DFUserModel))success
                   failure:(void(^)(HttpException * e))failure;

//验证码登陆
+ (void)validCodeLoginWithParams:(mbrValidCodeLogin *)param
                         success:(void(^)(id DFUserModel))success
                         failure:(void(^)(HttpException * e))failure;

// 获取用户基础信息
+ (void)getBaseInfoWithParams:(NSDictionary*)param
                      success:(void(^)(id DFUserModel))success
                      failure:(void(^)(HttpException * e))failure;

//用户登出
+ (void)logoutWithParams:(NSDictionary *)param
                success:(void(^)(id DFUserModel))success
                failure:(void(^)(HttpException * e))failure;

+ (void)queryMemberDetailWithParams:(NSDictionary *)param
                success:(void(^)(id DFUserModel))success
                failure:(void(^)(HttpException * e))failure;

// 验证绑定手机号是否存在
+ (void)checkBindPhoneNumberValidWithParams:(NSDictionary *)param
                       success:(void(^)(id DFUserModel))success
                       failure:(void(^)(HttpException * e))failure;

// 验证码校验 <- 不消耗验证码
+ (void)checkVerifyCodeValidWithPrams:(NSDictionary*)param
                              success:(void(^)(BaseAPIModel* apiModel))success
                              failure:(void(^)(HttpException * e))failure;

+ (void)registerValidWithParams:(NSDictionary *)param
                success:(void(^)(id DFUserModel))success
                failure:(void(^)(HttpException * e))failure;

//+ (void)registerWithParams:(NSDictionary *)param
//                success:(void(^)(id DFUserModel))success
//                failure:(void(^)(HttpException * e))failure;

+ (void)sendVerifyCodeWithParams:(NSDictionary *)param
                success:(void(^)(id DFUserModel))success
                failure:(void(^)(HttpException * e))failure;

// 3.2.1 获取短信验证码发送开关
+ (void)getVerifyCodeSwitchSuccess:(void(^)(VerifyCodeSwitchModel* model))success
                           failure:(void(^)(HttpException * e))failure;

// 4.0 获取需要统计的商家
+ (void)getStatisArraySuccess:(void (^)(TdVo *))success
                      failure:(void (^)(HttpException *))failure;

+ (void)sendCodeByImageVerifyWithParams:(NSDictionary *)param
                                success:(void(^)(id DFUserModel))success
                                failure:(void(^)(HttpException * e))failure;

+ (void)sendVoiceVerifyCodeWithParams:(NSDictionary *)param
                success:(void(^)(id DFUserModel))success
                failure:(void(^)(HttpException * e))failure;

+ (void)changeMobileWithParams:(NSDictionary *)param
                success:(void(^)(id DFUserModel))success
                failure:(void(^)(HttpException * e))failure;

//+ (void)resetPasswordWithParams:(NSDictionary *)param
//                success:(void(^)(id DFUserModel))success
//                failure:(void(^)(HttpException * e))failure;

+ (void)updatePasswordWithParams:(NSDictionary *)param
                success:(void(^)(id DFUserModel))success
                failure:(void(^)(HttpException * e))failure;

//+ (void)sendFindPwdVerifyCodeWithParams:(NSDictionary *)param
//                         success:(void(^)(id DFUserModel))success
//                         failure:(void(^)(HttpException * e))failure;

//+ (void)saveMemberInfoWithParams:(NSDictionary *)param
//                         success:(void(^)(id DFUserModel))success
//                         failure:(void(^)(HttpException * e))failure;

+ (void)tokenValidWithParams:(NSDictionary *)param
                     success:(void(^)(id obj))success
                     failure:(void(^)(HttpException * e))failure;
/**
 *  用户获取推荐人手机号
 *
 */
+ (void)InviterCheckWithParams:(MbrInviterCheckR *)param
                       success:(void(^)(id obj))success
                       failure:(void(^)(HttpException * e))failure;

/**
 *  更新推荐人的手机号
 *
 */
+ (void)InviteWithParams:(MbrInviterR *)param
                 success:(void(^)(id obj))success
                 failure:(void(^)(HttpException * e))failure;

/**
 *  3.5.5	用户注册(OK)
 */
+ (void)mbrRegisterParams:(MbrRegisterR *)params
                  success:(void(^)(id obj))success
                  failure:(void(^)(HttpException * e))failure;

/**
 *  邀请好友成功的回调
 */
+ (void)mbrRecommendShareWithParams:(NSDictionary *)params
                            success:(void(^)(id obj))success
                            failure:(void(^)(HttpException * e))failure;

/**
 *  获取分享的url
 */
+ (void)mbrRecommendGetRecommendUrlWithParams:(NSDictionary *)params
                            success:(void(^)(id obj))success
                            failure:(void(^)(HttpException * e))failure;

+ (void)UserCollectTags:(MbrInviterCheckR *)model success:(void (^)(id))success failure:(void (^)(HttpException *))failure;

//家庭用药new图标，是否显示
+ (void)familyTag:(MbrInviterCheckR *)model success:(void (^)(id))success failure:(void (^)(HttpException *))failure;
//家庭用药消失new图标
+ (void)familyHidTag:(MbrInviterCheckR *)model success:(void (^)(id))success failure:(void (^)(HttpException *))failure;

+ (void)getInviteInfo:(MbrInviterInfoModelR *)model success:(void (^)(id obj))success failure:(void (^)(HttpException *e))failure;

+ (void)bindWeiXin:(BindModelR*)model success:(void (^)(BaseAPIModel* obj))success failure:(void (^)(HttpException *e))failure;

+ (void)bindQQ:(BindModelR*)model success:(void (^)(BaseAPIModel* obj))success failure:(void (^)(HttpException *e))failure;

//3.1请求客服电话
+ (void)queryServiceTelSuccess:(void(^)(ServiceTelModel *obj))success failure:(void (^)(HttpException *e))failure;

/**
 *  4.0.0赠送大礼包
 */
+ (void)presentGift:(PresentGiftR*)presentGiftR
            success:(void(^)(PresentGiftModel* presentGiftModel))success
            failure:(void(^)(HttpException * e))failure;


@end
