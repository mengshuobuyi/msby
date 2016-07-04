//
//  QuestionDetailViewController.m
//  APP
//
//  Created by qwfy0006 on 15/3/9.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QuestionDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "Appdelegate.h"
#import "Constant.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "SBJson.h"
#import "ReturnIndexView.h"
#import "ProblemModelR.h"
#import "ProblemModel.h"
#import "Problem.h"
#import "QuestionDetailCellLeft.h"
#import "QuestionDetailCellRight.h"
#import "ConsultForFreeRootViewController.h"
#import "MessageBoxListViewController.h"
#import "LoginViewController.h"

@interface QuestionDetailViewController ()<UITableViewDataSource,UITableViewDelegate,ReturnIndexViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) int page;
@property (strong, nonatomic) UIView *noDataView;
@property (strong, nonatomic) NSString *logoUrl;
@property (strong, nonatomic) ReturnIndexView *indexView;
@property (strong, nonatomic) UIButton *askButton;
@property (nonatomic, strong) UILabel *numLabel;   //数字角标
@property (nonatomic, strong) UILabel *redLabel;   //小红点
@property (assign, nonatomic) int passNumber;



@end

@implementation QuestionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"问题详情";
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    
    [self setupTableView];
    [self setUpBottomView];
    self.view.backgroundColor = RGBHex(qwColor11);
    

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


- (void)logoutAction
{
    if (self.dataArray && self.dataArray.count > 0) {
        [self.dataArray removeAllObjects];
    }
}


- (void)setupTableView
{
    CGRect rect = self.view.frame;
    rect.size.height -=  (50+64) ;
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.allowsSelection = NO;
    self.tableView.backgroundColor = RGBHex(qwColor11);
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.passNumber = [QWGLOBALMANAGER updateRedPoint];
//    [self setUpRightItem];
    
    self.askButton.enabled = YES;
    if (self.dataArray.count == 0) {
        self.page = 1;
        [self getQuestionDetailList];
    }
    [self.tableView reloadData];
}

- (void)viewDidCurrentView
{
    if (self.dataArray.count == 0) {
        self.page = 1;
        [self getQuestionDetailList];
    }
    [self.tableView reloadData];
}


#pragma mark======  缓存数据

- (void)loadCachedQuestionDetail
{
    if (self.dataArray.count > 0) {
        [self.dataArray removeAllObjects];
    }
    
    NSString *where = [NSString stringWithFormat:@"classId = '%@' and teamId = '%@'",self.classId,self.teamId];
    NSArray *arr = [ProblemDetailModel getArrayFromDBWithWhere:where];
    
    [self.dataArray addObjectsFromArray:arr];
    
    
    for (ProblemDetailModel *model in arr) {
        self.logoUrl = model.imgUrl;
    }
    
    if (self.dataArray.count == 0) {
        [self showInfoView:kWarningN2 image:@"网络信号icon.png"];
        self.tableView.hidden = YES;
    }else
    {
        [self removeInfoView];
        self.tableView.hidden = NO;
    }
    [self.tableView reloadData];
}


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
    self.askButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.askButton setTitleColor:RGBHex(qwColor4) forState:UIControlStateNormal];
    self.askButton.layer.cornerRadius = 2.0;
    self.askButton.layer.masksToBounds = YES;
    [self.askButton addTarget:self action:@selector(askMedcineClick1) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.askButton];
    [self.view addSubview:bgView];
}

- (void)askMedcineClick1
{
    self.askButton.enabled = NO;
    ConsultForFreeRootViewController *consultViewController = [[UIStoryboard storyboardWithName:@"ConsultForFree" bundle:nil] instantiateViewControllerWithIdentifier:@"ConsultForFreeRootViewController"];
    
    consultViewController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:consultViewController animated:YES];
}

#pragma  mark----------------------列表代理------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProblemDetailModel *mod = self.dataArray[indexPath.row];
    
    if ([mod.role integerValue] == 1) {
        return [QuestionDetailCellRight getCellHeight:mod];
    }else
    {
        return [QuestionDetailCellLeft getCellHeight:mod];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProblemDetailModel *model = self.dataArray[indexPath.row];
    
    QuestionDetailCellLeft *cellLeft = nil;
    QuestionDetailCellRight *cellRight = nil;

    if ([model.role integerValue]==1) {
        cellRight = [tableView dequeueReusableCellWithIdentifier:@"rightCell"];
        if (!cellRight) {
            cellRight = [[QuestionDetailCellRight alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rightCell"];
        }
        [cellRight setCell:model];
        return cellRight;
        
    }else if ([model.role integerValue]==2){
        cellLeft = [tableView dequeueReusableCellWithIdentifier:@"leftCell"];
        if (!cellLeft) {
            cellLeft = [[QuestionDetailCellLeft alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftCell"];
        }
        if ([self.logoUrl isKindOfClass:[NSNull class]]) {
            [cellLeft.imgUrl setImage:[UIImage imageNamed:@"默认药房.PNG"]];
        }else
        {
            [cellLeft.imgUrl setImageWithURL:[NSURL URLWithString:self.logoUrl] placeholderImage:[UIImage imageNamed:@"默认药房.PNG"]];
        }
       
        [cellLeft setCell:model];
        return cellLeft;
    }
    return nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//接收通知
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

//从服务器获取数据
- (void)getQuestionDetailList
{
    [self removeInfoView];
    __weak QuestionDetailViewController *weakSelf = self;
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [self loadCachedQuestionDetail];
    }else
    {
        ProblemDetailModelR *model = [ProblemDetailModelR new];
        model.classId = self.classId;
        model.teamId = self.teamId;
        model.currPage = [NSString stringWithFormat:@"%d",weakSelf.page];
        model.pageSize = @"10";
       
            [Problem detailWithParams:model success:^(id obj) {
                ProblemListPage *page = obj;
                if (self.page == 1) {
                    [self.dataArray removeAllObjects];
                }
                for (id obj in page.list) {
                    [self.dataArray addObject:obj];
                }
                if (self.dataArray.count == 0) {
                    [self showInfoView:kWarning30 image:@"ic_img_fail"];
                    self.tableView.hidden = YES;
                }else
                {
                    [self removeInfoView];
                    self.tableView.hidden = NO;
                }
                
                self.logoUrl = page.imgUrl;
                
                NSMutableArray *arr = [NSMutableArray array];
                for (ProblemDetailModel *model in self.dataArray) {
                    model.teamId = self.teamId;
                    model.classId = self.classId;
                    model.imgUrl = page.imgUrl;
                    [arr addObject:model];
                }
                
                [ProblemDetailModel saveObjToDBWithArray:arr];
                
                [weakSelf.tableView reloadData];
                [weakSelf.tableView footerEndRefreshing];
            } failure:^(HttpException *e) {
                if(e.errorCode!=-999){
                    if(e.errorCode == -1001){
                        [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                    }else{
                        [self showInfoView:kWarning39 image:@"ic_img_fail"];
                    }
                }
                [self.tableView footerEndRefreshing];
            }];
        
    }
    
}

- (void)viewInfoClickAction:(id)sender
{
    if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        [self removeInfoView];
        [self getQuestionDetailList];
    }
}


@end
