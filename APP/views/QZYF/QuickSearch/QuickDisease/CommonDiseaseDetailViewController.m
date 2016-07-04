//
//  CommonDiseaseDetailViewController.m
//  APP
//
//  Created by Meng on 15/6/2.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "CommonDiseaseDetailViewController.h"
#import "ZhPMethod.h"
#import "DynamicHeightCell.h"
#import "Disease.h"
#import "Favorite.h"
#import "DiseaseTreatRuleMedicineViewController.h"
#import "LoginViewController.h"
#import "ConsultForFreeRootViewController.h"
#import "QCSlideSwitchView.h"
#import "RCDraggableButton.h"
#import "MessageBoxListViewController.h"
#import "WebDirectViewController.h"

static NSString * const descCellIdentifier = @"descCellIdentifier";
static NSString * const sectionCellIdentifier = @"sectionCellIdentifier";

@interface CommonDiseaseDetailViewController ()<UITableViewDataSource,UITableViewDelegate,QCSlideSwitchViewDelegate>
{
    CGFloat rowHeight;
    
    DiseaseTreatRuleMedicineViewController *currentViewController;
    
    RCDraggableButton *avatar;
}
@property (strong, nonatomic) ReturnIndexView *indexView;
@property (nonatomic, strong) UILabel *numLabel;   //数字角标
@property (nonatomic, strong) UILabel *redLabel;   //小红点
//head view
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *diseaseTitle;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
//head view action
- (IBAction)collectButtonClick:(UIButton *)sender;
//table view
@property (nonatomic ,strong) QCSlideSwitchView * slideSwitchView;
@property (weak, nonatomic) IBOutlet UITableView *diseaseTableView;

//foundation class
@property (nonatomic ,strong) NSMutableDictionary *diseaseDict;
@property (nonatomic ,strong) NSMutableArray *formulaListArray;
@property (nonatomic ,strong) NSMutableArray *formulaDetailArray;
@property (nonatomic ,strong) NSMutableArray *sliderViewControllers;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineConstraints;
@property (assign, nonatomic) int passNumber;


@end

@implementation CommonDiseaseDetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self initObj];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self initObj];
    }
    return self;
}

- (void)initObj
{
    self.diseaseDict = [NSMutableDictionary dictionary];
    self.formulaDetailArray = [NSMutableArray array];
    self.formulaListArray = [NSMutableArray array];
    self.sliderViewControllers = [NSMutableArray array];
}

- (void)awakeFromNib
{
    self.lineConstraints.constant = 0.5;
    [self.collectButton setBackgroundImage:[[UIImage imageNamed:@"ic_btn_collect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.shareButton setBackgroundImage:[[UIImage imageNamed:@"icon_share_new"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    rowHeight = 300;
    [self.diseaseTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:descCellIdentifier];
    [self.diseaseTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:sectionCellIdentifier];
    [self.diseaseTableView addStaticImageHeader];
    self.diseaseTableView.tableHeaderView = self.headView;
    self.diseaseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setupSliderViewControllers];
    [self setupSliderView];
    [self requestDiseaseInfomation];
//    [self createCosutomButton];
    [self.diseaseTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    self.diseaseTableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.diseaseTableView.footerReleaseToRefreshText = @"松开加载更多数据了";
    self.diseaseTableView.footerRefreshingText = @"正在帮你加载中";
    self.diseaseTableView.footerNoDataText = kWarning44;
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.passNumber = [QWGLOBALMANAGER updateRedPoint];
    
    ((QWBaseNavigationController *)self.navigationController).canDragBack = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    ((QWBaseNavigationController *)self.navigationController).canDragBack = YES;
}
-(void)popVCAction:(id)sender {
    [super popVCAction:sender];
    [QWGLOBALMANAGER statisticsEventId:@"x_jb_2_fh" withLable:@"疾病" withParams:nil];
}
- (void)createCosutomButton
{
    //增加咨询的按钮
    
    avatar = [[RCDraggableButton alloc] initWithFrame:CGRectMake(APP_W-68, SCREEN_H-142, 45, 45)];
    [avatar setBackgroundImage:[UIImage imageNamed:@"img_btn_advisory"] forState:UIControlStateNormal];
    [self.view addSubview:avatar];//加载图片
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(consultDoctor:)];
    [avatar addGestureRecognizer:singleTap];//点击图片事件
    [self.view addSubview:avatar];//加载图片
}

- (void)setupSliderViewControllers
{
    DiseaseTreatRuleMedicineViewController *treatMedicine = [[DiseaseTreatRuleMedicineViewController alloc] init];
    treatMedicine.navigationController = self.navigationController;
    treatMedicine.title = @"治疗用药";
    treatMedicine.requestType = @"1";
    treatMedicine.diseaseId = self.diseaseId;
    
    DiseaseTreatRuleMedicineViewController *healthFood = [[DiseaseTreatRuleMedicineViewController alloc] init];
    healthFood.navigationController = self.navigationController;
    healthFood.title = @"健康食品";
    healthFood.requestType = @"2";
    healthFood.diseaseId = self.diseaseId;
    
    DiseaseTreatRuleMedicineViewController *medicineGoods = [[DiseaseTreatRuleMedicineViewController alloc] init];
    medicineGoods.navigationController = self.navigationController;
    medicineGoods.title = @"医疗用品";
    medicineGoods.requestType = @"3";
    medicineGoods.diseaseId = self.diseaseId;
    
    currentViewController = treatMedicine;
    
    [self.sliderViewControllers addObject:treatMedicine];
    [self.sliderViewControllers addObject:healthFood];
    [self.sliderViewControllers addObject:medicineGoods];
}

- (void)setupSliderView
{
    self.slideSwitchView = [[QCSlideSwitchView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 500)];
    [self.slideSwitchView.rootScrollView setFrame:CGRectMake(0, 0, APP_W, self.slideSwitchView.rootScrollView.bounds.size.height)];
    self.slideSwitchView.tabItemNormalColor = RGBHex(qwColor7);
    [self.slideSwitchView.topScrollView setBackgroundColor:RGBHex(qwColor4)];
    self.slideSwitchView.tabItemSelectedColor = RGBHex(qwColor1);
    [self.slideSwitchView.rigthSideButton.titleLabel setFont:fontSystem(kFontS4)];
    self.slideSwitchView.slideSwitchViewDelegate = self;
    self.slideSwitchView.rootScrollView.scrollEnabled = YES;
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"blue_line_and_shadow"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    
    [self.slideSwitchView buildUI];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 34.5, APP_W, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [self.slideSwitchView.topScrollView addSubview:line];
}


- (void)viewInfoClickAction:(id)sender
{
    if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        [self removeInfoView];
        [self requestDiseaseInfomation];
    }
}


- (void)requestDiseaseInfomation
{
    DiseaseDetailIosR *detaileR=[DiseaseDetailIosR new];
    detaileR.diseaseId = self.diseaseId;
    
    [Disease getDiseaseDetailIOSWithParam:detaileR success:^(id obj) {
        [self.diseaseDict addEntriesFromDictionary:obj];
        
        self.diseaseTitle.text = self.diseaseDict[@"name"];
        
        [self.formulaListArray removeAllObjects];
        if ([self.diseaseDict[@"formulaList"] isKindOfClass:[NSArray class]]) {
            [self.formulaListArray addObjectsFromArray:self.diseaseDict[@"formulaList"]];
        }
        [self checkIsCollectOrNot];
        [self.diseaseTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    } failure:^(HttpException *e) {
        //217的修改点  cj
        if(QWGLOBALMANAGER.currentNetWork == kNotReachable){
            [self showInfoView:kWarning12 image:@"网络信号icon.png"];
            return;
        }else{
            if(e.errorCode!=-999){
                if(e.errorCode == -1001){
                    [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                }else{
                    [self showInfoView:kWarning39 image:@"ic_img_fail"];
                }
                
            }
            return;
        }
    }];
}

// opType: 1 查询; 2 写入; 3 取消;
- (void)checkIsCollectOrNot
{
    if (QWGLOBALMANAGER.loginStatus) {
        FavoriteCollectR *collectR = [FavoriteCollectR new];
        collectR.token = QWGLOBALMANAGER.configure.userToken;
        collectR.objId = self.diseaseId;
        collectR.objType = @"3";
        collectR.method = @"1";
        [Favorite collectWithParam:collectR success:^(id DFUserModel) {
            CancleResult *model=(CancleResult *)DFUserModel;
            if ([model.result isEqualToString:@"1"]) {
                [self.collectButton setBackgroundImage:[[UIImage imageNamed:@"ic_btn_have been collection"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            }else if([model.result isEqualToString:@"0"]){
                [self.collectButton setBackgroundImage:[[UIImage imageNamed:@"ic_btn_collect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
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

#pragma mark section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 35.0f;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        return _slideSwitchView.topScrollView;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 10)];
        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 0.5)];
        topLine.backgroundColor = RGBHex(qwColor10);
        [v addSubview:topLine];
        
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, v.frame.origin.y + v.frame.size.height-0.5, APP_W, 0.5)];
        bottomLine.backgroundColor = RGBHex(qwColor10);
        [v addSubview:bottomLine];
        
        v.backgroundColor = self.view.backgroundColor;
        return v;
    }
    return 0;
}


#pragma mark row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString *desc = self.diseaseDict[@"desc"];
        if (!StrIsEmpty(desc)) {
            CGSize adjustSize = getTempTextSize(desc, fontSystem(kFontS4), 270 +2);
            if (adjustSize.height > 60) {
                return 60;
            }else if(adjustSize.height < 20){
                return 20 + 20;
            }else{
                return adjustSize.height + 20;
            }
        }else{
            return 20;
        }
    }else if (indexPath.section == 1){
        return rowHeight;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [self.diseaseTableView dequeueReusableCellWithIdentifier:descCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSString *desc = self.diseaseDict[@"desc"];
        if (!StrIsEmpty(desc)) {
            cell.textLabel.text = desc;
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.font = fontSystem(kFontS4);
            cell.textLabel.textColor = RGBHex(qwColor6);
            CGSize adjustSize = getTempTextSize(self.diseaseDict[@"desc"], fontSystem(kFontS4), 270 +2);
            CGFloat x = cell.textLabel.frame.origin.x;
            CGFloat y = cell.textLabel.frame.origin.y;
            if (adjustSize.height > 60) {
                [cell.textLabel setFrame:CGRectMake(x-2, y , APP_W-21 +2, 60)];
            }else if(adjustSize.height < 20){
                [cell.textLabel setFrame:CGRectMake(x-2, y , APP_W-21 +2, 20)];
            }else{
                [cell.textLabel setFrame:CGRectMake(x-2, y , APP_W-21 +2, adjustSize.height)];
            }
        }else{
            
        }
        
        return cell;
    }else if (indexPath.section == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sectionCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:self.slideSwitchView];
        return cell;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSString *diseaseId = self.diseaseId;
        NSString *title = [NSString stringWithFormat:@"%@详情",self.title];
        WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
        vcWebDirect.showConsultBtn = YES;
        
        WebDiseaseDetailModel *modelDisease = [[WebDiseaseDetailModel alloc] init];
        modelDisease.diseaseId = diseaseId;
        
        WebDirectLocalModel *modelLocal = [[WebDirectLocalModel alloc] init];
        modelLocal.modelDisease = modelDisease;
        modelLocal.title = title;
        modelLocal.typeLocalWeb = WebPageToWebTypeDisease;
        [vcWebDirect setWVWithLocalModel:modelLocal];
        
        NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
        [QWGLOBALMANAGER statisticsEventId:@"x_jb_3" withLable:@"疾病" withParams:nil];
        vcWebDirect.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vcWebDirect animated:YES];
        
    }
}

#pragma mark QCSliderView

- (NSUInteger)numberOfTab:(QCSlideSwitchView *)view
{
    return self.sliderViewControllers.count;
}
- (UIViewController *)slideSwitchView:(QCSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    return self.sliderViewControllers[number];
}

- (void)slideSwitchView:(QCSlideSwitchView *)view willselectTab:(NSUInteger)number
{
    self.diseaseTableView.footerNoDataText = kWarning44;
    [self.diseaseTableView.footer setDiseaseCanLoadMore:YES];
    currentViewController = self.sliderViewControllers[number];
    [currentViewController currentViewSelected:^(CGFloat height) {
        rowHeight = height;
        [self.slideSwitchView setFrame:CGRectMake(0, 0, APP_W, rowHeight)];
        [self.slideSwitchView.rootScrollView setFrame:CGRectMake(0, 0, APP_W, rowHeight)];
        [self.diseaseTableView reloadData];
    }];
}

- (void)slideSwitchView:(QCSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    
}

- (void)footerRereshing
{
    [currentViewController footerRereshing:^(CGFloat height) {
        rowHeight = height;
        [self.slideSwitchView.rootScrollView setFrame:CGRectMake(0, 0, APP_W, rowHeight)];
        [self.slideSwitchView setFrame:CGRectMake(0, 0, APP_W, rowHeight)];
        [self.diseaseTableView reloadData];
        [self.diseaseTableView footerEndRefreshing];
    }:^(BOOL canLoadMore) {
    
        if (canLoadMore == NO) {
            [self.diseaseTableView.footer setCanLoadMore:canLoadMore];
        }
    }:^{
        [self.diseaseTableView footerEndRefreshing];
    }];
}

- (IBAction)collectButtonClick:(UIButton *)sender {
    if (!QWGLOBALMANAGER.loginStatus) {
        LoginViewController * login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        login.isPresentType = YES;
        login.parentNavgationController = self.navigationController;
        UINavigationController * nav = [[QWBaseNavigationController alloc] initWithRootViewController:login];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    FavoriteCollectR *collectR=[FavoriteCollectR new];
    collectR.token=QWGLOBALMANAGER.configure.userToken;
    collectR.objId= self.diseaseId;
    collectR.objType=@"3";
    collectR.method=@"1";//检查对象是否已经收藏
    
    [Favorite collectWithParam:collectR success:^(id DFUserModel) {
        
        CancleResult *model=(CancleResult *)DFUserModel;
        if ([model.apiStatus intValue]==1001003) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:ALERT_MESSAGE delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alertView.tag = 999;
            alertView.delegate = self;
            [alertView show];
            return;
        }else if([model.apiStatus intValue]==0){
            if([model.result isEqualToString:@"1"]){//已经收藏
                collectR.method = @"3";
                [Favorite collectWithParam:collectR success:^(id DFUserModel) {
                    CancleResult *subModel=(CancleResult *)DFUserModel;
                    if ([subModel.result isEqualToString:@"4"]) {//取消收藏成功
                        [self showSuccess:@"取消收藏成功"];
                        [self.collectButton setBackgroundImage:[[UIImage imageNamed:@"ic_btn_collect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                    }else if ([subModel.result isEqualToString:@"5"]) {//取消收藏失败
                        [self showError:subModel.apiMessage];
                        return ;
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
                
            }else if([model.result isEqualToString:@"0"]){
                collectR.method = @"2";
                [Favorite collectWithParam:collectR success:^(id DFUserModel) {
                    CancleResult *subModel=(CancleResult *)DFUserModel;
                    if ([subModel.result isEqualToString:@"2"]) {//收藏成功
                        [self showSuccess:@"添加收藏成功"];
                        [self.collectButton setBackgroundImage:[[UIImage imageNamed:@"ic_btn_have been collection"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                    }else if ([subModel.result isEqualToString:@"3"]) {//收藏失败
                        [self showError:subModel.apiMessage];
                        return ;
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
    }failure:^(HttpException *e) {
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

//跳转到咨询页面
- (void)consultDoctor:(id)sender {
    
    ConsultForFreeRootViewController *consultViewController = [[UIStoryboard storyboardWithName:@"ConsultForFree" bundle:nil] instantiateViewControllerWithIdentifier:@"ConsultForFreeRootViewController"];
    consultViewController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:consultViewController animated:YES];
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
