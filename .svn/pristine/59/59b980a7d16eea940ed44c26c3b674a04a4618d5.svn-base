//
//  WebDirectViewController.h
//  APP
//
//  Created by PerryChen on 8/20/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "QWBaseVC.h"
#import "WebDirectModel.h"
#import "QWWebViewController.h"
#import "ReturnIndexView.h"
#import "WebDirectMacro.h"
#import "QWCallbackPluginExt.h"

typedef void (^InfoListRefreshBlock)(BOOL success);

@protocol WebDirectBackDelegate <NSObject>

//- (void)backToFreshTitle;                   // 慢病订阅资讯返回, 通知H5刷新new字段
//- (void)backToFreshList;                    // 添加慢病专区返回, 通知H5刷新慢病页面
- (void)needUpdateInfoList:(BOOL)needUp;    // 从H5资讯详情返回后，刷新本地资讯列表
//- (void)backFromSlowGuide;                  // 通知H5 跳过慢病引导页
//- (void)backToMyCollectTopic;               // 通知专题专刊更新
/**
 回调H5的统一方法(V2.2.0之后统一用这个)
 */
- (void)runCallbackWithPageType:(NSString *)strType;
- (void)runCallbackWithTypeID:(CallbackType)typeCallback;
@end



@interface WebDirectViewController : QWWebViewController<WebDirectBackDelegate>
@property (nonatomic, strong) WebDirectModel *modelDir;         // H5 返回的参数
@property (nonatomic, strong) NSString *webURL;
@property (nonatomic, strong) ReturnIndexView *indexView;
@property (nonatomic, copy) InfoListRefreshBlock blockInfoList;

@property (nonatomic, assign) LocalShareType typeShare;         // 本地跳转H5的分享类型
@property (nonatomic, strong) QWCallbackPluginExt *extShare;    // 回调H5的插件对象
@property (nonatomic, assign) BOOL showConsultBtn;              // 显示咨询按钮
@property (nonatomic, assign) BOOL isOtherLinks;                // 外链
@property (nonatomic, assign) BOOL didSetShare;                 // 是否已经设置了分享，优先级高
@property (nonatomic, assign) BOOL isSpecial;                   // 是否是特刊
@property (nonatomic, assign) NSInteger pageType;               // HTML 页面类型
@property (nonatomic, weak) id<WebDirectBackDelegate> callBackDelegate;
@property (nonatomic,assign) BOOL isComeFromCredit;
@property (nonatomic,assign) BOOL isComeFromPur;
@property (nonatomic,assign) BOOL isComeFromChannel;
@property (nonatomic,assign) NSInteger zhuanQuId;
@property (nonatomic,copy) void(^winAlert)();                   //中奖纪录填写完弹提示
@property (nonatomic, assign) BOOL showCustomLoading;
//支付用到的逻辑
@property (nonatomic, assign) BOOL payButton;                   // 是否禁止右滑
@property (nonatomic, strong) NSString *isComeFromConfirm;             //1从订单详情页面进入 2订单列表
@property (nonatomic, assign) BOOL isUp;                   // 是否出栈
@property (nonatomic, assign) BOOL NeedTwoTab;
@property (nonatomic, strong, readonly) WebDirectLocalModel *modelLocal;

- (void)setWVWithURL:(NSString *)strURL title:(NSString *)strTitle withType:(WebTitleType)enumType;
- (void)setWVWithURL:(NSString *)strURL title:(NSString *)strTitle withType:(WebTitleType)enumType withShareType:(LocalShareType)enumShareType;     // 需要在下级页面获取分享信息的时候用这个方法

// H5跳转H5时根据H5的返回值设置相应内容
- (void)setWVWithModel:(WebDirectModel *)modelDir withType:(WebTitleType)enumType;
// 本地跳转H5时设置相应HTML界面信息
- (void)setWVWithLocalModel:(WebDirectLocalModel *)modelDir;

// 跳转本地界面
- (void)jumpToLocalVC:(WebDirectModel *)modelDir;
// 跳转H5页面
- (void)jumpToH5Page:(WebDirectModel *)modelDir;
//跳转到支付界面
- (void)actionWithAliPayInfo:(NSString *)orderInfo withObjId:(NSString*)objId;

//跳转到微信支付界面
- (void)actionWithWetChatPayInfo:(NSString *)orderInfo withObjId:(NSString*)objId;

// H5 主调的方法
- (void)actionShare:(WebPluginModel *)modelPlugin;      // H5通知分享
- (void)showAlertWithMessage:(NSString *)strMsg;        // H5通知弹框

- (void)actionPhoneWithNumber:(NSString *)phoneNum;         // H5通知打电话
- (void)actionHideShareBtn;                             // 隐藏分享按钮
- (void)showLoading;                                    // 显示原生loading 框
- (void)hideLoading;                                    // 隐藏原生loading 框
- (void)popCurVC;                                       // 跳出当前页面

- (void)actionShowShare;                                // 显示导航栏分享

- (void)actionInformH5:(CallbackType)typeCallback;      // 原生通知H5进行操作，需要传入类型ID，详见 CallbackType

//- (void)actionCommentRefresh;       // 通知专题详情页面刷新评论列表
//- (void)actionCouponTitle;          // 通知药品详情H5页面立即领取按钮置灰逻辑
@end
