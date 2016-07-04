//
//  QuickSearchDrugListViewController.m
//  wenYao-store
//
//  Created by YYX on 15/6/8.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QuickSearchDrugListViewController.h"
#import "DrugDetailViewController.h"
#import "MedicineListCell.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "Drug.h"
#import "XPChatViewController.h"
#import "QuickSearchDrugViewController.h"
#import "ChatViewController.h"
#import "ReturnIndexView.h"
#import "LoginViewController.h"
#import "MessageBoxListViewController.h"

@interface QuickSearchDrugListViewController ()<UITableViewDelegate,UITableViewDataSource,ReturnIndexViewDelegate>

{
    NSInteger currentPage;
    UIView *_nodataView;
}
@property (nonatomic ,strong) NSMutableArray * dataSource;
@property (nonatomic,strong)UITableView *tableViews;
@property (nonatomic, strong) ReturnIndexView *indexView;
@property (nonatomic, strong) UILabel *numLabel;   //数字角标
@property (nonatomic, strong) UILabel *redLabel;   //小红点
@property (assign, nonatomic) int passNumber;

@end

@implementation QuickSearchDrugListViewController

- (instancetype)init
{
    if (self = [super init]) {
        UIBarButtonItem *barbutton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(popVCAction:)];
        self.navigationItem.leftBarButtonItem=barbutton;
        self.tableViews=[[UITableView alloc]init];
        [self.tableViews setFrame:CGRectMake(0, 0, APP_W, APP_H -NAV_H)];
        self.tableViews.separatorStyle=UITableViewCellSeparatorStyleNone;
        self.tableViews.dataSource=self;
        self.tableViews.delegate=self;
        [self.tableViews addFooterWithTarget:self action:@selector(footerRereshing)];
        self.tableViews.footerPullToRefreshText =kWarning6;
        self.tableViews.footerReleaseToRefreshText = kWarning7;
        self.tableViews.footerRefreshingText = kWarning8;
        self.tableViews.backgroundColor=RGBHex(qwColor11);
        [self.view addSubview:self.tableViews];
        currentPage = 1;
    }
    return self;
}
-(void)popVCAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加用药列表";
    self.tableViews.rowHeight = 88;
    self.dataSource = [NSMutableArray array];
    UILabel *lableTips=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, APP_W, 39.5)];
    lableTips.text=@"请选择一个药品提问";
    lableTips.textColor=RGBHex(qwColor8);
    lableTips.font=fontSystem(kFontS4);
    lableTips.textAlignment=NSTextAlignmentCenter;
    lableTips.backgroundColor=RGBHex(qwColor4);
    
    UIView *lineSpe=[[UIView alloc] initWithFrame:CGRectMake(0, 39.5, APP_W, 0.5)];
    lineSpe.backgroundColor=RGBHex(qwColor10);
    [lableTips addSubview:lineSpe];
    self.tableViews.tableHeaderView=lableTips;
    
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.passNumber = [QWGLOBALMANAGER updateRedPoint];
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





- (void)cancelAction
{
    NSArray *viewControllers = self.navigationController.viewControllers;
    for(NSInteger index = viewControllers.count - 1; index > 0; index--)
    {
        UIViewController *viewController = viewControllers[index];
        if ([viewController isKindOfClass:[XPChatViewController class]]) {
            [self.navigationController popToViewController:viewController animated:YES];
            break;
        }else if([viewController isKindOfClass:[ChatViewController class]]){
            [self.navigationController popToViewController:viewController animated:YES];
            break;
        }else if(index == 0){
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)footerRereshing{
    currentPage ++;
    [self setKwId:self.kwId];
}

- (void)setKwId:(NSString *)kwId
{
    _kwId = kwId;
    productBykwIdR *productR=[productBykwIdR new];
    productR.kwId=kwId;
    productR.currPage=[NSString stringWithFormat:@"%ld",(long)currentPage];
    productR.pageSize=[NSString stringWithFormat:@"%i",10];
    productR.type = @"1";
    productR.v = @"2.0";
    //新增城市和省
    
    MapInfoModel *mapInfoModel = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
    productR.province=mapInfoModel==nil?@"江苏省":mapInfoModel.province;
    productR.city=mapInfoModel==nil?@"苏州市":mapInfoModel.city;
    
    [Drug queryProductByKwIdWithParam:productR Success:^(id DFUserModel) {
        GetSearchKeywordsModel *product=DFUserModel;
        if(currentPage == 1){
            [self.dataSource removeAllObjects];
        }
        for (productclassBykwId *productclass in product.list) {
            [self.dataSource addObject:productclass];
        }
        if (self.dataSource.count > 0) {
            [self.tableViews reloadData];
        }else{
            [self showNoDataViewWithString:@"暂无数据!"];
        }
        [self.tableViews footerEndRefreshing];
        
    } failure:^(HttpException *e) {
        [self showInfoView:@"服务器吃药去啦！请稍后重试" image:@"ic_img_fail"];
        [self.tableViews footerEndRefreshing];
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellIdentifier = @"cellIdentifier";
    MedicineListCell * cell = (MedicineListCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MedicineListCell" owner:self options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=RGBHex(qwColor4);
    }
    productclassBykwId *productclass=self.dataSource[indexPath.row];
    [cell setCell:productclass];
    
    //此处不需要显示赠折抵扣小标签 --jxb 2015.9.6
    //if(!productclass.gift)
    {
        [cell.giftLabel removeFromSuperview];
    }
    //if(!productclass.discount)
    {
        [cell.foldLabel removeFromSuperview];
    }
    //if(!productclass.voucher)
    {
        [cell.pledgeLabel removeFromSuperview];
    }
    //if(!productclass.special)
    {
        [cell.specialLabel removeFromSuperview];
    }
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *selection = [self.tableViews indexPathForSelectedRow];
    if (selection) {
        [self.tableViews deselectRowAtIndexPath:selection animated:YES];
    }
    
    productclassBykwId *product = self.dataSource[indexPath.row];
    if (self.block) {
        self.block(product);
    }
    NSArray *viewControllers = self.navigationController.viewControllers;
    for(NSInteger index = viewControllers.count - 1; index > 0; index--)
    {
        UIViewController *viewController = viewControllers[index];
        if ([viewController isKindOfClass:[XPChatViewController class]]) {
            [self.navigationController popToViewController:viewController animated:YES];
            break;
        }else if([viewController isKindOfClass:[ChatViewController class]]){
            [self.navigationController popToViewController:viewController animated:YES];
            break;
        }else if(index == 0){
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//显示没有历史搜索记录view
-(void)showNoDataViewWithString:(NSString *)nodataPrompt
{
    if (_nodataView) {
        [_nodataView removeFromSuperview];
        _nodataView = nil;
    }
    _nodataView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H-NAV_H)];
    _nodataView.backgroundColor = [UIColor colorWithRed:231/255.0 green:236/255.0 blue:238/255.0 alpha:1.0];
    UIImage * searchImage = [UIImage imageNamed:@"ic_img_fail"];
    
    UIImageView *dataEmpty = [[UIImageView alloc]initWithFrame:RECT(0, 0, searchImage.size.width, searchImage.size.height)];
    dataEmpty.center = CGPointMake(APP_W/2, 110);
    dataEmpty.image = searchImage;
    [_nodataView addSubview:dataEmpty];
    
    UILabel* lable_ = [[UILabel alloc]initWithFrame:RECT(0,dataEmpty.frame.origin.y + dataEmpty.frame.size.height + 10, nodataPrompt.length*20,30)];
    lable_.font =fontSystem(kFontS5);
    lable_.textColor =RGBHex(qwColor8);
    lable_.textAlignment = NSTextAlignmentCenter;
    lable_.center = CGPointMake(APP_W/2, lable_.center.y);
    lable_.text = nodataPrompt;
    [_nodataView addSubview:lable_];
    [self.view insertSubview:_nodataView atIndex:self.view.subviews.count];
}


@end
