//
//  MyCreditViewController.m
//  APP
//  “我的积分”页面
//  包括 日常任务、圈子任务、一次性任务、每月等级奖励任务
//  3.1.0在一次性任务中新增首次关注圈子和首次关注专家任务
//  接口：
//  获取会员积分 api/mbr/score/queryMyScoreDetail
//  Created by Martin.Liu on 15/11/30.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "MyCreditViewController.h"
#import "DailyTaskTableCell.h"
#import "SingleTaskTableCell.h"
#import "PerfectInformationViewController.h"    // 完善资料
#import "CreditRuleDetailViewController.h"      // 规则说明
#import "ChangePhoneNumberViewController.h"     // 绑定手机号
#import "CreditRecordViewController.h"          // 积分明细
#import "AllCircleViewController.h"             // 全部圈子
#import "CarePharmacistViewController.h"        // 专家页面
#import "Credit.h"
#import "ConstraintsUtility.h"
#import "WebDirectViewController.h"
#import "QWProgressHUD.h"
#import "SVProgressHUD.h"
#import "DetialLevelViewController.h"
#import "LoginViewController.h"
#import "Mbr.h"
#import "MAVrLineWithOnePix.h"
#import "AppDelegate.h"
#import "UIImage+Tint.h"

@interface MyCreditViewController ()<UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate>
{
    CreditModel         *model;
    NSMutableDictionary *dataDic;
}
@property (strong, nonatomic) IBOutlet UITableView          *tableView;
@property (strong, nonatomic) IBOutlet UIView               *tableHearderView;
@property (strong, nonatomic) IBOutlet UIView               *tableHeaderBackView;
@property (strong, nonatomic) IBOutlet UIImageView *tableHeaderBackImageView;
@property (strong, nonatomic) IBOutlet UIView               *creditTextContainerView;
@property (strong, nonatomic) IBOutlet UILabel              *creditCountLabel;
@property (strong, nonatomic) IBOutlet UIView *creditStoreContainerView;
@property (strong, nonatomic) IBOutlet UIButton             *creditStoreBtn;
@property (strong, nonatomic) IBOutlet UIButton             *creditDetailBtn;
@property (strong, nonatomic) IBOutlet MAVrLineWithOnePix   *vrLineBetweenBtns;
@property (strong, nonatomic) NSMutableArray                *dailyTaskArray;
@property (strong, nonatomic) NSMutableArray                *singleTaskArray;
@property (strong, nonatomic) NSMutableArray                *monthlyTaskArray;
@property (strong, nonatomic) NSMutableArray                *circleTaskArray;
// 邀请好友的信息model
@property (nonatomic, strong) InviterInfoModel              *modelInviterInfo;

- (IBAction)creditStoreBtnAction:(id)sender;
- (IBAction)creditRuleDetailBtnAction:(id)sender;

@end

@implementation MyCreditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的积分";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"积分明细" style:UIBarButtonItemStyleDone target:self action:@selector(creditRuleDetailBtnAction:)];
    
    dataDic = [NSMutableDictionary dictionary];
    [self getInviterInfo];
}

- (NSMutableArray *)dailyTaskArray
{
    if (!_dailyTaskArray) {
        _dailyTaskArray = [NSMutableArray array];
    }
    return _dailyTaskArray;
}

- (NSMutableArray *)singleTaskArray
{
    if (!_singleTaskArray) {
        _singleTaskArray = [NSMutableArray array];
    }
    return _singleTaskArray;
}

- (NSMutableArray *)circleTaskArray
{
    if (!_circleTaskArray) {
        _circleTaskArray = [NSMutableArray array];
    }
    return _circleTaskArray;
}

- (NSMutableArray *)monthlyTaskArray
{
    if (!_monthlyTaskArray) {
        _monthlyTaskArray = [NSMutableArray array];
    }
    return _monthlyTaskArray;
}

#pragma mark - 按顺序获取认识的任务，分门别类
- (void)sortTask:(CreditModel*)creditModel
{
    // 日常任务
    [self.dailyTaskArray removeAllObjects];
//    for (NSString* taskKey in @[CreditTaskKey_Sign, CreditTaskKey_Share, CreditTaskKey_Trade, CreditTaskKey_Appraise]) {
//        for (CreditTaskModel* taskModel in creditModel.dailyTasks) {
//            if ([taskKey isEqualToString:taskModel.taskKey]) {
//                [self.dailyTaskArray addObject:taskModel];
//                break;
//            }
//        }
//    }
    // 圈子任务
    [self.circleTaskArray removeAllObjects];
    NSArray* array = [creditModel.dailyTasks arrayByAddingObjectsFromArray:creditModel.teamTasks];
    for (NSString* taskKey in @[CreditTaskKey_Sign, CreditTaskKey_Share, CreditTaskKey_Trade, CreditTaskKey_Appraise,CreditTaskKey_SNS_Post, CreditTaskKey_SNS_Reply, CreditTaskKey_SNS_Zan]) {
//        for (CreditTaskModel* taskModel in creditModel.teamTasks) {
        for (CreditTaskModel* taskModel in array) {
            if ([taskKey isEqualToString:taskModel.taskKey]) {
                [self.circleTaskArray addObject:taskModel];
                break;
            }
        }
    }
    // 一次性任务
    [self.singleTaskArray removeAllObjects];
    for (NSString* taskKey in @[CreditTaskKey_Bind, CreditTaskKey_Full, CreditTaskKey_Invite, CreditTaskKey_CareCirlce, CreditTaskKey_CareExpert]) {
        for (CreditTaskModel* taskModel in creditModel.onceTasks) {
            if ([taskKey isEqualToString:taskModel.taskKey]) {
                [self.singleTaskArray addObject:taskModel];
                break;
            }
        }
    }
    // 每月等级奖励
    [self.monthlyTaskArray removeAllObjects];
    
    for (CreditTaskModel* taskModel in creditModel.monthlyTasks) {
        if ([taskModel.taskKey hasPrefix:@"VIP"]) {
            [self.monthlyTaskArray addObject:taskModel];
            break;
        }
    }
    // 等级为0时候，接口没有返回每月提示的任务，所以需要弹出每月奖励提示（客户端写的）
    // 如果没有返回每月等级奖励，则显示该等级暂无奖励，升至V1，每月可获xx积分。
    if (self.monthlyTaskArray.count == 0) {
        CreditTaskModel* tipMontylyTaskmodel = [[CreditTaskModel alloc] init];
        tipMontylyTaskmodel.taskName = [NSString stringWithFormat:@"该等级暂无奖励，升至V1，每月可获%ld积分", (long)[QWGLOBALMANAGER rewardScoreWithTaskKey:CreditTaskKey_VIP1]];
        tipMontylyTaskmodel.taskKey = CreditTaskKey_MonthlyTip;
        [self.monthlyTaskArray addObject:tipMontylyTaskmodel];
    }
    
    [dataDic removeAllObjects];
    int index = 0;
    if (self.dailyTaskArray.count > 0) {
        [dataDic setObject:self.dailyTaskArray forKey:@(index)];
        index ++;
    }
    if (self.circleTaskArray.count > 0) {
        [dataDic setObject:self.circleTaskArray forKey:@(index)];
        index ++;
    }
    if (self.singleTaskArray.count > 0) {
        [dataDic setObject:self.singleTaskArray forKey:@(index)];
        index ++;
    }
    if (self.monthlyTaskArray.count > 0) {
        [dataDic setObject:self.monthlyTaskArray forKey:@(index)];
        index ++;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)popVCAction:(id)sender
{
    [QWGLOBALMANAGER statisticsEventId:@"x_wd_jf_fh" withLable:@"我的-积分-返回" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl)}]];
    [super popVCAction:sender];
}

- (void)UIGlobal
{
    self.view.backgroundColor = RGBHex(qwColor11);
    if ([APPDelegate isMainTab]) {
        self.tableHeaderBackImageView.image = [[UIImage imageNamed:@"mypoints_bg_point"] imageWithTintColor:RGBHex(qwColor1)];
//        self.tableHeaderBackView.backgroundColor = RGBHex(qwColor3);
    }
    else
    {
        self.tableHeaderBackImageView.image = [[UIImage imageNamed:@"mypoints_bg_point"] imageWithTintColor:RGBHex(qwColor1)];
//        self.tableHeaderBackView.backgroundColor = RGBHex(qwColor1);
    }
//    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.creditStoreContainerView.backgroundColor = RGBHex(qwColor2);
    self.creditStoreContainerView.layer.masksToBounds = YES;
    self.creditStoreContainerView.layer.cornerRadius = 4;
//    self.creditCountLabel.font = [UIFont boldSystemFontOfSize:kFontS8];
//    self.creditCountLabel.textColor = RGBHex(qwColor4);
//    
//    self.creditStoreBtn.titleLabel.font = [UIFont systemFontOfSize:kFontS4];
//    [self.creditStoreBtn setTitleColor:RGBHex(qwColor7) forState:UIControlStateNormal];
//    
//    self.creditDetailBtn.titleLabel.font = [UIFont systemFontOfSize:kFontS4];
//    [self.creditDetailBtn setTitleColor:RGBHex(qwColor7) forState:UIControlStateNormal];
//    self.vrLineBetweenBtns.backgroundColor = RGBHex(qwColor10);
}

#pragma mark - 从接口中获取积分数据，并刷新页面
- (void) loadData
{
    CreditModelR* creditModelR = [[CreditModelR alloc] init];
    creditModelR.token = QWGLOBALMANAGER.configure.userToken;
    __weak __typeof(self)weakSelf = self;
    [Credit getCreditDetail:creditModelR success:^(CreditModel *creditModel) {
        weakSelf.creditCountLabel.text = [NSString stringWithFormat:@"%ld", (long)creditModel.mbrScore];
        [weakSelf sortTask:creditModel];
        [weakSelf.tableView reloadData];
        DebugLog(@"credit response : %@", creditModel);
    } failure:^(HttpException *e) {
        DebugLog(@"credit response error : %@", e);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataDic.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* array = [dataDic objectForKey:@(section)];
    if (array == self.dailyTaskArray) {
        return 1;
    }
    if ([array isKindOfClass:[NSArray class]]) {
        return array.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dailyTaskArray.count > 0 && indexPath.section == 0) {
        return 120;
    }
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 45)];
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    view.backgroundColor = RGBHex(qwColor11);
    UILabel* titleLabelInSection = [[UILabel alloc] init];
    titleLabelInSection.font = [UIFont systemFontOfSize:14.f];
    titleLabelInSection.textColor = RGBHex(qwColor7);
    [view addSubview:titleLabelInSection];
    
    PREPCONSTRAINTS(titleLabelInSection);
    ALIGN_LEADING(titleLabelInSection, 15);
    ALIGN_CENTER_V(titleLabelInSection);
    
    BOOL hasDialyTaskIntro = NO;
    BOOL hasCircleTaskIntro = NO;
    
    NSArray* array = [dataDic objectForKey:@(section)];
    if (array == self.dailyTaskArray) {
        titleLabelInSection.text = @"日常任务";
        hasDialyTaskIntro = YES;
    }
    else if (array == self.circleTaskArray)
    {
        // 日常任务和圈子任务合并在一起为日常任务
        titleLabelInSection.text = @"日常任务";
        hasCircleTaskIntro = YES;
    }
    else if (array == self.singleTaskArray)
    {
        titleLabelInSection.text = @"一次性任务";
    }
    else if (array == self.monthlyTaskArray)
    {
        titleLabelInSection.text = @"每月等级奖励任务";
    }
    if (hasDialyTaskIntro || hasCircleTaskIntro) {
        UIButton* explainBtn = [[UIButton alloc] init];
        [explainBtn setImage:[UIImage imageNamed:@"ic_btn_explain"] forState:UIControlStateNormal];
        [view addSubview:explainBtn];
        if (hasDialyTaskIntro) {
            [explainBtn addTarget:self action:@selector(gotoCreditRuleDetailVC) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            [explainBtn addTarget:self action:@selector(gotoCreditRuleDetailVC) forControlEvents:UIControlEventTouchUpInside];
        }
        PREPCONSTRAINTS(explainBtn);
        CENTER_V(explainBtn);
        CONSTRAIN_SIZE(explainBtn, 55, 30);
        ALIGN_TRAILING(explainBtn, 0);
    }
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    __weak __typeof(self)weakSelf = self;
    
    // 日常任务
    if (self.dailyTaskArray.count > 0 && section == 0) {
        DailyTaskTableCell* cell = (DailyTaskTableCell*)[tableView dequeueReusableCellWithIdentifier:@"DailyTaskTableCell" forIndexPath:indexPath];
        [cell setCell:self.dailyTaskArray];
        return cell;
    }
    CreditTaskModel* taskModel = nil;
    NSArray* currentTaskArray = [dataDic objectForKey:@(indexPath.section)];
    if (currentTaskArray.count > indexPath.row) {
        taskModel = currentTaskArray[indexPath.row];
    }
    // 等级为0时候，接口没有返回每月提示的任务，所以需要弹出每月奖励提示（客户端写的）
    if ([CreditTaskKey_MonthlyTip isEqualToString:taskModel.taskKey]) {
        NSString* cellIdentifier = @"cellIdentifier";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:kFontS1];
            cell.textLabel.textColor = RGBHex(qwColor8);
        }
        cell.textLabel.text = taskModel.taskName;
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        return cell;
    }
    // 一次性任务 每月等级奖励
    SingleTaskTableCell* cell = (SingleTaskTableCell*)[tableView dequeueReusableCellWithIdentifier:@"SingleTaskTableCell" forIndexPath:indexPath];
    [cell setCell:taskModel];
    // 绑定手机号
    if ([CreditTaskKey_Bind isEqualToString:taskModel.taskKey]) {
        cell.actionBtn.touchUpInsideBlock = ^{
            [weakSelf bindPhoneAction];
        };
    }
    // 完善资料
    else if ([CreditTaskKey_Full isEqualToString:taskModel.taskKey])
    {
        cell.actionBtn.touchUpInsideBlock = ^{
            [weakSelf gotoPerfectInforVC];
        };
    }
    // 去领取
    else if ([taskModel.taskKey hasPrefix:@"VIP"])
    {
        cell.actionBtn.touchUpInsideBlock = ^{
            [weakSelf gotoLevelDetailVC];
        };
    }
    // 去邀请
    else if ([CreditTaskKey_Invite isEqualToString:taskModel.taskKey])
    {
        cell.actionBtn.touchUpInsideBlock = ^{
            [weakSelf inviteAction];
        };
    }
    // 去关注圈子
    else if ([CreditTaskKey_CareCirlce isEqualToString:taskModel.taskKey])
    {
        cell.actionBtn.touchUpInsideBlock = ^{
            [weakSelf careCircleAction];
        };
    }
    // 去关注专家
    else if ([CreditTaskKey_CareExpert isEqualToString:taskModel.taskKey])
    {
        cell.actionBtn.touchUpInsideBlock = ^{
            [weakSelf careExpertAction];
        };
    }
    // 去发帖
    else if ([CreditTaskKey_SNS_Post isEqualToString:taskModel.taskKey])
    {
        cell.actionBtn.touchUpInsideBlock = ^{
            [weakSelf postAction];
        };
    }
    // 去回帖
    else if ([CreditTaskKey_SNS_Reply isEqualToString:taskModel.taskKey])
    {
        cell.actionBtn.touchUpInsideBlock = ^{
            [weakSelf replyPostAction];
        };
    }
    // 去点赞
    else if ([CreditTaskKey_SNS_Zan isEqualToString:taskModel.taskKey])
    {
        cell.actionBtn.touchUpInsideBlock = ^{
            [weakSelf praiseAction];
        };
    }
    else
    {
        cell.actionBtn.touchUpInsideBlock = nil;
    }
    return cell;
}

// 圈子任务行为
// 去评价
- (void)appraiseAction
{
    
}

#pragma mark - 去发帖
- (void)postAction
{
    [QWGLOBALMANAGER statisticsEventId:@"x_sygrzx_jf_ft" withLable:@"个人中心-我的积分-去发帖" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl)}]];
    [APPDelegate.mainVC selectedViewControllerWithTag:Enum_TabBar_Items_ForumHome];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

#pragma mark - 去回帖
- (void)replyPostAction
{
    [QWGLOBALMANAGER statisticsEventId:@"x_sygrzx_jf_ht" withLable:@"个人中心-我的积分-去回帖" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl)}]];
    [APPDelegate.mainVC selectedViewControllerWithTag:Enum_TabBar_Items_ForumHome];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

#pragma mark - 去点赞
- (void)praiseAction
{
    [QWGLOBALMANAGER statisticsEventId:@"x_sygrzx_jf_dz" withLable:@"个人中心-我的积分-去点赞" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl)}]];
    [APPDelegate.mainVC selectedViewControllerWithTag:Enum_TabBar_Items_ForumHome];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

#pragma mark - 一次性任务事件监听 暂时没在用。 写死了
- (void) trackEventWithIndexPath:(NSIndexPath*)indexPath taskModel:(CreditTaskModel*)taskModel
{
    // 一次性任务
    if (taskModel.taskType == 2) {
    }
}

#pragma mark - 获取邀请好友的信息
- (void)getInviterInfo
{
    [Mbr getInviteInfo:[MbrInviterInfoModelR new] success:^(id obj) {
        if (obj != nil) {
            self.modelInviterInfo = (InviterInfoModel *) obj;
        }
    } failure:^(HttpException *e) {
        
    }];
    
}

#pragma mark - 邀请动作
- (void) inviteAction
{
    [QWGLOBALMANAGER statisticsEventId:@"x_wd_jf_yqhy" withLable:@"积分" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl)}]];
    ShareContentModel *modelShare = [[ShareContentModel alloc] init];
    modelShare.typeShare = ShareTypeRecommendFriends;
    modelShare.typeCome=@"2";
    if (self.modelInviterInfo != nil) {
        modelShare.title = self.modelInviterInfo.title;
        modelShare.content = self.modelInviterInfo.desc;
        modelShare.imgURL = self.modelInviterInfo.imgUrl;
    }
    if (!QWGLOBALMANAGER.loginStatus) {
        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
        [self presentViewController:navgationController animated:YES completion:NULL];
        __weak typeof(self) weakSelf = self;
        loginViewController.loginSuccessBlock = ^(){
            [weakSelf popUpShareView:modelShare];
        };
    }else {//登陆后
        if (QWGLOBALMANAGER.configure.inviteCode == nil) {
            QWGLOBALMANAGER.configure.inviteCode = @"";
        }
//        modelShare.shareLink = [NSString stringWithFormat:@"%@html5/v224/register.html?inviteCode=%@",BASE_URL_V2,QWGLOBALMANAGER.configure.inviteCode];
        modelShare.shareLink = [NSString stringWithFormat:@"%@html5/v224/downLoad.html?inviteCode=%@",BASE_URL_V2,QWGLOBALMANAGER.configure.inviteCode];
        [self popUpShareView:modelShare];
    }
}

#pragma mark - 进入绑定手机号页面
- (void) bindPhoneAction
{
    [QWGLOBALMANAGER statisticsEventId:@"x_wd_jf_bdsjh" withLable:@"绑定手机号" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl)}]];
    ChangePhoneNumberViewController* bindPhoneVC = [[ChangePhoneNumberViewController alloc] init];
    bindPhoneVC.changePhoneType = ChangePhoneType_BindPhoneNumber;
    bindPhoneVC.isSingleTask = YES;
    bindPhoneVC.model = model;
    [self.navigationController pushViewController:bindPhoneVC animated:YES];
}

#pragma mark - 进入完善资料页面
- (void) gotoPerfectInforVC
{
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"用户等级"]=[NSString stringWithFormat:@"%d",model.level];
    [QWGLOBALMANAGER statisticsEventId:@"x_wd_jf_wszl" withLable:@"积分" withParams:tdParams];
    PerfectInformationViewController* perfectInfoVC = [[PerfectInformationViewController alloc] init];
    [self.navigationController pushViewController:perfectInfoVC animated:YES];
}

#pragma mark - 进入全部圈子页面
- (void)careCircleAction
{
    [QWGLOBALMANAGER statisticsEventId:@"x_wd_jf_gzqz" withLable:@"我的-积分-首次关注的圈子任务" withParams:nil];
    AllCircleViewController* allCirCleVC = (AllCircleViewController*)[[UIStoryboard storyboardWithName:@"Forum" bundle:nil] instantiateViewControllerWithIdentifier:@"AllCircleViewController"];
    allCirCleVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:allCirCleVC animated:YES];
}

#pragma mark - 进入专家页面
- (void)careExpertAction
{
    [QWGLOBALMANAGER statisticsEventId:@"x_wd_jf_gzzj" withLable:@"我的-积分-首次关注的专家任务" withParams:nil];
    [APPDelegate.mainVC selectedViewControllerWithTag:Enum_TabBar_Items_ForumHome];
    [self.navigationController popToRootViewControllerAnimated:NO];
    //发送两次通知。是为了如果圈子还没有加载，那么通知是收不到的，所以需要延迟一次在发送通知过
    [self postNotiGotoCareExpertFromCredit];
    [self performSelector:@selector(postNotiGotoCareExpertFromCredit) withObject:nil afterDelay:0.1];
//    CarePharmacistViewController* carePharmacisVC = [[UIStoryboard storyboardWithName:@"Forum" bundle:nil] instantiateViewControllerWithIdentifier:@"CarePharmacistViewController"];
//    carePharmacisVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:carePharmacisVC animated:YES];
}

- (void)postNotiGotoCareExpertFromCredit
{
    [QWGLOBALMANAGER postNotif:NotifGotoCareExpertFromCredit data:nil object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 进入积分规则页面 h5
- (void) gotoCreditRuleDetailVC
{
    [QWGLOBALMANAGER statisticsEventId:@"x_wd_jf_rcrw_gzsm" withLable:@"我的-积分-日常任务-规则说明" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl)}]];
    WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
    modelLocal.typeLocalWeb = WebLocalTypeIntegralRull;
    modelLocal.title = @"规则说明";
    [vcWebMedicine setWVWithLocalModel:modelLocal];
    [self.navigationController pushViewController:vcWebMedicine animated:YES];
}

#pragma mark - 进入圈子规则页面 h5
- (void) gotoCircleRuleDetailVC
{
    [QWGLOBALMANAGER statisticsEventId:@"x_wd_jf_qzrw_gzsm" withLable:@"我的-积分-圈子任务-规则说明" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl)}]];
    WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
    modelLocal.typeLocalWeb = WebLocalTypeToCircleRules;
    modelLocal.title = @"规则说明";
    [vcWebMedicine setWVWithLocalModel:modelLocal];
    [self.navigationController pushViewController:vcWebMedicine animated:YES];
}

#pragma mark - 进入等级页面
- (void) gotoLevelDetailVC
{
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"用户等级"]=[NSString stringWithFormat:@"%d",model.level];
    [QWGLOBALMANAGER statisticsEventId:@"x_wd_jf_lqdjjl" withLable:@"积分" withParams:tdParams];
    DetialLevelViewController* levelDetail = [[DetialLevelViewController alloc] init];
    levelDetail.isComeFromIntegralVC = YES;
    [self.navigationController pushViewController:levelDetail animated:YES];
}

#pragma mark - 积分商城按钮行为
- (IBAction)creditStoreBtnAction:(id)sender {
    [QWGLOBALMANAGER statisticsEventId:@"我的积分_积分商城" withLable:@"积分" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl)}]];
    //积分商城
    WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    vcWebMedicine.isComeFromCredit = YES;

        WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
        modelLocal.typeLocalWeb = WebPageTypeIntegralIndex;
        modelLocal.title = @"积分商城";
        [vcWebMedicine setWVWithLocalModel:modelLocal];
        [self.navigationController pushViewController:vcWebMedicine animated:YES];
}

#pragma mark - 积分明细按钮行为 storeboard中已经配置跳转
- (IBAction)creditRuleDetailBtnAction:(id)sender {
    //积分明细    segue 已配置
    [QWGLOBALMANAGER statisticsEventId:@"我的积分_积分明细" withLable:@"我的-积分-积分明细" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl)}]];
    CreditRecordViewController* creditRecordVC = [[UIStoryboard storyboardWithName:@"Credit" bundle:nil] instantiateViewControllerWithIdentifier:@"CreditRecordViewController"];
    [self.navigationController pushViewController:creditRecordVC animated:YES];
}

#pragma mark - UIScrollViewDelegate 根据拖拉表格视图放大积分标签的视图
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 0) {
        CGFloat scale = (self.tableHearderView.frame.size.height - scrollView.contentOffset.y)/self.tableHearderView.frame.size.height;
        scale = scale > 1.5 ? 1.5 : scale;
        self.creditTextContainerView.transform = CGAffineTransformMakeScale(scale, scale);
    }
}

#pragma mark ----- 处理通知
- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj
{
    if(NotifRefreshCurAppPageTwo==type){
//        [self loadData];
    }
}

- (void)reloadDataAfterShare
{
    [self loadData];
}
@end
