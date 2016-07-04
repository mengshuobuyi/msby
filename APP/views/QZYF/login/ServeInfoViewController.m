//
//  ServeInfoViewController.m
//  wenyao
//
//  Created by Meng on 14-9-30.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "ServeInfoViewController.h"
#import "Constant.h"
#import "ReturnIndexView.h"
#import "MessageBoxListViewController.h"
#import "LoginViewController.h"

@interface ServeInfoViewController ()<UIWebViewDelegate,ReturnIndexViewDelegate>

@property (nonatomic ,strong) UIWebView * webView;
@property (nonatomic ,strong) ReturnIndexView *indexView;
@property (nonatomic, strong) UILabel *numLabel;   //数字角标
@property (nonatomic, strong) UILabel *redLabel;   //小红点
@property (assign, nonatomic) int passNumber;


@end

@implementation ServeInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
        
    }
    return self;
}

- (id)init{
    if (self = [super init]) {
        
        if (iOSv7 && self.view.frame.origin.y==0) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
        }
        
       
        //self.webView.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.passNumber = [QWGLOBALMANAGER updateRedPoint];

    if (self.webRequestType == WebRequestTypeServeClauses) {
        
    }else
    {
        self.passNumber = [QWGLOBALMANAGER updateRedPoint];
//        [self setUpRightItem];
    }
    
    switch (self.webRequestType) {
        case WebRequestTypeServeClauses://服务条款
        {
            self.title = @"用户注册协议";
            
        }
            break;
        case WebRequestTypeFunctionIntroduce://功能介绍
        {
            self.title = @"功能介绍";
        }
            break;
        case WebRequestTypeUserProtocol://用户协议
        {
            self.title = @"用户协议";
        }
            break;
        case WebRequestTypeAboutWenyao://关于问药
        {
            self.title = @"关于问药";
        }
            break;
        case WebRequestTypeIamStore://我是商户
        {
            self.title = @"商家端下载";
            [QWCLICKEVENT qwTrackPageBegin:@"ServeInfoViewController_wssj"];
        }
            break;
            
        default:
            break;
    }

    
//    [[QWLoading instance] showLoading];
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [self showInfoView:kWarning12 image:@"网络信号icon"];
//        [[QWLoading instance] removeLoading];
        return;
    }
    
    
    [self loadWebView];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.webView stopLoading];
    
    switch (self.webRequestType) {
        case WebRequestTypeServeClauses://服务条款
        {
        }
            break;
        case WebRequestTypeFunctionIntroduce://功能介绍
        {
        }
            break;
        case WebRequestTypeUserProtocol://用户协议
        {
        }
            break;
        case WebRequestTypeAboutWenyao://关于问药
        {
        }
            break;
        case WebRequestTypeIamStore://我是商户
        {
            self.title = @"商家端下载";
           [QWCLICKEVENT qwTrackPageEnd:@"ServeInfoViewController_wssj"];
        }
            break;
            
        default:
            break;
    }
}

- (void)viewInfoClickAction:(id)sender
{
    if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        [self removeInfoView];
//        [[QWLoading instance] showLoading];
        [self loadWebView];
    }
}

- (void)loadWebView
{
    /*
     
     问药用户端--隐私保护	http://xxxxx/app/helpClass/yhysbh
     问药用户端--法律声明	http://xxxxx/app/helpClass/yhflsm
     
     问药用户端--功能介绍	http://xxxxx/app/helpClass/yhgnjs
     问药用户端--关于问药	http://xxxxx/app/helpClass/yhgywy
     问药用户端—-服务条款	http://xxxxx/app/helpClass/hyfwtk
     
     */
    
    NSString * str = nil;
    switch (self.webRequestType) {
        case WebRequestTypeServeClauses://服务条款
        {
            str = @"api/helpClass/yhfwtk";
            self.title = @"用户注册协议";
        }
            break;
        case WebRequestTypeFunctionIntroduce://功能介绍
        {
            str = @"app/html/v2.2.0/function.html";
            self.title = @"功能介绍";
        }
            break;
        case WebRequestTypeUserProtocol://用户协议
        {
            str = @"api/helpClass/yhyhxy";
            self.title = @"用户协议";
        }
            break;
        case WebRequestTypeAboutWenyao://关于问药
        {
            str = @"helpClass/yhgnjs";
            self.title = @"关于问药";
        }
            break;
        case WebRequestTypeIamStore://我是商户
        {
            str = @"html5/merchantLoad.html";
            self.title = @"商家端下载";
        }
            break;
            
        default:
            break;
    }
    NSString * url = myFormat(@"%@%@",BASE_URL_V2,str);
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, APP_W, APP_H - NAV_H)];
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.delegate = self;
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
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
    [QWGLOBALMANAGER.tabBar setSelectedIndex:0];
}
#pragma mark---------------------------------------------跳转到首页-----------------------------------------------

//- (void)setWebRequestType:(WebRequestType)webRequestType
//{
//    _webRequestType = webRequestType;
//    
//    /*
//     
//     问药用户端--隐私保护	http://xxxxx/app/helpClass/yhysbh
//     问药用户端--法律声明	http://xxxxx/app/helpClass/yhflsm
//     
//     问药用户端--功能介绍	http://xxxxx/app/helpClass/yhgnjs
//     问药用户端--关于问药	http://xxxxx/app/helpClass/yhgywy
//     问药用户端—-服务条款	http://xxxxx/app/helpClass/hyfwtk
//     
//     */
//    
//    NSString * str = nil;
//    switch (webRequestType) {
//        case WebRequestTypeServeClauses://服务条款
//        {
//            str = @"api/helpClass/yhfwtk";
//            self.title = @"用户注册协议";
//        }
//            break;
//        case WebRequestTypeFunctionIntroduce://功能介绍
//        {
//            str = @"html5/function.html";
//            self.title = @"功能介绍";
//        }
//            break;
//        case WebRequestTypeUserProtocol://用户协议
//        {
//            str = @"api/helpClass/yhyhxy";
//            self.title = @"用户协议";
//        }
//            break;
//        case WebRequestTypeAboutWenyao://关于问药
//        {
//            str = @"helpClass/yhgnjs";
//            self.title = @"关于问药";
//        }
//            break;
//        case WebRequestTypeIamStore://我是商户
//        {
//            str = @"html5/merchantLoad.html";
//            self.title = @"商户端下载";
//        }
//            break;
//            
//        default:
//            break;
//    }
//    NSString * url = myFormat(@"%@%@",BASE_URL_V2,str);
//    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, APP_W, APP_H - NAV_H)];
//    self.webView.backgroundColor = [UIColor whiteColor];
//    self.webView.delegate = self;
//    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    [self.webView loadRequest:request];
//    [self.view addSubview:self.webView];
//}

- (void)webViewDidStartLoad:(UIWebView *)webView
{

    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//    [[QWLoading instance] removeLoading];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (![error.userInfo[@"NSErrorFailingURLStringKey"] hasPrefix:@"emp://"]) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        [[QWLoading instance] removeLoading];
        [self showInfoView:@"服务器吃药去啦！请稍后重试" image:@"ic_img_fail"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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