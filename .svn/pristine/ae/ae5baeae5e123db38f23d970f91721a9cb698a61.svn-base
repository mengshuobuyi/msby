
//
//  DrugDetailViewController.m
//  wenyao
//
//  Created by Meng on 14-9-28.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "DrugDetailViewController.h"
#import "Coupon.h"
#import "Drug.h"
#import "Favorite.h"
#import "ZhPMethod.h"
#import "KnowLedgeViewController.h"
#import "LoginViewController.h"
#import "DrugDetailViewController.h"
#import "RCDraggableButton.h"
//#import "CouponGenerateViewController.h"
#import "KnowLedgeViewController.h"
//#import "CouponDeatilViewController.h"
#import "ReturnIndexView.h"
#import "ConsultForFreeRootViewController.h"
#import "MessageBoxListViewController.h"
#import "SVProgressHUD.h"

@interface DrugDetailViewController ()<ReturnIndexViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIFont * titleFont;
    UIFont * contentFont;
    UIFont * topTitleFont;
    TopView * topView;
    UIView *footView;
    UIImageView * buttonImage;
    
    NSInteger m_descFont;
    NSInteger m_titleFont;
    NSInteger m_topTitleFont;
    UIFont          *defaultFont;
    BOOL isUp;
    int startTime;
    
    RCDraggableButton *avatar;
}
@property (strong, nonatomic) ReturnIndexView *indexView;
@property (strong, nonatomic) NSString *collectButtonImageName;
@property (strong, nonatomic) NSString *collectButtonName;
@property (nonatomic ,strong) NSMutableArray * dataSource;
@property (nonatomic ,strong) NSString * sid;//收藏时传入得id
@property(nonatomic,strong)NSString *medicineName;
@property(nonatomic,strong)NSString *medicineKnowledge;

//收藏按钮
@property (strong, nonatomic) UIButton *collectButton;

@property (nonatomic, strong) UILabel *numLabel;   //数字角标
@property (nonatomic, strong) UILabel *redLabel;   //小红点
@property (assign, nonatomic) int passNumber;

@end

@implementation DrugDetailViewController

- (id)init{
    
    if (self = [super init]) {
        buttonImage.image = [UIImage imageNamed:@"导航栏_收藏icon.png"];
        self.collectButtonImageName = @"导航栏_收藏icon.png";
        self.collectButtonName=@"收藏";
    }
    return self;
}

- (void)drugViewDidLoad{
    
    topView = [[TopView alloc] init];
    topView.hidden=YES;
    isUp = YES;
    m_descFont = kFontS4;
    m_titleFont = kFontS3;
    m_topTitleFont = kFontS2;
    defaultFont = fontSystem(kFontS5);
    
    self.dataSource = [NSMutableArray array];
    self.tableViews=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    
    self.tableViews.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableViews.dataSource=self;
    self.tableViews.delegate=self;
    self.tableViews.backgroundColor =RGBHex(qwColor11);
    
    self.tableViews.tableHeaderView = topView;
    [self.view addSubview:self.tableViews];
    footView = [[UIView alloc]initWithFrame:CGRectMake(0, APP_H -NAV_H, SCREEN_W, 40)];
    UIButton *pushBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, SCREEN_W - 20, 30)];
    [pushBtn setTitle:@"立即享受优惠" forState:UIControlStateNormal];
    [pushBtn setTitleColor: RGBHex(qwColor4) forState:UIControlStateNormal];
    [pushBtn setBackgroundColor:RGBHex(qwColor2)];
    pushBtn.layer.masksToBounds = YES;
    pushBtn.layer.cornerRadius = 2.0f;
    [pushBtn addTarget:self action:@selector(pushToGenerateView:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:pushBtn];
    [self.view addSubview:footView];
    
    titleFont=fontSystemBold(kFontS3);
    topTitleFont=fontSystemBold(kFontS2);
    contentFont=fontSystem(kFontS4);
    topView.titleFont=fontSystemBold(kFontS3);
    topView.topTitleFont=fontSystemBold(kFontS2);
    topView.contentFont=fontSystem(kFontS4);
    
#pragma ---index---
   
    [self ifHasCoupon];

    self.tableViews.backgroundColor =RGBHex(qwColor11);
    topView.facComeFrom = self.facComeFrom;
    
    [self.view bringSubviewToFront:avatar];

}

//跳转到咨询页面
- (IBAction)consultDoctor:(id)sender {
    ConsultForFreeRootViewController *consultViewController = [[UIStoryboard storyboardWithName:@"ConsultForFree" bundle:nil] instantiateViewControllerWithIdentifier:@"ConsultForFreeRootViewController"];
    
    consultViewController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:consultViewController animated:YES];
}

-(void)popVCAction:(id)sender{
    
    //如果是优惠活动，返回的时候直接返回到优惠详情页面？这个逻辑是以前的，不清楚----cj
    
//    for (UIViewController *temp in self.navigationController.viewControllers) {
//        
//        if ([temp isKindOfClass:[CouponDeatilViewController class]]) {
//            [self.navigationController popToViewController:temp animated:YES];
//            return;
//        }
//    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)ifHasCoupon{
    
    //第一次定位失败则不显示立即享受优惠按钮
//    if(![[QWUserDefault getObjectBy:APP_FIRSTLOCATION_NOTIFICATION] boolValue]){
//        
//        footView.hidden = YES;
//        footView.frame = CGRectMake(0, APP_H - NAV_H , SCREEN_W, 40);
//        [self.tableViews setFrame:CGRectMake(0, 0, APP_W, APP_H -NAV_H )];
//        [self obtainDataSource];
//        return;
//    }
    
    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
    if(QWGLOBALMANAGER.loginStatus){
        setting[@"token"] = QWGLOBALMANAGER.configure.userToken;
    }
    setting[@"proId"] = self.proId;
    NSString *province = [QWUserDefault getObjectBy:APP_PROVIENCE_NOTIFICATION];
    NSString *city = [QWUserDefault getObjectBy:APP_CITY_NOTIFICATION];
    
    //if(province && ![province isEqualToString:@""]){
    if(!StrIsEmpty(province)){
        setting[@"province"] = province;//省名称
    }else{
        setting[@"province"] =@"江苏省";
    }
    //if(city && ![city isEqualToString:@""]){
    if(!StrIsEmpty(city)){
        setting[@"city"] = city;//市名称
    }else{
        setting[@"city"] = @"苏州市";
    }
    
    
//    [Coupon promotionScanWithParms:setting success:^(id DFUserModel) {
//        CouponEnjoyModel *enjoymode=DFUserModel;
//        /**
//         *  0 正常
//         -10 商品不存在
//         -11 商品不适用
//         -2 活动未开始
//         -1 活动已结束
//         -4 活动异常
//         -13 总次数不足
//         -14 总人次不足
//         */
//        if(enjoymode.status && ([enjoymode.status intValue] == 0 || [enjoymode.status intValue] == -13 || [enjoymode.status intValue] == -14)){
//            //显示立即享受的按钮
//                footView.hidden = NO;
//                footView.frame = CGRectMake(0, APP_H -NAV_H - 40, SCREEN_W, 40);
//                [self.tableViews setFrame:CGRectMake(0, 0, APP_W, APP_H -NAV_H - 40)];
//        }else{
//            //不显示立即享受的按钮
//                footView.hidden = YES;
//                footView.frame = CGRectMake(0, APP_H -NAV_H , SCREEN_W, 40);
//                [self.tableViews setFrame:CGRectMake(0, 0, APP_W, APP_H -NAV_H )];
//        }
//        [self obtainDataSource];
//     
//    } failure:^(HttpException *e) {
//        footView.hidden = YES;
//        [self.tableViews setFrame:CGRectMake(0, 0, APP_W, APP_H -NAV_H )];
//        [self obtainDataSource];
//        return;
//    }];
    
}

- (void)pushToGenerateView:(id)sender{
    UIButton *btn = (UIButton *)sender;
    btn.userInteractionEnabled = NO;
    
    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
    if(QWGLOBALMANAGER.loginStatus){
        setting[@"token"] = QWGLOBALMANAGER.configure.userToken;
    }
    setting[@"proId"] = self.proId;
    NSString *province = [QWUserDefault getObjectBy:APP_PROVIENCE_NOTIFICATION];
    NSString *city = [QWUserDefault getObjectBy:APP_CITY_NOTIFICATION];
    //if(province && ![province isEqualToString:@""]){
    if(!StrIsEmpty(province)){
        setting[@"province"] = province;//省名称
    }else{
        setting[@"province"] =@"江苏省";
    }
    //if(city && ![city isEqualToString:@""]){
    if(!StrIsEmpty(city)){
        setting[@"city"] = city;//市名称
    }else{
        setting[@"city"] = @"苏州市";
    }
    
    
//    [Coupon promotionScanWithParms:setting success:^(id DFUserModel) {
//        CouponEnjoyModel *enjoymode=DFUserModel;
//        if ([enjoymode.status intValue] == 0) {
////            CouponGenerateViewController *generateView = [[CouponGenerateViewController alloc]initWithNibName:@"CouponGenerateViewController" bundle:nil];
////            generateView.useType = 3;
////            //传值：优惠活动详情
////            generateView.enjoy = enjoymode;
////            //传值：商品编码
////            generateView.proId = self.proId;
////            
////            for(id view in self.navigationController.viewControllers){
////                if([view isKindOfClass:[CouponGenerateViewController class]]){
////                    [self.navigationController popToViewController:view animated:YES];
////                    return;
////                }
////            }
////            generateView.delegatePopVC = self;
////            [self.navigationController pushViewController:generateView animated:YES];
////            btn.userInteractionEnabled = YES;
//            
//        }else{
//            [SVProgressHUD showErrorWithStatus:enjoymode.apiMessage duration:0.8f];
//            btn.userInteractionEnabled = YES;
//        }
//    } failure:^(HttpException *e) {
//        if(e.errorCode!=-999){
//            if(e.errorCode == -1001){
//                [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
//            }else{
//                [self showInfoView:kWarning39 image:@"ic_img_fail"];
//            }
//            
//        }
//        btn.userInteractionEnabled = YES;
//        return;
//    }];
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"药品详情";
//    if(!self.isConsult){
        self.passNumber = [QWGLOBALMANAGER updateRedPoint];
        [self setRightItems];
//    }else{
//        [self setRightItemsConsult];
//    }
    if([self isNetWorking]){
        [self showInfoView:kWarning12 image:@"网络信号icon"];
        return;
    }
    if(startTime == 0){
        [self drugViewDidLoad];
    }
    startTime ++;
}

- (void)viewInfoClickAction:(id)sender
{
    if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
      [self removeInfoView];
      [self drugViewDidLoad];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    startTime = 0;
    
    //增加咨询的按钮  暂时去掉
    
//    avatar = [[RCDraggableButton alloc] initWithFrame:CGRectMake(APP_W-78, SCREEN_H-142, 45, 45)];
//    [avatar setBackgroundImage:[UIImage imageNamed:@"img_btn_advisory"] forState:UIControlStateNormal];
//    [self.view addSubview:avatar];//加载图片
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(consultDoctor:)];
//    [avatar addGestureRecognizer:singleTap];//点击图片事件
//    [self.view addSubview:avatar];//加载图片
    
    
}


- (void)setRightItemsConsult{
    self.collectButtonImageName = @"导航栏_收藏icon.png";
    self.collectButtonName=@"收藏";
    UIView *ypDetailBarItems=[[UIView alloc]initWithFrame:CGRectMake(40, 0, 60, 55)];
    
    UIButton * zoomButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [zoomButton setFrame:CGRectMake(28, 0, 55,55)];
    [zoomButton addTarget:self action:@selector(zoomButtonClick) forControlEvents:UIControlEventTouchUpInside];
    zoomButton.titleLabel.font = [UIFont systemFontOfSize:19.0f];
    zoomButton.titleLabel.textColor = [UIColor whiteColor];
    [zoomButton setTitle:@"Aa" forState:UIControlStateNormal];
    [ypDetailBarItems addSubview:zoomButton];
    
   
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:ypDetailBarItems];
}


- (void)setRightItems{
    self.collectButtonImageName = @"导航栏_收藏icon.png";
    self.collectButtonName=@"收藏";
    UIView *ypDetailBarItems=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 55)];
    
    UIButton * zoomButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [zoomButton setFrame:CGRectMake(28, 0, 55,55)];
    [zoomButton addTarget:self action:@selector(zoomButtonClick) forControlEvents:UIControlEventTouchUpInside];
    zoomButton.titleLabel.font = [UIFont systemFontOfSize:19.0f];
    zoomButton.titleLabel.textColor = [UIColor whiteColor];
    [zoomButton setTitle:@"Aa" forState:UIControlStateNormal];
    [ypDetailBarItems addSubview:zoomButton];
    
    
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(65, 0, 60, 55)];
    //三个点button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(-5, 6, 50, 40);
    [button setImage:[UIImage imageNamed:@"icon-unfold.PNG"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(returnIndex) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:button];
    
    //数字角标
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 9, 18, 18)];
    self.numLabel.backgroundColor = RGBHex(qwColor3);
    self.numLabel.layer.cornerRadius = 9.0;
    self.numLabel.textColor = [UIColor whiteColor];
    self.numLabel.font = [UIFont systemFontOfSize:11];
    self.numLabel.textAlignment = NSTextAlignmentCenter;
    self.numLabel.layer.masksToBounds = YES;
    self.numLabel.text = @"10";
    self.numLabel.hidden = YES;
    [rightView addSubview:self.numLabel];
    
    //小红点
    self.redLabel = [[UILabel alloc] initWithFrame:CGRectMake(29, 17, 8, 8)];
    self.redLabel.backgroundColor = RGBHex(qwColor3);
    self.redLabel.layer.cornerRadius = 4.0;
    self.redLabel.layer.masksToBounds = YES;
    self.redLabel.hidden = YES;
    [rightView addSubview:self.redLabel];
    [ypDetailBarItems addSubview:rightView];
        
    UIBarButtonItem *fix=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fix.width=-20;
    self.navigationItem.rightBarButtonItems=@[fix,[[UIBarButtonItem alloc]initWithCustomView:ypDetailBarItems]];
    
    if (self.passNumber > 0)
    {
        //显示数字
        self.numLabel.hidden = NO;
        self.redLabel.hidden = YES;
        if (self.passNumber > 99) {
            self.passNumber = 99;
        }
        self.numLabel.text = [NSString stringWithFormat:@"%d",self.passNumber];
        
    }else if (self.passNumber == 0)
    {
        //显示小红点
        self.numLabel.hidden = YES;
        self.redLabel.hidden = NO;
        
    }else if (self.passNumber < 0)
    {
        //全部隐藏
        self.numLabel.hidden = YES;
        self.redLabel.hidden = YES;
    }

}
- (void)returnIndex
{
    self.indexView = [ReturnIndexView sharedManagerWithImage:@[@"ic_img_notice",@"icon home.PNG"] title:@[@"消息",@"首页"] passValue:self.passNumber];
    self.indexView.delegate = self;
    [self.indexView show];
}
- (void)RetunIndexView:(ReturnIndexView *)ReturnIndexView didSelectedIndex:(NSIndexPath *)indexPath
{
    [self.indexView hide];
    
    if (indexPath.row == 0)
    {
        if(!QWGLOBALMANAGER.loginStatus) {
            LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
            loginViewController.isPresentType = YES;
            [self presentViewController:navgationController animated:YES completion:NULL];
            return;
        }
        
        MessageBoxListViewController *vcMsgBoxList = [[UIStoryboard storyboardWithName:@"MessageBoxListViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MessageBoxListViewController"];
        
        vcMsgBoxList.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vcMsgBoxList animated:YES];
        
    }else if (indexPath.row == 1)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self performSelector:@selector(delayPopToHome) withObject:nil afterDelay:0.01];
    }
}
- (void)delayPopToHome
{
    [QWGLOBALMANAGER.tabBar setSelectedIndex:0];
}
#pragma mark---------------------------------------------跳转到首页-----------------------------------------------

- (void)zoomButtonClick{
    if (m_descFont == 20) {
        isUp = NO;
    }else if(m_descFont == 14){
        isUp = YES;
    }
    if (isUp) {
        m_descFont+=3;
        m_titleFont+=3;
        m_topTitleFont+=3;
    }else{
        m_descFont = 14;
        m_titleFont = 16;
        m_topTitleFont = 18;
    }
    topView.titleFont = [UIFont boldSystemFontOfSize:m_titleFont];
    topView.topTitleFont = [UIFont boldSystemFontOfSize:m_topTitleFont];
    topView.contentFont = [UIFont systemFontOfSize:m_descFont];
    
    titleFont = [UIFont boldSystemFontOfSize:m_titleFont];
    topTitleFont = [UIFont boldSystemFontOfSize:m_topTitleFont];
    contentFont = [UIFont systemFontOfSize:m_descFont];
    self.tableViews.tableHeaderView = topView;
    [self.tableViews reloadData];
}

//1001003
- (void)collectButtonClick{
    
    if (!QWGLOBALMANAGER.loginStatus) {
        LoginViewController * login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        login.isPresentType = YES;
        login.parentNavgationController = self.navigationController;
        UINavigationController * nav = [[QWBaseNavigationController alloc] initWithRootViewController:login];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    FavoriteCollectR *collectR=[FavoriteCollectR new];
    collectR.token=QWGLOBALMANAGER.configure.userToken;
    collectR.objId=self.sid;
    collectR.objType=@"1";
    collectR.method=@"1";//检查对象是否已经收藏
  [Favorite collectWithParam:collectR success:^(id DFUserModel) {
      CancleResult *model=(CancleResult *)DFUserModel;
      
       if ([model.apiStatus intValue]==1001003) {
             UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:ALERT_MESSAGE delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
             alertView.tag = 999;
             alertView.delegate = self;
             [alertView show];
             return;
       }else if([model.apiStatus intValue]==0){
           if ([model.result isEqualToString:@"1"])//已收藏
           {
               //若已收藏,则取消收藏
               collectR.method = @"3";
               [Favorite collectWithParam:collectR success:^(id DFUserModel){
                   CancleResult *subModel=(CancleResult *)DFUserModel;
                   if ([subModel.result isEqualToString:@"4"]) {
                       [self showSuccess:@"取消收藏成功"];
                       buttonImage.image = [UIImage imageNamed:@"导航栏_收藏icon.png"];
                       self.collectButtonImageName = @"导航栏_收藏icon.png";
                       self.collectButtonName=@"收藏";
                   }else if ([subModel.result isEqualToString:@"5"]) {//取消收藏失败
                       [self showError:subModel.apiMessage];
                       return ;
                   }
               } failure:^(HttpException *e) {
                   if(e.errorCode!=-999){
                       if(e.errorCode == -1001){
                           [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                       }else{
                           [self showInfoView:kWarning39 image:@"ic_img_fail"];
                       }
                       
                   }
                   return;
               }];
               
           }else if([model.result isEqualToString:@"0"])//未收藏
           {
               //若未收藏,则添加收藏
               collectR.method = @"2";
               [Favorite collectWithParam:collectR success:^(id DFUserModel) {
                   CancleResult *subModel=(CancleResult *)DFUserModel;
                   if ([subModel.result isEqualToString:@"2"]) {
                       [self showSuccess:@"添加收藏成功"];
                       buttonImage.image = [UIImage imageNamed:@"导航栏_已收藏icon.png"];
                       self.collectButtonImageName = @"导航栏_已收藏icon.png";
                       self.collectButtonName=@"取消收藏";
                   }else if ([subModel.result isEqualToString:@"3"]) {//收藏失败
                       [self showError:subModel.apiMessage];
                       return ;
                   }
               } failure:^(HttpException *e) {
                   if(e.errorCode!=-999){
                       if(e.errorCode == -1001){
                           [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                       }else{
                           [self showInfoView:kWarning39 image:@"ic_img_fail"];
                       }
                       
                   }
                   return;
               }];
           }
       
       
       }
      
  } failure:^(HttpException *e) {
      if(e.errorCode!=-999){
          if(e.errorCode == -1001){
              [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
          }else{
              [self showInfoView:kWarning39 image:@"ic_img_fail"];
          }
          
      }
      return;
  }];
    
    
}

// opType: 1 查询; 2 写入; 3 取消;
- (void)checkIsCollectOrNot
{
    if (QWGLOBALMANAGER.loginStatus) {
        FavoriteCollectR *collectR=[FavoriteCollectR new];
        collectR.token=QWGLOBALMANAGER.configure.userToken;
        collectR.objId=self.sid;
        collectR.objType=@"1";
        collectR.method=@"1";
        [Favorite collectWithParam:collectR success:^(id DFUserModel) {
            CancleResult *model=(CancleResult *)DFUserModel;
            if ([model.result isEqualToString:@"1"]) {
                buttonImage.image = [UIImage imageNamed:@"导航栏_已收藏icon.png"];
                self.collectButtonImageName = @"导航栏_已收藏icon.png";
                self.collectButtonName=@"取消收藏";
            }else if([model.result isEqualToString:@"0"]){
                buttonImage.image = [UIImage imageNamed:@"导航栏_收藏icon.png"];
                self.collectButtonImageName = @"导航栏_收藏icon.png";
                self.collectButtonName=@"收藏";
            }
        } failure:^(HttpException *e) {
            if(e.errorCode!=-999){
                if(e.errorCode == -1001){
                    [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                }else{
                    [self showInfoView:kWarning39 image:@"ic_img_fail"];
                }
                
            }
            return;
        }];
    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 999) {
        if (buttonIndex == 1) {
            LoginViewController * login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            login.isPresentType = YES;
            login.parentNavgationController = self.navigationController;
            UINavigationController * nav = [[QWBaseNavigationController alloc] initWithRootViewController:login];
            [self presentViewController:nav animated:YES completion:nil];
        }
    }
}


#pragma mark ------网络数据请求及解析------
- (void)obtainDataSource
{
    DrugDetailModelR *modelR=[DrugDetailModelR new];
    modelR.proId=self.proId;
    [Drug queryProductDetailWithParam:modelR Success:^(id DFModel) {
        self.collectButton.enabled = YES;
        [self fillupBaseInfo:DFModel];
        self.sid = DFModel[@"id"];
        self.medicineName = DFModel[@"shortName"];
        self.medicineKnowledge = DFModel[@"knowledgeTitle"];
        [self checkIsCollectOrNot];
    } failure:^(HttpException *e) {
        if(e.errorCode!=-999){
            if(e.errorCode == -1001){
                [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
            }else{
                [self showInfoView:kWarning39 image:@"ic_img_fail"];
            }
            
        }
        return;
    }];
}
- (void)fillupBaseInfo:(NSDictionary *)baseInfo{
    [self.dataSource removeAllObjects];
    topView.dataDictionary = baseInfo;
    topView.hidden=NO;
    self.tableViews.tableHeaderView = topView;
    NSMutableDictionary *change=[baseInfo mutableCopy];
    for (NSDictionary * dicT in change[@"useNotice"]) {
        NSMutableDictionary *dic = [dicT mutableCopy];
        NSString * t = dic[@"title"];
        NSString * c = dic[@"content"];
        //if (t.length > 0 && ([c isEqualToString:@""]||c.length == 0)) {
        if(t.length > 0 && (StrIsEmpty(c))){
            dic[@"content"] = @"尚不";
        }
        if (![dic[@"content"] isEqualToString:@"尚不"])
        {
            [self.dataSource addObject:dic];
        }
    }
    //空值隐藏整个tableview(不明白以前的逻辑，有何意义？)
    if (self.dataSource.count == 0&&!baseInfo) {
        self.tableViews.hidden = YES;
    }
    
    NSString *title = baseInfo[@"knowledgeTitle"];
    NSString *content = baseInfo[@"knowledgeContent"];
    if (title.length > 0) {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [dic setValue:@"用药小知识" forKey:@"title"];
        [dic setValue:title forKey:@"knowledgeTitle"];
        [dic setValue:content forKey:@"content"];
        [self.dataSource addObject:dic];
    }
    [self.tableViews reloadData];
}
#pragma mark ------UITableViewDelegate------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 10)];
    [view setBackgroundColor:RGBHex(qwColor11)];
    view.layer.masksToBounds=YES;
    view.layer.borderWidth = 0.5;
    view.layer.borderColor = RGBHex(qwColor10).CGColor;
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * dic = self.dataSource[indexPath.section];
    if (indexPath.row == 0) {
        return getTempTextSize([QWGLOBALMANAGER replaceSpecialStringWith:dic[@"title"]], titleFont, APP_W-20).height + 20;
    }
    
    if (indexPath.row == 1) {
        if ([dic[@"title"] isEqualToString:@"用药小知识"]) {
            return getTempTextSize([QWGLOBALMANAGER replaceSpecialStringWith:dic[@"title"]], titleFont, APP_W-20).height + 20;
        }
        return getTempTextSize([QWGLOBALMANAGER replaceSpecialStringWith:dic[@"content"]], contentFont, APP_W -20).height + 20;
    }
    return 30;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }

    
    [[cell viewWithTag:1008] removeFromSuperview];
    [[cell viewWithTag:1009] removeFromSuperview];
    [[cell viewWithTag:1010] removeFromSuperview];
    if(indexPath.row == 0) {
        cell.textLabel.font = titleFont;
        UIView *topSeparatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 0.5)];
        [topSeparatorView setBackgroundColor:RGBHex(qwColor10)];
        topSeparatorView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        topSeparatorView.tag = 1009;
        [cell addSubview:topSeparatorView];
        
        
        
    }else{
        cell.textLabel.font = contentFont;
        
        //药品的线的添加---cj
        UIView *topSeparatorView = [[UIView alloc] initWithFrame:CGRectMake(12, 0, APP_W, 0.5)];
        [topSeparatorView setBackgroundColor:RGBHex(qwColor10)];
        topSeparatorView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        topSeparatorView.tag = 1010;
        [cell addSubview:topSeparatorView];
        
        UIView *bottomSeparatorView = [[UIView alloc] initWithFrame:CGRectMake(0, MAX(cell.frame.size.height - 0.5,0), APP_W, 0.5)];
        [bottomSeparatorView setBackgroundColor:RGBHex(qwColor10)];
        bottomSeparatorView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
        bottomSeparatorView.tag = 1008;
        [cell addSubview:bottomSeparatorView];
    }
    
    NSDictionary * dic = self.dataSource[indexPath.section];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = dic[@"title"];
    }else{
        if ([dic[@"title"] isEqualToString:@"用药小知识"]) {
            cell.textLabel.text = [QWGLOBALMANAGER replaceSpecialStringWith:self.medicineKnowledge];
            cell.textLabel.font = fontSystem(contentFont.pointSize);
            cell.textLabel.numberOfLines = 1;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.font = contentFont;
            cell.textLabel.text = [QWGLOBALMANAGER replaceSpecialStringWith:dic[@"content"]];
        }
    }
    cell.textLabel.textColor = RGBHex(qwColor6);
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary * dic = self.dataSource[indexPath.section];
    if ([dic[@"title"] isEqualToString:@"用药小知识"]) {
        if (indexPath.row == 1) {
                        KnowLedgeViewController * knowLedge = [[KnowLedgeViewController alloc] init];
                        knowLedge.knowledgeTitle = dic[@"knowledgeTitle"];
                        knowLedge.knowledgeContent = dic[@"content"];
                        [self.navigationController pushViewController:knowLedge animated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj{
    if (NotiWhetherHaveNewMessage == type) {
        
        NSString *str = data;
        self.passNumber = [str integerValue];
        self.indexView.passValue = self.passNumber;
        [self.indexView.tableView reloadData];
        if (self.passNumber > 0)
        {
            //显示数字
            self.numLabel.hidden = NO;
            self.redLabel.hidden = YES;
            if (self.passNumber > 99) {
                self.passNumber = 99;
            }
            self.numLabel.text = [NSString stringWithFormat:@"%d",self.passNumber];
            
        }else if (self.passNumber == 0)
        {
            //显示小红点
            self.numLabel.hidden = YES;
            self.redLabel.hidden = NO;
            
        }else if (self.passNumber < 0)
        {
            //全部隐藏
            self.numLabel.hidden = YES;
            self.redLabel.hidden = YES;
        }
    }
}



@end



@implementation TopView
{
    CGFloat h;
    UIView *warning;
}
- (id)init{
    if (self = [super init]) {
        [self initLabel];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initLabel
{
    self.titleLabel = [[UILabel alloc] init];
    self.specLabel = [[UILabel alloc]init];
    self.factoryLabel = [[UILabel alloc]init];
    
    self.firstLabel = [[UILabel alloc] init];
    self.secondLabel = [[UILabel alloc] init];
    self.firstImageView = [[UIImageView alloc] init];
    self.secondImageView = [[UIImageView alloc] init];
}

- (void)setDataDictionary:(NSDictionary *)dataDictionary{
    _dataDictionary = dataDictionary;
    [self setUpView];
}



- (void)setContentFont:(UIFont *)contentFont{
    _contentFont = contentFont;
    [self setUpView];
}

- (void)setUpView{
    /*
     headerInfo =         {
     factory = "广州奇星药业有限公司";
     factoryAuth = 0;
     registerNo = "国药准字Z44022417";
     shortName = "奇星,新雪颗粒";
     sid = 5da18eb453ab3c869ab4011cac2b88fe;
     signCode = 1b;
     spec = "1.53g*6";
     type = "处方药中成药";
     unit = "盒";
     };
     */
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIView *topSeparatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 0.5)];
    [topSeparatorView setBackgroundColor:RGBHex(qwColor11)];
    topSeparatorView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    topSeparatorView.tag = 1009;
    [self addSubview:topSeparatorView];
    
    UIView *bottomSeparatorView = [[UIView alloc] initWithFrame:CGRectMake(0, MAX(self.frame.size.height - 0.5, 0), APP_W, 0.5)];
    [bottomSeparatorView setBackgroundColor:RGBHex(qwColor11)];
    bottomSeparatorView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    bottomSeparatorView.tag = 1008;
    [self addSubview:bottomSeparatorView];
    
    NSString * str = [QWGLOBALMANAGER replaceSpecialStringWith:self.dataDictionary[@"shortName"]];
    
    
    [self.titleLabel setFrame:CGRectMake(10, 10, APP_W-20, getTempTextSize(str, self.topTitleFont, APP_W-20).height)];
    self.titleLabel.text = str;
    self.titleLabel.font = self.topTitleFont;//[UIFont boldSystemFontOfSize:18.0f];
    self.titleLabel.textColor = RGBHex(qwColor6);
    [self addSubview:self.titleLabel];
    
    NSString *signcode = self.dataDictionary[@"signCode"];
    UIImage * firstImage = [[UIImage alloc] init];
    NSString * firstString = nil;
    NSString *recipeString = nil;
    
    if([signcode isEqualToString:@"1a"])
    {
        firstImage = [UIImage imageNamed:@"处方药.png"];
        firstString = @"处方药";
        recipeString = @"西药";
    }else if([signcode isEqualToString:@"1b"]){
        firstImage = [UIImage imageNamed:@"处方药.png"];
        firstString = @"处方药";
        recipeString = @"中成药";
    }else if([signcode isEqualToString:@"2a"]){
        firstImage = [UIImage imageNamed:@"otc-甲类.png"];
        firstString = @"甲类OTC非处方药";
        recipeString = @"西药";
    }else if([signcode isEqualToString:@"2b"]){
        firstImage = [UIImage imageNamed:@"otc-甲类.png"];
        firstString = @"甲类OTC非处方药";
        recipeString = @"中成药";
    }
    else if ([signcode isEqualToString:@"3a"]){
        firstImage = [UIImage imageNamed:@"otc-乙类.png"];
        firstString = @"乙类OTC非处方药";
        recipeString = @"西药";
    }else if([signcode isEqualToString:@"3b"]) {
        firstImage = [UIImage imageNamed:@"otc-乙类.png"];
        firstString = @"乙类OTC非处方药";
        recipeString = @"中成药";
    }else if([signcode isEqualToString:@"4c"]) {
        firstImage = nil;
        firstString = @"定型包装中药饮片";
    }else if([signcode isEqualToString:@"4d"]) {
        firstImage = nil;
        firstString = @"散装中药饮片";
    }else if([signcode isEqualToString:@"5"]) {
        firstImage = nil;
        firstString = @"保健食品";
    }else if([signcode isEqualToString:@"6"]) {
        firstImage = nil;
        firstString = @"食品";
    }else if([signcode isEqualToString:@"7"]) {
        firstImage = nil;
        firstString = @"械字号一类";
    }else if([signcode isEqualToString:@"8"]) {
        firstImage = nil;
        firstString = @"械字号二类";
    }else if([signcode isEqualToString:@"10"]) {
        firstImage = nil;
        firstString = @"消字号";
    }else if([signcode isEqualToString:@"11"]) {
        firstImage = nil;
        firstString = @"妆字号";
    }else if([signcode isEqualToString:@"12"]) {
        firstImage = nil;
        firstString = @"无批准号";
    }else if([signcode isEqualToString:@"13"]) {
        firstImage = nil;
        firstString = @"其他";
    }else if([signcode isEqualToString:@"9"]) {
        firstImage = nil;
        firstString = @"械字号三类";
    }
    
    //药品标签
    float logo_Y = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 8;
    //第一个view
    
    [self.firstImageView setFrame:CGRectMake(10, logo_Y, 25, 14)];
    self.firstImageView.image = firstImage;
    if(firstImage) {
        [self addSubview:self.firstImageView];
    }
    CGSize firstSize = getTempTextSize(firstString, self.contentFont, 200);
    
    //第一个label
    float first_label_X = 0;
    if(firstImage) {
        first_label_X = self.firstImageView.frame.origin.x + self.firstImageView.frame.size.width + 5;
    }else{
        first_label_X = 10;
    }
    [self.firstLabel setFrame:CGRectMake(first_label_X, logo_Y, firstSize.width + 30, firstSize.height)];
    self.firstLabel.text = firstString;
    self.firstLabel.font = self.contentFont;
    //    self.firstLabel.font = Font(14);
    self.firstLabel.textColor =RGBHex(qwColor7);
    [self addSubview:self.firstLabel];
    if(recipeString)
    {
        self.recipeImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.firstLabel.frame.origin.x + self.firstLabel.frame.size.width + 8, self.firstLabel.frame.origin.y + self.firstLabel.frame.size.height / 2 - 7.5, 20, 14)];
        if([recipeString isEqualToString:@"西药"]) {
            self.recipeImage.image = [UIImage imageNamed:@"西药.png"];
        }else{
            self.recipeImage.image = [UIImage imageNamed:@"中成药-1.png"];
        }
        [self addSubview:self.recipeImage];
        
        self.recipeLabel = [[UILabel alloc] initWithFrame:RECT(self.recipeImage.frame.origin.x + self.recipeImage.frame.size.width + 8, 35 , 100, 21)];
        [self.recipeLabel setFrame:CGRectMake(self.recipeImage.frame.origin.x + self.recipeImage.frame.size.width + 8, logo_Y - 2.5, APP_W-20,getTempTextSize(recipeString, self.titleFont, APP_W-20).height)];
        self.recipeLabel.textColor = RGBHex(qwColor7);
        self.recipeLabel.font = self.contentFont;
        self.recipeLabel.text = recipeString;
        [self addSubview:self.recipeLabel];
    }
    
    str = [QWGLOBALMANAGER replaceSpecialStringWith:self.dataDictionary[@"spec"]];
    [self.specLabel setFrame:CGRectMake(10, self.firstImageView.frame.origin.y + self.firstImageView.frame.size.height + 8, APP_W-20,getTempTextSize(str, self.titleFont, APP_W-20).height)];
    self.specLabel.text = [NSString stringWithFormat:@"%@",str];
    self.specLabel.textColor = RGBHex(qwColor7);
    self.specLabel.font = self.contentFont;
    [self addSubview:self.specLabel];
    
    
    str = [QWGLOBALMANAGER replaceSpecialStringWith:self.dataDictionary[@"factory"]];
    [self.factoryLabel setFrame:CGRectMake(10, self.specLabel.frame.origin.y + self.specLabel.frame.size.height + 8, APP_W-20,getTempTextSize(str, self.titleFont, APP_W-20).height)];
    self.factoryLabel.text = str;
    self.factoryLabel.font = self.contentFont;
    self.factoryLabel.textColor =RGBHex(qwColor7);
    [self addSubview:self.factoryLabel];
    
//        if([self.facComeFrom isEqualToString:@"1"]){
//            UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"news_img_star pharmacy"]];
//            imageView.frame = CGRectMake(10 + self.factoryLabel.text.length *self.contentFont.pointSize + 5, self.specLabel.frame.origin.y + self.specLabel.frame.size.height + 8, getTextSize(str, self.titleFont, APP_W-20).height, getTextSize(str, self.titleFont, APP_W-20).height);
//            [self addSubview:imageView];
//        }
    
    self.ephedrineLabel = [[UILabel alloc] init];
    [self.ephedrineLabel setFrame:CGRectMake(30, 8, (self.contentFont.pointSize - 1.5) * 16,self.contentFont.pointSize - 1.5)];
    self.ephedrineLabel.numberOfLines = 0;
    self.ephedrineLabel.textColor = RGBHex(qwColor7);
    self.ephedrineLabel.backgroundColor = RGBHex(qwColor11);
    self.ephedrineLabel.font = fontSystem(self.contentFont.pointSize - 1.5);
    self.ephedrineLabel.text = @"本品含麻黄碱，请遵医嘱谨慎使用。";
    
    self.ephedrineImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 8 , 15, 15)];
    self.ephedrineImage.image = [UIImage imageNamed:@"麻黄碱提醒icon.png"];
    self.ephedrineImage.backgroundColor =RGBHex(qwColor11);
    
    warning = [[UIView alloc]initWithFrame:CGRectMake(10, self.factoryLabel.frame.size.height + self.factoryLabel.frame.origin.y + 5, 30 + self.ephedrineLabel.frame.size.width, self.contentFont.pointSize + 16)];
    warning.backgroundColor =RGBHex(qwColor11);
    [warning addSubview:self.ephedrineLabel];
    [warning addSubview:self.ephedrineImage];
    [self addSubview:warning];
    
    if([self.dataDictionary[@"isContainEphedrine"] integerValue] == 1){
        //含麻黄碱
        h = warning.frame.origin.y + warning.frame.size.height + 8;
        warning.hidden = NO;
        
    }else{
        h = warning.frame.origin.y + 8;
        warning.hidden = YES;
        
    }
    //h = self.ephedrineLabel.frame.origin.y + self.ephedrineLabel.frame.size.height + 8;
    
    self.frame = CGRectMake(0, 0, APP_W, h);
}

@end
