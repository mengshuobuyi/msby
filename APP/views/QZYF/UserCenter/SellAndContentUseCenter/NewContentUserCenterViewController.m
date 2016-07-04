//
//  NewContentUserCenterViewController.m
//  APP
//  个人中心
//  Created by qw_imac on 16/4/19.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "NewContentUserCenterViewController.h"
#import "LoginViewController.h"
#import "MessageBoxListViewController.h"
#import "NewPersonInformationViewController.h"
#import "DetialLevelViewController.h"
#import "MyCreditViewController.h"
#import "LevelUpAlertView.h"
#import "QWProgressHUD.h"
#import "NewMyCollectViewController.h"
#import "UserCenterViewCell.h"
#import "QZNewSettingViewController.h"
#import "Mbr.h"
#import "SVProgressHUD.h"
#import "MineCareCircleViewController.h"
#import "MineCareExpertViewController.h"
#import "CarePharmacistViewController.h"
#import "ReceiverAddressTableViewController.h"
#import "SendPostHistoryViewController.h"
#import "ReplyPostHistoryViewController.h"
#import "MyPostDraftViewController.h"
#import "ExpertInfoViewController.h"
#import "CircleMsgRootViewController.h"
#define CENTERHEADER @"img_my_pepole"
#import "WebDirectViewController.h"
#import "FeedbackViewController.h"
#import "MKNumberBadgeView.h"
#import "ExpertInfoViewController.h"
@interface NewContentUserCenterViewController ()<UITableViewDataSource,UITableViewDelegate,ExpertInfoHiddenRedPointDelegate>
{
    NSArray       *titleArr;           //tableview的列表项
    NSArray       *imageArr;           //tableview的列表项前置的小图片
    NSString      *score;              //积分
    NSString      *level;              //等级
}
@property (weak, nonatomic) IBOutlet UIView         *loginAfterView;
@property (weak, nonatomic) IBOutlet UIView         *loginBeforeView;
@property (strong, nonatomic) IBOutlet UIView       *topView;
@property (weak, nonatomic) IBOutlet UIImageView    *nickImg;
@property (weak, nonatomic) IBOutlet UILabel        *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel        *levelLabel;
@property (weak, nonatomic) IBOutlet UIButton       *signBtn;
@property (nonatomic, strong) InviterInfoModel      *modelInviterInfo;
@property (nonatomic,assign) BOOL                   isSign;
@property (nonatomic,strong) mbrMemberInfo          *info;
@property (nonatomic,strong) LevelUpAlertView       *alertView;
@property (strong, nonatomic) UIImageView           *redPoint;
@property (nonatomic, strong) MKNumberBadgeView     *badgeView;
@property (assign, nonatomic) BOOL                  tabBarItemSelected;
@end

@implementation NewContentUserCenterViewController
-(void)UIGlobal {
    [super UIGlobal];
    self.nickImg.layer.cornerRadius = 32.0;
    self.nickImg.clipsToBounds = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (iOSv7 && self.view.frame.origin.y==0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    [self setNaviItem];
    if (!QWGLOBALMANAGER.weChatBusiness) {
        titleArr = @[@[@"我的发帖",@"我的回帖",@"草稿箱"],@[@"我的积分",@"积分商城",@"收货地址"],@[@"意见反馈",@"邀请好友使用问药"]];
        imageArr = @[@[@"personal_ic_post",@"personal_ic_replies",@"personal_ic_drafts"],@[@"mydail_ic_mypoints",@"mydail_ic_pointshop",@"mydail_ic_adress"],@[@"mydail_ic_opinion",@"mydail_ic_invitation"]];
    }else {
        titleArr = @[@[@"我的发帖",@"我的回帖",@"草稿箱"],@[@"我的积分",@"积分商城"],@[@"意见反馈",@"邀请好友使用问药"]];
        imageArr = @[@[@"personal_ic_post",@"personal_ic_replies",@"personal_ic_drafts"],@[@"mydail_ic_mypoints",@"mydail_ic_pointshop"],@[@"mydail_ic_opinion",@"mydail_ic_invitation"]];
    }
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginClick)];
    [self.loginBeforeView addGestureRecognizer:tap1];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(personHeadImageClick)];
    [self.loginAfterView addGestureRecognizer:tap];
    [self setUpTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self requestPersonInfomation];
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"BeRead"];
    if ([str isEqualToString:@"1"]) {
        QWGLOBALMANAGER.myCenterBudge.hidden = YES;
    }else
    {
        QWGLOBALMANAGER.myCenterBudge.hidden = NO;
    }
    if(self.badgeView.value > 0) {
        self.badgeView.hidden = NO;
    }else{
        self.badgeView.hidden = YES;
    }
    [self.tableMain reloadData];
    if ([QWGLOBALMANAGER queryCircleMsgRedPoint]) {
        // 圈子或者私聊有新消息，显示小红点
        self.redPoint.hidden = NO;
        QWGLOBALMANAGER.expertMineRedPoint.hidden = NO;
    } else {
        self.redPoint.hidden = YES;
        QWGLOBALMANAGER.expertMineRedPoint.hidden = YES;
    }
}

-(void)setUpTableView {
    self.tableMain =[[UITableView alloc] initWithFrame:CGRectMake(0, 0 , APP_W, [[UIScreen mainScreen] bounds].size.height -44-64-6) style:UITableViewStylePlain];
    self.tableMain.delegate = self;
    self.tableMain.dataSource = self;
    self.tableMain.scrollEnabled = YES;
    self.tableMain.backgroundColor = RGBHex(qwColor11);
    self.tableMain.separatorInset = UIEdgeInsetsZero;
    self.tableMain.separatorColor = RGBHex(qwColor10);
    [self.view addSubview:self.tableMain];
    self.topView.frame = CGRectMake(0, 0, APP_W, 146);
    self.tableMain.tableHeaderView = self.topView;
}

- (void)setNaviItem
{
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width = -15;
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 44)];
    bg.backgroundColor = [UIColor clearColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(18, -1, 60, 44);
    [btn setImage:[UIImage imageNamed:@"icon_news"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"icon_news_click"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(pushIntoMessageBox:) forControlEvents:UIControlEventTouchUpInside];
    [bg addSubview:btn];
    
    self.redPoint = [[UIImageView alloc] initWithFrame:CGRectMake(56, 8, 10, 10)];
    self.redPoint.image = [UIImage imageNamed:@"icon_red"];
    self.redPoint.hidden = YES;
    [bg addSubview:self.redPoint];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:bg];
    self.navigationItem.rightBarButtonItems = @[fixed,item];
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [leftBtn setTitleColor:RGBHex(qwColor4) forState:UIControlStateNormal];
    [leftBtn setTitle:@"设置" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(newSetting) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *naviBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = naviBtn;
}

-(void)newSetting {
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"页面类型"]=@"个人中心";
    [QWGLOBALMANAGER statisticsEventId:@"x_wd_sz" withLable:@"我的" withParams:tdParams];
    QZNewSettingViewController* setting = [[UIStoryboard storyboardWithName:@"QZSetting" bundle:nil] instantiateViewControllerWithIdentifier:@"QZNewSettingViewController"];
    setting.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:setting animated:YES];
}
- (IBAction)enterMyLevel:(UIButton *)sender {
    if (!QWGLOBALMANAGER.loginStatus) {
        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
        loginViewController.isPresentType = YES;
        [self presentViewController:navgationController animated:YES completion:NULL];
        __weak typeof(self) weakSelf = self;
        loginViewController.loginSuccessBlock = ^(){
            [weakSelf enterMyLevel];
        };
    }else {
        [self enterMyLevel];
    }
}

-(void)enterMyLevel {
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"页面类型"]=@"内容";
    [QWGLOBALMANAGER statisticsEventId:@"x_wd_dj" withLable:@"我的" withParams:tdParams];
    //等级页面
    DetialLevelViewController *viewController = [DetialLevelViewController new];
    viewController.isComeFromIntegralVC = NO;
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)sign:(UIButton *)sender {
//    if (self.isSign) {
//        [QWProgressHUD showSuccessWithStatus:@"今日已签到!" hintString:nil duration:2.0];
//    }else {
        [self signIn];
//    }
}

-(void)signIn {
    SignR *modelR = [SignR new];
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [self showInfoInView:self.tableMain offsetSize:0 text:@"网络未连通，请重试" image:@"网络信号icon"];
    }else {
        if (QWGLOBALMANAGER.configure.userToken) {
            modelR.token = QWGLOBALMANAGER.configure.userToken;
        }
        [Credit sign:modelR success:^(SignModel *responModel) {
            if ([responModel.apiStatus integerValue] == 0) {
                [QWProgressHUD showSuccessWithStatus:@"签到成功!" hintString:[NSString stringWithFormat:@"+%@",responModel.rewardScore] duration:2.0];
                [self requestPersonInfomation];
                NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
                tdParams[@"页面类型"]=@"内容";
                tdParams[@"积分"] = [NSString stringWithFormat:@"%@",score];
                [QWGLOBALMANAGER statisticsEventId:@"x_wd_qd" withLable:@"我的" withParams:tdParams];
            }else {
                [QWProgressHUD showSuccessWithStatus:responModel.apiMessage hintString:nil duration:2.0];
            }
        } failure:^(HttpException *e) {
            [QWProgressHUD showSuccessWithStatus:@"签到失败!" hintString:nil duration:2.0];
        }];
    }
}

- (IBAction)btnsClick:(UIButton *)sender {
    switch (sender.tag) {
        case 1://关注的圈子
            if (!QWGLOBALMANAGER.loginStatus) {
                __weak typeof(self) weakSelf = self;
                LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
                loginViewController.isPresentType = YES;
                loginViewController.loginSuccessBlock = ^{
                    [QWGLOBALMANAGER statisticsEventId:@"x_wd_gzdqz" withLable:@"我的-关注的圈子" withParams:nil];
                    MineCareCircleViewController* careCircleVC = [[MineCareCircleViewController alloc] init];
                    careCircleVC.hidesBottomBarWhenPushed = YES;
                    [weakSelf.navigationController pushViewController:careCircleVC animated:YES];
                };
                [self presentViewController:navgationController animated:YES completion:NULL];
            }
            else if (QWGLOBALMANAGER.configure.flagSilenced) {
                [SVProgressHUD showErrorWithStatus:@"您已被禁言"];
                return;
            }
            else
            {
                [QWGLOBALMANAGER statisticsEventId:@"x_wd_gzdqz" withLable:@"我的-关注的圈子" withParams:nil];
                MineCareCircleViewController* careCircleVC = [[MineCareCircleViewController alloc] init];
                careCircleVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:careCircleVC animated:YES];
            }
            break;
        case 2://关注的专家
            if (!QWGLOBALMANAGER.loginStatus) {
                LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
                loginViewController.isPresentType = YES;
                [self presentViewController:navgationController animated:YES completion:NULL];
                __weak typeof(self) weakSelf = self;
                loginViewController.loginSuccessBlock = ^(){
                    if (QWGLOBALMANAGER.configure.flagSilenced) {
                        [SVProgressHUD showErrorWithStatus:@"您已被禁言"];
                        return;
                    }
                    else
                    {
                        [QWGLOBALMANAGER statisticsEventId:@"x_wd_gzdzj" withLable:@"我的-关注的专家" withParams:nil];
                        MineCareExpertViewController* careExpertVC = [[MineCareExpertViewController alloc] init];
                        careExpertVC.hidesBottomBarWhenPushed = YES;
                        [weakSelf.navigationController pushViewController:careExpertVC animated:YES];
                    }
                };
            }
            else
            {
                if (QWGLOBALMANAGER.configure.flagSilenced) {
                    [SVProgressHUD showErrorWithStatus:@"您已被禁言"];
                    return;
                }
                [QWGLOBALMANAGER statisticsEventId:@"x_wd_gzdzj" withLable:@"我的-关注的专家" withParams:nil];
                MineCareExpertViewController* careExpertVC = [[MineCareExpertViewController alloc] init];
                careExpertVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:careExpertVC animated:YES];
            }
            break;
        case 3://我的收藏
            if(QWGLOBALMANAGER.loginStatus){
                [self enterCollect];
            }else{
                LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
                loginViewController.isPresentType = YES;
                [self presentViewController:navgationController animated:YES completion:NULL];
                __weak typeof(self) weakSelf = self;
                loginViewController.loginSuccessBlock = ^(){
                    [weakSelf enterCollect];
                };
            }
            break;
    }
}
-(void)enterCollect {
    [QWGLOBALMANAGER statisticsEventId:@"x_wd_wdsc" withLable:@"我的-我的收藏" withParams:nil];
    NewMyCollectViewController *myCollectView = [[NewMyCollectViewController alloc]init];
    myCollectView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myCollectView animated:YES];
}

//用户体验--主动登录用navi push 被动登录用present
- (void)loginButtonClick {
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
    loginViewController.isPresentType = YES;
    [self presentViewController:navgationController animated:YES completion:NULL];
}

-(void)loginClick {
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    loginViewController.hidesBottomBarWhenPushed = YES;
    loginViewController.needVerifyFullInfo = YES;
    [self.navigationController pushViewController:loginViewController animated:YES];
}

- (void)personHeadImageClick {
    NewPersonInformationViewController *personInfoViewController = [[NewPersonInformationViewController alloc]  init];
    personInfoViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:personInfoViewController animated:YES];
}
//进入消息盒子
- (void)pushIntoMessageBox:(id)sender
{
    if(!QWGLOBALMANAGER.loginStatus) {
        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
        loginViewController.isPresentType = YES;
        [self presentViewController:navgationController animated:YES completion:NULL];
        __weak typeof(self) weakSelf = self;
        loginViewController.loginSuccessBlock = ^(){
            [weakSelf enterMessageBox];
        };
        return;
    }else {
        [self enterMessageBox];
    }
}

-(void)enterMessageBox {
    if (QWGLOBALMANAGER.loginStatus == NO) {
        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
        loginViewController.isPresentType = YES;
        [self presentViewController:navgationController animated:YES completion:NULL];
        __weak typeof(self) weakSelf = self;
        loginViewController.loginSuccessBlock = ^(){
            [weakSelf enterCircleMsg];
        };
    } else {
        [self enterCircleMsg];
    }
}

- (void) hiddenCircleMessageRedPoint
{
    self.redPoint.hidden = YES;
    QWGLOBALMANAGER.expertMineRedPoint.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //立刻刷新小红点
    [QWGLOBALMANAGER updateRedPoint];
}

- (void)enterCircleMsg
{
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"页面类型"]=@"内容";
    tdParams[@"事件"]=@"消息";
    [QWGLOBALMANAGER statisticsEventId:@"x_wd_xx" withLable:@"消息" withParams:tdParams];
    
    ExpertInfoViewController *vc = [[ExpertInfoViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -----
#pragma mark ----- 列表代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [(NSArray *)titleArr[section] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 7.0)];
    bgView.backgroundColor = [UIColor clearColor];
    return bgView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 0.1)];
    bgView.backgroundColor = [UIColor clearColor];
    return bgView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UserCenterViewCell getCellHeight:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 7.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UserCenterViewCell *cell = (UserCenterViewCell *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"UserCenterViewCell" owner:self options:nil][0];
    }
    cell.scoreLabel.hidden = YES;
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            if (QWGLOBALMANAGER.loginStatus) {
                cell.scoreLabel.hidden = NO;
                cell.scoreLabel.text = [NSString stringWithFormat:@"(%@)",score];
            }else {
                cell.scoreLabel.hidden = YES;
            }
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = titleArr[indexPath.section][indexPath.row];
    cell.titleImageView.image = [UIImage imageNamed:imageArr[indexPath.section][indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorHidden=YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {//我的发帖
                    if(QWGLOBALMANAGER.loginStatus){
                        [self enterMyFatie];
                    }else{
                        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                        UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
                        loginViewController.isPresentType = YES;
                        [self presentViewController:navgationController animated:YES completion:NULL];
                        __weak typeof(self) weakSelf = self;
                        loginViewController.loginSuccessBlock = ^(){
                            [weakSelf enterMyFatie];
                        };
                    }
                    break;
                }
                case 1://我的回帖
                {
                    if(QWGLOBALMANAGER.loginStatus){
                        [self enterMyHuitie];
                    }else{
                        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                        UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
                        loginViewController.isPresentType = YES;
                        [self presentViewController:navgationController animated:YES completion:NULL];
                        __weak typeof(self) weakSelf = self;
                        loginViewController.loginSuccessBlock = ^(){
                            [weakSelf enterMyHuitie];
                        };
                    }
                }
                    break;
                case 2://草稿箱
                {
                    if(QWGLOBALMANAGER.loginStatus){
                        [self enterDraftbox];
                    }else{
                        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                        UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
                        loginViewController.isPresentType = YES;
                        [self presentViewController:navgationController animated:YES completion:NULL];
                        __weak typeof(self) weakSelf = self;
                        loginViewController.loginSuccessBlock = ^(){
                            [weakSelf enterDraftbox];
                        };
                    }
                }
                    break;
            }
        }
            break;
        case 1:
            switch (indexPath.row) {
                case 0://我的积分
                {
                    if(QWGLOBALMANAGER.loginStatus){
                        [self enterMyCredit];
                    }else{
                        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                        UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
                        loginViewController.isPresentType = YES;
                        [self presentViewController:navgationController animated:YES completion:NULL];
                        __weak typeof(self) weakSelf = self;
                        loginViewController.loginSuccessBlock = ^(){
                            [weakSelf enterMyCredit];
                        };
                    }
                }
                    break;
                case 1:
                {//积分商城
                    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
                    tdParams[@"等级"]=level;
                    [QWGLOBALMANAGER statisticsEventId:@"x_sygrzx_jfsc" withLable:@"我的" withParams:tdParams];
                    WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
                    WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
                    modelLocal.typeLocalWeb = WebPageTypeIntegralIndex;
                    modelLocal.title = @"积分商城";
                    [vcWebMedicine setWVWithLocalModel:modelLocal];
                    [self.navigationController pushViewController:vcWebMedicine animated:YES];
                }
                    break;
                case 2:
                {
                    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
                    tdParams[@"页面类型"]=@"内容";
                    [QWGLOBALMANAGER statisticsEventId:@"x_wd_shdz" withLable:@"我的" withParams:tdParams];
                    if(QWGLOBALMANAGER.loginStatus){
                        [self enterAddressList];
                    }else{
                        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                        UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
                        loginViewController.isPresentType = YES;
                        [self presentViewController:navgationController animated:YES completion:NULL];
                        __weak typeof(self) weakSelf = self;
                        loginViewController.loginSuccessBlock = ^(){
                            [weakSelf enterAddressList];
                        };
                    }
                }
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0://意见反馈
                {
                    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
                    tdParams[@"等级"]=level;
                    [QWGLOBALMANAGER statisticsEventId:@"x_sygrzx_yjfk" withLable:@"我的" withParams:tdParams];
                    FeedbackViewController * feedback = [[FeedbackViewController alloc] initWithNibName:@"FeedbackViewController" bundle:nil];
                    feedback.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:feedback animated:YES];
                }
                    break;
                case 1://邀请好友
                {
                    if(QWGLOBALMANAGER.loginStatus){
                        [self getInviterInfo];
                    }else{
                        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                        UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
                        loginViewController.isPresentType = YES;
                        [self presentViewController:navgationController animated:YES completion:NULL];
                        __weak typeof(self) weakSelf = self;
                        loginViewController.loginSuccessBlock = ^(){
                            [weakSelf getInviterInfo];
                        };
                    }
                }
                    break;
            }
            break;
    }
}

// 获取邀请好友的信息
- (void)getInviterInfo {
    [Mbr getInviteInfo:[MbrInviterInfoModelR new] success:^(id obj) {
        if (obj != nil) {
            self.modelInviterInfo = (InviterInfoModel *) obj;
            [self inviteFriend];
        }
    } failure:^(HttpException *e) {
        
    }];
}

-(void)inviteFriend {
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"页面类型"]=@"内容";
    [QWGLOBALMANAGER statisticsEventId:@"x_wd_yqhy" withLable:@"我的" withParams:tdParams];
    
    ShareContentModel *modelShare = [[ShareContentModel alloc] init];
    modelShare.typeShare = ShareTypeRecommendFriends;
    modelShare.typeCome=@"1";//从我的个人中心进来
    if (self.modelInviterInfo != nil) {
        modelShare.title = self.modelInviterInfo.title;
        modelShare.content = self.modelInviterInfo.desc;
        modelShare.imgURL = self.modelInviterInfo.imgUrl;
    }
    if (!QWGLOBALMANAGER.loginStatus) {
        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
        loginViewController.isPresentType = YES;
        [self presentViewController:navgationController animated:YES completion:NULL];
        __weak typeof(self) weakSelf = self;
        loginViewController.loginSuccessBlock = ^(){
            [weakSelf popUpShareView:modelShare];
        };
    }else {
        if (QWGLOBALMANAGER.configure.inviteCode == nil) {
            QWGLOBALMANAGER.configure.inviteCode = @"";
        }
        modelShare.shareLink = [NSString stringWithFormat:@"%@html5/v224/downLoad.html?inviteCode=%@",BASE_URL_V2,QWGLOBALMANAGER.configure.inviteCode];
        [self popUpShareView:modelShare];
    }
}

-(void)enterMyCredit {
    //积分页面
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"页面类型"]=@"营销";
    [QWGLOBALMANAGER statisticsEventId:@"x_wd_jf" withLable:@"我的" withParams:tdParams];
    MyCreditViewController* creditVC = [[UIStoryboard storyboardWithName:@"Credit" bundle:nil] instantiateViewControllerWithIdentifier:@"MyCreditViewController"];
    creditVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:creditVC animated:YES];
}

-(void)enterAddressList {
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"等级"]=level;
    [QWGLOBALMANAGER statisticsEventId:@"x_sygrzx_shdz" withLable:@"我的" withParams:tdParams];
    ReceiverAddressTableViewController *vc = [ReceiverAddressTableViewController new];
    vc.pageType = PageComeFromReceiveAddress;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//我的发帖
-(void)enterMyFatie {
    if (!QWGLOBALMANAGER.loginStatus) {
        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
        loginViewController.isPresentType = YES;
        [self presentViewController:navgationController animated:YES completion:NULL];
        __weak typeof(self) weakSelf = self;
        loginViewController.loginSuccessBlock = ^(){
            if (QWGLOBALMANAGER.configure.flagSilenced) {
                [SVProgressHUD showErrorWithStatus:@"您已被禁言"];
                return;
            }
            else
            {
                [QWGLOBALMANAGER statisticsEventId:@"x_wd_wdft" withLable:@"我的-我的发帖" withParams:nil];
                SendPostHistoryViewController* sendPostHistory = [[SendPostHistoryViewController alloc] init];
                sendPostHistory.hidesBottomBarWhenPushed = YES;
                sendPostHistory.token = QWGLOBALMANAGER.configure.userToken;
                [weakSelf.navigationController pushViewController:sendPostHistory animated:YES];
            }
        };
    }
    else
    {
        if (QWGLOBALMANAGER.configure.flagSilenced) {
            [SVProgressHUD showErrorWithStatus:@"您已被禁言"];
            return;
        }
        [QWGLOBALMANAGER statisticsEventId:@"x_wd_wdft" withLable:@"我的-我的发帖" withParams:nil];
        SendPostHistoryViewController* sendPostHistory = [[SendPostHistoryViewController alloc] init];
        sendPostHistory.hidesBottomBarWhenPushed = YES;
        sendPostHistory.token = QWGLOBALMANAGER.configure.userToken;
        [self.navigationController pushViewController:sendPostHistory animated:YES];
    }
}
//我的回帖
-(void)enterMyHuitie {
    if (!QWGLOBALMANAGER.loginStatus) {
        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
        loginViewController.isPresentType = YES;
        [self presentViewController:navgationController animated:YES completion:NULL];
        __weak typeof(self) weakSelf = self;
        loginViewController.loginSuccessBlock = ^(){
            [QWGLOBALMANAGER statisticsEventId:@"x_wd_wdht" withLable:@"我的-我的回帖" withParams:nil];
            SendPostHistoryViewController* sendPostHistory = [[SendPostHistoryViewController alloc] init];
            sendPostHistory.hidesBottomBarWhenPushed = YES;
            sendPostHistory.token = QWGLOBALMANAGER.configure.userToken;
            [weakSelf.navigationController pushViewController:sendPostHistory animated:YES];
        };
    }
    else
    {
        if (QWGLOBALMANAGER.configure.flagSilenced) {
            [SVProgressHUD showErrorWithStatus:@"您已被禁言"];
            return;
        }
        [QWGLOBALMANAGER statisticsEventId:@"x_wd_wdht" withLable:@"我的-我的回帖" withParams:nil];
        ReplyPostHistoryViewController* replyPostHistoryVC = [[ReplyPostHistoryViewController alloc] init];
        replyPostHistoryVC.token = QWGLOBALMANAGER.configure.userToken;
        replyPostHistoryVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:replyPostHistoryVC animated:YES];
    }
}
//草稿箱
-(void)enterDraftbox {
    if (QWGLOBALMANAGER.configure.flagSilenced) {
        [SVProgressHUD showErrorWithStatus:@"您已被禁言"];
        return;
    }
    [QWGLOBALMANAGER statisticsEventId:@"x_wd_cgx" withLable:@"我的-草稿箱" withParams:nil];
    MyPostDraftViewController* myPostDraft = [[MyPostDraftViewController alloc] init];
    myPostDraft.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myPostDraft animated:YES];
}


#pragma mark -----
#pragma mark ----- 设置Action
- (void)leftBarButtonClick{
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"页面类型"]=@"内容";
    [QWGLOBALMANAGER statisticsEventId:@"x_wd_sz" withLable:@"我的" withParams:tdParams];
    QZNewSettingViewController* setting = [[UIStoryboard storyboardWithName:@"QZSetting" bundle:nil] instantiateViewControllerWithIdentifier:@"QZNewSettingViewController"];
    setting.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:setting animated:YES];
}

#pragma mark -----
#pragma mark ----- 数据请求
//用于进入app之后接收到NotifLoginSuccess 和 NotifQuitOut 通知时请求的数据
- (void)requestPersonInfo {
    if (QWGLOBALMANAGER.loginStatus) {
        if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
            if(QWGLOBALMANAGER.configure){
                [self.nickImg setImageWithURL:[NSURL URLWithString:QWGLOBALMANAGER.configure.avatarUrl] placeholderImage:[UIImage imageNamed:CENTERHEADER] options:SDWebImageRetryFailed];
                if (QWGLOBALMANAGER.configure.nickName.length != 0) {
                    self.nameLabel.text = QWGLOBALMANAGER.configure.nickName;
                }else if(QWGLOBALMANAGER.configure.mobile.length != 0) {
                    self.nameLabel.text = QWGLOBALMANAGER.configure.mobile;
                }else {
                    if (QWGLOBALMANAGER.configure.userName.length != 0) {
                        self.nameLabel.text = QWGLOBALMANAGER.configure.userName;
                    }
                }
            }
        }else {
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            param[@"token"] = QWGLOBALMANAGER.configure.userToken;
            HttpClientMgr.progressEnabled = NO;
            [Mbr queryMemberDetailWithParams:param success:^(id obj){
                mbrMemberInfo *info = obj;
                self.info = info;
                if (info) {
                    if (!StrIsEmpty(info.headImageUrl)) {
                        QWGLOBALMANAGER.configure.avatarUrl = info.headImageUrl;
                    }
                    self.loginBeforeView.hidden = YES;
                    //显示头像
                    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
                        [self performSelector:@selector(showHeaderImage:) withObject:info afterDelay:1];
                    }else{
                        [self.nickImg setImageWithURL:[NSURL URLWithString:info.headImageUrl] placeholderImage:[UIImage imageNamed:CENTERHEADER]];
                    }
                    level = info.level;
                    score = info.score;
                    self.levelLabel.text = [NSString stringWithFormat:@"V%d会员",[level integerValue]];
                    //是否签到
                    self.isSign = info.sign;
                    
                    //判断签到btn背景图片
                    if (info.sign) {
                        UIImage *image = [UIImage imageNamed:@"home_icon_pressde"];
                        [self.signBtn setBackgroundImage:image forState:UIControlStateNormal];
                    }else {
                        [self.signBtn setBackgroundImage:[UIImage imageNamed:@"home_icon"] forState:UIControlStateNormal];
                    }
                    //存储数据
                    [mbrMemberInfo saveObjToDB:info];
                    
                    //显示用户名
                    if (info.nickName.length != 0) {
                        self.nameLabel.text = info.nickName;
                    }else if (info.mobile.length != 0) {
                        self.nameLabel.text = info.mobile;
                    }else if(QWGLOBALMANAGER.configure.userName.length != 0){
                        self.nameLabel.text = QWGLOBALMANAGER.configure.userName;
                    }
                    
                    [self.tableMain reloadData];
                }else {
                    if ([(NSString *)info.apiStatus isEqualToString:@"1"]) {
                        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:ALERT_MESSAGE delegate:  self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        alertView.tag = 999;
                        alertView.delegate = self;
                        [alertView show];
                        return;
                    }else{
                        [SVProgressHUD showErrorWithStatus:info.apiMessage duration:DURATION_SHORT];
                    }
                }
            }
                                     failure:^(HttpException *e){
                                         
                                     }];
        }
    }else {
        self.loginBeforeView.hidden = NO;
        [self.tableMain reloadData];
    }
}

//升级
-(void)levelUpWith:(NSString *)currentLevel {
    LevelUpModel *model = [[LevelUpModel alloc]init];
    model.level = [currentLevel integerValue];
    model.integral = [QWGLOBALMANAGER rewardScoreWithTaskKey:[NSString stringWithFormat:@"VIP%d",model.level]];
    self.alertView = [LevelUpAlertView levelUpAlertViewWith:model];
    self.alertView.frame =  CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    self.alertView.bkView.alpha = 0.0;
    
    UIWindow *win = [[UIApplication sharedApplication] keyWindow];
    [win addSubview:self.alertView];
    [UIView animateWithDuration:0.25 animations:^{
        self.alertView.bkView.alpha =0.4;
        self.alertView.alertView.hidden = NO;
    }];
}

//用于viewwillappear的时候请求数据  两个数据请求分开是为了在进入app的时候不会弹升级提示框
- (void)requestPersonInfomation {
    if (QWGLOBALMANAGER.loginStatus) {
        if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
            if(QWGLOBALMANAGER.configure){
                [self.nickImg setImageWithURL:[NSURL URLWithString:QWGLOBALMANAGER.configure.avatarUrl] placeholderImage:[UIImage imageNamed:CENTERHEADER] options:SDWebImageRetryFailed];
                if (QWGLOBALMANAGER.configure.nickName.length != 0) {
                    self.nameLabel.text = QWGLOBALMANAGER.configure.nickName;
                }else if(QWGLOBALMANAGER.configure.mobile.length != 0) {
                    self.nameLabel.text = QWGLOBALMANAGER.configure.mobile;
                }else {
                    if (QWGLOBALMANAGER.configure.userName.length != 0) {
                        self.nameLabel.text = QWGLOBALMANAGER.configure.userName;
                    }
                }
            }
        }else {
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            param[@"token"] = QWGLOBALMANAGER.configure.userToken;
            HttpClientMgr.progressEnabled = NO;
            [Mbr queryMemberDetailWithParams:param success:^(id obj){
                mbrMemberInfo *info = obj;
                if (info.upgrade) {
                    [self levelUpWith:info.level];
                }
                self.info = info;
                if (info) {
                    if (!StrIsEmpty(info.headImageUrl)) {
                        QWGLOBALMANAGER.configure.avatarUrl = info.headImageUrl;
                    }
                    self.loginBeforeView.hidden = YES;
                    //显示头像
                    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
                        [self performSelector:@selector(showHeaderImage:) withObject:info afterDelay:1];
                    }else{
                        [self.nickImg setImageWithURL:[NSURL URLWithString:info.headImageUrl] placeholderImage:[UIImage imageNamed:CENTERHEADER]];
                    }
                    level = info.level;
                    score = info.score;
                    self.levelLabel.text = [NSString stringWithFormat:@"V%d会员",[level integerValue]];
                    //是否签到
                    self.isSign = info.sign;
                    
                    //判断签到btn背景图片
                    if (info.sign) {
                        UIImage *image = [UIImage imageNamed:@"home_icon_pressde"];
                        [self.signBtn setBackgroundImage:image forState:UIControlStateNormal];
                    }else {
                        [self.signBtn setBackgroundImage:[UIImage imageNamed:@"home_icon"] forState:UIControlStateNormal];
                    }
                    //存储数据
                    [mbrMemberInfo saveObjToDB:info];
                    
                    //显示用户名
                    if (info.nickName.length != 0) {
                        self.nameLabel.text = info.nickName;
                    }else if (info.mobile.length != 0) {
                        self.nameLabel.text = info.mobile;
                    }else if(QWGLOBALMANAGER.configure.userName.length != 0){
                        self.nameLabel.text = QWGLOBALMANAGER.configure.userName;
                    }
                    [self.tableMain reloadData];
                }else {
                    if ([(NSString *)info.apiStatus isEqualToString:@"1"]) {
                        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:ALERT_MESSAGE delegate:  self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        alertView.tag = 999;
                        alertView.delegate = self;
                        [alertView show];
                        return;
                    }else{
                        [SVProgressHUD showErrorWithStatus:info.apiMessage duration:DURATION_SHORT];
                    }
                }
            }
                                     failure:^(HttpException *e){
                                         
                                     }];
        }
    }else {
        self.loginBeforeView.hidden = NO;
        [self.tableMain reloadData];
    }
}

- (void)showHeaderImage:(mbrMemberInfo *)info {
    [self.nickImg setImageWithURL:[NSURL URLWithString:info.headImageUrl] placeholderImage:[UIImage imageNamed:CENTERHEADER]];
    [self.tableMain reloadData];
}

#pragma mark -----
#pragma mark ----- 处理通知
- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj
{
    if (NotifLoginSuccess == type || NotifQuitOut == type) {
        [self requestPersonInfo];
        QWGLOBALMANAGER.needShowBadge = NO;
        [QWGLOBALMANAGER setBadgeNumStatus:NO];
        [self.tableMain reloadData];
        if (NotifQuitOut == type) {
            self.redPoint.hidden = YES;
            QWGLOBALMANAGER.expertMineRedPoint.hidden = YES;
        }
    } else if(NotiMessageBadgeNum == type) {
        [self.badgeView setValueOnly:[data integerValue]];
    }else if(NotifRefreshCurAppPageOne==type){
        
    }else if (NotifCircleMsgRedPoint == type)
    {
        if ([QWGLOBALMANAGER queryCircleMsgRedPoint]) {
            // 圈子或者私聊有新消息，显示小红点
            self.redPoint.hidden = NO;
            QWGLOBALMANAGER.expertMineRedPoint.hidden = NO;
        } else {
            self.redPoint.hidden = YES;
            QWGLOBALMANAGER.expertMineRedPoint.hidden = YES;
        }
    }else if(NotifTabsWillTransition == type) {
        [self requestPersonInfomation];
    }
}

@end