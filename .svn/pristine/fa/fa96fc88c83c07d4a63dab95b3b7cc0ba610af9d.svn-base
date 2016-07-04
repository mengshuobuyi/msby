//
//  NewsPageViewController.m
//  APP
//
//  Created by qw on 15/2/27.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "HealthInfoPageViewController.h"
#import "QWGlobalManager.h"
#import "SVProgressHUD.h"

#import "QCSlideSwitchView.h"

#import "Healthinfo.h"

#import "InformationListViewController.h"
#import "HealthInfoRecommendViewController.h"

#import "QWGlobalManager.h"
#import "DrugGuideApi.h"
#import "LoginViewController.h"
#import "MessageBoxListViewController.h"

@interface HealthInfoPageViewController ()<QCSlideSwitchViewDelegate>
{
    NSArray *               arrChannel;
    NSMutableArray *        viewControllers;
    UIViewController *      currentViewController;
}
@property (nonatomic, strong) QCSlideSwitchView *slideSwitchView;
@property (nonatomic, assign) BOOL needJump;
@end

@implementation HealthInfoPageViewController
@synthesize slideSwitchView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    if (iOSv7 && self.view.frame.origin.y==0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.title = @"健康资讯";
    viewControllers=nil;
    viewControllers = [NSMutableArray arrayWithCapacity:5];
    
    _badgeView = [[MKNumberBadgeView alloc] initWithFrame:CGRectMake(5, -6, 35, 35)];
    _badgeView.shadow = NO;
    _badgeView.userInteractionEnabled = NO;
    _badgeView.hideWhenZero = NO;
    _badgeView.tag = 888;
    _badgeView.hidden = NO;
    _badgeView.textColor=RGBHex(qwColor4);
    //小信封
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(20, 0, 25, 44);
    [rightButton addSubview:_badgeView];
    [rightButton setImage:[UIImage imageNamed:@"ic_btn_newsbox"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(pushIntoMessageBox:) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //立刻刷新小红点
    [QWGLOBALMANAGER updateRedPoint];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if(currentViewController)
    {
        [currentViewController viewWillAppear:animated];
    } else {
        if (QWGLOBALMANAGER.currentNetWork == NotReachable) {
            NSArray *arrLocal = [HealthinfoChannel getArrayFromDBWithWhere:nil];
            if (arrLocal.count > 0) {
                
            } else {
                [self showInfoView:kWarningN2 image:@"网络信号icon"];
                return;
            }
            
        } else {
            [self removeInfoView];
        }
    }
    
    if(self.badgeView.value > 0) {
        self.badgeView.hidden = NO;
    }else{
        self.badgeView.hidden = YES;
    }
    
    //点击小红点消失
    
    if (QWGLOBALMANAGER.needShowBadge == YES) {
        self.needJump = YES;
        QWGLOBALMANAGER.needShowBadge = NO;
        [QWGLOBALMANAGER setBadgeNumStatus:NO];
        
        
        NSMutableDictionary *setting = [NSMutableDictionary dictionary];
        setting[@"token"] = StrFromObj(QWGLOBALMANAGER.configure.userToken);
        [DrugGuideApi drugGuideReadDotWithParams:setting success:^(id obj) {
            
            if ([obj[@"apiStatus"] integerValue] == 0) {
                
            }else
            {
                [SVProgressHUD showErrorWithStatus:obj[@"apiMessage"] duration:0.8];
            }
            
        } failure:^(HttpException *e) {
            
        }];
        
    }
    
    
    [self getChannelList];
    ((QWBaseNavigationController *)self.navigationController).canDragBack = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.badgeView.hidden = YES;
    ((QWBaseNavigationController *)self.navigationController).canDragBack = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -----
#pragma mark ----- 设置Action

- (void)pushIntoMessageBox:(id)sender
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
    if(sender) {
        [self.navigationController pushViewController:vcMsgBoxList animated:YES];
    }else{
        [self.navigationController pushViewController:vcMsgBoxList animated:YES];
    }
    
}



//初始化各标签显示内容
- (void)setUpViewControllerWith:(NSArray *)array
{
//    if(array == nil || [array count]==0)
//        return;
    
    //服务器获取的channel
    for(id obj in array)
    {
        // comment by perry. need update
        HealthinfoChannel * channel = obj;
        if ([channel.isRecommend intValue] == 1) {
            HealthInfoRecommendViewController *vcRecommend = [[UIStoryboard storyboardWithName:@"HealthInfo" bundle:nil] instantiateViewControllerWithIdentifier:@"HealthInfoRecommendViewController"];
            vcRecommend.navigationController = self.navigationController;
            vcRecommend.channelInfo = channel;
            vcRecommend.title = channel.channelName;
            [viewControllers addObject:vcRecommend];
        } else {
            InformationListViewController *controller = [[InformationListViewController alloc] init];
            controller.navigationController = self.navigationController;
            controller.channelInfo = channel;
            controller.title = channel.channelName;
            [viewControllers addObject:controller];
        }
    }
    //固定的channel
    //如果关注的是慢性病，则跳转到慢性病标签，默认是第一个标签

    currentViewController = viewControllers[0];
    
    [self setupSilderView];
}

- (void)jumpToDisease
{

}


//设置滑动
- (void)setupSilderView
{
    if (self.slideSwitchView) {
        [self.slideSwitchView removeFromSuperview];
        self.slideSwitchView = nil;
    }
    
    self.slideSwitchView = [[QCSlideSwitchView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H-NAV_H)];
    self.slideSwitchView.userSelectedChannelID = 0;

    if (self.needJump) {
        self.slideSwitchView.userSelectedChannelID = viewControllers.count-1+100;
    } else {
        self.slideSwitchView.userSelectedChannelID = 100;
    }
    
    self.slideSwitchView.tabItemNormalColor = [QCSlideSwitchView colorFromHexRGB:@"7c7c7c"];
    [self.slideSwitchView.topScrollView setBackgroundColor:RGBHex(qwColor11)];
    self.slideSwitchView.tabItemSelectedColor = RGBHex(qwColor1);
    self.slideSwitchView.slideSwitchViewDelegate = self;
    self.slideSwitchView.isNeedAdjust = YES;
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"blue_line_and_shadow"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    [self.slideSwitchView buildUI];
    self.slideSwitchView.rootScrollView.scrollEnabled = YES;
    [self.view addSubview:self.slideSwitchView];
}

#pragma mark -
#pragma mark QCSlideSwitchViewDelegate

- (NSUInteger)numberOfTab:(QCSlideSwitchView *)view
{
    return viewControllers.count;
}

- (UIViewController *)slideSwitchView:(QCSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    return viewControllers[number];
}

- (void)slideSwitchView:(QCSlideSwitchView *)view willselectTab:(NSUInteger)number
{
    [viewControllers[number] viewWillAppear:NO];
}

- (void)slideSwitchView:(QCSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
//        [SVProgressHUD showErrorWithStatus:@"网络未连接，请重试" duration:0.8f];
//        return;
    }
    if(currentViewController == viewControllers[number])
        return;
    currentViewController = viewControllers[number];
    
    HealthinfoChannel * channel = arrChannel[number];
        // comment by perry, need change
        if ([channel.isRecommend intValue] == 1) {
            [(HealthInfoRecommendViewController *)currentViewController refresh];
            ((HealthInfoRecommendViewController*)currentViewController).strAdviceID = @"";
        } else {
            [(InformationListViewController*)currentViewController refresh];
            ((InformationListViewController*)currentViewController).strAdviceID = @"";
        }

        self.slideSwitchView.rootScrollView.scrollEnabled = YES;
    
}

#pragma mark -
#pragma mark 数据请求
- (void)getChannelList
{
    if (viewControllers.count > 1) {
        if (self.needJump) {
            [self.slideSwitchView jumpToTabAtIndex:[viewControllers count]-1];
            self.needJump = NO;
        } else {
            // comment by perry, need update
            if ([currentViewController isKindOfClass:[InformationListViewController class]]) {
                [(InformationListViewController*)currentViewController refresh];
            } else if ([currentViewController isKindOfClass:[HealthInfoRecommendViewController class]]) {
                [(HealthInfoRecommendViewController*)currentViewController refresh];
            }
            
        }
        return;
    }
    if (QWGLOBALMANAGER.currentNetWork != NotReachable) {
        [HealthinfoChannel deleteAllObjFromDB];
    }
    
    //先从缓存读取数据
    arrChannel = [HealthinfoChannel getArrayFromDBWithWhere:nil];
    
    //从服务器读取数据
    if([arrChannel count] == 0 || arrChannel == nil)//没有数据 向网络进行请求
    {
        [self removeInfoView];
        [Healthinfo QueryChannelsuccess:^(id obj){
            if ([obj isKindOfClass:[NSArray class]]) {
            arrChannel = (NSArray*)obj;
                //这边的要shan
//                for (int i = 0; i<arrChannel.count; i++) {
//                    HealthinfoChannel * channel = arrChannel[i];
//                    channel.isRecommend = @"1";
//                }
            //保存数据到数据库
            [HealthinfoChannel saveObjToDBWithArray:arrChannel];
                                    
            [viewControllers removeAllObjects];
            [self setUpViewControllerWith:arrChannel];
            if (self.needJump) {
                [self.slideSwitchView jumpToTabAtIndex:[viewControllers count]-1];
                self.needJump = NO;
                }
            }
            // comment by perry. need update
            if ([currentViewController isKindOfClass:[InformationListViewController class]]) {
                [(InformationListViewController*)currentViewController refresh];
            } else if ([currentViewController isKindOfClass:[HealthInfoRecommendViewController class]]) {
                [(HealthInfoRecommendViewController*)currentViewController refresh];
            }
                            }
                          failure:^(HttpException *e){
                             
//                              [self showInfoView:kWarning39 image:@"ic_img_fail"];
                              if(e.errorCode!=-999){
                                  if(e.errorCode == -1001){
                                      [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                                  }else{
                                      [self showInfoView:kWarning39 image:@"ic_img_fail"];
                                  }
                                  
                              }
//                              [viewControllers removeAllObjects];
//                              [self setUpViewControllerWith:arrChannel];
                          }];
    }
    else
    {
        [viewControllers removeAllObjects];
        [self setUpViewControllerWith:arrChannel];
        // comment by perry. need update
        if ([currentViewController isKindOfClass:[InformationListViewController class]]) {
            [(InformationListViewController*)currentViewController refresh];
        } else if ([currentViewController isKindOfClass:[HealthInfoRecommendViewController class]]) {
            [(HealthInfoRecommendViewController*)currentViewController refresh];
        }
//        [(InformationListViewController*)currentViewController refresh];
    }
}

- (void)viewInfoClickAction:(id)sender
{
    if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        [self removeInfoView];
        [self getChannelList];
    }
}

#pragma mark -
#pragma mark 处理本视图收到的通知

- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj
{
    if (type == NotiJumptoDisease) {
        [self jumpToDisease];
    }
    else if(NotiMessageBadgeNum == type)
    {
        [self.badgeView setValueOnly:[data integerValue]];
    }
}


@end
