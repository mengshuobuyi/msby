//
//  MedicineListViewController.m
//  wenyao
//
//  Created by Meng on 14-9-28.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "MedicineListViewController.h"
#import "MedicineListCell.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "ReturnIndexView.h"
#import "Drug.h"
#import "MessageBoxListViewController.h"
#import "LoginViewController.h"
#import "WebDirectViewController.h"


@interface MedicineListViewController ()<TopTableViewDelegate,UITableViewDataSource,UITableViewDelegate,ReturnIndexViewDelegate>
{
    NSInteger currentPage;
    BOOL menuIsShow;
    UIButton * rightBarButton;
    NSString* factoryIsShow;
}
@property (nonatomic,strong) TopTableView *topTable;
@property (nonatomic,strong) NSMutableArray * dataSource;
@property (nonatomic,strong) UITableView *listTableView;
@property (nonatomic,strong) ReturnIndexView *indexView;
@property (nonatomic,strong) __block NSMutableArray *data;
@property (nonatomic,strong) NSMutableArray * factoryArray;
@property (nonatomic,strong) UIButton        *backGoundCover;
@property (nonatomic, strong) UILabel *numLabel;   //数字角标
@property (nonatomic, strong) UILabel *redLabel;   //小红点
@property (assign, nonatomic) int passNumber;


@end

@implementation MedicineListViewController


- (id)init{
    if (self = [super init]) {
        menuIsShow = NO;
        
        self.topTable = [[TopTableView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H)];
        self.topTable.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        self.topTable.tag=2000;
        self.topTable.hidden = YES;
        self.topTable.mTableView.tag=1000;
        self.topTable.delegate = self;
        self.topTable.mTableView.frame = CGRectMake(0,-500, APP_W, 380);
        [self.view addSubview:self.topTable];
        
    }
    return self;
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)popVCAction:(id)sender {
    [super popVCAction:sender];
    [QWGLOBALMANAGER statisticsEventId:@"x_yp_3_fh" withLable:@"药品" withParams:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"列表";
    self.listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_W, APP_H) style:UITableViewStylePlain];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.frame = CGRectMake(0, 0, APP_W, APP_H-NAV_H);
    self.listTableView.rowHeight = 88;
    [self.listTableView addStaticImageHeader];
    [self.view addSubview:self.listTableView];
    
    [self.listTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    [self.listTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.listTableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.listTableView.footerReleaseToRefreshText = @"松开加载更多数据了";
    self.listTableView.footerRefreshingText = @"正在帮你加载中";
    self.listTableView.footerNoDataText = kWarning44;
    currentPage = 1;
    
    self.backGoundCover = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect rect = self.view.frame;
    self.backGoundCover.frame = rect;
    self.backGoundCover.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    self.backGoundCover.hidden = YES;
    menuIsShow = NO;
    self.dataSource = [NSMutableArray array];
    self.factoryArray = [NSMutableArray array];
    self.data = [NSMutableArray array];
}

- (void)setClassId:(NSString *)classId{
    _classId = [classId copy];
    if (self.isShow == 1) {//要显示右上角的商家列表
        [self initRightBarButton];
        self.topTable.topClassId = self.classId;
    }else{
        self.passNumber = [QWGLOBALMANAGER updateRedPoint];
//        [self setUpRightItem];
    }
    if ([self.className isEqualToString:@"SubRegularDrugsViewController"]) {//常备商品跳转
        [self loadHealthyScenarioData:self.classId];
        
        
    }else{
        [self loadDataWithClassId:self.classId];
    }
}


- (void)initRightBarButton{
    CGSize size =[GLOBALMANAGER sizeText:@"全部生产厂家" font:fontSystem(kFontS1)];
    rightBarButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, size.width, 20)];
    rightBarButton.backgroundColor = [UIColor clearColor];
    rightBarButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
    [rightBarButton setTitle:@"全部生产厂家" forState:UIControlStateNormal];
    rightBarButton.titleLabel.font = fontSystem(kFontS1);
    [rightBarButton setTintColor:[UIColor blueColor]];
    [rightBarButton addTarget:self action:@selector(barButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage * arrImage = [UIImage imageNamed:@"头部下拉箭头.png"];
    UIImageView * arrImageView = [[UIImageView alloc] initWithFrame:CGRectMake(rightBarButton.frame.origin.x + rightBarButton.frame.size.width, 15, arrImage.size.width, arrImage.size.height)];
    arrImageView.image = arrImage;
    [rightBarButton addSubview:arrImageView];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBarButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

//生产厂家的列表的显示
- (void)barButtonClick{
    //原来没有显示，点击后显示
    if (menuIsShow == NO) {
            FetchProFactoryByClassModelR *requestModel = [FetchProFactoryByClassModelR new];
            requestModel.classId = self.classId;
            requestModel.currPage = @1;
            requestModel.pageSize = @20;
            
            [Drug fetchProFactoryByClassWithParam:requestModel Success:^(id DFUserModel) {
                QueryProductClassModel *queryProductClassModel = (QueryProductClassModel *)DFUserModel;
                self.topTable.topDataArr = queryProductClassModel.list;//生产厂家的数据
            } failure:^(HttpException *e) {
                if(e.errorCode!=-999){
                    if(e.errorCode == -1001){
                        [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                    }else{
                        [self showInfoView:kWarning39 image:@"ic_img_fail"];
                    }
                    
                }
                return;
            }];
        [UIView animateWithDuration:0.5 animations:^{
            self.topTable.hidden = NO;
            self.topTable.mTableView.frame = CGRectMake(0, 0, APP_W, 360);
            self.backGoundCover.hidden = NO;
        }];
        menuIsShow = YES;
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.topTable.hidden = YES;
            self.topTable.mTableView.frame = CGRectMake(0, -500, APP_W, 360);
            self.backGoundCover.hidden = YES;
            
        }];
        menuIsShow = NO;
    }
    
}


- (void)viewInfoClickAction:(id)sender
{
    if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        [self removeInfoView];
        if ([self.className isEqualToString:@"SubRegularDrugsViewController"]) {//常备商品跳转
            [self loadHealthyScenarioData:self.classId];
        }else{
            [self loadDataWithClassId:self.classId];
        }
    }
}



//加载健康方案的药品列表
- (void)loadHealthyScenarioData:(NSString *)classId
{
    
    HealthyScenarioDrugModelR *model = [HealthyScenarioDrugModelR new];
    model.classId = classId;
    model.currPage = @(currentPage);
    model.pageSize = @(PAGE_ROW_NUM);
    model.v = @"2.0";
    //新增城市和省
    
    MapInfoModel *mapInfoModel = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
    model.province=mapInfoModel==nil?@"江苏省":mapInfoModel.province;
    model.city=mapInfoModel==nil?@"苏州市":mapInfoModel.city;
    
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        //本地缓存读取功能
        NSString * where = [NSString stringWithFormat:@"classId = '%@'",classId];
        NSArray *arr = [HealthyScenarioDrugModel getArrayFromDBWithWhere:where];
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:arr];
        if (self.dataSource.count > 0) {
            [self.listTableView reloadData];
            [self.listTableView footerEndRefreshing];
        }else{
            [self showInfoView:kWarning12 image:@"网络信号icon"];
        }
    } else {
    
        [Drug queryRecommendProductByClassWithParam:model success:^(id UFModel) {
            
            HealthyScenarioListModel *scneario =(HealthyScenarioListModel *) UFModel;
            [self.dataSource addObjectsFromArray:scneario.list];
            for (HealthyScenarioDrugModel *model in self.dataSource) {
                model.classId=classId;
                model.proIdSceno=[NSString stringWithFormat:@"%@_%@",model.proId,model.classId];
                [HealthyScenarioDrugModel updateObjToDB:model WithKey:model.proIdSceno];
            }
            
            if(scneario.list.count>0){
                currentPage ++ ;
                [self.listTableView reloadData];
            }else{
                self.listTableView.footer.canLoadMore=NO;
            }
            
           [self.listTableView footerEndRefreshing];
            
        } failure:^(HttpException *e) {
            if(e.errorCode!=-999){
                if(e.errorCode == -1001){
                    [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                }else{
                    [self showInfoView:kWarning39 image:@"ic_img_fail"];
                }
                
            }
            return;
        }];
    }
}

//加载其他带id药品列表
- (void)loadDataWithClassId:(NSString *)classId{
    
    
    QueryProductByClassModelR *queryProductByClassModelR = [QueryProductByClassModelR new];
    queryProductByClassModelR.classId = classId;
    if(factoryIsShow!=nil){
        queryProductByClassModelR.factory=factoryIsShow;
    }
    queryProductByClassModelR.currPage = @(currentPage);
    queryProductByClassModelR.pageSize = @(PAGE_ROW_NUM);
    
    //新增城市和省
    
    MapInfoModel *mapInfoModel = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
    queryProductByClassModelR.province=mapInfoModel==nil?@"江苏省":mapInfoModel.province;
    queryProductByClassModelR.city=mapInfoModel==nil?@"苏州市":mapInfoModel.city;
    queryProductByClassModelR.v = @"2.0";
    
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        //本地缓存读取功能
        NSString * where = [NSString stringWithFormat:@"classId = '%@'",classId];
        NSArray *arr = [QueryProductByClassItemModel getArrayFromDBWithWhere:where];
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:arr];
        if (self.dataSource.count > 0) {
            [self.listTableView reloadData];
            [self.listTableView footerEndRefreshing];
        }else{
            [self showInfoView:kWarning12 image:@"网络信号icon"];
        }
        
    } else {
    [Drug queryProductByClassWithParam:queryProductByClassModelR Success:^(id DFUserModel) {
        QueryProductClassModel *queryProductClassModel = (QueryProductClassModel *)DFUserModel;
        [self.dataSource addObjectsFromArray:queryProductClassModel.list];
        
        for (QueryProductByClassItemModel *model in self.dataSource) {
            model.classId=classId;
            [QueryProductByClassItemModel saveObjToDB:model];
            
        }
        if(queryProductClassModel.list.count>0){
            currentPage ++ ;
            [self.listTableView reloadData];
            [self.listTableView footerEndRefreshing];
        }else{
            self.listTableView.footer.canLoadMore=NO;
            [self.listTableView footerEndRefreshing];
        }
    } failure:^(HttpException *e) {
        if(e.errorCode!=-999){
            if(e.errorCode == -1001){
                [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
            }else{
                [self showInfoView:kWarning39 image:@"ic_img_fail"];
            }
    
        }
        return;
    }];
    }
}

- (void)footerRereshing
{
    HttpClientMgr.progressEnabled = NO;
    if (self.classId) {
        if ([self.className isEqualToString:@"SubRegularDrugsViewController"]) {
            [self loadHealthyScenarioData:self.classId];
            
        }else{
            [self loadDataWithClassId:self.classId];
        }
    }
    
}



#pragma mark -------topTable数据回调-------
- (void)tableViewCellSelectedReturnData:(NSArray *)dataArr withClassId:(NSString *)classId  withIndexPath:(NSIndexPath *)indexPath withFactory:(NSString*)topFactory keyWord:(NSString *)keyword{
    //设置点击后的页面的展示
    [self barButtonClick];
    [rightBarButton setTitle:keyword forState:UIControlStateNormal];
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:dataArr];
     self.listTableView.footer.canLoadMore=YES;
    if (indexPath.row == 0) {
        //如果是第一行,那就是加载全部数据（全部生产厂家）
        currentPage = 2;
        factoryIsShow=nil;
        [self.listTableView reloadData];
        //[self performSelectorOnMainThread:@selector(loadDataWithClassId:) withObject:classId waitUntilDone:YES];
        //[self loadDataWithClassId:self.classId];
    }else{
        //如果不是第一行,那就不需要上拉刷新,移除底部刷新工具
        //[self.listTableView removeFooter];
        
        factoryIsShow=topFactory;
        currentPage=2;
        [self.listTableView reloadData];
    }
    
}

- (void)dismissMenuWithButton
{
    [UIView animateWithDuration:0.5 animations:^{
        self.topTable.mTableView.frame = CGRectMake(0, -500, APP_W, 360);
        self.topTable.hidden = YES;
        self.backGoundCover.hidden = YES;
    }];
    menuIsShow = NO;
}
#pragma table的代理-----------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MedicineListCell getCellHeight:nil] ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"cellIdentifier";
    MedicineListCell * cell = nil;
    cell = [[NSBundle mainBundle] loadNibNamed:@"MedicineListCell" owner:self options:nil][0];
    cell.separatorInset = UIEdgeInsetsZero;
    UIView *bkView = [[UIView alloc]initWithFrame:cell.frame];
    bkView.backgroundColor = RGBHex(qwColor10);
    cell.selectedBackgroundView = bkView;
    
    if ([self.className isEqualToString:@"SubRegularDrugsViewController"]) {
        HealthyScenarioDrugModel *drugModel=self.dataSource[indexPath.row];

        [cell setSenaioCell:drugModel];
//        if(!drugModel.gift) {
//            [cell.giftLabel removeFromSuperview];
//        }
//        if(!drugModel.discount) {
//            [cell.foldLabel removeFromSuperview];
//        }
//        if(!drugModel.voucher) {
//            [cell.pledgeLabel removeFromSuperview];
//        }
//        if(!drugModel.special) {
//            [cell.specialLabel removeFromSuperview];
//        }
    }else{
        QueryProductByClassItemModel *model = self.dataSource[indexPath.row];
        [cell setCell:model];
//        if(!model.gift) {
//            [cell.giftLabel removeFromSuperview];
//        }
//        if(!model.discount) {
//            [cell.foldLabel removeFromSuperview];
//        }
//        if(!model.voucher) {
//            [cell.pledgeLabel removeFromSuperview];
//        }
//        if(!model.special) {
//            [cell.specialLabel removeFromSuperview];
//        }
    }
    
    
        [cell.giftLabel removeFromSuperview];
        [cell.foldLabel removeFromSuperview];
        [cell.pledgeLabel removeFromSuperview];
        [cell.specialLabel removeFromSuperview];

    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *selection = [tableView indexPathForSelectedRow];
    if (selection) {
        [tableView deselectRowAtIndexPath:selection animated:YES];
    }
    HealthyScenarioDrugModel *dic = self.dataSource[indexPath.row];
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"点击内容"] = dic.proName;
    [QWGLOBALMANAGER statisticsEventId:@"x_yp_4" withLable:@"列表" withParams:tdParams];
    [self pushToDrugDetailWithDrugID:dic.proId promotionId:dic.promotionId drugName:dic.proName];
}

- (void)pushToDrugDetailWithDrugID:(NSString *)drugId promotionId:(NSString *)promotionID drugName:(NSString *)drugName{
    //从健康常备内进入的
    if ([self.className isEqualToString:@"SubRegularDrugsViewController"]) {
        //渠道统计
        ChannerTypeModel *model=[ChannerTypeModel new];
        model.objRemark=drugName;
        model.objId=drugId;
        model.cKey=@"e_jkfa_product";
        [QWGLOBALMANAGER qwChannel:model];
    }else{
        //渠道统计
        ChannerTypeModel *model=[ChannerTypeModel new];
        model.objRemark=drugName;
        model.objId=drugId;
        model.cKey=@"e_zc_product";
        [QWGLOBALMANAGER qwChannel:model];
    }
    
    
    
    
    WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    
    MapInfoModel *modelMap = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
    WebDrugDetailModel *modelDrug = [WebDrugDetailModel new];
    modelDrug.modelMap = modelMap;
    modelDrug.proDrugID = drugId;
    modelDrug.promotionID = promotionID;
    WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
    modelLocal.modelDrug = modelDrug;
    modelLocal.typeLocalWeb = WebPageToWebTypeMedicine;
    [vcWebMedicine setWVWithLocalModel:modelLocal];
    [self.navigationController pushViewController:vcWebMedicine animated:YES];
}


#pragma table的代理-----------------------------------------


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


#pragma mark --------自定义弹出的tableView--------

@implementation TopTableView


static TopTableView *topview=nil;
+(TopTableView *)sharedTopview{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        topview=[[TopTableView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H)];
        
        topview.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        
    });
    return topview;
}


- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenTopView)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        
        self.mTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 360) style:UITableViewStylePlain];
        self.mTableView.delegate = self;
        self.mTableView.dataSource = self;
        [self addSubview:self.mTableView];
        self.mTableView.rowHeight = 40.0f;
        topCurrentPage=2;
        
        [self.mTableView addFooterWithTarget:self action:@selector(footerRereshingFactory)];
        self.mTableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
        self.mTableView.footerReleaseToRefreshText = @"松开加载更多数据了";
        self.mTableView.footerRefreshingText = @"正在帮你加载中";
        self.mTableView.footerNoDataText = kWarning44;
        
        historyRow = -1;
        currentRow = -1;
        
        
        [self.mTableView removeGestureRecognizer:tap];
        
    }
    return self;
}



-(void)setTopDataArr:(NSArray *)topDataArr{
    
    self.topDataSource = [NSMutableArray array];
    [self.topDataSource addObjectsFromArray:topDataArr];
    FetchProFactoryByClassModel *model = [FetchProFactoryByClassModel new];
    model.factory = @"全部生产厂家";
    [self.topDataSource insertObject:model atIndex:0];
    if(self.topDataSource.count <= 9){
        self.mTableView.frame = CGRectMake(0, 0, APP_W, self.mTableView.rowHeight * self.topDataSource.count);
    }
    
    [self.mTableView reloadData];
    
}



- (void)footerRereshingFactory{
    HttpClientMgr.progressEnabled = NO;
    //到达新的代理页面
    FetchProFactoryByClassModelR *requestModel = [FetchProFactoryByClassModelR new];
    requestModel.classId = self.topClassId;
    requestModel.currPage = @(topCurrentPage);
    requestModel.pageSize = @20;
    
    [Drug fetchProFactoryByClassWithParam:requestModel Success:^(id DFUserModel) {
        
        QueryProductClassModel *queryProductClassModel = (QueryProductClassModel *)DFUserModel;
        NSInteger count = self.topDataSource.count;
        [self.topDataSource addObjectsFromArray: queryProductClassModel.list];
        if (self.topDataSource.count > count) {
            topCurrentPage++;
            [self.mTableView reloadData];
        }else {
        self.mTableView.footer.canLoadMore=NO;
        }
        [self.mTableView footerEndRefreshing];
    } failure:^(HttpException *e) {
        [self.mTableView footerEndRefreshing];
        DebugLog(@"%@",e);
    }];
}



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
     DebugLog(@"%@", NSStringFromClass([touch.view class]));
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"] ) {
        return NO;
    }
    return YES;
}

- (void)hiddenTopView
{
  
    if ([self.delegate respondsToSelector:@selector(dismissMenuWithButton)]) {
        [self.delegate dismissMenuWithButton];
    }
}

#pragma toptable的代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.topDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentfier = @"cellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentfier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentfier];
        cell.textLabel.font = fontSystem(kFontS4);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == historyRow) {
        UIImage * image = [UIImage imageNamed:@"勾.png"];
        UIImageView * accessView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        accessView.image = image;
        cell.accessoryView = accessView;
        cell.textLabel.textColor = RGBHex(qwColor1);
    } else {
        cell.accessoryView = [[UIView alloc]init];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    FetchProFactoryByClassModel *model = self.topDataSource[indexPath.row];
    
    cell.textLabel.text = model.factory;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    currentRow = indexPath.row;
    NSIndexPath * historyPath = [NSIndexPath indexPathForRow:historyRow inSection:0];
    NSIndexPath * currentPath = [NSIndexPath indexPathForRow:currentRow inSection:0];
   
    UITableViewCell * historyCell = [tableView cellForRowAtIndexPath:historyPath];
    UITableViewCell * currentCell = [tableView cellForRowAtIndexPath:currentPath];
    
    UIImage * image = [UIImage imageNamed:@"勾.png"];
    UIImageView * accessView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    accessView.image = image;
    
    
    if (currentRow != historyRow) {
        
        historyCell.accessoryView = [[UIView alloc]init];
        historyCell.textLabel.textColor = [UIColor blackColor];
        currentCell.accessoryView = accessView;
        currentCell.textLabel.textColor = RGBHex(qwColor1);
    }
    historyRow = currentRow;
    QueryProductByClassModelR *queryProductByClassModelR = [QueryProductByClassModelR new];
    queryProductByClassModelR.classId = self.topClassId;
    queryProductByClassModelR.currPage = @1;
    queryProductByClassModelR.pageSize = @PAGE_ROW_NUM;
    
    //新增城市和省
    
    MapInfoModel *mapInfoModel = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
    queryProductByClassModelR.province=mapInfoModel==nil?@"江苏省":mapInfoModel.province;
    queryProductByClassModelR.city=mapInfoModel==nil?@"苏州市":mapInfoModel.city;
    
    if (indexPath.row != 0) {//不是全部商家
        FetchProFactoryByClassModel *model = self.topDataSource[indexPath.row];
        queryProductByClassModelR.factory = model.factory;
        self.topFactory=model.factory;
    }

    [Drug queryProductByClassWithParam:queryProductByClassModelR Success:^(id DFUserModel) {
        QueryProductClassModel *queryProductClassModel = (QueryProductClassModel *)DFUserModel;
        if ([self.delegate respondsToSelector:@selector(tableViewCellSelectedReturnData:withClassId:withIndexPath:withFactory:keyWord:)]) {
            FetchProFactoryByClassModel *fetchModel = self.topDataSource[indexPath.row];
            [self.delegate tableViewCellSelectedReturnData:queryProductClassModel.list
                                               withClassId:self.topClassId
                                             withIndexPath:indexPath
                                             withFactory:self.topFactory
                                                   keyWord:fetchModel.factory];
        }
        
        
    } failure:^(HttpException *e) {
        
    }];
}


@end
