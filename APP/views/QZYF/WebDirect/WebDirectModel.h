//
//  WebDirectModel.h
//  APP
//
//  Created by PerryChen on 8/21/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "BaseModel.h"
#import "MapInfoModel.h"
#import "WebDirectMacro.h"

// H5 返回的跳转本地界面所需要的参数
@interface WebDirectParamsModel : BaseModel
/**
 H5 跳转 H5 链接所需要的ID：
 症状ID，疾病ID，专题ID，资讯ID，优惠细则ID, 药品ID
 H5 跳转 本地 所需要的ID：
 跳转A类疾病的ID，大家都在问专区的ID，药品列表的疾病ID，慢病优惠券的优惠ID，专题评论的专题ID，优惠券使用成功的优惠券ID，优惠商品的ID
 */
@property (nonatomic, strong) NSString *mktgId;//会员营销ID

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *promotionId;        // 药品详情的促销Id
@property (nonatomic, strong) NSString *zufangId;           // 跳转药品列表的组方ID
@property (nonatomic, strong) NSString *branchId;           // 药房ID
@property (nonatomic, strong) NSString *consultTitle;       // 咨询页面，咨询标题
@property (nonatomic, strong) NSString *drugId;             // 跳转聊天页面的药品ID
@property (nonatomic, strong) NSString *drugImgUrl;         // 跳转聊天页面的药品图片URL
@property (nonatomic, strong) NSString *drugName;           // 跳转聊天页面的药品名称
@property (nonatomic, strong) NSString *label;              // 跳转聊天页面的knowledgetitle
@property (nonatomic, strong) NSString *token;              // token (暂时没用)
@property (nonatomic, strong) NSString *pid;                // 跳转查看更多药房的药品id
@property (nonatomic, strong) NSString *groupCount;         // (暂时没用)
@property (nonatomic, strong) NSString *attentionId;        // 跳转慢病详情的慢病id
@property (nonatomic, strong) NSString *drugGuideId;        // 跳转慢病详情的用药指导id
@property (nonatomic, strong) NSString *groupId;            // 跳转慢病优惠券的药店id
@property (nonatomic, strong) NSString *title;              // 慢病详情标题, H5的分享标题
@property (nonatomic, strong) NSString *limitQty;           // 抢购数量上限
@property (nonatomic, strong) NSString *diseaseName;        // 跳转本地的疾病页面的疾病名称
@property (nonatomic, strong) NSString *type;               // 优惠细则的页面类型
@property (nonatomic, strong) NSString *myCouponId;         // (暂时没用)
@property (nonatomic, strong) NSString *proid;              // 优惠活动列表ID
@property (nonatomic, strong) NSString *hasAddress;         // 是否有收货地址
@property (nonatomic, strong) NSString *code;               // 商品比价页面所需要的code

@property (nonatomic, strong) NSString *branchName;
@property (nonatomic, strong) NSString *branchProId;
@property (nonatomic, strong) NSString *ProCode;
@property (nonatomic, strong) NSString *proName;
@property (nonatomic, strong) NSString *proBrand;
@property (nonatomic, strong) NSString *proSpec;
@property (nonatomic, strong) NSString *proImgUrl;
@property (nonatomic, strong) NSString *proPrice;

@property (nonatomic, assign) NSInteger proStock;
@property (nonatomic, assign) NSInteger saleStock;
@property (nonatomic ,strong) NSString  *proPromotionId;
@property (nonatomic ,strong) NSString  *value;

@property (nonatomic, strong) NSString *couponId;           // 优惠券id

@property (nonatomic, strong) NSString *nMes;             // 是否是V3.0新增的资讯跳转的评论接口

@end

// H5 主动跳转设置参数的MODEL
@interface WebDirectModel : BaseModel

@property (nonatomic, strong) NSString *jumpType;           // 界面跳转类型 1 是跳转本地。 2是跳转H5
@property (nonatomic, strong) NSString *pageType;           // H5跳转本地的界面类型
@property (nonatomic, strong) NSString *title;              // H5页面的标题
@property (nonatomic, strong) NSString *url;                // 跳转H5的URL
@property (nonatomic, strong) NSString *progressbar;        // 是否显示进度条
@property (nonatomic, strong) WebDirectParamsModel *params; // H5返回的参数Model

@end

// 本地跳转健康资讯页面，所需要的Model
@interface WebHealthInfoModel : BaseModel
@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSString *msgID;
@property (nonatomic, strong) NSString *contentType;        // 1:复文本, 2:图文模式
@end

// 本地跳转资讯详情页面，所需要的Model
@interface WebInfoMsgModel : BaseModel
@property (nonatomic, strong) NSString *msgID;
@property (nonatomic, strong) NSString *contentType;        // 1:复文本, 2:图文模式
@end

// 本地跳转问答详情所需要的Model
@interface WebAnswerModel : BaseModel
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@end

// 本地跳转优惠细则详情页面，所需要的优惠券model
@interface WebCouponConditionModel : BaseModel
@property (nonatomic, strong) NSString *couponId;
@property (nonatomic, strong) NSString *type;
@end

// 本地跳转H5的症状详情页面，所需要的症状详情model
@interface WebSymptomDetailModel : BaseModel
@property (nonatomic, strong) NSString *symptomId;
@end

// 本地跳转H5的疾病详情页面，所需要的疾病信息model
@interface WebDiseaseDetailModel : BaseModel
@property (nonatomic, strong) NSString *diseaseId;
@end

// 本地跳转H5的健康自测详情页面，所需要的自测model
@interface WebHealthCheckDetailModel : BaseModel
@property (nonatomic, strong) NSString *checkTestId;
@end

// 本地跳转H5的药品详情页面，所需要的药品信息model
@interface WebDrugDetailModel : BaseModel
@property (nonatomic, strong) MapInfoModel *modelMap;
@property (nonatomic, strong) NSString *showDrug;       // 1展示药品促销标签
@property (nonatomic, strong) NSString *proDrugID;      // 药品ID
@property (nonatomic, strong) NSString *promotionID;    // 促销ID
@property (nonatomic, strong) NSString *activityID;    // 抢购活动的ID
@end

@interface WebOrderDetailModel : BaseModel
@property (nonatomic, strong) NSString* orderId;                      // 订单的ID
@property (nonatomic, strong) NSString* orderIdName;                      // 订单的药店
@property (nonatomic, strong) NSString* orderCode;                      // 订单的药店
@end


// 本地跳转H5的页面, 所需要的信息Model
@interface WebDirectLocalModel : WebDirectModel
@property (nonatomic, strong) WebDrugDetailModel *modelDrug;            // 药品详情的model
@property (nonatomic, strong) WebDiseaseDetailModel *modelDisease;      // 疾病详情的Model
@property (nonatomic, strong) WebSymptomDetailModel *modelSymptom;      // 症状详情的Model
@property (nonatomic, strong) WebHealthInfoModel *modelHealInfo;        // 健康资讯的Model
@property (nonatomic, strong) WebCouponConditionModel *modelCondition;  // 优惠详情的model
@property (nonatomic, strong) WebHealthCheckDetailModel *modelHealthCheck; //健康自测的model
@property (nonatomic, strong) WebInfoMsgModel *modelInfoMsg;            // 资讯详情的Model V3.0新增
@property (nonatomic, strong) NSString *strParams;                      // 专题或者专区的参数URL
@property (nonatomic, assign) LocalShareType typeShare;                 // 本地跳转H5的分享页面类型
@property (nonatomic, assign) WebLocalType typeLocalWeb;                // 本地跳转H5的界面类型
@property (nonatomic, assign) WebTitleType typeTitle;                   // 设置导航栏的右上角逻辑
@property (nonatomic, assign) BOOL isSpecial;                           // 是否是专刊
@property (nonatomic, assign) BOOL isFromPushNoti;                      // 是否是从推送进入
@property (nonatomic, strong) WebOrderDetailModel *modelOrder;            // 订单详情的model
@property (nonatomic, strong) WebAnswerModel *modelAnswer;              // 问答详情Model
@end

// H5调用原生代码所需要的参数的model。包含分享，电话，弹框等
@interface WebPluginParamsModel : BaseModel
@property (nonatomic, strong) NSString *shareType;              // h5分享类型
@property (nonatomic, strong) NSString *title;                  // h5替换的标题
@property (nonatomic, strong) NSString *img_url;                // h5分享的图片URL
@property (nonatomic, strong) NSString *content;                // h5分享的内容
@property (nonatomic, strong) NSString *objId;                  // h5分享的类型id
@end

// H5调用原生代码所需要的model
@interface WebPluginModel : BaseModel
@property (nonatomic, strong) NSString *type;                   // 1：title替换  2：打电话   3：分享   4：提示框
@property (nonatomic, strong) NSString *url;                    // h5分享的链接
@property (nonatomic, strong) NSString *message;                // 打电话的电话号码和提示框的信息
@property (nonatomic, strong) WebPluginParamsModel *params;     // h5 回调参数model
@end


