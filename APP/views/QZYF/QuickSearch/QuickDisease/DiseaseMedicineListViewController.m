//
//  DiseaseMedicineListViewController.m
//  quanzhi
//
//  Created by ZhongYun on 14-6-20.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "DiseaseMedicineListViewController.h"
#import "Categorys.h"
#import "Drug.h"
#import "ZhPMethod.h"
#import "MJRefresh.h"
#import "Factory.h"
#import "MedicineListCell.h"
#import "ReturnIndexView.h"
#import "LoginViewController.h"
#import "MessageBoxListViewController.h"
#import "WebDirectViewController.h"


@interface DiseaseMedicineListViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView* m_table;
    NSMutableArray* m_data;
    int m_currPage;
    BOOL bisSells;
    
}

@property (nonatomic, strong) ReturnIndexView *indexView;
@property (nonatomic, strong) UILabel *numLabel;   //数字角标
@property (nonatomic, strong) UILabel *redLabel;   //小红点
@property (assign, nonatomic) int passNumber;

@end

@implementation DiseaseMedicineListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        if (iOSv7 && self.view.frame.origin.y==0) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
        }    
        m_data = [[NSMutableArray alloc] init];
        m_currPage = 1;
        bisSells = NO;
        
        m_table = [[UITableView alloc] initWithFrame:RECT(0, 0, APP_W, APP_H-NAV_H)
                                               style:UITableViewStylePlain];
        m_table.backgroundColor = [UIColor clearColor];
        m_table.separatorStyle = UITableViewCellSeparatorStyleNone;
        m_table.bounces = YES;
        m_table.rowHeight = 90;
        m_table.delegate = self;
        m_table.dataSource = self;
        [self.view addSubview:m_table];
        
         [m_table addFooterWithTarget:self action:@selector(footerRereshing)];
        m_table.footerPullToRefreshText = @"上拉可以加载更多数据了";
        m_table.footerReleaseToRefreshText = @"松开加载更多数据了";
        m_table.footerRefreshingText = @"正在帮你加载中";
        m_table.footerNoDataText = kWarning44;
       
    }
    return self;
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




- (void)footerRereshing
{
     HttpClientMgr.progressEnabled = NO;
    [self loadData];
}

- (void)setParams:(NSDictionary *)params
{
    _params = params;
    [self loadData];
}

- (void)loadData
{
    bisSells = NO;
    MapInfoModel *mapInfoModel = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
    if (self.params[@"formulaId"]) {
        DiseaseFormulaPruductR *formula=[DiseaseFormulaPruductR new];
        formula.diseaseId=self.params[@"diseaseId"];
        formula.formulaId=self.params[@"formulaId"];
        formula.currPage=StrFromInt(m_currPage);//@(m_currPage);
        formula.pageSize=StrFromInt(PAGE_ROW_NUM);//@(PAGE_ROW_NUM);
        //新增城市和省

        formula.province=mapInfoModel==nil?@"江苏省":mapInfoModel.province;
        formula.city=mapInfoModel==nil?@"苏州市":mapInfoModel.city;
        formula.v = @"2.0";
        
        HttpClientMgr.progressEnabled = NO;
        [Drug queryDiseaseFormulaProductListWithParam:formula Success:^(id DFUserModel) {
            DiseaseFormulaPruduct *formup=DFUserModel;
            if(formup.list.count>0){
                [m_data addObjectsFromArray:formup.list];
                [m_table reloadData];
                m_currPage ++;
            }else{
            m_table.footer.canLoadMore=NO;
            }
            
            
            
            [m_table footerEndRefreshing];
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
    } else if (self.params[@"type"]) {//治疗用药
        DiseaseProductListR *productr=[DiseaseProductListR new];
        productr.diseaseId=self.params[@"diseaseId"];
        productr.type=myFormat(@"%@", self.params[@"type"]);
        productr.currPage=StrFromInt(m_currPage);
        productr.pageSize=StrFromInt(PAGE_ROW_NUM);
        productr.v = @"2.0";
        
        //新增城市和省
        
        productr.province=mapInfoModel==nil?@"江苏省":mapInfoModel.province;
        productr.city=mapInfoModel==nil?@"苏州市":mapInfoModel.city;
        
        [Drug queryDiseaseProductListWithParam:productr Success:^(id DFUserModel) {
            DiseaseFormulaPruduct *productModel = (DiseaseFormulaPruduct *)DFUserModel;
            
            if(productModel.list.count>0){
                [m_data addObjectsFromArray:productModel.list];
                [m_table reloadData];
                m_currPage ++;
            }else{
                m_table.footer.canLoadMore=NO;
            }
            
            
            [m_table footerEndRefreshing];
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

#pragma mark - MJRefreshBaseViewDelegate


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return m_table.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [m_table cellForRowAtIndexPath:indexPath].selected = NO;
    DiseaseFormulaPruductclass *model = (DiseaseFormulaPruductclass*)m_data[indexPath.row];
    [self pushToDrugDetailWithDrugID:model.proId promotionId:model.promotionId];
}

- (void)pushToDrugDetailWithDrugID:(NSString *)drugId promotionId:(NSString *)promotionID{
    
    WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    MapInfoModel *modelMap = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
    WebDrugDetailModel *modelDrug = [WebDrugDetailModel new];
    modelDrug.modelMap = modelMap;
    modelDrug.proDrugID = drugId;
    modelDrug.promotionID = promotionID;
    WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
    modelLocal.typeLocalWeb = WebPageToWebTypeMedicine;
    modelLocal.modelDrug = modelDrug;
    [vcWebMedicine setWVWithLocalModel:modelLocal];
    [self.navigationController pushViewController:vcWebMedicine animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return m_data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *cellIdentifier = @"cellIdentifier";
    MedicineListCell * cell = (MedicineListCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MedicineListCell" owner:self options:nil][0];
        cell.separatorInset = UIEdgeInsetsZero;
        UIView *bkView = [[UIView alloc]initWithFrame:cell.frame];
        bkView.backgroundColor = RGBHex(qwColor10);
        cell.selectedBackgroundView = bkView;
    }
    DiseaseFormulaPruductclass *model = (DiseaseFormulaPruductclass*)m_data[indexPath.row];
    [cell setFoumalCell:model];
//    if(!model.gift) {
//        [cell.giftLabel removeFromSuperview];
//    }
//    if(!model.discount) {
//        [cell.foldLabel removeFromSuperview];
//    }
//    if(!model.voucher) {
//        [cell.pledgeLabel removeFromSuperview];
//    }
//    if(!model.special) {
//        [cell.specialLabel removeFromSuperview];
//    }
    [cell.giftLabel removeFromSuperview];
    [cell.foldLabel removeFromSuperview];
    [cell.pledgeLabel removeFromSuperview];
    [cell.specialLabel removeFromSuperview];
    return cell;
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
