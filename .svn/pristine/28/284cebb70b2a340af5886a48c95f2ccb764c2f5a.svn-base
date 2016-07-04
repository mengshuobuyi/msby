//
//  FamiliarQuestionViewController.m
//  APP
//
//  Created by qwfy0006 on 15/3/6.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "FamiliarQuestionViewController.h"
#import "QCSlideSwitchView.h"
#import "QuestionListViewController.h"
#import "SVProgressHUD.h"
#import "QWGlobalManager.h"
#import "Problem.h"
#import "ReturnIndexView.h"
#import "ProblemModel.h"
#import "ConsultForFreeRootViewController.h"
#import "MessageBoxListViewController.h"
#import "LoginViewController.h"

@interface FamiliarQuestionViewController ()<QCSlideSwitchViewDelegate,ReturnIndexViewDelegate>

@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic, assign) BOOL isLoadNativeCache;
@property (nonatomic, strong) QCSlideSwitchView *slideSwitchView;
@property (nonatomic, strong) UIView *noDataView;
@property (nonatomic, strong) NSArray *arrChannel;
@property (nonatomic, strong) ReturnIndexView *indexView;
@property (nonatomic, strong) UIButton *askButton;
@property (nonatomic, strong) UILabel *numLabel;   //数字角标
@property (nonatomic, strong) UILabel *redLabel;   //小红点
@property (assign, nonatomic) int passNumber;


@end

@implementation FamiliarQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (iOSv7 && self.view.frame.origin.y==0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGBHex(qwColor4),NSForegroundColorAttributeName,fontSystem(kFontS2),NSFontAttributeName, nil]];
    
    
    [self setUpBottomView];
    self.viewControllers = [NSMutableArray arrayWithCapacity:0];
    
    self.title = @"大家都在问";
    
    
}

#pragma mark---------------------------------------------跳转到首页-----------------------------------------------

- (void)setUpRightItem
{
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width = -15;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    
    //三个点button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(5, -2, 50, 40);
    [button setImage:[UIImage imageNamed:@"icon-unfold.PNG"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(returnIndex) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:button];
    
    //数字角标
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(38, 1, 18, 18)];
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
    self.redLabel = [[UILabel alloc] initWithFrame:CGRectMake(43, 10, 8, 8)];
    self.redLabel.backgroundColor = RGBHex(qwColor3);
    self.redLabel.layer.cornerRadius = 4.0;
    self.redLabel.layer.masksToBounds = YES;
    self.redLabel.hidden = YES;
    [rightView addSubview:self.redLabel];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItems = @[fixed,rightItem];
    
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
    [[QWGlobalManager sharedInstance].tabBar setSelectedIndex:0];
}
#pragma mark---------------------------------------------跳转到首页-----------------------------------------------

- (void)setUpBottomView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50-64, self.view.frame.size.width, 50)];
    bgView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [bgView addSubview:line];
    
    self.askButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.askButton.frame = CGRectMake((bgView.frame.size.width-275)/2, 5, 275, 40);
    [self.askButton setBackgroundColor:RGBHex(qwColor2)];
    [self.askButton setTitle:@"我也要问药" forState:UIControlStateNormal];
    self.askButton.titleLabel.font = fontSystem(kFontS2);
    [self.askButton setTitleColor:RGBHex(qwColor4) forState:UIControlStateNormal];
    self.askButton.layer.cornerRadius = 2.0;
    self.askButton.layer.masksToBounds = YES;
    [self.askButton addTarget:self action:@selector(askMedcineAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.askButton];
    [self.view addSubview:bgView];
}

//我也要问药
- (void)askMedcineAction
{
    self.askButton.enabled = NO;
    ConsultForFreeRootViewController *consultViewController = [[UIStoryboard storyboardWithName:@"ConsultForFree" bundle:nil] instantiateViewControllerWithIdentifier:@"ConsultForFreeRootViewController"];
    
    consultViewController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:consultViewController animated:YES];
}


#pragma mark 缓存数据

- (void)logoutAction
{
    if (self.viewControllers && self.viewControllers.count > 0) {
        [self.viewControllers removeAllObjects];
    }
}

- (void)loadCachedChannelList
{
    if (self.viewControllers.count > 0) {
        return;
    }
    
    NSString * where = [NSString stringWithFormat:@"moduleId = '%@'",self.strModuleId];
    NSArray *arrChannel = [ProblemModule getArrayFromDBWithWhere:where];
    
    [self setupViewControllerWith:arrChannel];
    if (arrChannel.count == 0) {
        self.slideSwitchView.hidden = YES;
        [self showInfoView:kWarning12 image:@"网络信号icon.png"];
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.passNumber = [QWGLOBALMANAGER updateRedPoint];
//    [self setUpRightItem];
    self.askButton.enabled = YES;
    if(self.currentViewController)
    {
        [self.currentViewController viewWillAppear:animated];
    }
    
    if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        [self queryChannelList];
    }
    else
    {
        [self loadCachedChannelList];
    }
}

- (void)setupViewControllerWith:(NSArray *)array{
    
    
    if (array == nil || [array count]==0) {
        return;
    }
    
    for (id obj in array) {
        ProblemModule *model = obj;
        QuestionListViewController *controller = [[QuestionListViewController alloc]init];
        self.currentViewController = controller;
        controller.title = model.name;
        controller.classId = model.classId;
        controller.moduleId = self.strModuleId;
        controller.currNavigationController = self.navigationController;
        [self.viewControllers addObject:controller];
    }
      [self setupSliderView];
  
    
}

- (void)setupSliderView{
    
    if (self.slideSwitchView) {
        [self.slideSwitchView removeFromSuperview];
        self.slideSwitchView = nil;
    }
    self.slideSwitchView = [[QCSlideSwitchView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H-NAV_H - 50)];
    self.slideSwitchView.tabItemNormalColor = [QCSlideSwitchView colorFromHexRGB:@"666666"];
    [self.slideSwitchView.topScrollView setBackgroundColor:RGBHex(qwColor4)];
    self.slideSwitchView.tabItemSelectedColor = RGBHex(qwColor1);
    [self.slideSwitchView.rigthSideButton.titleLabel setFont:fontSystem(kFontS4)];
    self.slideSwitchView.slideSwitchViewDelegate = self;
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"blue_line_and_shadow"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    [self.slideSwitchView buildUI];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 35, APP_W, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [self.slideSwitchView addSubview:line];
    
    self.slideSwitchView.rootScrollView.scrollEnabled = YES;
    [self.view addSubview:self.slideSwitchView];
    
}

- (NSUInteger)numberOfTab:(QCSlideSwitchView *)view{
    return self.viewControllers.count;
}

- (UIViewController *)slideSwitchView:(QCSlideSwitchView *)view viewOfTab:(NSUInteger)number{
    return self.viewControllers[number];
}

- (void)slideSwitchView:(QCSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    if(self.currentViewController == self.viewControllers[number])
        return;
    self.currentViewController = self.viewControllers[number];
    [(QuestionListViewController *)self.currentViewController refresh];
    //[self.viewControllers[number] viewDidCurrentView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark 处理本视图收到的通知
- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj{
    if (NotifQuitOut == type) {
        DebugLog(@"NotifMessageOfficial:%@",data);
        [self logoutAction];
    }else if (NotiWhetherHaveNewMessage == type) {
        
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

- (void)viewInfoClickAction:(id)sender
{
    if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        [self removeInfoView];
        [self queryChannelList];
    }
}

#pragma mark 数据请求

- (void)queryChannelList
{
    if(self.viewControllers.count > 0){
        return;
    }
    
        ProblemModuleR *model = [ProblemModuleR new];
        model.moduleId = self.strModuleId;
    
        [self removeInfoView];
        [Problem moduleClassWithParams:model success:^(id obj) {
            if ([obj isKindOfClass:[NSArray class]]) {
//                [self didLoad];
                self.arrChannel = (NSArray *)obj;
                [self.viewControllers removeAllObjects];
                [self setupViewControllerWith:self.arrChannel];
                
                NSMutableArray *arr = [NSMutableArray array];
                for (ProblemModule *model in self.arrChannel) {
                    model.moduleId = self.strModuleId;
                    [arr addObject:model];
                }
//                [(QuestionListViewController*)self.currentViewController refresh];
                [ProblemModule saveObjToDBWithArray:arr];
                
                if (self.arrChannel.count == 0) {
                    self.slideSwitchView.hidden = YES;
                    [self showInfoView:kWarning30 image:@"ic_img_fail"];
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
            
            
        }];
    
}

@end
