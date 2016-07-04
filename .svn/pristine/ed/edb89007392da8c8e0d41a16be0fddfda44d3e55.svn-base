//
//  MycollectViewController.m
//  wenyao
//
//  Created by Meng on 14-9-17.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "MycollectViewController.h"
#import "QCSlideSwitchView.h"
#import "MedicineCollectViewController.h"
#import "OtherCollectViewController.h"
#import "ReturnIndexView.h"
#import "MessageBoxListViewController.h"
#import "LoginViewController.h"
#import "WebDirectViewController.h"

@interface MycollectViewController ()<QCSlideSwitchViewDelegate,ReturnIndexViewDelegate>
{
    __weak OtherCollectViewController  *currentViewController;
    QWBaseVC * currentTab;
}
@property (nonatomic ,strong) NSMutableArray * viewControllerArray;
@property (nonatomic ,strong) QCSlideSwitchView * slideSwitchView;
@property (nonatomic ,strong) ReturnIndexView *indexView;
@property (nonatomic, strong) UILabel *numLabel;   //数字角标
@property (nonatomic, strong) UILabel *redLabel;   //小红点
@property (assign, nonatomic) int passNumber;

@end

@implementation MycollectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.viewControllerArray = [NSMutableArray array];
        if (iOSv7 && self.view.frame.origin.y==0) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
        }
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的收藏";
    
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.passNumber = [QWGLOBALMANAGER updateRedPoint];
//    [self setUpRightItem];
    
    [self setUpViewController];
    
    if (currentTab) {
        [currentTab viewDidCurrentView];
    }
    
    ((QWBaseNavigationController *)self.navigationController).canDragBack = NO;
}

- (void)setUpViewController{

    if(self.viewControllerArray.count > 0)
    return;
    
    //药品收藏
    OtherCollectViewController *medicineCollect = [[OtherCollectViewController alloc] init];
    medicineCollect.title = @"药品";
    medicineCollect.navigationController = self.navigationController;
    [self.viewControllerArray addObject:medicineCollect];
//    MedicineCollectViewController * medicineCollect = [[MedicineCollectViewController alloc]init];
//    medicineCollect.title = @"药品";
//    medicineCollect.navigationController = self.navigationController;
//    [self.viewControllerArray addObject:medicineCollect];
    
    //症状收藏
    OtherCollectViewController * symptomCollectViewController = [[OtherCollectViewController alloc]init];
    symptomCollectViewController.title = @"症状";
    symptomCollectViewController.navigationController = self.navigationController;
//    symptomCollectViewController.containerViewController=self;
    [self.viewControllerArray addObject:symptomCollectViewController];
    
    //疾病收藏
    OtherCollectViewController * diseaseCollectViewController = [[OtherCollectViewController alloc] init];
    diseaseCollectViewController.title = @"疾病";
    diseaseCollectViewController.navigationController = self.navigationController;
    [self.viewControllerArray addObject:diseaseCollectViewController];
    
    //资讯收藏
    OtherCollectViewController * infomationCollectViewController = [[OtherCollectViewController alloc] init];
    infomationCollectViewController.title = @"资讯";
    infomationCollectViewController.navigationController = self.navigationController;
    [self.viewControllerArray addObject:infomationCollectViewController];
    

//    OtherCollectViewController * coupnViewController = [[OtherCollectViewController alloc] init];
//    coupnViewController.title = @"优惠活动";
//    coupnViewController.navigationController = self.navigationController;
//    [self.viewControllerArray addObject:coupnViewController];
    
    
    WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    
    vcWebMedicine.title = @"专题";
//    vcWebMedicine.view.frame = CGRectMake(vcWebMedicine.view.bounds.origin.x, vcWebMedicine.view.bounds.origin.y, vcWebMedicine.view.bounds.size.width, vcWebMedicine.view.bounds.size.height - 50);
    
    vcWebMedicine.viewHeight = APP_H - 35.0;
    WebDirectLocalModel *modelLocal = [[WebDirectLocalModel alloc] init];
    modelLocal.typeLocalWeb = WebLocalTypeMyTopics;
    [vcWebMedicine setWVWithLocalModel:modelLocal];
    [self.viewControllerArray addObject:vcWebMedicine];
    
    
    
    WebDirectViewController *vcWeb = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    vcWeb.title = @"专刊";
//    vcWebMedicine.view.frame = CGRectMake(vcWebMedicine.view.bounds.origin.x, vcWebMedicine.view.bounds.origin.y, vcWebMedicine.view.bounds.size.width, vcWebMedicine.view.bounds.size.height - 50);
    vcWeb.viewHeight = APP_H - 35.0;
    WebDirectLocalModel *modelLocalTopics = [[WebDirectLocalModel alloc] init];
    modelLocalTopics.typeLocalWeb = WebLocalTypeMySpecialTopics;
    [vcWeb setWVWithLocalModel:modelLocalTopics];
    [self.viewControllerArray addObject:vcWeb];
    
//    [self.viewControllerArray addObject:vcWeb];
  
    
    [self setupSilderView];
}

- (void)setupSilderView{
    self.slideSwitchView = [[QCSlideSwitchView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H-NAV_H)];
    self.slideSwitchView.tabItemNormalColor = RGBHex(qwColor7); //[QCSlideSwitchView colorFromHexRGB:@"7c7c7c"];
    [self.slideSwitchView.topScrollView setBackgroundColor:RGBHex(qwColor11)];
    self.slideSwitchView.tabItemSelectedColor = RGBHex(qwColor1);
    self.slideSwitchView.slideSwitchViewDelegate = self;
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"blue_line_and_shadow"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    self.slideSwitchView.isCollectAdjust = YES;
    [self.slideSwitchView buildUI];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 35 - 0.5, APP_W, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [self.slideSwitchView addSubview:line];
    self.slideSwitchView.rootScrollView.scrollEnabled = YES;
    [self.view addSubview:self.slideSwitchView];
    
}

- (NSUInteger)numberOfTab:(QCSlideSwitchView *)view
{
    return self.viewControllerArray.count;
}

- (UIViewController *)slideSwitchView:(QCSlideSwitchView *)view viewOfTab:(NSUInteger)number{
    return self.viewControllerArray[number];
}

- (void)slideSwitchView:(QCSlideSwitchView *)view didselectTab:(NSUInteger)number{
    if(number == 4 || number == 5){
        return;
    }
    
//    if (number != 0) {
        currentViewController = self.viewControllerArray[number];
//    }
    currentTab = self.viewControllerArray[number];
    switch (number) {
        case 0:
        {
//            MedicineCollectViewController * medicine = (MedicineCollectViewController *)self.viewControllerArray[number];
//            [medicine viewDidCurrentView];
            currentViewController.collectType = medicineCollect;
            break;
        }
        case 1:
        {
            currentViewController.collectType = symptomCollect;
            break;
        }
        case 2:
        {
            currentViewController.collectType = diseaseCollect;
            break;
        }
        case 3:
        {
            currentViewController.collectType = messageCollect;
            break;
        }
        default:
            break;
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
