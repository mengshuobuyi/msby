//
//  AppDelegate.m
//  APP
//
//  Created by carret on 15/1/16.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "AppDelegate.h"
#import "SystemMacro.h"
#import "HttpClient.h"
#import "css.h"
#import "QWcss.h"
#import "QWGlobalManager.h"
#import "Mbr.h"
//版本更新
#import "VersionUpdate.h"
#import "QWYSViewController.h"
#import "System.h"
#import "LoginViewController.h"
#import "SVProgressHUD.h"
#import "DrugGuideModelR.h"
#import "DrugGuideApi.h"
#import "DrugGuideModel.h"

#import "Consult.h"
#import "ConsultModelR.h"
#import "ConsultModel.h"
#import "CircleMsgRootViewController.h"
//#import "WYLocalNotifVC.h"
#import "WYLocalNotifDetailVC.h"
#import "QWLocalNotif.h"
#import "QWCommon.h"
#import "PayInfo.h"

#import "NotificationModel.h"
#import "DetailSubscriptionListViewController.h"
#import "IndentDetailListViewController.h"
#import "DrugGuideModel.h"
#import "HomePageViewController.h"

#import "LoginViewController.h"
#import "UMSocial.h"

#import "UMSocialSinaSSOHandler.h"
#import "UMSocialQQHandler.h"
#import "AppFadeCover.h"
#import "ChatViewController.h"
#import "XPChatViewController.h"

#import "WebDirectViewController.h"
#import "CouponPharmacyDeailViewController.h"
#import "CenterCouponDetailViewController.h"
#import "MyCouponDetailViewController.h"
#import "MyCouponDrugDetailViewController.h"
#import "MsgNotiListViewController.h"
#import "MyCouponQuanViewController.h"
#import "MyCouponDrugViewController.h"
#import "SplashView.h"
#import "CustomInfoAlertView.h"
#import "Forum.h"
#import "ExpertInfoViewController.h"
#import "WXApi.h"
#import "PostDetailViewController.h"     // 帖子详情页面
#import "PrivateChatViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "MsgCouponListViewController.h"
#import "HealthViewController.h"
#import "AboutWenYaoViewController.h"
#import "NewPersonInformationViewController.h"
#import "CreditRecordViewController.h"

//AES加密 秘钥
#import "AESUtil.h"
#define AES_KEY @"Ao6IFeRFTsXuaD681snWCk" //key可修改

@interface AppDelegate() <CustomInfoAlertDelegate>

@property (nonatomic, strong) NSDictionary *dicNotiBody;
@end
@implementation AppDelegate 
@synthesize window;

#pragma mark － 启动
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //微信支付初始化,在后台注册app id
    [WXApi registerApp:appWXID withDescription:@"wenyao 4.0.0"];
    //talking
    [QWCLICKEVENT qwTrackInit:appTalkingDataID withChannelId:@"AppStore"];
    [TalkingDataAppCpa init:ADTackingID withChannelId:@"AppStore"];
    [self addObserverGlobal];
    [QWUserDefault setNumber:[NSNumber numberWithLongLong:0] key:SERVER_TIME];
    [QWGLOBALMANAGER createHeartBeatTimer];

#pragma mark 推送通知
    NSDictionary *dicNotice = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (dicNotice) {
        [self application:application didReceiveRemoteNotification:dicNotice];
    }
    
#pragma mark 启动闹钟详情
    UILocalNotification * localNotify = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if(localNotify)
    {
        [self application:application didReceiveLocalNotification:localNotify];
    }
    else {
        //重置闹钟
        [[QWLocalNotif instance] resetAllLN];
    }
    //先设置定义  域名是否被封的测试
    //cj----cj
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *apiUrl = [def objectForKey:@"APIDOMAIN"];
    NSString *h5Url = [def objectForKey:@"H5DOMAIN"];
    if(!StrIsEmpty(apiUrl)){
        [HttpClientMgr setBaseUrl:apiUrl];
    }else{
        [HttpClientMgr setBaseUrl:BASE_URL_V2];
    }
    //请求第一个域名
    [self queryOnceDomain];
    
    // 正式运行
    
    NSDictionary * userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if(userInfo)
    {
        // 从推送启动的
//        self.dicNotiBody = userInfo;
//        [self application:application didReceiveRemoteNotification:userInfo];
        [self initforLaunchWithApplication:application Option:userInfo];
    } else {
        // 正常启动的
        self.dicNotiBody = nil;
        [self initforLaunchWithApplication:application Option:nil];
        
    }
    
    [self initLogSetting];
   
    return YES;
}


-(void)setStartApp{
    
    //重新默认
    //cj----cj
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *apiUrl = [def objectForKey:@"APIDOMAIN"];
    NSString *h5Url = [def objectForKey:@"H5DOMAIN"];
    if(!StrIsEmpty(apiUrl)){
        [HttpClientMgr setBaseUrl:apiUrl];
    }else{
        [HttpClientMgr setBaseUrl:BASE_URL_V2];
    }
    
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:APP_LAST_SYSTEM_VERSION_V2];
    if(!lastVersion || ![lastVersion isEqualToString:APP_VERSION]) {
        [[NSUserDefaults standardUserDefaults] setObject:APP_VERSION forKey:APP_LAST_SYSTEM_VERSION_V2];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    [QWGLOBALMANAGER saveOperateLog:@"3"];
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    //强制使用图形验证码
    [QWGLOBALMANAGER getForceSecuritySwitch];
    //获取统计商家的接口信息
    [QWGLOBALMANAGER getStatisBranchArray];
    // 获取保存积分规则
    [QWGLOBALMANAGER queryAndSaveCreditRules];
    // 获取用户基础信息
    [self getBaseInfo];
    [self setPushNoti];
    
    [QWGLOBALMANAGER postNotif:NotifPushViewAfterStartUp data:nil object:nil];
}

-(void)returnSetStartApp{
    //不变
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    [user removeObjectForKey:@"APIDOMAIN"];
    [user removeObjectForKey:@"H5DOMAIN"];
    [user synchronize];
    
    [HttpClientMgr setBaseUrl:BASE_URL_V2];
    
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:APP_LAST_SYSTEM_VERSION_V2];
    if(!lastVersion || ![lastVersion isEqualToString:APP_VERSION]) {
        //        [QWGLOBALMANAGER clearOldCache];
        [[NSUserDefaults standardUserDefaults] setObject:APP_VERSION forKey:APP_LAST_SYSTEM_VERSION_V2];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    [QWGLOBALMANAGER saveOperateLog:@"3"];
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    //获取强制使用图形验证码
    [QWGLOBALMANAGER getForceSecuritySwitch];
    //获取统计商家的接口信息
    [QWGLOBALMANAGER getStatisBranchArray];
    // 获取保存积分规则
    [QWGLOBALMANAGER queryAndSaveCreditRules];
    // 获取用户基础信息
    [self getBaseInfo];
    [self setPushNoti];
    [QWGLOBALMANAGER postNotif:NotifPushViewAfterStartUp data:nil object:nil];
}

- (void)setPushNoti
{
//    if (self.dicNotiBody!=nil) {
//      [self application:[UIApplication sharedApplication] didReceiveRemoteNotification:self.dicNotiBody];
//    }
}

- (void)delayPushVC
{
    [self performSelector:@selector(pushNotiVC) withObject:nil afterDelay:1.0];
}

- (void)pushNotiVC
{
    if (self.dicNotiBody != nil) {
//        [self application:[UIApplication sharedApplication] didReceiveRemoteNotification:self.dicNotiBody];
        [self handleRemoteNotificationWihtInfo:self.dicNotiBody canJump:YES];
        self.dicNotiBody = nil;
    }
}

-(void)queryOnceDomain{
    
    NSDictionary *setting=[NSDictionary dictionary];
    
    [System systemDomainIsParams:setting success:^(id obj) {
        DomianIsModel *model=[DomianIsModel parse:obj];
        //当检查出来域名是否被封, true: 正常， false：被封
        if([model.apiStatus intValue]==0){
            if(model.domainFlag){
                //不变
                [self returnSetStartApp];
                return ;
            }else{
                //获取新的域名
                [System systemNewDomainParams:setting success:^(id resobj) {
                    DomianModel *resmodel=[DomianModel parse:resobj];
                    if([resmodel.apiStatus intValue]==0){
                        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
                        [def setObject:[NSString stringWithFormat:@"%@/",resmodel.apiDomain] forKey:@"APIDOMAIN"];
                        [def setObject:[NSString stringWithFormat:@"%@/",resmodel.h5Domain] forKey:@"H5DOMAIN"];
                    }
                    //结束了以后重新设置域名  冗错
                    [self setStartApp];
                }failure:^(HttpException *e) {
                    //结束了以后重新设置域名  冗错
                    [self setStartApp];
                }];
                
            }
            
        }else{
            //请求第二个域名
            [self queryTwiceDomain];
        }
        
    }failure:^(HttpException *e) {
        //请求第二个域名
        [self queryTwiceDomain];
    }];
    
}


-(void)queryTwiceDomain{
    
    NSDictionary *setting=[NSDictionary dictionary];
    [System systemDomainIsTwiceParams:setting success:^(id obj) {
        DomianIsModel *model=[DomianIsModel parse:obj];
        //当检查出来域名是否被封, true: 正常， false：被封
        if([model.apiStatus intValue]==0){
            if(model.domainFlag){
                //不变
                [self returnSetStartApp];
                return ;
            }else{
                //获取新的域名
                [System systemNewDomainTwiceParams:setting success:^(id resobj) {
                    DomianModel *resmodel=[DomianModel parse:resobj];
                    if([resmodel.apiStatus intValue]==0){
                        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
                        [def setObject:[NSString stringWithFormat:@"%@/",resmodel.apiDomain] forKey:@"APIDOMAIN"];
                        [def setObject:[NSString stringWithFormat:@"%@/",resmodel.h5Domain] forKey:@"H5DOMAIN"];
                    }
                    //结束了以后重新设置域名  冗错
                    [self setStartApp];
                }failure:^(HttpException *e) {
                    //结束了以后重新设置域名  冗错
                    [self setStartApp];
                }];
                
            }
        }else{
            //结束了以后重新设置域名  冗错
            [self setStartApp];
        }
    }failure:^(HttpException *e) {
        //结束了以后重新设置域名  冗错
        [self setStartApp];
    }];
    
}

- (void)initLogSetting
{
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat: @"Documents/Log/"]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:path]){
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:[[DDLogFileManagerDefault alloc] initWithLogsDirectory:path]];
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 1;
    [DDLog addLogger:fileLogger];
}

- (QWTabBar *)currentTabBar
{
    return self.mainVC.currentTabbar;
}

- (BOOL)isMainTab
{
    return self.mainVC.currentTabbar == self.mainVC.tabbarTwo;
}

- (void)getBaseInfo
{
    if (!StrIsEmpty(QWGLOBALMANAGER.configure.userToken)) {
        [QWGLOBALMANAGER getUserBaseInfo];
    }
}

- (void)didPostNoti
{
    [self application:nil didReceiveRemoteNotification:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    QWGLOBALMANAGER.boolLoadFromFirstIn = NO;
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}



/**
 *  @brief 获取当前时间,并且存到本地
 */
- (void)saveNowDateToLocal
{
    NSDate *nowDate = [NSDate date];
    [QWUserDefault setObject:nowDate key:kApplicationLastAliveDate];
}

//读取上次保存的日期,并且计算与当前日期的时间间隔
- (BOOL)compareDateInterval:(NSInteger)times
{
    //历史时间
    NSDate *presentDate = [QWUserDefault getObjectBy:kApplicationLastAliveDate];
    DebugLog(@"开始进入后台 = %@",presentDate);
    
    //当前时间
    NSDate *nowDate = [NSDate date];
    DebugLog(@"开始进入前台 = %@",nowDate);
    
    NSTimeInterval timeInterval = [nowDate timeIntervalSinceDate:presentDate];
    
    
    DebugLog(@"在后台时间 = %f",timeInterval);
    
    if (timeInterval >= (60*60 *times)) {
        return YES;
    }
    return NO;
    
}

//程序进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [QWGLOBALMANAGER postNotif:NotifAppWillEnterForeground data:nil object:nil];
    [QWGLOBALMANAGER enablePushNotification:NO];
    BOOL post = [self compareDateInterval:1];
    //后台进前台,超过1小时才定位
//    if (post) {
        [QWGLOBALMANAGER postNotif:NotifLocationNeedReload data:nil object:nil];
//    }
    post = [self compareDateInterval:0.167];
    if(post) {
        [QWGLOBALMANAGER upLoadLogFile];
    }
}

//程序进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [QWGLOBALMANAGER postNotif:NotifAppDidEnterBackground data:nil object:nil];
    [QWGLOBALMANAGER enablePushNotification:YES];
    [QWGLOBALMANAGER applicationDidEnterBackground];
    
    [self saveNowDateToLocal];
    if (QWGLOBALMANAGER.loginStatus == YES) {
        //        NSInteger intTotal = 0;
        //        NSArray *arrCached = [HistoryMessages getArrayFromDBWithWhere:nil];
        //        for (int i = 0; i < arrCached.count; i++) {
        //            HistoryMessages *model = (HistoryMessages *)arrCached[i];
        //            [HistoryMessages updateObjToDB:model WithKey:[NSString stringWithFormat:@"%@",model.relatedid]];
        //            intTotal += [model.systemUnreadCounts intValue];
        //            intTotal += [model.unreadCounts intValue];
        //        }
        //        [QWGLOBALMANAGER updateRedPoint];
        [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber;
        //        [QWGLOBALMANAGER updateUnreadCountBadge:intTotal];
    }
    [QWGLOBALMANAGER statisticsEventId:@"x_tc" withLable:@"进入后台" withParams:nil];
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
//    [[[UIAlertView alloc] initWithTitle:@"测试弹框" message:@"hahahaha" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil] show];
    [QWGLOBALMANAGER postNotif:NotifAppDidBecomeActive data:nil object:nil];
    [QWGLOBALMANAGER applicationDidBecomeActive];
    
    
    [QWUserDefault setNumber:[NSNumber numberWithLongLong:0] key:SERVER_TIME];
    [QWGLOBALMANAGER createHeartBeatTimer];
    //强制使用图形验证码
    [QWGLOBALMANAGER getForceSecuritySwitch];
    //获取统计商家的接口信息
    [QWGLOBALMANAGER getStatisBranchArray];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSString *where = [NSString stringWithFormat:@"messagetype = '%d' or messagetype = '%d'",MessageMediaTypeMedicineShowOnce,MessageMediaTypeMedicineSpecialOffersShowOnce];
    [QWPTPMessage deleteObjFromDBWithWhere:where];
    [QWGLOBALMANAGER postNotif:NotifAppWillTerminal data:nil object:nil];
    
}
#pragma mark - 闹钟
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if ([QWUserDefault getBoolBy:APP_Alarm_VIBRATION_ENABLE] == YES) {
        [QWCommon invokeVibration];
    }

    NSMutableDictionary *info = [NSMutableDictionary dictionaryWithDictionary:[notification userInfo]];

    WYLocalNotifModel *ln=[WYLocalNotifModel parse:info];
    if (application.applicationState==UIApplicationStateInactive || application.applicationState==UIApplicationStateBackground) {

        WYLocalNotifModel *mode=nil;
        
        id obj=[[QWLocalNotif instance] getLNList];
        if ([obj isKindOfClass:[NSMutableArray class]]) {
            for (WYLocalNotifModel *mm in obj) {
//                if (info[@"hashValue"] && [info[@"hashValue"] isEqualToString:mm.hashValue]) {
                if (ln.hashValue && [ln.hashValue isEqualToString:mm.hashValue]) {
                    mode=mm;
                    break;
                }
            }
        }
        
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LocalNotif" bundle:nil];
        WYLocalNotifDetailVC* vc = [sb instantiateViewControllerWithIdentifier:@"WYLocalNotifDetailVC"];
        vc.backButtonEnabled=YES;
        vc.modLocalNotif=mode;
        vc.listClock=obj;
        
        UINavigationController *nav = [[QWBaseNavigationController alloc] initWithRootViewController:vc];
        if(QWGLOBALMANAGER.tabBar.presentedViewController){
            
        }else{
            [QWGLOBALMANAGER.tabBar presentViewController:nav animated:NO completion:^{
            }];
        }
    }
    else if(application.applicationState==UIApplicationStateActive){
        //app使用状态
        if (info[@"type"] && [info[@"type"] isEqualToString:@"DrugClock"]) {
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@的用药：%@",info[@"productUser"],info[@"productName"]] delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"亲，到点用药啦～" message:[NSString stringWithFormat:@"%@",info[@"productName"]] delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            alert.tag = 319;
            [alert show];
        }
        //清通知栏
        int badgeCount = [UIApplication sharedApplication].applicationIconBadgeNumber;
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badgeCount];
    }
}




#pragma mark -
#pragma mark PushNotification Delegate
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)_deviceToken
{
    NSString *devStr = [NSString stringWithFormat:@"%@",_deviceToken];
    NSArray *array = [devStr componentsSeparatedByString:@" "];
    QWGLOBALMANAGER.deviceToken = [array componentsJoinedByString:@""];
    QWGLOBALMANAGER.deviceToken = [QWGLOBALMANAGER.deviceToken substringWithRange:NSMakeRange(1, QWGLOBALMANAGER.deviceToken.length - 2)];
    if(QWGLOBALMANAGER.loginStatus) {
        UpdateDeviceByTokenModelR *updateDeviceToken = [UpdateDeviceByTokenModelR new];
        updateDeviceToken.token = QWGLOBALMANAGER.configure.userToken;
        updateDeviceToken.deviceCode = QWGLOBALMANAGER.deviceToken;
        [System updateDeviceByToken:[updateDeviceToken dictionaryModel] success:NULL failure:NULL];
    }
    
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    DDLogVerbose(@"%@",error);
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    self.isLaunchByNotification = YES;
    BOOL canJump = FALSE;
    if (application.applicationState==UIApplicationStateInactive || application.applicationState==UIApplicationStateBackground)
    {
        DDLogVerbose(@"。。。。。。。。。。后台收到的通知");
        canJump = TRUE;
    }
    else if(UIApplicationStateActive == application.applicationState)
    {
        DDLogVerbose(@"。。。。。。。。。前台收到的通知");
        canJump = FALSE;
    }
    if (self.dicNotiBody != nil) {
        canJump = TRUE;
    }
    
    [self handleRemoteNotificationWihtInfo:userInfo canJump:canJump];
}

- (void)handleNewRemoteNotificationWihtInfo:(NSDictionary *)userInfo canJump:(BOOL)canJump
{
    NSData *jsonData = [userInfo[@"message"] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    
    NotificationModel *modelHasBug = [NotificationModel parse:dic]; // bug :字段值都是数组
    NotificationModel *model = [modelHasBug fixedStrValueModel];
    if (!model) return;

    NSInteger newType = model.ot.integerValue;
    [QWGLOBALMANAGER noticeUnreadByPushType:newType readFlag:NO newPush:YES];
        
    if (newType == MsgBoxNoticeTypeHealth) {// 健康指南
        if (canJump) {
            [self jumpToHealthGuide];
        }else{
            NSDictionary *aps = [userInfo valueForKey:@"aps"];
            NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
            CustomInfoAlertView *alert=[CustomInfoAlertView instance];
            alert.alertTitle.text = content;
            alert.blockDirect = ^(BOOL success) {
                [self jumpToHealthGuide];
            };
            alert.blockCancel = nil;
            [alert show];
        }
    }
    //            else if (newType == MsgBoxNoticeTypeCoupon) { // 应该还是旧类型
    //            }
    else if (newType == MsgBoxNoticeTypeReport) {
        if (canJump) {
            [self jumpToAboutWenyao];
        }else{
            NSDictionary *aps = [userInfo valueForKey:@"aps"];
            NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
            CustomInfoAlertView *alert=[CustomInfoAlertView instance];
            alert.alertTitle.text = content;
            alert.blockDirect = ^(BOOL success) {
                [self jumpToAboutWenyao];
            };
            alert.blockCancel = nil;
            [alert show];
        }
    }
    else if (newType == MsgBoxNoticeTypeRebindPhone) {
        if (canJump) {
            [self jumpToPersonalInfoDetail];
        }else{
            NSDictionary *aps = [userInfo valueForKey:@"aps"];
            NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
            CustomInfoAlertView *alert=[CustomInfoAlertView instance];
            alert.alertTitle.text = content;
            alert.blockDirect = ^(BOOL success) {
                [self jumpToPersonalInfoDetail];
            };
            alert.blockCancel = nil;
            [alert show];
        }
    }
    else if (newType == MsgBoxNoticeTypeCreditStore) {
        if (canJump) {
            [self jumpToCreditExchangeList];
        }else{
            NSDictionary *aps = [userInfo valueForKey:@"aps"];
            NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
            CustomInfoAlertView *alert=[CustomInfoAlertView instance];
            alert.alertTitle.text = content;
            alert.blockDirect = ^(BOOL success) {
                [self jumpToCreditExchangeList];
            };
            alert.blockCancel = nil;
            [alert show];
        }
    }
    else if (newType == MsgBoxNoticeTypeGoodsCredit || newType == MsgBoxNoticeTypeCreditChanged) {
        if (canJump) {
            [self jumpToCreditDetails];
        }else{
            NSDictionary *aps = [userInfo valueForKey:@"aps"];
            NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
            CustomInfoAlertView *alert=[CustomInfoAlertView instance];
            alert.alertTitle.text = content;
            alert.blockDirect = ^(BOOL success) {
                [self jumpToCreditDetails];
            };
            alert.blockCancel = nil;
            [alert show];
        }
    }
    else if(newType == MsgBoxNoticeTypeOPCoupon)//运营平台代金券推送提醒
    {
//        params[@"代金券提醒"] = @"代金券提醒";
        if(model.nid){
            [CouponNotiListRequest setCouponNotiReadWithMessageId:model.nd];
            //渠道统计 用户行为统计
            ChannerTypeModel *modelTwo=[ChannerTypeModel new];
            modelTwo.objRemark=@"代金券";
            modelTwo.objId=model.nid;
            modelTwo.cKey=@"push_click";
            [QWGLOBALMANAGER qwChannel:modelTwo];
        }
        if (canJump) {
            UITabBarController *vcTab = APPDelegate.currentTabBar;
            UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
            CenterCouponDetailViewController *vcDetail = [[CenterCouponDetailViewController alloc] initWithNibName:@"CenterCouponDetailViewController" bundle:nil];
            vcDetail.couponId = model.objId;
            vcDetail.hidesBottomBarWhenPushed = YES;
            [vcNavi pushViewController:vcDetail animated:YES];
        } else {
            UITabBarController *vcTab = APPDelegate.currentTabBar;
            UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
            QWBaseVC *vcLastObj = (QWBaseVC *)[vcNavi.viewControllers lastObject];
            [vcLastObj.view endEditing:YES];
            [vcNavi.navigationBar endEditing:YES];
            [QWGLOBALMANAGER postNotif:NotifDismssKeyboard data:nil object:nil];
            NSDictionary *aps = [userInfo valueForKey:@"aps"];
            NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
            CustomInfoAlertView *alert=[CustomInfoAlertView instance];
            alert.alertTitle.text = content;
            alert.blockDirect = ^(BOOL success) {
                CenterCouponDetailViewController *vcDetail =[[CenterCouponDetailViewController alloc] initWithNibName:@"CenterCouponDetailViewController" bundle:nil];
                vcDetail.couponId=model.objId;
                vcDetail.hidesBottomBarWhenPushed = YES;
                [vcNavi pushViewController:vcDetail animated:YES];
            };
            alert.blockCancel = ^(BOOL cancel) {
            };
            
            [alert show];
            
        }
    }
    else if(newType == MsgBoxNoticeTypeOPGoodsSales)//运营平台优惠商品推送提醒
    {
//        params[@"优惠商品提醒"] = @"优惠商品提醒";
        if(model.nid){
            [CouponNotiListRequest setCouponNotiReadWithMessageId:model.nd];
            //渠道统计 用户行为统计
            ChannerTypeModel *modelTwo=[ChannerTypeModel new];
            modelTwo.objRemark=@"优惠商品";
            modelTwo.objId=model.nid;
            modelTwo.cKey=@"push_click";
            [QWGLOBALMANAGER qwChannel:modelTwo];
        }
        if (canJump) {
            //                    if (QWGLOBALMANAGER.configure.userToken.length == 0) {
            //                        [self jumpToWebView:[NSString stringWithFormat: @"/app/html/v2.2.0/drugDetail.html?promotionId=%@&token=&showDrug=0",model.objId]titl:@"优惠商品"];
            UITabBarController *vcTab = APPDelegate.currentTabBar;
            UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
            QWBaseVC *vcLastObj = (QWBaseVC *)[vcNavi.viewControllers lastObject];
            WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
            
            MapInfoModel *modelMap = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
            
            WebDrugDetailModel *modelDrug = [WebDrugDetailModel new];
            modelDrug.modelMap = modelMap;
            modelDrug.proDrugID = @"";
            modelDrug.promotionID = model.objId;
            modelDrug.showDrug = @"0";
            WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
            modelLocal.title = @"优惠商品";
            modelLocal.modelDrug = modelDrug;
            modelLocal.typeLocalWeb = WebPageToWebTypeMedicine;
            [vcWebMedicine setWVWithLocalModel:modelLocal];
            vcWebMedicine.hidesBottomBarWhenPushed = YES;
            [vcLastObj.navigationController pushViewController:vcWebMedicine animated:YES];
        } else {
            UITabBarController *vcTab = APPDelegate.currentTabBar;
            UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
            QWBaseVC *vcLastObj = (QWBaseVC *)[vcNavi.viewControllers lastObject];
            [vcLastObj.view endEditing:YES];
            [vcNavi.navigationBar endEditing:YES];
            [QWGLOBALMANAGER postNotif:NotifDismssKeyboard data:nil object:nil];
            NSDictionary *aps = [userInfo valueForKey:@"aps"];
            NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
            CustomInfoAlertView *alert=[CustomInfoAlertView instance];
            alert.alertTitle.text = content;
            alert.blockDirect = ^(BOOL success) {
                
                
                WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
                
                MapInfoModel *modelMap = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
                WebDrugDetailModel *modelDrug = [WebDrugDetailModel new];
                modelDrug.modelMap = modelMap;
                modelDrug.proDrugID = @"";
                modelDrug.promotionID = model.objId;
                modelDrug.showDrug = @"0";
                WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
                modelLocal.title = @"优惠商品";
                modelLocal.modelDrug = modelDrug;
                modelLocal.typeLocalWeb = WebPageToWebTypeMedicine;
                [vcWebMedicine setWVWithLocalModel:modelLocal];
                vcWebMedicine.hidesBottomBarWhenPushed = YES;
                [vcLastObj.navigationController pushViewController:vcWebMedicine animated:YES];
            };
            alert.blockCancel = ^(BOOL cancel) {
            };
            [alert show];
        }
    }
    else if (newType == MsgBoxNoticeTypeOPNews)//资讯
    {//资讯
//        params[@"资讯提醒"] = @"资讯提醒";
        if(model.nid){
            [CouponNotiListRequest setCouponNotiReadWithMessageId:model.nd];
            //渠道统计 用户行为统计
            ChannerTypeModel *modelTwo=[ChannerTypeModel new];
            modelTwo.objRemark=@"资讯";
            modelTwo.objId=model.nid;
            modelTwo.cKey=@"push_click";
            [QWGLOBALMANAGER qwChannel:modelTwo];
        }
        if (canJump) {
            [self jumpToHealthInfoPage:model.objId withType:model.contentType];
        } else {
            NSDictionary *aps = [userInfo valueForKey:@"aps"];
            NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
            UITabBarController *vcTab = APPDelegate.currentTabBar;
            UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
            QWBaseVC *vcLastObj = (QWBaseVC *)[vcNavi.viewControllers lastObject];
            [vcNavi.navigationBar endEditing:YES];
            [vcLastObj.view endEditing:YES];
            [QWGLOBALMANAGER postNotif:NotifDismssKeyboard data:nil object:nil];
            CustomInfoAlertView *alert=[CustomInfoAlertView instance];
            alert.alertTitle.text = content;
            alert.blockDirect = ^(BOOL success) {
                [self jumpToHealthInfoPage:model.objId withType:model.contentType];
            };
            alert.blockCancel = ^(BOOL cancel) {
            };
            [alert show];
        }
    }
    else if(newType == MsgBoxNoticeTypeOPOutLink)//外链
    {
        //add by lijian at 2.2.4
        
        if(model.nid){
            [CouponNotiListRequest setCouponNotiReadWithMessageId:model.nd];
            //渠道统计 用户行为统计
            ChannerTypeModel *modelTwo=[ChannerTypeModel new];
            modelTwo.objRemark=@"外链";
            modelTwo.objId=model.nid;
            modelTwo.cKey=@"push_click";
            [QWGLOBALMANAGER qwChannel:modelTwo];
        }
//        params[@"外链提醒"] = @"外链提醒";
        
        if (canJump) {
            [self jumpToOtherWebview:model.url titl:@""];
        } else {
            NSDictionary *aps = [userInfo valueForKey:@"aps"];
            NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
            UITabBarController *vcTab = APPDelegate.currentTabBar;
            UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
            QWBaseVC *vcLastObj = (QWBaseVC *)[vcNavi.viewControllers lastObject];
            [vcNavi.navigationBar endEditing:YES];
            [vcLastObj.view endEditing:YES];
            [QWGLOBALMANAGER postNotif:NotifDismssKeyboard data:nil object:nil];
            CustomInfoAlertView *alert=[CustomInfoAlertView instance];
            alert.alertTitle.text = content;
            alert.blockDirect = ^(BOOL success) {
                [self jumpToOtherWebview:model.url titl:@""];
            };
            alert.blockCancel = ^(BOOL cancel) {
            };
            [alert show];
        }
    }
    else if(newType == MsgBoxNoticeTypeOPShopSales)//优惠活动
    {
//        params[@"优惠活动"] = @"优惠活动";
        if(model.nid){
            [CouponNotiListRequest setCouponNotiReadWithMessageId:model.nd];
            //渠道统计 用户行为统计
            ChannerTypeModel *modelTwo=[ChannerTypeModel new];
            modelTwo.objRemark=@"优惠活动";
            modelTwo.objId=model.nid;
            modelTwo.cKey=@"push_click";
            [QWGLOBALMANAGER qwChannel:modelTwo];
        }
        if (canJump) {
            UITabBarController *vcTab = APPDelegate.currentTabBar;
            UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
            // 促销活动
            CouponPharmacyDeailViewController *couponPharmacy = [[CouponPharmacyDeailViewController alloc]initWithNibName:@"CouponPharmacyDeailViewController" bundle:nil];
            couponPharmacy.storeId = model.branchId;
            couponPharmacy.activityId = model.objId;
            couponPharmacy.hidesBottomBarWhenPushed = YES;
            [vcNavi pushViewController:couponPharmacy animated:YES];
        } else {
            NSDictionary *aps = [userInfo valueForKey:@"aps"];
            NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
            UITabBarController *vcTab = APPDelegate.currentTabBar;
            UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
            QWBaseVC *vcLastObj = (QWBaseVC *)[vcNavi.viewControllers lastObject];
            [vcLastObj.view endEditing:YES];
            [vcNavi.navigationBar endEditing:YES];
            [QWGLOBALMANAGER postNotif:NotifDismssKeyboard data:nil object:nil];
            CustomInfoAlertView *alert=[CustomInfoAlertView instance];
            alert.alertTitle.text = content;
            alert.blockDirect = ^(BOOL success) {
                
                // 促销活动
                CouponPharmacyDeailViewController *couponPharmacy = [[CouponPharmacyDeailViewController alloc]initWithNibName:@"CouponPharmacyDeailViewController" bundle:nil];
                couponPharmacy.storeId = model.branchId;
                couponPharmacy.activityId = model.objId;
                //                    couponPharmacy.branchName = ;
                couponPharmacy.hidesBottomBarWhenPushed = YES;
                [vcNavi pushViewController:couponPharmacy animated:YES];
            };
            alert.blockCancel = ^(BOOL cancel) {
            };
            
            [alert show];
        }
    }
    else if(newType == MsgBoxNoticeTypeCoupon)//优惠使用情况通知
    {
        //渠道统计 用户行为统计
        if (model.nid) {
            ChannerTypeModel *modelTwo=[ChannerTypeModel new];
            modelTwo.objRemark=@"优惠使用";
            modelTwo.objId=model.nid;
            modelTwo.cKey=@"push_click";
            [QWGLOBALMANAGER qwChannel:modelTwo];
        }
        if (canJump) {
            UITabBarController *vcTab = APPDelegate.currentTabBar;
            UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
            
            NSString *strNd = [NSString stringWithFormat:@"%@",model.nd];
            
            NSString *strOd = [NSString stringWithFormat:@"%@",model.od];
            if (strNd.length > 0) {
                [CouponNotiListRequest setCouponNotiReadWithMessageId:strNd];
            }
            
//            if ([model.t integerValue] == 1) {
                if ([model.s intValue] == 1) {      //Coupon that near expire
                    //fixed at 11.17 by lijian
                    MyCouponDetailViewController *VC = [[MyCouponDetailViewController alloc]init];
                    VC.myCouponId = strOd.length ? strOd : model.objId;
                    VC.hidesBottomBarWhenPushed = YES;
                    [vcNavi pushViewController:VC animated:YES];
                }else if([model.s intValue] == 2)       // frozen coupon
                {
                    MyCouponQuanViewController *myCouponQuan = [[MyCouponQuanViewController alloc]init];
                    myCouponQuan.hidesBottomBarWhenPushed = YES;
                    [vcNavi pushViewController:myCouponQuan animated:YES];
                }else {
                    MyCouponQuanViewController *myCouponQuan = [[MyCouponQuanViewController alloc]init];
                    myCouponQuan.hidesBottomBarWhenPushed = YES;
                    [vcNavi pushViewController:myCouponQuan animated:YES];
                }
                
//            }
//                else if ([model.t integerValue] == 2)
//            {
//                if ([model.s intValue] == 1) {      //Product that near expire
//                    MyCouponDrugDetailViewController *drugDetail = [[MyCouponDrugDetailViewController alloc]init];
//                    
//                    //优惠商品状态(1：已领取 2：已使用 3：已过期)
//                    drugDetail.proDrugId = strOd;
//                    drugDetail.hidesBottomBarWhenPushed = YES;
//                    [vcNavi pushViewController:drugDetail animated:YES];
//                    
//                } else if([model.s intValue] == 2)           // frozen product
//                {
//                    MyCouponDrugViewController * myCouponDrug = [[MyCouponDrugViewController alloc]init];
//                    myCouponDrug.hidesBottomBarWhenPushed = YES;
//                    [vcNavi pushViewController:myCouponDrug animated:YES];
//                }
//            }
        }
        else {
            NSDictionary *aps = [userInfo valueForKey:@"aps"];
            NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
            UITabBarController *vcTab = APPDelegate.currentTabBar;
            UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
            QWBaseVC *vcLastObj = (QWBaseVC *)[vcNavi.viewControllers lastObject];
            [vcLastObj.view endEditing:YES];
            [vcNavi.navigationBar endEditing:YES];
            [QWGLOBALMANAGER postNotif:NotifDismssKeyboard data:nil object:nil];
            CustomInfoAlertView *alert=[CustomInfoAlertView instance];
            alert.alertTitle.text = content;
            alert.blockDirect = ^(BOOL success) {
                NSString *strNd = [NSString stringWithFormat:@"%@",model.nd];
                NSString *strOd = [NSString stringWithFormat:@"%@",model.od];
                if (strNd.length > 0) {
                    [CouponNotiListRequest setCouponNotiReadWithMessageId:strNd];
                }
//                if ([model.t integerValue] == 1) {
                    if ([model.s intValue] == 1) {      //Coupon that near expire
                        MyCouponDetailViewController *VC = [[MyCouponDetailViewController alloc]init];
                        VC.myCouponId = strOd.length ? strOd : model.objId;
                        VC.hidesBottomBarWhenPushed = YES;
                        [vcNavi pushViewController:VC animated:YES];
                        
                    }else if([model.s intValue] == 2)       // frozen coupon
                    {
                        MyCouponQuanViewController *myCouponQuan = [[MyCouponQuanViewController alloc]init];
                        myCouponQuan.hidesBottomBarWhenPushed = YES;
                        [vcNavi pushViewController:myCouponQuan animated:YES];
                    }else {
                        MyCouponQuanViewController *myCouponQuan = [[MyCouponQuanViewController alloc]init];
                        myCouponQuan.hidesBottomBarWhenPushed = YES;
                        [vcNavi pushViewController:myCouponQuan animated:YES];
                    }
//                }else if ([model.t integerValue] == 2)
//                {
//                    if ([model.s intValue] == 1) {      //Product that near expire
//                        MyCouponDrugDetailViewController *drugDetail = [[MyCouponDrugDetailViewController alloc]init];
//                        
//                        drugDetail.proDrugId = strOd;
//                        drugDetail.hidesBottomBarWhenPushed = YES;
//                        [vcNavi pushViewController:drugDetail animated:YES];
//                    } else if([model.s intValue] == 2)           // frozen product
//                    {
//                        MyCouponDrugViewController * myCouponDrug = [[MyCouponDrugViewController alloc]init];
//                        myCouponDrug.hidesBottomBarWhenPushed = YES;
//                        [vcNavi pushViewController:myCouponDrug animated:YES];
//                    }
//                }
            };
            alert.blockCancel = ^(BOOL cancel) {
            };
            
            [alert show];
        }
        
    }
    else if (newType == MsgBoxNoticeTypeOPNewsTopic) //资讯专题详情
    {
        if (canJump) {
            [self jumpToSpecDetailWithId:model.objId];
        }else{
            NSDictionary *aps = [userInfo valueForKey:@"aps"];
            NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
            CustomInfoAlertView *alert=[CustomInfoAlertView instance];
            alert.alertTitle.text = content;
            alert.blockDirect = ^(BOOL success) {
                [self jumpToSpecDetailWithId:model.objId];
            };
            alert.blockCancel = ^(BOOL cancel) {
            };
            [alert show];
        }
    }
    else if (newType == MsgBoxNoticeTypeOPPostDetail) //帖子详情
    {
        if (canJump) {
            [self jumpToPostDetailWithId:model.objId];
        }else{
            NSDictionary *aps = [userInfo valueForKey:@"aps"];
            NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
            CustomInfoAlertView *alert=[CustomInfoAlertView instance];
            alert.alertTitle.text = content;
            alert.blockDirect = ^(BOOL success) {
                [self jumpToPostDetailWithId:model.objId];
            };
            alert.blockCancel = ^(BOOL cancel) {
            };
            [alert show];
        }
    }
}

- (void)handleRemoteNotificationWihtInfo:(NSDictionary *)userInfo canJump:(BOOL)canJump
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if(userInfo[@"message"])
    {
        
        DDLogVerbose(@"收到推送 %@",userInfo[@"message"]);
        
        NSData *jsonData = [userInfo[@"message"] dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        
        [QWGLOBALMANAGER postNotif:NotiMessageBadgeNum data:[NSString stringWithFormat:@"%ld",[UIApplication sharedApplication].applicationIconBadgeNumber] object:nil];
        NotificationModel *model = [NotificationModel parse:dic];

        if (model.ot != nil) {
            [self handleNewRemoteNotificationWihtInfo:userInfo canJump:canJump];
         } else { // 走原有逻辑
            [QWGLOBALMANAGER noticeUnreadByPushType:model.type.integerValue readFlag:NO newPush:NO];
            // add by perry
            // 更新角标数据
            if([[NSString stringWithFormat:@"%@",model.type] isEqualToString:@"5"])//第二次扩散
            {
                //[QWGLOBALMANAGER postNotif:NotiMessageBoxUpdateStatue data:model object:self];
                if (canJump) {
                    [self jumpChatMessage:model.consultid WithType:MessageShowTypeDiffusion];
                }
                
            }
            else if ([[NSString stringWithFormat:@"%@",model.type] isEqualToString:@"4"])//问题已过期（待测试）
            {
                if (canJump) {
                    [self jumpChatMessage:model.consultid WithType:MessageShowTypeTimeout];
                }
                
                //[QWGLOBALMANAGER postNotif:NotiMessageBoxUpdateStatue data:model object:nil];
            }
            else if ([[NSString stringWithFormat:@"%@",model.type] isEqualToString:@"3"])//问题已关闭（待测试）
            {
                if (canJump) {
                    [self jumpChatMessage:model.consultid WithType:MessageShowTypeClosed];
                }
                //[QWGLOBALMANAGER postNotif:NotiMessageBoxUpdateStatue data:model object:nil];
            }
            else if([[NSString stringWithFormat:@"%@",model.type] isEqualToString:@"7"])//聊天详情
            {
                if (canJump) {
                    [self jumpChatMessage:model.consultid WithType:MessageShowTypeAnswering];
                }
            }
            else if([[NSString stringWithFormat:@"%@",model.type] isEqualToString:@"8"])//慢病订阅
            {
                if (canJump) {
                    [self jumpToDiseaseVC:model.drugGuideId withAttentionID:model.attentionId title:model.attentionName];
                }
            }
            else if([[NSString stringWithFormat:@"%@",model.type] isEqualToString:@"9"])//点对点提示扩散
            {
                if (canJump) {
                    [self jumpToP2PMessage:model.summaryId WithType:MessageShowTypeP2PDiffusion];
                }
            }
            else if([[NSString stringWithFormat:@"%@",model.type] isEqualToString:@"10"])//点对点聊天
            {
                if (canJump) {
                    [self jumpToP2PMessage:model.summaryId WithType:MessageShowTypeP2PChat];
                }
            }
            // add  by  shen
            else if([[NSString stringWithFormat:@"%@",model.type] isEqualToString:@"11"])//运营平台代金券推送提醒
            {
                
                params[@"代金券提醒"] = @"代金券提醒";
                if(model.nid){
                    [CouponNotiListRequest setCouponNotiReadWithMessageId:model.nd];
                    //渠道统计 用户行为统计
                    ChannerTypeModel *modelTwo=[ChannerTypeModel new];
                    modelTwo.objRemark=@"代金券";
                    modelTwo.objId=model.nid;
                    modelTwo.cKey=@"push_click";
                    [QWGLOBALMANAGER qwChannel:modelTwo];
                }
                if (canJump) {
                    UITabBarController *vcTab = APPDelegate.currentTabBar;
                    UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
                    CenterCouponDetailViewController *vcDetail =[[CenterCouponDetailViewController alloc] initWithNibName:@"CenterCouponDetailViewController" bundle:nil];
                    vcDetail.couponId=model.objId;
                    vcDetail.hidesBottomBarWhenPushed = YES;
                    [vcNavi pushViewController:vcDetail animated:YES];
                } else {
                    UITabBarController *vcTab = APPDelegate.currentTabBar;
                    UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
                    QWBaseVC *vcLastObj = (QWBaseVC *)[vcNavi.viewControllers lastObject];
                    [vcLastObj.view endEditing:YES];
                    [vcNavi.navigationBar endEditing:YES];
                    [QWGLOBALMANAGER postNotif:NotifDismssKeyboard data:nil object:nil];
                    NSDictionary *aps = [userInfo valueForKey:@"aps"];
                    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
                    CustomInfoAlertView *alert=[CustomInfoAlertView instance];
                    alert.alertTitle.text = content;
                    alert.blockDirect = ^(BOOL success) {
                        CenterCouponDetailViewController *vcDetail =[[CenterCouponDetailViewController alloc] initWithNibName:@"CenterCouponDetailViewController" bundle:nil];
                        vcDetail.couponId=model.objId;
                        vcDetail.hidesBottomBarWhenPushed = YES;
                        [vcNavi pushViewController:vcDetail animated:YES];
                    };
                    alert.blockCancel = ^(BOOL cancel) {
                    };
                    
                    [alert show];
                    
                }
            }
            else if([[NSString stringWithFormat:@"%@",model.type] isEqualToString:@"12"])//运营平台优惠商品推送提醒
            {
                params[@"优惠商品提醒"] = @"优惠商品提醒";
                if(model.nid){
                    [CouponNotiListRequest setCouponNotiReadWithMessageId:model.nd];
                    //渠道统计 用户行为统计
                    ChannerTypeModel *modelTwo=[ChannerTypeModel new];
                    modelTwo.objRemark=@"优惠商品";
                    modelTwo.objId=model.nid;
                    modelTwo.cKey=@"push_click";
                    [QWGLOBALMANAGER qwChannel:modelTwo];
                }
                if (canJump) {
                    //                    if (QWGLOBALMANAGER.configure.userToken.length == 0) {
                    //                        [self jumpToWebView:[NSString stringWithFormat: @"/app/html/v2.2.0/drugDetail.html?promotionId=%@&token=&showDrug=0",model.objId]titl:@"优惠商品"];
                    UITabBarController *vcTab = APPDelegate.currentTabBar;
                    UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
                    QWBaseVC *vcLastObj = (QWBaseVC *)[vcNavi.viewControllers lastObject];
                    WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
                    
                    MapInfoModel *modelMap = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
                    
                    WebDrugDetailModel *modelDrug = [WebDrugDetailModel new];
                    modelDrug.modelMap = modelMap;
                    modelDrug.proDrugID = @"";
                    modelDrug.promotionID = model.objId;
                    modelDrug.showDrug = @"0";
                    WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
                    modelLocal.title = @"优惠商品";
                    modelLocal.modelDrug = modelDrug;
                    modelLocal.typeLocalWeb = WebPageToWebTypeMedicine;
                    [vcWebMedicine setWVWithLocalModel:modelLocal];
                    vcWebMedicine.hidesBottomBarWhenPushed = YES;
                    [vcLastObj.navigationController pushViewController:vcWebMedicine animated:YES];
                } else {
                    UITabBarController *vcTab = APPDelegate.currentTabBar;
                    UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
                    QWBaseVC *vcLastObj = (QWBaseVC *)[vcNavi.viewControllers lastObject];
                    [vcLastObj.view endEditing:YES];
                    [vcNavi.navigationBar endEditing:YES];
                    [QWGLOBALMANAGER postNotif:NotifDismssKeyboard data:nil object:nil];
                    NSDictionary *aps = [userInfo valueForKey:@"aps"];
                    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
                    CustomInfoAlertView *alert=[CustomInfoAlertView instance];
                    alert.alertTitle.text = content;
                    alert.blockDirect = ^(BOOL success) {
                        
                        
                        WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
                        
                        MapInfoModel *modelMap = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
                        WebDrugDetailModel *modelDrug = [WebDrugDetailModel new];
                        modelDrug.modelMap = modelMap;
                        modelDrug.proDrugID = @"";
                        modelDrug.promotionID = model.objId;
                        modelDrug.showDrug = @"0";
                        WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
                        modelLocal.title = @"优惠商品";
                        modelLocal.modelDrug = modelDrug;
                        modelLocal.typeLocalWeb = WebPageToWebTypeMedicine;
                        [vcWebMedicine setWVWithLocalModel:modelLocal];
                        vcWebMedicine.hidesBottomBarWhenPushed = YES;
                        [vcLastObj.navigationController pushViewController:vcWebMedicine animated:YES];
                    };
                    alert.blockCancel = ^(BOOL cancel) {
                    };
                    [alert show];
                }
            }
            else if ([[NSString stringWithFormat:@"%@",model.type] isEqualToString:@"13"])//资讯
            {//资讯
                params[@"资讯提醒"] = @"资讯提醒";
                if(model.nid){
                    [CouponNotiListRequest setCouponNotiReadWithMessageId:model.nd];
                    //渠道统计 用户行为统计
                    ChannerTypeModel *modelTwo=[ChannerTypeModel new];
                    modelTwo.objRemark=@"资讯";
                    modelTwo.objId=model.nid;
                    modelTwo.cKey=@"push_click";
                    [QWGLOBALMANAGER qwChannel:modelTwo];
                }
                if (canJump) {
                    [self jumpToHealthInfoPage:model.objId withType:model.contentType];
                } else {
                    NSDictionary *aps = [userInfo valueForKey:@"aps"];
                    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
                    UITabBarController *vcTab = APPDelegate.currentTabBar;
                    UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
                    QWBaseVC *vcLastObj = (QWBaseVC *)[vcNavi.viewControllers lastObject];
                    [vcNavi.navigationBar endEditing:YES];
                    [vcLastObj.view endEditing:YES];
                    [QWGLOBALMANAGER postNotif:NotifDismssKeyboard data:nil object:nil];
                    CustomInfoAlertView *alert=[CustomInfoAlertView instance];
                    alert.alertTitle.text = content;
                    alert.blockDirect = ^(BOOL success) {
                        [self jumpToHealthInfoPage:model.objId withType:model.contentType];
                    };
                    alert.blockCancel = ^(BOOL cancel) {
                    };
                    [alert show];
                }
            }
            else if([[NSString stringWithFormat:@"%@",model.type] isEqualToString:@"15"])//外链
            {
                //add by lijian at 2.2.4
                
                if(model.nid){
                    [CouponNotiListRequest setCouponNotiReadWithMessageId:model.nd];
                    //渠道统计 用户行为统计
                    ChannerTypeModel *modelTwo=[ChannerTypeModel new];
                    modelTwo.objRemark=@"外链";
                    modelTwo.objId=model.nid;
                    modelTwo.cKey=@"push_click";
                    [QWGLOBALMANAGER qwChannel:modelTwo];
                }
                params[@"外链提醒"] = @"外链提醒";
                
                if (canJump) {
                    [self jumpToOtherWebview:model.url titl:@""];
                } else {
                    NSDictionary *aps = [userInfo valueForKey:@"aps"];
                    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
                    UITabBarController *vcTab = APPDelegate.currentTabBar;
                    UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
                    QWBaseVC *vcLastObj = (QWBaseVC *)[vcNavi.viewControllers lastObject];
                    [vcNavi.navigationBar endEditing:YES];
                    [vcLastObj.view endEditing:YES];
                    [QWGLOBALMANAGER postNotif:NotifDismssKeyboard data:nil object:nil];
                    CustomInfoAlertView *alert=[CustomInfoAlertView instance];
                    alert.alertTitle.text = content;
                    alert.blockDirect = ^(BOOL success) {
                        [self jumpToOtherWebview:model.url titl:@""];
                    };
                    alert.blockCancel = ^(BOOL cancel) {
                    };
                    [alert show];
                }
            }
            else if([[NSString stringWithFormat:@"%@",model.type] isEqualToString:@"16"])//优惠活动
            {
                params[@"优惠活动"] = @"优惠活动";
                if(model.nid){
                    [CouponNotiListRequest setCouponNotiReadWithMessageId:model.nd];
                    //渠道统计 用户行为统计
                    ChannerTypeModel *modelTwo=[ChannerTypeModel new];
                    modelTwo.objRemark=@"优惠活动";
                    modelTwo.objId=model.nid;
                    modelTwo.cKey=@"push_click";
                    [QWGLOBALMANAGER qwChannel:modelTwo];
                }
                if (canJump) {
                    UITabBarController *vcTab = APPDelegate.currentTabBar;
                    UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
                    // 促销活动
                    CouponPharmacyDeailViewController *couponPharmacy = [[CouponPharmacyDeailViewController alloc]initWithNibName:@"CouponPharmacyDeailViewController" bundle:nil];
                    couponPharmacy.storeId = model.branchId;
                    couponPharmacy.activityId = model.objId;
                    couponPharmacy.hidesBottomBarWhenPushed = YES;
                    [vcNavi pushViewController:couponPharmacy animated:YES];
                } else {
                    NSDictionary *aps = [userInfo valueForKey:@"aps"];
                    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
                    UITabBarController *vcTab = APPDelegate.currentTabBar;
                    UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
                    QWBaseVC *vcLastObj = (QWBaseVC *)[vcNavi.viewControllers lastObject];
                    [vcLastObj.view endEditing:YES];
                    [vcNavi.navigationBar endEditing:YES];
                    [QWGLOBALMANAGER postNotif:NotifDismssKeyboard data:nil object:nil];
                    CustomInfoAlertView *alert=[CustomInfoAlertView instance];
                    alert.alertTitle.text = content;
                    alert.blockDirect = ^(BOOL success) {
                        
                        // 促销活动
                        CouponPharmacyDeailViewController *couponPharmacy = [[CouponPharmacyDeailViewController alloc]initWithNibName:@"CouponPharmacyDeailViewController" bundle:nil];
                        couponPharmacy.storeId = model.branchId;
                        couponPharmacy.activityId = model.objId;
                        //                    couponPharmacy.branchName = ;
                        couponPharmacy.hidesBottomBarWhenPushed = YES;
                        [vcNavi pushViewController:couponPharmacy animated:YES];
                    };
                    alert.blockCancel = ^(BOOL cancel) {
                    };
                    
                    [alert show];
                }
            }
            else if([[NSString stringWithFormat:@"%@",model.type] isEqualToString:@"17"])//优惠使用情况通知
            {
                //渠道统计 用户行为统计
                if (model.nid) {
                    ChannerTypeModel *modelTwo=[ChannerTypeModel new];
                    modelTwo.objRemark=@"优惠使用";
                    modelTwo.objId=model.nid;
                    modelTwo.cKey=@"push_click";
                    [QWGLOBALMANAGER qwChannel:modelTwo];
                }
                if (canJump) {
                    UITabBarController *vcTab = APPDelegate.currentTabBar;
                    UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
                    
                    NSString *strNd = [NSString stringWithFormat:@"%@",model.nd];
                    
                    NSString *strOd = [NSString stringWithFormat:@"%@",model.od];
                    if (strNd.length > 0) {
                        [CouponNotiListRequest setCouponNotiReadWithMessageId:strNd];
                    }
                    
                    if ([model.t integerValue] == 1) {
                        if ([model.s intValue] == 1) {      //Coupon that near expire
                            //fixed at 11.17 by lijian
                            MyCouponDetailViewController *VC = [[MyCouponDetailViewController alloc]init];
                            VC.myCouponId = strOd;
                            VC.hidesBottomBarWhenPushed = YES;
                            [vcNavi pushViewController:VC animated:YES];
                        }else if([model.s intValue] == 2)       // frozen coupon
                        {
                            MyCouponQuanViewController *myCouponQuan = [[MyCouponQuanViewController alloc]init];
                            myCouponQuan.hidesBottomBarWhenPushed = YES;
                            [vcNavi pushViewController:myCouponQuan animated:YES];
                        }
                        
                    }else if ([model.t integerValue] == 2)
                    {
                        if ([model.s intValue] == 1) {      //Product that near expire
                            MyCouponDrugDetailViewController *drugDetail = [[MyCouponDrugDetailViewController alloc]init];
                            
                            //优惠商品状态(1：已领取 2：已使用 3：已过期)
                            drugDetail.proDrugId = strOd;
                            drugDetail.hidesBottomBarWhenPushed = YES;
                            [vcNavi pushViewController:drugDetail animated:YES];
                            
                        } else if([model.s intValue] == 2)           // frozen product
                        {
                            MyCouponDrugViewController * myCouponDrug = [[MyCouponDrugViewController alloc]init];
                            myCouponDrug.hidesBottomBarWhenPushed = YES;
                            [vcNavi pushViewController:myCouponDrug animated:YES];
                        }
                    }
                }
                else {
                    NSDictionary *aps = [userInfo valueForKey:@"aps"];
                    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
                    UITabBarController *vcTab = APPDelegate.currentTabBar;
                    UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
                    QWBaseVC *vcLastObj = (QWBaseVC *)[vcNavi.viewControllers lastObject];
                    [vcLastObj.view endEditing:YES];
                    [vcNavi.navigationBar endEditing:YES];
                    [QWGLOBALMANAGER postNotif:NotifDismssKeyboard data:nil object:nil];
                    CustomInfoAlertView *alert=[CustomInfoAlertView instance];
                    alert.alertTitle.text = content;
                    alert.blockDirect = ^(BOOL success) {
                        NSString *strNd = [NSString stringWithFormat:@"%@",model.nd];
                        NSString *strOd = [NSString stringWithFormat:@"%@",model.od];
                        if (strNd.length > 0) {
                            [CouponNotiListRequest setCouponNotiReadWithMessageId:strNd];
                        }
                        if ([model.t integerValue] == 1) {
                            if ([model.s intValue] == 1) {      //Coupon that near expire
                                MyCouponDetailViewController *VC = [[MyCouponDetailViewController alloc]init];
                                VC.myCouponId = strOd;
                                VC.hidesBottomBarWhenPushed = YES;
                                [vcNavi pushViewController:VC animated:YES];
                                
                            }else if([model.s intValue] == 2)       // frozen coupon
                            {
                                MyCouponQuanViewController *myCouponQuan = [[MyCouponQuanViewController alloc]init];
                                myCouponQuan.hidesBottomBarWhenPushed = YES;
                                [vcNavi pushViewController:myCouponQuan animated:YES];
                            }
                        }else if ([model.t integerValue] == 2)
                        {
                            if ([model.s intValue] == 1) {      //Product that near expire
                                MyCouponDrugDetailViewController *drugDetail = [[MyCouponDrugDetailViewController alloc]init];
                                
                                drugDetail.proDrugId = strOd;
                                drugDetail.hidesBottomBarWhenPushed = YES;
                                [vcNavi pushViewController:drugDetail animated:YES];
                            } else if([model.s intValue] == 2)           // frozen product
                            {
                                MyCouponDrugViewController * myCouponDrug = [[MyCouponDrugViewController alloc]init];
                                myCouponDrug.hidesBottomBarWhenPushed = YES;
                                [vcNavi pushViewController:myCouponDrug animated:YES];
                            }
                        }
                    };
                    alert.blockCancel = ^(BOOL cancel) {
                    };
                    
                    [alert show];
                }
                
            }
            else if([[NSString stringWithFormat:@"%@",model.type] isEqualToString:@"18"])//订单通知
            {
                if (canJump) {
                    
                    UITabBarController *vcTab = APPDelegate.currentTabBar;
                    UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
                    
                    NSString *strNd = [NSString stringWithFormat:@"%@",model.nd];
                    //渠道统计 用户行为统计
                    ChannerTypeModel *modelTwo=[ChannerTypeModel new];
                    modelTwo.objRemark=@"订单通知";
                    modelTwo.objId=model.nid;
                    modelTwo.cKey=@"push_click";
                    [QWGLOBALMANAGER qwChannel:modelTwo];
                    if (strNd.length > 0) {
                        [SysNotiListRequest setOrderNotiReadWithMessageId:strNd success:nil failure:nil];
                    }
                    
                    IndentDetailListViewController *vc = [IndentDetailListViewController new];
                    vc.orderId = model.orderId;
                    
                    vc.hidesBottomBarWhenPushed = YES;
                    [vcNavi pushViewController:vc animated:YES];
                    
                }
                else {
                    NSDictionary *aps = [userInfo valueForKey:@"aps"];
                    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
                    UITabBarController *vcTab = APPDelegate.currentTabBar;
                    UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
                    QWBaseVC *vcLastObj = (QWBaseVC *)[vcNavi.viewControllers lastObject];
                    [vcLastObj.view endEditing:YES];
                    [vcNavi.navigationBar endEditing:YES];
                    [QWGLOBALMANAGER postNotif:NotifDismssKeyboard data:nil object:nil];
                    CustomInfoAlertView *alert=[CustomInfoAlertView instance];
                    alert.alertTitle.text = content;
                    alert.blockDirect = ^(BOOL success) {
                        NSString *strNd = [NSString stringWithFormat:@"%@",model.nd];
                        //渠道统计 用户行为统计
                        if (model.nid) {
                            ChannerTypeModel *modelTwo=[ChannerTypeModel new];
                            modelTwo.objRemark=@"推送显示的内容";
                            modelTwo.objId=model.nid;
                            modelTwo.cKey=@"push_click";
                            [QWGLOBALMANAGER qwChannel:modelTwo];
                        }
                        if (strNd.length > 0) {
                            [SysNotiListRequest setOrderNotiReadWithMessageId:strNd success:nil failure:nil];
                        }
                        IndentDetailListViewController *vc = [IndentDetailListViewController new];
                        vc.orderId = model.orderId;
                        
                        vc.hidesBottomBarWhenPushed = YES;
                        [vcNavi pushViewController:vc animated:YES];
                    };
                    alert.blockCancel = ^(BOOL cancel) {
                    };
                    
                    [alert show];
                }
            }
            else if([[NSString stringWithFormat:@"%@",model.type] isEqualToString:@"2"])//全维药事
            {
                if (canJump) {
                    [self jumpToOffical];
                } else {
                }
            }
            else if ([[NSString stringWithFormat:@"%@",model.type] isEqualToString:@"19"]) //圈子消息
            {
                if (canJump) {
                    [self jumpToCircleInfoWith:model];
                }else{
                    //前台不做通知 只显示小红点

                    if (model.msgClass == 1) {
                        QWGLOBALMANAGER.configure.expertCommentRed = YES;
                    }else if (model.msgClass == 2){
                        QWGLOBALMANAGER.configure.expertFlowerRed = YES;
                    }else if (model.msgClass == 99){
                        QWGLOBALMANAGER.configure.expertSystemInfoRed = YES;
                        if (model.msgType == 16 || model.msgType == 18) {
                            QWGLOBALMANAGER.configure.flagSilenced = YES;
                        }else if (model.msgType == 17 || model.msgType == 19){
                            QWGLOBALMANAGER.configure.flagSilenced = NO;
                        }
                    }
                    [QWGLOBALMANAGER saveAppConfigure];
                    [QWGLOBALMANAGER postNotif:NotifCircleMsgRedPoint data:nil object:nil];
                    QWGLOBALMANAGER.expertMineRedPoint.hidden = NO;
                }
            }
            else if ([[NSString stringWithFormat:@"%@",model.type] isEqualToString:@"25"]) //圈子私聊列表
            {
                if (canJump) {
                    [self jumpToPrivateCircleMsg];
                }else{
                    //前台不做通知 只显示小红点
                    QWGLOBALMANAGER.configure.expertPrivateMsgRed = YES;
                    [QWGLOBALMANAGER postNotif:NotifCircleMsgRedPoint data:nil object:self];
                    [QWGLOBALMANAGER saveAppConfigure];
                    QWGLOBALMANAGER.expertMineRedPoint.hidden = NO;
                }
            }
            else if ([[NSString stringWithFormat:@"%@",model.type] isEqualToString:@"28"]) //资讯专题详情
            {
                if (canJump) {
                    [self jumpToSpecDetailWithId:model.objId];
                }else{
                    NSDictionary *aps = [userInfo valueForKey:@"aps"];
                    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
                    CustomInfoAlertView *alert=[CustomInfoAlertView instance];
                    alert.alertTitle.text = content;
                    alert.blockDirect = ^(BOOL success) {
                        [self jumpToSpecDetailWithId:model.objId];
                    };
                    alert.blockCancel = ^(BOOL cancel) {
                    };
                    [alert show];
                }
            }
            else if ([[NSString stringWithFormat:@"%@",model.type] isEqualToString:@"29"]) //帖子详情
            {
                if (canJump) {
                    [self jumpToPostDetailWithId:model.objId];
                }else{
                    NSDictionary *aps = [userInfo valueForKey:@"aps"];
                    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
                    CustomInfoAlertView *alert=[CustomInfoAlertView instance];
                    alert.alertTitle.text = content;
                    alert.blockDirect = ^(BOOL success) {
                        [self jumpToPostDetailWithId:model.objId];
                    };
                    alert.blockCancel = ^(BOOL cancel) {
                    };
                    [alert show];
                }
            }else if ([[NSString stringWithFormat:@"%@",model.type] isEqualToString:@"30"]) //消息通知列表
            {
                if (canJump) {
                    [self jumpToCouponMsgList];
                }else{
                    NSDictionary *aps = [userInfo valueForKey:@"aps"];
                    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
                    CustomInfoAlertView *alert=[CustomInfoAlertView instance];
                    alert.alertTitle.text = content;
                    alert.blockDirect = ^(BOOL success) {
                        [self jumpToCouponMsgList];
                    };
                    alert.blockCancel = ^(BOOL cancel) {
                    };
                    [alert show];
                }
            }
        }
    }
}
/**
 *  跳转消息通知列表
 */
- (void)jumpToCouponMsgList
{
    UITabBarController *vcTab = APPDelegate.currentTabBar;
    UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
    
    UIViewController *vcLastObj = [vcNavi.viewControllers lastObject];
    if ([vcLastObj isKindOfClass:[MsgCouponListViewController class]]) {
        [(MsgCouponListViewController *)vcLastObj refreshConsultList];
    } else {
        MsgCouponListViewController *vc = [[UIStoryboard storyboardWithName:@"MessageBoxListViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"MsgCouponListViewController"];
        vc.hidesBottomBarWhenPushed = YES;
        [vcNavi pushViewController:vc animated:YES];
    }
}

// 跳转健康指南
- (void)jumpToHealthGuide
{
    [self handleJumpWithVCCreator:^UIViewController *{
        return [HealthViewController new];
    } vcClass:[HealthViewController class] refreshAction:^(UIViewController *vc) {
        [((HealthViewController*) vc) refreshConsultList];
    }];
}


- (void)jumpToAboutWenyao
{
    [self handleJumpWithVCCreator:^UIViewController *{
        return [AboutWenYaoViewController new];
    } vcClass:[AboutWenYaoViewController class] refreshAction:nil];
    [QWGLOBALMANAGER statisticsEventId:@"x_sz_gywy" withLable:@"设置" withParams:nil];
}

- (void)jumpToPersonalInfoDetail
{
    [self handleJumpWithVCCreator:^UIViewController *{
        return [NewPersonInformationViewController new];
    } vcClass:[NewPersonInformationViewController class] refreshAction:^(UIViewController *vc) {
        [((NewPersonInformationViewController *)vc) loadData];
    }]; 
    [QWGLOBALMANAGER statisticsEventId:@"我的_个人资料" withLable:nil withParams:nil];
}

- (void)jumpToCreditDetails
{
    [self handleJumpWithVCCreator:^UIViewController *{
        return [[UIStoryboard storyboardWithName:@"Credit" bundle:nil] instantiateViewControllerWithIdentifier:@"CreditRecordViewController"];
    } vcClass:[CreditRecordViewController class] refreshAction:^(UIViewController *vc) {
        [((CreditRecordViewController *)vc) loadData];
    }];
    [QWGLOBALMANAGER statisticsEventId:@"我的积分_积分明细" withLable:@"我的-积分-积分明细" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl)}]];
}

- (void)jumpToCreditExchangeList
{
    
    UITabBarController *vcTab = APPDelegate.currentTabBar;
    UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
    UIViewController *vcLastObj = [vcNavi.viewControllers lastObject];
    if ([vcLastObj isKindOfClass:[WebDirectViewController class]]) {
        WebDirectViewController *vc = (WebDirectViewController *)vcLastObj;
        if (vc.pageType == WebPageToWebTypeExchangeList || vc.pageType == WebPageToWebTypeSuccessToList || vc.modelLocal.typeLocalWeb == WebLocalTypeExchangeList) {
            [vc.m_webView reload];
            return;
        }
    }
    WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
    modelLocal.typeLocalWeb = WebLocalTypeExchangeList;
    modelLocal.title = @"兑换记录";
    [vcWebMedicine setWVWithLocalModel:modelLocal];
    vcWebMedicine.hidesBottomBarWhenPushed = YES;
    [vcNavi pushViewController:vcWebMedicine animated:YES];
}

- (void)handleJumpWithVCCreator:(UIViewController* (^)())vcCreator vcClass:(Class)vcClass refreshAction:(void (^)(UIViewController *vc))refresh
{
    UITabBarController *vcTab = APPDelegate.currentTabBar;
    UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
    UIViewController *vcLastObj = [vcNavi.viewControllers lastObject];
    if ([vcLastObj isKindOfClass:vcClass]) {
        if (refresh) {
            refresh(vcLastObj);
        }
    } else {
        if (vcCreator) {
            UIViewController *vc = vcCreator();
            vc.hidesBottomBarWhenPushed = YES;
            [vcNavi pushViewController:vc animated:YES];
        }
    }
}


/**
 *  跳转到私聊消息列表
 */
- (void)jumpToPrivateCircleMsg
{
    
     UITabBarController *vcTab = APPDelegate.currentTabBar;
     UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
     
     UIViewController *vcLastObj = [vcNavi.viewControllers lastObject];
    if ([vcLastObj isKindOfClass:[PrivateChatViewController class]]) {
        if (((PrivateChatViewController *)vcLastObj).fromList) {
            
        } else {
            CircleMsgRootViewController *vc = [[UIStoryboard storyboardWithName:@"ExpertInfo" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleMsgRootViewController"];
            vc.hidesBottomBarWhenPushed = YES;
            [vcNavi pushViewController:vc animated:YES];
        }
    } else if ([vcLastObj isKindOfClass:[CircleMsgRootViewController class]]) {
         [((CircleMsgRootViewController *)vcLastObj) refreshAllCircleMsg];
     } else {
         CircleMsgRootViewController *vc = [[UIStoryboard storyboardWithName:@"ExpertInfo" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleMsgRootViewController"];
         vc.hidesBottomBarWhenPushed = YES;
         [vcNavi pushViewController:vc animated:YES];
     }
}

/**
 *  跳转到专题详情页面
 *
 *  @param specId 专题id
 */
- (void)jumpToSpecDetailWithId:(NSString *)specId
{
    UITabBarController *vcTab = APPDelegate.currentTabBar;
    UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
    WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    WebDirectLocalModel *modelLocal = [[WebDirectLocalModel alloc] init];
    modelLocal.url = [NSString stringWithFormat:@"%@QWYH/web/message/html/subject.html?id=%@",H5_BASE_URL,specId];
    modelLocal.typeLocalWeb = WebLocalTypeOuterLink;
    modelLocal.typeTitle = WebTitleTypeOnlyShare;
    vcWebDirect.isOtherLinks = YES;
    [vcWebDirect setWVWithLocalModel:modelLocal];
    vcWebDirect.hidesBottomBarWhenPushed = YES;
    [vcNavi pushViewController:vcWebDirect animated:YES];
}

/**
 *  跳转到帖子详情页面
 *
 *  @param postId 帖子id
 */
- (void)jumpToPostDetailWithId:(NSString *)postId
{
    UITabBarController *vcTab = APPDelegate.currentTabBar;
    UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
    PostDetailViewController* postDetailVC = (PostDetailViewController*)[[UIStoryboard storyboardWithName:@"Forum" bundle:nil] instantiateViewControllerWithIdentifier:@"PostDetailViewController"];
    postDetailVC.hidesBottomBarWhenPushed = YES;
    postDetailVC.postId = postId;
    [vcNavi pushViewController:postDetailVC animated:YES];
}

- (void)jumpToCircleInfoWith:(id)data
{
    NotificationModel *model = (NotificationModel *)data;
    
    int tab;
    if (model.msgClass == 1) {//评论
        tab = 1;
    }else if (model.msgClass == 2){//鲜花
        tab = 2;
    }else if (model.msgClass == 99){//系统消息
        tab = 99;
        
        if (model.msgType == 16 || model.msgType == 18) {
            QWGLOBALMANAGER.configure.flagSilenced = YES;
        }else if (model.msgType == 17 || model.msgType == 19){
            QWGLOBALMANAGER.configure.flagSilenced = NO;
        }
    }
    [self jumpToExpertInfo:tab];
}

/**
 *  跳转到专家消息页面
 *
 *  @param tab <#tab description#>
 */
- (void)jumpToExpertInfo:(int)tab
{
    UITabBarController *vcTab = APPDelegate.currentTabBar;
    UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
    ExpertInfoViewController *vc = [[ExpertInfoViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.selectedTab = tab;
    [vcNavi pushViewController:vc animated:YES];
}

-(void)afterDelay:(NSTimeInterval )timerInterval block:(void (^)())block{
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timerInterval*NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        block();
    });
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        // 取消
    } else {
        
    }
}

- (void)actionCancelWithAlert:(CustomInfoAlertView *)alert
{
    DDLogVerbose(@"the alert model is %@",alert.model);
}

- (void)actionDirectWithAlert:(CustomInfoAlertView *)alert
{
    DDLogVerbose(@"the alert model is %@",alert.model);
}

/**
 *  慢病订阅的跳转
 */
- (void)jumpToDiseaseVC:(NSString *)diseaseID withAttentionID:(NSString *)attentionID title:(NSString *)title
{
    QWGLOBALMANAGER.needShowBadge = NO;
    [QWGLOBALMANAGER setBadgeNumStatus:NO];
    UITabBarController *vcTab = APPDelegate.currentTabBar;
    UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
    
    DetailSubscriptionListViewController *detailSubscriptionViewController = [[DetailSubscriptionListViewController alloc] init];
    DrugGuideListModel *modelDrug = [[DrugGuideListModel alloc] init];
    modelDrug.guideId = diseaseID;
    modelDrug.title = title;
//    modelDrug.hasRead = YES;
    [DrugGuideListModel updateObjToDB:modelDrug WithKey:modelDrug.guideId];
    detailSubscriptionViewController.modelDrugGuide = modelDrug;
    detailSubscriptionViewController.hidesBottomBarWhenPushed = YES;
    [vcNavi pushViewController:detailSubscriptionViewController animated:YES];
}
/**
 *  外链
 */
//-(void)jumpToWebView:(NSString *)url titl:(NSString *)title withShareType:(LocalShareType)typeShare
//{
//    UITabBarController *vcTab = (UITabBarController *)self.window.rootViewController;
//    UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
//    QWBaseVC *vcLastObj = (QWBaseVC *)[vcNavi.viewControllers lastObject];
//    WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
//    
//    [vcWebDirect setWVWithURL:[NSString stringWithFormat:@"%@%@",HTML5_DIRECT_URL,url] title:title withType:WebTitleTypeNone];
//    //    [vcWebDirect setWVWithURL:url title:title withType:WebTitleTypeNone];
//    vcWebDirect.vcHolder = vcLastObj;
//    vcWebDirect.hidesBottomBarWhenPushed = YES;
//    [vcNavi pushViewController:vcWebDirect animated:YES];
//}
- (void)jumpToHealthInfoPage:(NSString *)healthID withType:(NSString *)contentType
{
    // 跳转健康资讯
    UITabBarController *vcTab = APPDelegate.currentTabBar;
    UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
    WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    WebHealthInfoModel *modelHealth = [[WebHealthInfoModel alloc] init];
    WebDirectLocalModel *modelLocal = [[WebDirectLocalModel alloc] init];
    modelHealth.msgID = healthID;
    modelHealth.contentType = contentType;
    modelLocal.modelHealInfo = modelHealth;
    modelLocal.typeLocalWeb = WebPageToWebTypeInfo;

    [vcWebDirect setWVWithLocalModel:modelLocal];
    vcWebDirect.hidesBottomBarWhenPushed = YES;
    [vcNavi pushViewController:vcWebDirect animated:YES];
}

-(void)jumpToOtherWebview:(NSString *)url titl:(NSString *)title
{
    // 跳转外链
    UITabBarController *vcTab = APPDelegate.currentTabBar;
    UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
    WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    WebDirectLocalModel *modelLocal = [[WebDirectLocalModel alloc] init];
    if (![url hasPrefix:@"http"]) {
        url = [NSString stringWithFormat:@"%@%@",H5_BASE_URL,url];
    }
    modelLocal.url = url;
    vcWebDirect.isOtherLinks = YES;
    modelLocal.typeLocalWeb = WebLocalTypeOuterLink;
    [vcWebDirect setWVWithLocalModel:modelLocal];

    vcWebDirect.hidesBottomBarWhenPushed = YES;
    [vcNavi pushViewController:vcWebDirect animated:YES];
}
/**
 *  点对点聊天的跳转
 */
// TODO: 小红点
- (void)jumpToP2PMessage:(NSString *)sessionID WithType:(MessageShowType)type
{
    UITabBarController *vcTab = APPDelegate.currentTabBar;
    UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
        UIViewController *vcLastObj = [vcNavi topViewController];
    if ([vcLastObj isKindOfClass:[ChatViewController class]]) {
        [QWGLOBALMANAGER noticeUnreadLocalWithType:MsgBoxListMsgTypeShopConsult sessionID:sessionID isRead:YES];
    } else {
    }
    
}

//跳转到聊天详情
//跳转到待抢答列表
-(void)jumpChatMessage:(NSString*)consultId WithType:(MessageShowType)type
{
    
    UITabBarController *vcTab = APPDelegate.currentTabBar;
    UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
    
    UIViewController *vcLastObj = [vcNavi.viewControllers lastObject];
    if ([vcLastObj isKindOfClass:[XPChatViewController class]]) {
        HistoryMessages* msg = [HistoryMessages getObjFromDBWithWhere:[NSString stringWithFormat:@"relatedid = %@",consultId]];
        if(msg) {
            // 更新消息盒子列表上，咨询集合的未读数
            PharMsgModel *modelMsg = [PharMsgModel getObjFromDBWithWhere:@"type = 2"];
            modelMsg.unreadCounts = [NSString stringWithFormat:@"%d",[modelMsg.unreadCounts intValue]-[msg.isShowRedPoint intValue]];
            [PharMsgModel updateToDB:modelMsg where:@"type = 2"];
            
            // 更新消息盒子咨询列表中得未读数
            MsgNotifyListModel *modelMsgNoti = [MsgNotifyListModel getObjFromDBWithKey:msg.relatedid];
            if (modelMsgNoti) {
                modelMsgNoti.unreadCounts = @"0";
                modelMsgNoti.systemUnreadCounts = @"0";
                modelMsgNoti.showRedPoint = @"0";
                [MsgNotifyListModel updateObjToDB:modelMsgNoti WithKey:msg.relatedid];
            }
            dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
            dispatch_async(aQueue, ^(void) {
                [HistoryMessages updateObjToDB:msg WithKey:msg.relatedid];
            });
        }
        XPChatViewController *vcChat = (XPChatViewController *)vcLastObj;
        [vcChat reloadData];
    } else {
//        messageViewController.historyMsg = msg;
//        messageViewController.showType = type;
//        //    messageViewController
//        messageViewController.messageSender = [NSString stringWithFormat:@"%@",consultId];
//        messageViewController.avatarUrl = @"";
//        messageViewController.hidesBottomBarWhenPushed = YES;
//        [vcNavi pushViewController:messageViewC ontroller animated:NO];
    }
}
-(void)jumpToOffical
{
    // 4.0 不应有全维药事
    [self jumpToHealthGuide];
    return;
    
    UITabBarController *vcTab = APPDelegate.currentTabBar;
    UINavigationController *vcNavi = (UINavigationController *)vcTab.selectedViewController;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    UIViewController *vcLastObj = [vcNavi.viewControllers lastObject];
    
    //更新小红点
    PharMsgModel* msg = [PharMsgModel getObjFromDBWithWhere:[NSString stringWithFormat:@"type = %@",MsgBoxListOfficialType]];
    if (msg) {
        msg.unreadCounts = @"0";
        msg.systemUnreadCounts = @"0";
        [PharMsgModel updateToDB:msg where:[NSString stringWithFormat:@"type = %@",MsgBoxListOfficialType]];
    }
    
    [OfficialMessages updateSetToDB:@"issend = '1'" WithWhere:nil];
    [QWGLOBALMANAGER updateRedPoint];

    if ([vcLastObj isKindOfClass:[QWYSViewController class]]) {//如果当前页面在全维药事
        QWYSViewController *vcChat = (QWYSViewController *)vcLastObj;
        [vcChat refeshingRecentMessage];
    } else {//如果当前页面不在全维药事
        QWYSViewController *vc = [[UIStoryboard storyboardWithName:@"QWYSViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"QWYSViewController"];
        vc.hidesBottomBarWhenPushed = YES;
        [vcNavi pushViewController:vc animated:YES];  
    }

}


#pragma mark -
#pragma mark  整体界面的初始化
#pragma 跳转支付宝和问药的APP
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    /**
     *  add by martin 3.1增加的，从帖子详情h5外链进来
     */
    if ([url.description hasPrefix:@"quanwei"]) {
        return [self p_handelPostdeURL:url];
    }else if([url.host isEqualToString:@"safepay"]){
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            DDLogVerbose(@"result = %@",resultDic);
        }];
        return YES;
    }else{
        [WXApi handleOpenURL:url delegate:QWGLOBALMANAGER];
        return  [UMSocialSnsService handleOpenURL:url];
    }
    
 
}



- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    /**
     *  add by martin 3.1增加的，从帖子详情h5外链进来
     */
    if ([url.description hasPrefix:@"quanwei"]) {
        return [self p_handelPostdeURL:url];
    }else if([url.host isEqualToString:@"safepay"]){
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            DDLogVerbose(@"result = %@",resultDic);
            if([resultDic[@"resultStatus"]isEqualToString:@"9000"]){//支付成功
                for(int i=0;i<3;i++){//3次请求接口
                    BOOL successStatus=[QWGLOBALMANAGER getAliResult:QWGLOBALMANAGER.payOrderId index:i];
                    if(successStatus) break;
                }
            }else if([resultDic[@"resultStatus"]isEqualToString:@"4000"]){//支付中
                for(int i=0;i<3;i++){//3次请求接口
                    BOOL successStatus=[QWGLOBALMANAGER getAliResult:QWGLOBALMANAGER.payOrderId index:i];
                    if(successStatus) break;
                }
            }else{//支付失败
                PayInfoModel *responseModel =[PayInfoModel new];
                responseModel.notiType=@"ali";//支付宝
                responseModel.notiTypeStatus=@"1";//用户中途取消，失败
                [QWGLOBALMANAGER postNotif:NotifPayStatusUnknown data:responseModel object:nil];
            }

        }];
        return YES;
    }else{
        BOOL result = YES;
        if([[url host] rangeOfString:@"pay"].location != NSNotFound) {
            result = [WXApi handleOpenURL:url delegate:QWGLOBALMANAGER];
        }else{
            result = [UMSocialSnsService handleOpenURL:url];
        }
        return result;
    }
}


/**
 * http://192.168.5.245:8184/QWWEB/v310/web/integral_mall/html/proDetail.html?id=093c4b6b4d57470aa2d42f0b12543951
 * H5积分商城分享链接唤起app，跳至积分商品详情页 add by 朱鹏翔
 */
-(BOOL)h_handelH5URL:(NSURL *)url {
    NSString *urlString = url.description;
    if ([urlString rangeOfString:@"malldetail"].location != NSNotFound) {
        NSString *proID = [[urlString componentsSeparatedByString:@"id="] lastObject];
        if (StrIsEmpty(proID)) {
            return NO;
        }
        WebDirectViewController *webVC = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
        WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
        modelLocal.title = @"商品详情";
        modelLocal.typeLocalWeb = WebLocalTypeOuterLink;
        modelLocal.url = [NSString stringWithFormat:@"http://192.168.5.245:8184/QWAPP/v310/QWYH/web/integral_mall/html/proDetail.html?id=%@",proID];
        [webVC setWVWithLocalModel:modelLocal];
        UIViewController* presentedVC = [self.mainVC presentedViewController];
        if ([presentedVC isKindOfClass:[UINavigationController class]]) {
             UINavigationController* naviVC = (UINavigationController*)presentedVC;
            [naviVC pushViewController:webVC animated:YES];
        }else {
            QWBaseNavigationController* nav = [[QWBaseNavigationController alloc] initWithRootViewController:webVC];
            nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            
            [nav.navigationBar setBarTintColor:RGBHex(qwColor1)];
            CGRect rect = CGRectMake(0, 0, 1, 1);
            UIGraphicsBeginImageContext(rect.size);
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetFillColorWithColor(context,[RGBHex(qwColor1) CGColor]);
            CGContextFillRect(context, rect);
            UIImage * imge = [[UIImage alloc] init];
            imge = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            [nav.navigationBar setBackgroundImage:imge forBarMetrics:UIBarMetricsDefault];
            [nav.navigationBar setShadowImage:[[UIImage alloc] init]];
            
            [APPDelegate.mainVC presentViewController:nav animated:YES completion:nil];
        }
        return YES;
    }
    return NO;
}
/**
 *  add by martin 3.1增加的，从h5外链进来present帖子详情
 *  格式类似：quanweiios://postsdetail?id=f761ac8ef8ca4564b6926a4dc722ce03
 */
- (BOOL)p_handelPostdeURL:(NSURL*)url
{
    NSString* urlString = url.description;
    if ([urlString hasPrefix:@"quanwei"]) {
        // 特殊情况处理 by 朱鹏翔
        [GLOBALMANAGER postNotif:NotifRemoveHealthView data:nil object:nil];
        if ([urlString rangeOfString:@"postsdetail"].location != NSNotFound) {
            NSArray* array = [urlString componentsSeparatedByString:@"="];
            if (array.count > 0) {
                for (int index = 0; index < array.count-1; index++) {
                    if ([array[index] isKindOfClass:[NSString class]] && [array[index] rangeOfString:@"postsdetail"].location != NSNotFound) {
                        NSString* postId = array[index
                                                 +1];
                        postId = [postId stringByReplacingOccurrencesOfString:@"&" withString:@""];
                        PostDetailViewController* postDetailVC = [[UIStoryboard storyboardWithName:@"Forum" bundle:nil] instantiateViewControllerWithIdentifier:@"PostDetailViewController"];
                        postDetailVC.postId = postId;
                        postDetailVC.isBackToDismiss = YES;
                        postDetailVC.hidesBottomBarWhenPushed = YES;
                        postDetailVC.preVCNameStr = @"分享链接";
                        
                        UIViewController* presentedVC = [self.mainVC presentedViewController];
                        // 如果已经有弹出的navi
                        if ([presentedVC isKindOfClass:[UINavigationController class]]) {
                            UINavigationController* naviVC = ((UINavigationController*)presentedVC);
                            UIViewController* topVC = naviVC.topViewController;
                            // 如果顶层vc是帖子详情，并且postid一样则不增加页面
                            if ([topVC isKindOfClass:[PostDetailViewController class]] && [postId isEqualToString:((PostDetailViewController*)postDetailVC).postId]) {
                            }
                            else
                            {
                                [naviVC pushViewController:postDetailVC animated:NO];
                            }
                        }
                        else
                        {
                            QWBaseNavigationController* nav = [[QWBaseNavigationController alloc] initWithRootViewController:postDetailVC];
                            nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                            
                            [nav.navigationBar setBarTintColor:RGBHex(qwColor3)];
                            CGRect rect = CGRectMake(0, 0, 1, 1);
                            UIGraphicsBeginImageContext(rect.size);
                            CGContextRef context = UIGraphicsGetCurrentContext();
                            CGContextSetFillColorWithColor(context,[RGBHex(qwColor3) CGColor]);
                            CGContextFillRect(context, rect);
                            UIImage * imge = [[UIImage alloc] init];
                            imge = UIGraphicsGetImageFromCurrentImageContext();
                            UIGraphicsEndImageContext();
                            
                            [nav.navigationBar setBackgroundImage:imge forBarMetrics:UIBarMetricsDefault];
                            [nav.navigationBar setShadowImage:[[UIImage alloc] init]];
                            
                            [APPDelegate.mainVC presentViewController:nav animated:YES completion:nil];
                        }
                    }
                }
            }
            return YES;
        }
        else if([urlString rangeOfString:@"malldetail"].location != NSNotFound) {
            //积分商城分享唤起app add by 朱鹏翔
            [self h_handelH5URL:url];
        }
    }
    return NO;
}

- (void)initforLaunchWithApplication:(UIApplication *)application Option:(NSDictionary *)dic
{
    [QWGLOBALMANAGER initNavigationBarStyle:RGBHex(qwColor4)];
    [self registerLocalNotification];
    [self registerRemoteNotification];
    
    [QWGLOBALMANAGER umengInit];
    [QWGLOBALMANAGER initsocailShare:nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor blackColor];
    self.mainVC = [MainViewController new];
    self.window.rootViewController = self.mainVC;
    [self initTabBar];
    if([QWUserDefault getBoolBy:APP_LOGIN_STATUS])
    {
        [[UIApplication sharedApplication].keyWindow addSubview:QWGLOBALMANAGER.fadeCover];
    }
    [QWGLOBALMANAGER statisticsEventId:@"启动" withLable:@"启动" withParams:nil];
    
    if (dic) {
        // 从通知进的,取消启动页
        if (!self.dicNotiBody) {
            self.dicNotiBody = dic;
        }
//        [self application:application didReceiveRemoteNotification:dic];
       
    } else {
        //启动页
        [QWGLOBALMANAGER showSplash];
    }

    //引导页的一种
    //QWGLOBALMANAGER.fadeCover = [[AppFadeCover alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)showOPSplash
{
    //启动时长
    double duration = [QWUserDefault getDoubleBy:APP_LAUNCH_DURATION];
    
    if (duration>0 && [QWUserDefault getObjectBy:APP_LAUNCH_IMAGE] != nil) {
        
        [SplashView showSplashViewAtWindow:self.window WithBlock:^{
            
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            if([[userDefault objectForKey:@"showGuide"] boolValue] == NO) {
                [userDefault setObject:[NSNumber numberWithBool:YES] forKey:@"showGuide"];
                [userDefault synchronize];
                [QWGLOBALMANAGER postNotif:NotifAppCheckVersion data:nil object:self];
            }
            NSString *url = [QWUserDefault getStringBy:APP_LAUNCH_URL];
            NSMutableDictionary *setting = [NSMutableDictionary dictionary];
            if([QWUserDefault getStringBy:APP_LAUNCH_TITLE]) {
                setting[@"启动页标题"] = [QWUserDefault getStringBy:APP_LAUNCH_TITLE];
            }
//            if(url && ![url isEqualToString:@""]){
//                
//                [self jumpToOtherWebview:url titl:[QWUserDefault getStringBy:APP_LAUNCH_TITLE]];
//            }
            if (!StrIsEmpty(url)) {
                [self jumpToOtherWebview:url titl:[QWUserDefault getStringBy:APP_LAUNCH_TITLE]];
            }
        }];
    }
}

- (void)setMyCenterRedBuddge
{
    QWGLOBALMANAGER.myCenterBudge = [[UIImageView alloc] initWithFrame:CGRectMake(286, 5, 10, 10)];
    QWGLOBALMANAGER.myCenterBudge.layer.cornerRadius = 5.0f;
    QWGLOBALMANAGER.myCenterBudge.layer.masksToBounds = YES;
    QWGLOBALMANAGER.myCenterBudge.backgroundColor = RGBHex(qwColor3);
    [QWGLOBALMANAGER.tabBar.tabBar addSubview:QWGLOBALMANAGER.myCenterBudge];
    QWGLOBALMANAGER.myCenterBudge.hidden = YES;
}

- (void)autoLoginAction
{
    if(![QWUserDefault getStringBy:APP_PASSWORD_KEY])
    {
        return;
    }
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    mbrLogin *param=[mbrLogin new];
    param.account = [QWUserDefault getStringBy:APP_USERNAME_KEY];
    param.password = [QWUserDefault getStringBy:APP_PASSWORD_KEY];
    param.device = IOS_DEVICE;
    param.deviceCode = DEVICE_ID;//
    param.pushDeviceCode = QWGLOBALMANAGER.deviceToken;
    param.credentials=[AESUtil encryptAESData:[QWUserDefault getStringBy:APP_PASSWORD_KEY] app_key:AES_KEY];
    
    HttpClientMgr.progressEnabled=NO;
    [Mbr loginWithParams:param
                 success:^(id obj){
                     [QWGLOBALMANAGER.fadeCover fadeOut];
                     mbrUser *user = obj;
                     if (user && [user.apiStatus intValue] == 0) {
                         QWGLOBALMANAGER.configure.userToken = user.token;
                         QWGLOBALMANAGER.configure.passPort = user.passportId;
                         QWGLOBALMANAGER.configure.nickName = user.nickName;
                         QWGLOBALMANAGER.configure.avatarUrl = user.avatarUrl;
                         QWGLOBALMANAGER.loginStatus = YES;
                         [QWGLOBALMANAGER saveAppConfigure];
                         [QWGLOBALMANAGER loginSucessCallBack];
                         //通知登录成功
                         [QWGLOBALMANAGER postNotif:NotifLoginSuccess data:nil object:self];
                         [QWGLOBALMANAGER saveOperateLog:@"2"];
                     }else{
                         [SVProgressHUD showErrorWithStatus:user.apiMessage duration:0.8f];
                     }

                 }
                 failure:^(HttpException *e) {
                     [QWGLOBALMANAGER.fadeCover fadeOut];
                 }];
}


#pragma mark 测试代码
- (void)testCode{
    //初始化界面
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
 
//    UIViewController* vc = [board instantiateViewControllerWithIdentifier:@"menu"];
  
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[HomePageViewController alloc]init];;
}

#pragma mark -
#pragma mark 初始化
/**
 *  初始化导航栏样式
 */


/**
 *  初始化tab标签样式
 */
- (void)initTabBar
{
    
//    QWGLOBALMANAGER.tabBar = [[QWTabBar alloc] initWithDelegate:self];
    QWGLOBALMANAGER.tabBar = self.mainVC.tabbarOne;
}

- (void)registerLocalNotification
{
    
}



#pragma mark -
#pragma mark 推送相关接口


#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}
#endif

#pragma mark
#pragma mark 注册推送通知

- (void)registerRemoteNotification
{
#ifdef __IPHONE_8_0
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }  else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
#else
    UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
#endif
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSUInteger index = [tabBarController.viewControllers indexOfObject:viewController];
    if (index == 2)
    {
//点击咨询

    }
}

#pragma mark 全局通知
- (void)addObserverGlobal{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotif:) name:kQWGlobalNotification object:nil];
}

- (void)getNotif:(NSNotification *)sender{
    
    NSDictionary *dd=sender.userInfo;
    NSInteger ty=-1;
    id data;
    id obj;
    
    if ([GLOBALMANAGER object:[dd objectForKey:@"type"] isClass:[NSNumber class]]) {
        ty=[[dd objectForKey:@"type"]integerValue];
    }
    data=[dd objectForKey:@"data"];
    obj=[dd objectForKey:@"object"];
    
    [self getNotifType:ty data:data target:obj];
}

#pragma mark 全局通知
- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj{
    if (type == NotifAppCheckVersion) {
        [QWGLOBALMANAGER checkVersion];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self.window];
    CGRect statusFrame = [[UIApplication sharedApplication] statusBarFrame];
    if (CGRectContainsPoint(statusFrame, point)) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kQWClickStatusNotification object:nil];
    }
}

////禁用三方键盘
//- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(NSString *)extensionPointIdentifier
//{
//    if ([extensionPointIdentifier isEqualToString:@"com.apple.keyboard-service"]) {
//        return NO;
//    }
//    return YES;
//}
#define DE_BASE_URL_SIT                     @"http://m.api.sit.qwysfw.cn"
#define DE_H5_DOMAIN_URL_SIT                @"http://h5-api.sit.qwysfw.cn"
#define DE_ONCE_URL_SIT                     @"http://58.210.18.35:9400"
#define DE_TWICE_URL_SIT                    @"http://58.210.18.35:9400"
#define SHOW_NATIONWIDE_SIT                 @NO
#define SHOW_HTML_SIT                       @NO
#define DE_SHARE_URL_SIT                    @"http://m.sit.qwysfw.cn"

@end
