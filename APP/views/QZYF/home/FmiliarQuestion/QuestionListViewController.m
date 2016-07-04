//
//  QuestionListViewController.m
//  APP
//
//  Created by qwfy0006 on 15/3/6.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QuestionListViewController.h"
#import "FamiliarQuestionListCell.h"
#import "HttpClient.h"
#import "UIImageView+WebCache.h"
#import "Appdelegate.h"
#import "QWGlobalManager.h"
#import "Constant.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "SBJson.h"
#import "ProblemModelR.h"
#import "ProblemModel.h"
#import "Problem.h"
#import "QuestionDetailViewController.h"
#import "ReturnIndexView.h"
#import "LoginViewController.h"
#import "MessageBoxListViewController.h"
#import "ConsultForFreeRootViewController.h"

@interface QuestionListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataList;
@property (assign, nonatomic) int page;
@property (strong, nonatomic) UIView *noDataView;
@property (nonatomic, strong) UIButton *askButton;

@property (strong, nonatomic) ReturnIndexView *indexView;
@property (nonatomic, strong) UILabel *numLabel;   //数字角标
@property (nonatomic, strong) UILabel *redLabel;   //小红点
@property (assign, nonatomic) int passNumber;

@end

@implementation QuestionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataList = [NSMutableArray arrayWithCapacity:0];
    
    self.title = @"大家都在问";
    
    [self setupTableView];
    [self setUpHeaderView];
    [self setUpBottomView];
    
    __weak QuestionListViewController *weakSelf = self;
    [self.tableView addFooterWithCallback:^{
        if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
            HttpClientMgr.progressEnabled = NO;
            weakSelf.page ++;
            [weakSelf getQuestionList];
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"网络未连接，请重试！" duration:0.8];
            [weakSelf.tableView footerEndRefreshing];
        }
    }];
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开加载更多数据了";
    self.tableView.footerRefreshingText = @"正在帮你加载中";
    self.tableView.footerNoDataText = kWarning44;
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.passNumber = [QWGLOBALMANAGER updateRedPoint];
//    [self setUpRightItem];
    self.askButton.enabled = YES;
    if (self.dataList.count == 0) {
        self.page = 1;
        [self getQuestionList];
    }
    [self.tableView reloadData];
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

#pragma mark ---- 网络获取我的列表数据 ----

- (void)getQuestionList
{
    [self removeInfoView];
    __weak QuestionListViewController *weakSelf = self;
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [self loadCacheQuestionList];
    }else
    {
        NSMutableDictionary *setting = [NSMutableDictionary dictionary];
        setting[@"moduleId"] = StrFromObj(self.strModuleId);
        setting[@"currPage"] = [NSString stringWithFormat:@"%d",weakSelf.page];
        setting[@"pageSize"] = @"10";
        [Problem ProblemListByModuleWithParams:setting success:^(id obj) {
        
            ProblemListPage *page = obj;
            if (self.page == 1) {
                [self.dataList removeAllObjects];
            }
            for (id obj in page.list) {
                [self.dataList addObject:obj];
            }
            
            if (page.list.count ==  0) {
                self.tableView.footer.canLoadMore = NO;
            }
            
            if (self.dataList.count == 0) {
                [self showInfoView:kWarning30 image:@"ic_img_fail"];
                self.tableView.hidden = YES;
            }else
            {
                [self removeInfoView];
                self.tableView.hidden = NO;
            }
            
            NSMutableArray *arr = [NSMutableArray array];
            for (ProblemListModel *model in page.list) {
//                model.moduleId = self.moduleId;
                [arr addObject:model];
            }
            
            //缓存
            [ProblemListModel saveObjToDBWithArray:arr];
            
            [weakSelf.tableView reloadData];
            [self.tableView footerEndRefreshing];
            
        } failure:^(HttpException *e) {
            
            [self.tableView footerEndRefreshing];
            if(e.errorCode!=-999){
                if(e.errorCode == -1001){
                    [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                }else{
                    [self showInfoView:kWarning39 image:@"ic_img_fail"];
                }
            }
        }];
        
    }
    
    
}

- (void)viewInfoClickAction:(id)sender
{
    if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        [self removeInfoView];
        [self getQuestionList];
    }
}


#pragma mark ---- 缓存 ----

- (void)loadCacheQuestionList
{
    if (self.dataList.count > 0) {
        [self.dataList removeAllObjects];
    }
    
    NSString *where = [NSString stringWithFormat:@"classId = '%@' and moduleId = '%@'",self.classId,self.moduleId];
    NSArray *arr = [ProblemListModel getArrayFromDBWithWhere:where];
    
    [self.dataList addObjectsFromArray:arr];
    if (self.dataList.count == 0) {
        [self showInfoView:kWarning12 image:@"网络信号icon.png"];
        self.tableView.hidden = YES;
    }else
    {
        [self removeInfoView];
        self.tableView.hidden = NO;
    }
    [self.tableView reloadData];
}


- (void)setupTableView
{
    CGRect rect = self.view.frame;
    rect.size.height -= (64 + 50);
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    self.tableView.hidden = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:RGBHex(qwColor11)];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [self.tableView setSeparatorInset:(UIEdgeInsetsMake(0, 0, 0, 0))];
    }
    [self.view addSubview:self.tableView];
}

- (void)setUpBottomView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50-64, self.view.frame.size.width, 50)];
    bgView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [bgView addSubview:line];
    
    self.askButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.askButton.frame = CGRectMake(bgView.frame.size.width-100, 10, 80, 30);
    [self.askButton setBackgroundColor:RGBHex(qwColor2)];
    [self.askButton setTitle:@"我也要问" forState:UIControlStateNormal];
    self.askButton.titleLabel.font = fontSystem(kFontS4);
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

- (void)setUpHeaderView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    bgView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 1, bgView.frame.size.width, bgView.frame.size.height)];
    lab.text = @"常见用药问题";
    lab.font = fontSystem(kFontS5);
    lab.textColor = RGBHex(qwColor8);
    [bgView addSubview:lab];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 40-0.5, self.view.frame.size.width, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [bgView addSubview:line];
    
    [self.view addSubview:bgView];
    self.tableView.tableHeaderView = bgView;
    
}


#pragma mark--------------------列表代理--------------------

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 7;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 7)];
    vi.backgroundColor = [UIColor clearColor];
    return vi;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [FamiliarQuestionListCell getCellHeight:self.dataList[indexPath.section]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *QuestionListCellIdentifier = @"FamiliarQuestionListCell";
    FamiliarQuestionListCell *cell = (FamiliarQuestionListCell *)[tableView dequeueReusableCellWithIdentifier:QuestionListCellIdentifier];
    if(cell == nil)
    {
        UINib *nib = [UINib nibWithNibName:@"FamiliarQuestionListCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:QuestionListCellIdentifier];
        cell = (FamiliarQuestionListCell *)[tableView dequeueReusableCellWithIdentifier:QuestionListCellIdentifier];
        
    }
    
    id mod=[self.dataList objectAtIndex:indexPath.section];
    [cell setCell:mod];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataList.count == 0) {
        return;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QuestionDetailViewController *detailVC = [[QuestionDetailViewController alloc]init];
    ProblemListModel *model = self.dataList[indexPath.section];
    detailVC.classId = model.classId;
    detailVC.teamId = model.teamId;
    [self.navigationController pushViewController:detailVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//接收logout通知
- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj
{
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

- (void)logoutAction
{
    if (self.dataList && self.dataList.count >0) {
        [self.dataList removeAllObjects];
    }
}

@end
