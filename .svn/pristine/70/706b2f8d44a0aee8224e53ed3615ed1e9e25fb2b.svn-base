//
//  HealthySlideViewController.m
//  APP
//
//  Created by caojing on 15-3-10.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "HealthySlideViewController.h"
#import "ScenarioDrugViewController.h"
#import "ScenarioInfoViewController.h"
#import "MessageBoxListViewController.h"
#import "LoginViewController.h"

@interface HealthySlideViewController (){
   __weak QWBaseVC  *currentViewController;
}
@property (nonatomic, strong) UILabel *numLabel;   //数字角标
@property (nonatomic, strong) UILabel *redLabel;   //小红点
@property (assign, nonatomic) int passNumber;

@end

@implementation HealthySlideViewController


- (id)init{
    if (self = [super init]) {
        self.viewControllerArray = [NSMutableArray array];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewController];
    [self setupSliderView];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.passNumber = [QWGLOBALMANAGER updateRedPoint];
//    [self setUpRightItem];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViewController{
    
    ScenarioDrugViewController *firstDrugView = [[ScenarioDrugViewController alloc]init];
    firstDrugView.drugDict = self.infoDict;
    firstDrugView.navigationController = self.navigationController;
    
    ScenarioInfoViewController *knowledgeView = [[ScenarioInfoViewController alloc]init];
    knowledgeView.navigationController = self.navigationController;
    knowledgeView.knowledgeDict = self.infoDict;
    
    currentViewController = firstDrugView;
    [self.viewControllerArray addObject:firstDrugView];
    [self.viewControllerArray addObject:knowledgeView];
}

- (void)setupSliderView{
    
    self.slideSwitchView = [[QCSlideSwitchView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H-NAV_H)];
    self.slideSwitchView.tabItemNormalColor = RGBHex(qwColor7);//[QCSlideSwitchView colorFromHexRGB:kColor6];
    [self.slideSwitchView.topScrollView setBackgroundColor:RGBHex(qwColor4)];
    self.slideSwitchView.tabItemSelectedColor = RGBHex(qwColor1);
    [self.slideSwitchView.rigthSideButton.titleLabel setFont:fontSystem(kFontS4)];
    self.slideSwitchView.slideSwitchViewDelegate = self;
    self.slideSwitchView.rootScrollView.scrollEnabled = YES;
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"blue_line_and_shadow"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];

    [self.slideSwitchView buildUI];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 35, APP_W, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [self.slideSwitchView addSubview:line];
    [self.view addSubview:self.slideSwitchView];
}

- (NSUInteger)numberOfTab:(QCSlideSwitchView *)view{
    return self.viewControllerArray.count;
}

/*!
 * @method 每个tab所属的viewController
 * @abstract
 * @discussion
 * @param tab索引
 * @result viewController
 */
- (UIViewController *)slideSwitchView:(QCSlideSwitchView *)view viewOfTab:(NSUInteger)number{
    return self.viewControllerArray[number];
}

- (void)slideSwitchView:(QCSlideSwitchView *)view didselectTab:(NSUInteger)number{
    [self.viewControllerArray[number] viewDidCurrentView];
   
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
