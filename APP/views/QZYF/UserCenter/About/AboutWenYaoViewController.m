//
//  AboutWenYaoViewController.m
//  APP
//
//  Created by qwfy0006 on 15/3/16.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "AboutWenYaoViewController.h"
#import "FeedbackViewController.h"
//#import "MBProgressHUD+Add.h"
#import "SVProgressHUD.h"
#import "ServeInfoViewController.h"
#import "introductionViewController.h"
#import "AppDelegate.h"
#import "HelpInstructViewController.h"
#import "ReturnIndexView.h"
#import "LoginViewController.h"
#import "MessageBoxListViewController.h"
#import "Mbr.h"
#import "CommendPersonViewController.h"
#import "CommendSuccessViewController.h"
#import "WebDirectViewController.h"
#import "AddRecommenderViewController.h"
#import "MyRecommenderViewController.h"

@interface AboutWenYaoViewController ()<UIAlertViewDelegate,ReturnIndexViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) NSArray * titleArray;
@property (nonatomic ,strong) NSString *strDownload;
@property (nonatomic, strong) ReturnIndexView *indexView;
@property (nonatomic ,strong) UILabel *lblVersion;
@property (nonatomic ,strong) UIView *viewNewVersion;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UILabel *numLabel;   //数字角标
@property (nonatomic, strong) UILabel *redLabel;   //小红点
@property (assign, nonatomic) int passNumber;

@end

@implementation AboutWenYaoViewController

- (id)init{
    if (self = [super init]) {
        self.title = @"关于问药";
        if (iOSv7 && self.view.frame.origin.y==0) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
        }
       
        [self setUpTableView];
        UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 150)];
        topView.backgroundColor = RGBHex(qwColor11);
        
        UIImageView * topImageView = [[UIImageView alloc] initWithFrame:CGRectMake((APP_W-60)/2, 40, 60, 60)];
        topImageView.layer.masksToBounds = YES;
        topImageView.layer.cornerRadius = 10;
        topImageView.image = [UIImage imageNamed:@"2_2_0_icon"];
        [topView addSubview:topImageView];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, topImageView.frame.origin.y + topImageView.frame.size.height + 11, APP_W, 20)];
        titleLabel.text = [NSString stringWithFormat:@"问药 %@",APP_VERSION];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = font(kFont1, kFontS2);
        titleLabel.textColor = RGBHex(qwColor8);
        [topView addSubview:titleLabel];
        
//        UILabel * versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.frame.origin.y + titleLabel.frame.size.height + 5, APP_W, 16)];
//        versionLabel.text = [NSString stringWithFormat:@"%@",APP_VERSION];
//        versionLabel.textAlignment = NSTextAlignmentCenter;
//        versionLabel.font = fontSystem(kFontS4);
//        [topView addSubview:versionLabel];
        
//        UILabel * line = [[UILabel alloc] initWithFrame:CGRectMake(0, 189, APP_W, 0.5)];
//        line.backgroundColor = RGBHex(qwColor10);
//        [topView addSubview:line];
         self.tableView.tableHeaderView = topView;
//#ifdef DEBUG
//        self.titleArray = @[@"功能介绍",@"给好评",@"用户协议",@"帮助指导",@"我是商家",@"我的推荐人",@"上传错误日志"];
//#else
       self.titleArray = @[@"功能介绍",@"给好评",@"用户协议",@"帮助指导",@"我是商家"];
//#endif
        
    }
    return self;
}

- (void)setUpTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_W, APP_H - NAV_H) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 44;
    self.tableView.scrollEnabled = YES;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.titleArray.count;
}

- (NSInteger)getIntValueFromVersionStr:(NSString *)strVersion
{
    NSArray *arrVer = [strVersion componentsSeparatedByString:@"."];
    NSString *strVer = [arrVer componentsJoinedByString:@""];
    NSInteger intVer = [strVer integerValue];
    return intVer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.font = fontSystem(kFontS4);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 43.5, APP_W, 0.5)];
        line.backgroundColor = RGBHex(qwColor10);
        [cell addSubview:line];
        
        if (indexPath.row == 4) {
            UILabel *redTipImage = [[UILabel alloc]initWithFrame:CGRectMake(80, 15, 22, 15)];
            redTipImage.backgroundColor = [UIColor redColor];
            redTipImage.tag = 1009;
            redTipImage.hidden = YES;
            redTipImage.layer.cornerRadius = 5.0;
            redTipImage.layer.masksToBounds = YES;
            redTipImage.text = @"new";
            redTipImage.font = [UIFont systemFontOfSize:11];
            redTipImage.textColor = [UIColor whiteColor];
            [cell.contentView addSubview:redTipImage];
            
        }
        
    }
//    if (indexPath.row == 4){
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        UILabel *redTipImage = (UILabel *)[cell.contentView viewWithTag:1009];
//        
//        NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"BeRead"];
//        if ([str isEqualToString:@"1"]) {
//            redTipImage.hidden = YES;
//        }else
//        {
//            redTipImage.hidden = NO;
//        }
//    }
    
    UIImageView *im = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arr_right"]];
    cell.accessoryView = im;
    CGRect rect1 = cell.accessoryView.frame;
    rect1.origin.x = APP_W - rect1.size.width - 15;
    cell.accessoryView.frame = rect1;
    
    CGRect rect = cell.textLabel.frame;
    rect.origin.x = 15.0f;
    cell.textLabel.frame = rect;
    cell.textLabel.font = fontSystem(15.0f);
    cell.textLabel.textColor = RGBHex(qwColor6);
    cell.textLabel.text = self.titleArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0)//功能介绍
    {
        ServeInfoViewController * serverInfo = [[ServeInfoViewController alloc] init];
        serverInfo.webRequestType = WebRequestTypeFunctionIntroduce;
        [self.navigationController pushViewController:serverInfo animated:YES];
        
    }else if (indexPath.row == 1)//给好评
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/wen-yao-bi-yi-sheng-geng-dong/id901262090?mt=8"]];
    }else if (indexPath.row == 2)//用户协议
    {
        ServeInfoViewController * serverInfo = [[ServeInfoViewController alloc] init];
        serverInfo.webRequestType = WebRequestTypeUserProtocol;
        [self.navigationController pushViewController:serverInfo animated:YES];
        
    }else if (indexPath.row == 3)//帮助指导
    {
        HelpInstructViewController *helpVC = [[HelpInstructViewController alloc] init];
        [self.navigationController pushViewController:helpVC animated:YES];
                
    }
//    if (indexPath.row == 5)//邀请好友
//    {
//        
//        
//        
//        if (QWGLOBALMANAGER.loginStatus) {
//            
//            InviteFriendViewController *inviteVc = [[UIStoryboard storyboardWithName:@"InviteFriend" bundle:nil] instantiateViewControllerWithIdentifier:@"InviteFriendViewController"];
//            
//            inviteVc.hidesBottomBarWhenPushed = YES;
//            
//            [self.navigationController pushViewController:inviteVc animated:YES];
//            
//        }else{
//            
//            [self loginButtonClick];
//            
//        }
//    }
    if (indexPath.row == 4)//我是商家
    {
        WebDirectViewController *serverInfo = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
        WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
        modelLocal.typeLocalWeb = WebLocalTypeIMMerchant;
        modelLocal.title = @"商家端下载";
        [serverInfo setWVWithLocalModel:modelLocal];
        serverInfo.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:serverInfo animated:YES];
        
        
//        ServeInfoViewController * serverInfo = [[ServeInfoViewController alloc] init];
//        serverInfo.webRequestType = WebRequestTypeIamStore;
//        
//        [self.navigationController pushViewController:serverInfo animated:YES];
    }
    if (indexPath.row == 5)//我的推荐人
    {

        if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
            [SVProgressHUD showErrorWithStatus:@"网络异常，请重试" duration:0.8];
            return;
        }else
        {
            
        }
    }
    if(indexPath.row == 6) {
        //上传错误日志
        
    }
}


- (void)loginButtonClick
{
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    loginViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10000) {
        if (buttonIndex == 0) {
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.strDownload]];
        }
    }
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
