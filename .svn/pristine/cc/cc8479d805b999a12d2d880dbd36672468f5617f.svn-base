//
//  Mbr.m
//  APP
//
//  Created by qw on 15/3/3.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "Mbr.h"
#import "Constant.h"
#import "MbrModelR.h"
#import "MapInfoModel.h"
#import "UserDefault.h"
#import "QWGlobalManager.h"
@implementation Mbr

//示例代码
//NSMutableDictionary *param = [NSMutableDictionary dictionary];
//param[@"account"] = self.nameField.text;
//param[@"password"] = self.passwdField.text;
//param[@"deviceCode"] = QWGLOBALMANAGER.deviceToken;
//param[@"device"] = @"2";
//
//[Mbr loginWithParams:param
//             success:^(id obj){
//             }
//             failure:^(HttpException *e){
//             }];


+ (void)loginWithParams:(mbrLogin *)param
                success:(void(^)(id DFUserModel))success
                failure:(void(^)(HttpException * e))failure
{
    [[HttpClient sharedInstance] post:NW_login params:[param dictionaryModel] success:^(id responseObj) {

        DebugLog(@"responseObj===>%@",responseObj);
        mbrUser *body= [mbrUser parse:responseObj];
        
        if (success) {
            success(body);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)tpaLoginWithParams:(mbrTPALogin *)param
                   success:(void(^)(id DFUserModel))success
                   failure:(void(^)(HttpException * e))failure
{
    MapInfoModel *mapModel = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
    BOOL locationSucces = [QWUserDefault getBoolBy:kLocationSuccess];
    if (locationSucces) {
        param.city = mapModel.city;
    }else
    {
        param.city = @"";
    }
    
    MapInfoModel *mapInfoModel = [QWUserDefault getModelBy:APP_MAPINFOMODEL];
    if(mapInfoModel)
    {
        param.city = mapInfoModel.city;
    }
    param.branchId = [QWGLOBALMANAGER getMapBranchId];
    [[HttpClient sharedInstance] post:NW_tpaLogin params:[param dictionaryModel] success:^(id responseObj) {
        DebugLog(@"tpalogin responseObj===>%@",responseObj);
        mbrUser *body= [mbrUser parse:responseObj];
        if (success) {
            success(body);
        }

    } failure:^(HttpException *e) {
        DebugLog(@"tpalogin error : %@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)validCodeLoginWithParams:(mbrValidCodeLogin *)param
                         success:(void(^)(id DFUserModel))success
                         failure:(void(^)(HttpException * e))failure
{
    MapInfoModel *mapModel = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
    BOOL locationSucces = [QWUserDefault getBoolBy:kLocationSuccess];
    if (locationSucces) {
        param.city = mapModel.city;
    }else
    {
        param.city = @"";
    }
    param.branchId = [QWGLOBALMANAGER getMapBranchId];
    [[HttpClient sharedInstance] post:NW_validCodeLogin params:[param dictionaryModel] success:^(id responseObj) {
        DebugLog(@"validLogin responseObj===>%@",responseObj);
        mbrUser* body = [mbrUser parse:responseObj];
        if (success) {
            success(body);
        }
        
    } failure:^(HttpException *e) {
        DebugLog(@"tpalogin error : %@",e);
        if (failure) {
            failure(e);
        }
    }];

}

// 获取用户基础信息
+ (void)getBaseInfoWithParams:(NSDictionary*)param
                      success:(void(^)(id DFUserModel))success
                      failure:(void(^)(HttpException * e))failure
{
    [[HttpClient sharedInstance] getWithoutProgress:API_GetBaseInfo params:param success:^(id responseObj) {
        mbrBaseInfo* baseInfo = [mbrBaseInfo parse:responseObj];
        if (success) {
            success(baseInfo);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"getbaseinfo error : %@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)logoutWithParams:(NSDictionary *)param
                 success:(void(^)(id DFUserModel))success
                 failure:(void(^)(HttpException * e))failure
{
    [[HttpClient sharedInstance] post:NW_logout params:param success:^(id responseObj) {
        
        if (success) {
            success(responseObj);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)queryMemberDetailWithParams:(NSDictionary *)param
                        success:(void(^)(id DFUserModel))success
                        failure:(void(^)(HttpException * e))failure
{
    
    [[HttpClient sharedInstance] post:NW_queryMemberDetail
                               params:param
                              success:^(id resultObj) {
                                  mbrMemberInfo * info =[mbrMemberInfo parse:resultObj];
                                  if (info) {
                                      if (success) {
                                          success(info);
                                      }
                                  }
                                  else
                                  {
                                      if (success) {
                                          success(resultObj);
                                      }
                                  }  
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}

// 验证绑定手机号是否存在
+ (void)checkBindPhoneNumberValidWithParams:(NSDictionary *)param
                                    success:(void(^)(id DFUserModel))success
                                    failure:(void(^)(HttpException * e))failure
{
    [[HttpClient sharedInstance] post:NW_CheckMobile params:param success:^(id responseObj) {
        DebugLog(@"checkBindPhoneNumber responseObj===>%@",responseObj);
        if (success) {
            success(responseObj);
        }
        
    } failure:^(HttpException *e) {
        DebugLog(@"tpalogin error : %@",e);
        if (failure) {
            failure(e);
        }
    }];
}

// 验证码校验 <- 不消耗验证码
+ (void)checkVerifyCodeValidWithPrams:(NSDictionary *)param
                              success:(void (^)(BaseAPIModel *))success
                              failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] post:API_CheckVerifyCodeValid params:param success:^(id responseObj) {
        BaseAPIModel* baseAPIModel = [BaseAPIModel parse:responseObj];
        if (success) {
            success(baseAPIModel);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"check verify code valid error : %@",e);
        if (failure) {
            failure(e);
        }
    }];
}

//用户注册校验
+ (void)registerValidWithParams:(NSDictionary *)param
                        success:(void(^)(id DFUserModel))success
                        failure:(void(^)(HttpException * e))failure
{
    NSString *url = [NSString stringWithFormat:@"%@?mobile=%@",NW_registerValid,param[@"mobile"]];
    
    [[HttpClient sharedInstance] get:url
                               params:nil
                              success:^(id resultObj) {
                                
                                  
                                  if (success) {
                                      success(resultObj);
                                  }
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}

//+ (void)registerWithParams:(NSDictionary *)param
//                   success:(void(^)(id DFUserModel))success
//                   failure:(void(^)(HttpException * e))failure
//{
//    [[HttpClient sharedInstance] post:NW_queryMemberDetail
//                               params:param
//                              success:^(id resultObj) {
//                                  
//                                  if (success) {
//                                      success(resultObj);
//                                  }
//                              }
//                              failure:^(HttpException *e) {
//                                  DebugLog(@"%@",e);
//                                  if (failure) {
//                                      failure(e);
//                                  }
//                              }];
//}

+ (void)sendVerifyCodeWithParams:(NSDictionary *)param
                         success:(void(^)(id DFUserModel))success
                         failure:(void(^)(HttpException * e))failure
{
    
    
    [[HttpClient sharedInstance] post:NW_sendVerifyCode
                               params:param
                              success:^(id resultObj) {
                                  
                                  msgModel *msg = [msgModel parse:resultObj];
                                  
                                  if (success) {
                                      success(msg);
                                  }
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}

// 3.2.1 获取短信验证码发送开关
+ (void)getVerifyCodeSwitchSuccess:(void (^)(VerifyCodeSwitchModel *))success
                           failure:(void (^)(HttpException *))failure
{
    [HttpClientMgr get:API_GetVerifyCodeSwitch params:nil success:^(id responseObj) {
        VerifyCodeSwitchModel* model = [VerifyCodeSwitchModel parse:responseObj];
        if (success) {
            success(model);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}


// 4.0 获取需要统计的商家
+ (void)getStatisArraySuccess:(void (^)(TdVo *))success
                           failure:(void (^)(HttpException *))failure
{
    [HttpClientMgr get:GetStatisBranchArray params:nil success:^(id responseObj) {
        TdVo* model = [TdVo parse:responseObj Elements:[TdGroupSimpleVo class] forAttribute:@"groups"];
        if (success) {
            success(model);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}



+ (void)sendCodeByImageVerifyWithParams:(NSDictionary *)param
                                success:(void (^)(id))success
                                failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] post:API_SendCodeByImageVerify
                               params:param
                              success:^(id resultObj) {
                                  BaseAPIModel *apiModel = [BaseAPIModel parse:resultObj];
                                  
                                  if (success) {
                                      success(apiModel);
                                  }
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}

+ (void)sendVoiceVerifyCodeWithParams:(NSDictionary *)param
                          success:(void(^)(id DFUserModel))success
                          failure:(void(^)(HttpException * e))failure
{
    [[HttpClient sharedInstance] post:API_SendVoiceVerifyCode
                               params:param
                              success:^(id resultObj) {
                                  BaseAPIModel* baseAPIModel =[BaseAPIModel parse:resultObj];
                                  if (success) {
                                      success(baseAPIModel);
                                  }
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}

+ (void)changeMobileWithParams:(NSDictionary *)param
                       success:(void(^)(id DFUserModel))success
                       failure:(void(^)(HttpException * e))failure
{
    [[HttpClient sharedInstance] post:NW_changeMobile
                               params:param
                              success:^(id resultObj) {
                                  
                                  if (success) {
                                      success(resultObj);
                                  }
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}

//重置密码
//+ (void)resetPasswordWithParams:(NSDictionary *)param
//                        success:(void(^)(id DFUserModel))success
//                        failure:(void(^)(HttpException * e))failure
//{
//    [[HttpClient sharedInstance] post:NW_resetPassword
//                               params:param
//                              success:^(id resultObj) {
//                                  
//                                  if (success) {
//                                      success(resultObj);
//                                  }
//                              }
//                              failure:^(HttpException *e) {
//                                  DebugLog(@"%@",e);
//                                  if (failure) {
//                                      failure(e);
//                                  }
//                              }];
//}

//修改密码
+ (void)updatePasswordWithParams:(NSDictionary *)param
                         success:(void(^)(id DFUserModel))success
                         failure:(void(^)(HttpException * e))failure
{
    [[HttpClient sharedInstance] put:NW_updatePassword
                               params:param
                              success:^(id resultObj) {
                                  
                                  BaseAPIModel *model = [BaseAPIModel parse:resultObj];
                                  
                                  if (success) {
                                      success(model);
                                  }
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}

//+ (void)sendFindPwdVerifyCodeWithParams:(NSDictionary *)param
//                                success:(void(^)(id DFUserModel))success
//                                failure:(void(^)(HttpException * e))failure
//{
//    [[HttpClient sharedInstance] post:NW_queryMemberDetail
//                               params:param
//                              success:^(id resultObj) {
//                                  
//                                  if (success) {
//                                      success(resultObj);
//                                  }
//                              }
//                              failure:^(HttpException *e) {
//                                  DebugLog(@"%@",e);
//                                  if (failure) {
//                                      failure(e);
//                                  }
//                              }];
//}
//
//+ (void)saveMemberInfoWithParams:(NSDictionary *)param
//                         success:(void(^)(id DFUserModel))success
//                         failure:(void(^)(HttpException * e))failure
//{
//    [[HttpClient sharedInstance] post:NW_queryMemberDetail
//                               params:param
//                              success:^(id resultObj) {
//                                  
//                                  if (success) {
//                                      success(resultObj);
//                                  }
//                              }
//                              failure:^(HttpException *e) {
//                                  DebugLog(@"%@",e);
//                                  if (failure) {
//                                      failure(e);
//                                  }
//                              }];
//}
+ (void)tokenValidWithParams:(NSDictionary *)param
                     success:(void(^)(id obj))success
                     failure:(void(^)(HttpException * e))failure
{
    HttpClientMgr.progressEnabled=NO;
    [HttpClientMgr post:TokenValid
                               params:param
                              success:^(id resultObj) {
                                  BaseAPIModel *objModel = [BaseAPIModel parse:resultObj];
                                  if (success) {
                                      success(objModel);
                                  }
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}


+ (void)InviterCheckWithParams:(MbrInviterCheckR *)param
                       success:(void(^)(id obj))success
                       failure:(void(^)(HttpException * e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:QueryCommendPersonPhone
                               params:[param dictionaryModel]
                              success:^(id resultObj) {
                                  if ([resultObj[@"apiStatus"] integerValue] == 0) {
                                      if (success) {
                                          success(resultObj);
                                      }
                                  }
                                 
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}


//2.1.4 URL地址更改为api/mbr/inviter  repaired by lijian
+ (void)InviteWithParams:(MbrInviterR *)param
                 success:(void(^)(id obj))success
                 failure:(void(^)(HttpException * e))failure
{
    [HttpClientMgr put:QueryCimmitPersonPhone params:[param dictionaryModel] success:^(id responseObj) {
        
        MyInviterModel *model = [MyInviterModel parse:responseObj];
        if (success) {
            success(model);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
    
}

/**
 *  3.5.5	用户注册(OK)
 */
+ (void)mbrRegisterParams:(MbrRegisterR *)params
                  success:(void(^)(id obj))success
                  failure:(void(^)(HttpException * e))failure{
    params.branchId = [QWGLOBALMANAGER getMapBranchId];
    [[HttpClient sharedInstance]post:NW_register params:[params dictionaryModel] success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
        
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
    
}

+ (void)mbrRecommendShareWithParams:(NSDictionary *)params
                            success:(void(^)(id obj))success
                            failure:(void(^)(HttpException * e))failure
{
    [[HttpClient sharedInstance]get:MbrRecommendShare params:params success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
        
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)mbrRecommendGetRecommendUrlWithParams:(NSDictionary *)params
                                      success:(void(^)(id obj))success
                                      failure:(void(^)(HttpException * e))failure
{
    [[HttpClient sharedInstance]get:MbrRecommendGetRecommendUrl params:params success:^(id responseObj) {
        if (success) {
            success(responseObj);
        }
        
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}


+ (void)UserCollectTags:(MbrInviterCheckR *)model success:(void (^)(id))success failure:(void (^)(HttpException *))failure{
    
    [[HttpClient sharedInstance] get:UserInfoTag params:[model dictionaryModel] success:^(id responseObj) {
        
        UserInfoTagModel *info = [UserInfoTagModel parse:responseObj];
        
        if (success) {
            success(info);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

//家庭用药new图标，是否显示
+ (void)familyTag:(MbrInviterCheckR *)model success:(void (^)(id))success failure:(void (^)(HttpException *))failure{
    
    [[HttpClient sharedInstance] get:FamilyNewTag params:[model dictionaryModel] success:^(id responseObj) {
        
        HasNewVO *info = [HasNewVO parse:responseObj];
        
        if (success) {
            success(info);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

//家庭用药消失new图标
+ (void)familyHidTag:(MbrInviterCheckR *)model success:(void (^)(id))success failure:(void (^)(HttpException *))failure{
    
    [[HttpClient sharedInstance] get:FamilyHideNewTag params:[model dictionaryModel] success:^(id responseObj) {
        
        BaseAPIModel *info = [BaseAPIModel parse:responseObj];
        
        if (success) {
            success(info);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)getInviteInfo:(MbrInviterInfoModelR *)model success:(void (^)(id obj))success failure:(void (^)(HttpException *e))failure
{
    HttpClientMgr.progressEnabled = NO;
    [[HttpClient sharedInstance] get:GetInviteInfo params:[model dictionaryModel] success:^(id responseObj) {
        
        InviterInfoModel *info = [InviterInfoModel parse:responseObj];
        
        if (success) {
            success(info);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)bindWeiXin:(BindModelR*)model success:(void (^)(BaseAPIModel* obj))success failure:(void (^)(HttpException *e))failure
{
    [[HttpClient sharedInstance] post:API_BindWeixin params:[model dictionaryModel] success:^(id responseObj) {
        BaseAPIModel* responseModel = [BaseAPIModel parse:responseObj];
        if (success) {
            success(responseModel);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}

+ (void)bindQQ:(BindModelR*)model success:(void (^)(BaseAPIModel* obj))success failure:(void (^)(HttpException *e))failure
{
    [[HttpClient sharedInstance] post:API_BindQQ params:[model dictionaryModel] success:^(id responseObj) {
        BaseAPIModel* responseModel = [BaseAPIModel parse:responseObj];
        if (success) {
            success(responseModel);
        }
    } failure:^(HttpException *e) {
        DebugLog(@"%@",e);
        if (failure) {
            failure(e);
        }
    }];
}
+ (void)queryServiceTelSuccess:(void(^)(ServiceTelModel *obj))success failure:(void (^)(HttpException *e))failure{
    [[HttpClient sharedInstance] get:GetServiceTelLists params:nil success:^(id responseObj) {
        ServiceTelModel *model = [ServiceTelModel parse:responseObj];
        if (success) {
            success(model);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}

/**
 *  4.0.0 赠送大礼包
 */
+ (void)presentGift:(PresentGiftR *)presentGiftR
            success:(void (^)(PresentGiftModel *))success
            failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] postWithoutProgress:API_RegiterForPresentGift params:[presentGiftR dictionaryModel] success:^(id responseObj) {
        PresentGiftModel* model = [PresentGiftModel parse:responseObj];
        if (success) {
            success(model);
        }
    } failure:^(HttpException *e) {
        if (failure) {
            failure(e);
        }
    }];
}
@end
