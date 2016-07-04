//
//  NewsPageViewController.m
//  APP
//
//  Created by qw on 15/2/27.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "NewsPageViewController.h"
#import "QWGlobalManager.h"
#import "SVProgressHUD.h"

#import "QCSlideSwitchView.h"

#import "Healthinfo.h"

#import "InformationListViewController.h"
#import "DiseaseSubscriptionViewController.h"

#import "QWGlobalManager.h"

@interface NewsPageViewController ()<QCSlideSwitchViewDelegate>
{
    NSArray *               arrChannel;
    NSMutableArray *        viewControllers;
    UIViewController *      currentViewController;
}
@property (nonatomic, strong) QCSlideSwitchView *slideSwitchView;

@end

@implementation NewsPageViewController
@synthesize slideSwitchView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    if (iOSv7 && self.view.frame.origin.y==0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    self.navigationItem.title = @"健康资讯";
    viewControllers = [NSMutableArray arrayWithCapacity:5];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(currentViewController)
    {
        [currentViewController viewWillAppear:animated];
    }
    
    [self getChannelList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化各标签显示内容
- (void)setUpViewControllerWith:(NSArray *)array
{
    if(array == nil || [array count]==0)
        return;
    
    //服务器获取的channel
    for(id obj in array)
    {
        HealthinfoChannel * channel = obj;
        InformationListViewController *controller = [[InformationListViewController alloc] init];
        controller.navigationController = self.navigationController;
        controller.channelInfo = channel;
        controller.title = channel.channelName;
        [viewControllers addObject:controller];
        
    }
    //固定的channel
    DiseaseSubscriptionViewController *subscription = [[DiseaseSubscriptionViewController alloc] init];
    subscription.navigationController = self.navigationController;
    subscription.title = @"慢病订阅";
    [viewControllers addObject:subscription];

//如果关注的是慢性病，则跳转到慢性病标签，默认是第一个标签
//    if ((APPDelegate.dataBase)&&(![app.dataBase checkAllDiseaseReaded])) {
//        currentViewController = viewControllers[viewControllers.count-1];
//    } else {
//        currentViewController = viewControllers[0];
//    }
    
    [self setupSilderView];
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

    if (QWGLOBALMANAGER.needShowBadge == YES) {
        self.slideSwitchView.userSelectedChannelID = viewControllers.count-1+100;
    } else {
        self.slideSwitchView.userSelectedChannelID = 100;
    }
    
    self.slideSwitchView.tabItemNormalColor = [QCSlideSwitchView colorFromHexRGB:@"7c7c7c"];
    [self.slideSwitchView.topScrollView setBackgroundColor:UICOLOR(246, 246, 246)];
    self.slideSwitchView.tabItemSelectedColor = RGBHex(kColor3);
    self.slideSwitchView.slideSwitchViewDelegate = self;
    self.slideSwitchView.isNeedAdjust = YES;
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    [self.slideSwitchView buildUI];
    self.slideSwitchView.rootScrollView.scrollEnabled = NO;
    
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

- (void)slideSwitchView:(QCSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [SVProgressHUD showErrorWithStatus:@"网络未连接，请重试" duration:0.8f];
        return;
    }
    if(currentViewController == viewControllers[number])
        return;
    currentViewController = viewControllers[number];
    
    if (number == viewControllers.count) {
        [(DiseaseSubscriptionViewController*)currentViewController refresh];
    }
    else
    {
        [(InformationListViewController*)currentViewController refresh];
    }
    
    
    //[viewControllers[number] viewWillAppear:NO];
}

#pragma mark -
#pragma mark 数据请求
- (void)getChannelList
{
    //先从缓存读取数据
    arrChannel = [HealthinfoChannel getArrayFromDBWithWhere:nil];
    
    //从服务器读取数据
    if([arrChannel count] == 0 || arrChannel == nil)//没有数据 向网络进行请求
    {
        [Healthinfo QueryChannelsuccess:^(id obj){
                                if ([obj isKindOfClass:[NSArray class]]) {
                                    arrChannel = (NSArray*)obj;
                                    //保存数据到数据库
                                    [HealthinfoChannel saveObjToDBWithArray:arrChannel];
                                    [viewControllers removeAllObjects];
                                    [self setUpViewControllerWith:arrChannel];
                                }
                            }
                          failure:^(HttpException *e){
                              NSLog(@"获取channel失败");
                          }];
    }
    else
    {
        [viewControllers removeAllObjects];
        [self setUpViewControllerWith:arrChannel];
    }
}

@end
