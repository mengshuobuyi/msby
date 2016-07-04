//
//  PurchaseViewController.m
//  APP
//
//  Created by qw_imac on 15/11/9.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "PurchaseViewController.h"
#import "QWGlobalManager.h"
#import "Activity.h"
#import "ConfigInfo.h"
#import "LoginViewController.h"
#import "SVProgressHUD.h"
#import "WebDirectViewController.h"
#import "PickPromotionSuccessViewController.h"
@interface PurchaseViewController ()
{
    PurchaseHeaderView *headerView;
    NSTimer *timer;
    NSMutableArray *grabProductList;
    NSString *activityStatus;
    NSString *activityId;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *topView;
@end

@implementation PurchaseViewController
static NSString *cellIdentifier = @"PurchaseNewCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"抢购";
    grabProductList = [NSMutableArray array];
    activityStatus = [[NSString alloc]init];
    activityId = [[NSString alloc]init];
    [self setupUI];

    [self.tableView registerNib:[UINib nibWithNibName:@"PurchaseNewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];   
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [self showInfoInView:self.tableView offsetSize:0 text:kWarning12 image:@"网络信号icon"];
        [self.topView removeFromSuperview];
    }else {
        if (QWGLOBALMANAGER.weChatBusiness) {
            [self queryRushProductList];
        }else {
            [self queryGrabProductList];
        }         //请求抢购商品数据
        if (self.type != PurchaseStatusEnd && !timer && self.time > 0) {
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeRun) userInfo:nil repeats:YES];
        }
    }
}

-(void)timeRun {                                //顶部倒计时
    self.time --;
    [headerView updateUI:self.time];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

}

-(void)popVCAction:(id)sender {
    [super popVCAction:sender];
    if (timer) {
        [timer invalidate];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupUI {
    self.tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 40 , APP_W, [[UIScreen mainScreen] bounds].size.height - 64 -40) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.scrollEnabled = YES;
    [self.tableView addStaticImageHeader];
    //抢购倒计时页面
    headerView = [PurchaseHeaderView instancePurchaseHeaderView];
    [headerView setupPurchaseHeaderView:self.type WithTime:self.time];
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0 , APP_W, 38 )];
    [self.topView addSubview:headerView];
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0 , APP_W, 8 )];
    view.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = view;
    
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
   
}



#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return grabProductList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return [PurchaseNewCell returnCellHeight];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PurchaseNewCell *cell = (PurchaseNewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
   
    cell.purchaseBtn.tag = indexPath.row;
    if (QWGLOBALMANAGER.weChatBusiness) {
        RushProductVo *grab = grabProductList[indexPath.row];
        [cell setRushCell:grab With:activityStatus];
    }else {
        GrabPromotionProductVo *grab = grabProductList[indexPath.row];
        [cell setCell:grab With:activityStatus];
    }
        if ([activityStatus intValue] == 1) {    //活动未开始，点击btn跳转H5详情页面
            if (QWGLOBALMANAGER.weChatBusiness) {
                [cell.purchaseBtn addTarget:self action:@selector(runToPurchaseDetail:) forControlEvents:UIControlEventTouchUpInside];
            }else {
                [cell.purchaseBtn addTarget:self action:@selector(runToDetial:) forControlEvents:UIControlEventTouchUpInside];
            }
        }else if([activityStatus intValue] == 2){ //活动正在抢
            if (QWGLOBALMANAGER.weChatBusiness) {//开通微商点击抢购进入抢购详情页
                [cell.purchaseBtn addTarget:self action:@selector(runToPurchaseDetail:) forControlEvents:UIControlEventTouchUpInside];
            }else {//未开通以前的逻辑
                [cell.purchaseBtn addTarget:self action:@selector(purchase:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        return cell;
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"第几个"] = [NSString stringWithFormat:@"%d",indexPath.row];
//    GrabPromotionProductVo *productVo = grabProductList[indexPath.row];
//    tdParams[@"商品名"] = productVo.proName;
//    tdParams[@"优惠ID"] = productVo.promotionId;
    //这边要区分微商非微商model问题
    [QWGLOBALMANAGER statisticsEventId:@"x_qg_sp" withLable:@"抢购" withParams:tdParams];
    UIButton *btn = (UIButton *)[self.view viewWithTag:indexPath.row];
    if (QWGLOBALMANAGER.weChatBusiness) {
        [self runToPurchaseDetail:btn];
    }else {
        [self pushIntoWebViewWith:grabProductList[indexPath.row]];
    }
}
#pragma mark - 倒计时更新

-(void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj {
    if (type == NotifSanpUpCountDonwUpdate) {
        NSMutableDictionary *dic = (NSMutableDictionary *)data;
        NSNumber *time = dic[@"timestamp"];
        NSNumber *status = dic[@"status"];
        self.type = [status intValue];
        self.time = [time longLongValue];
        [headerView setupPurchaseHeaderView:self.type WithTime:self.time];
        if (QWGLOBALMANAGER.weChatBusiness) {
            [self queryRushProductList];
        }else {
            [self queryGrabProductList];
        }
        [self.tableView reloadData];
    }
}

#pragma mark - networking

//请求抢购商品数据

-(void)queryGrabProductList {
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
       [SVProgressHUD showErrorWithStatus:kWarning12 duration:0.8];
       return;
    }
    [[QWGlobalManager sharedInstance] readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
        GrabActivityModelR *modelR = [GrabActivityModelR new];
        if(mapInfoModel){
            modelR.cityName = mapInfoModel.city;
        }else{
            modelR.cityName = @"苏州市";
        }

        if (QWGLOBALMANAGER.loginStatus) {
            modelR.token = QWGLOBALMANAGER.configure.userToken;
        }
        
        modelR.grabActivityId = self.grabActivityId;
        [Activity getGrabPromotionProduct:modelR success:^(GrabProductListVo *responModel) {
          
            if ([responModel.apiStatus intValue] == 1 || [responModel.apiStatus intValue] == 2 || [responModel.apiStatus intValue] == 3) {
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responModel.apiMessage] duration:0.8];
                return;
            }
            if (responModel.productList && responModel.productList.count != 0) {
                activityStatus = responModel.activityStatus;
                activityId = responModel.activityId;
                grabProductList = [NSMutableArray arrayWithArray:responModel.productList];
                [self.tableView reloadData];
            }
        } failure:^(HttpException *e) {
            if (e.errorCode != -999) {
                if(e.errorCode == -1001){
                    [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                }else{
                    [self showInfoView:kWarning39 image:@"ic_img_fail"];
                }
            }
        }];
    }];
}
//微商情况下请求数据
-(void)queryRushProductList {
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [SVProgressHUD showErrorWithStatus:kWarning12 duration:0.8];
        return;
    }
    QueryRushProductR *modelR = [QueryRushProductR new];
    if (QWGLOBALMANAGER.configure.userToken) {
        modelR.token = QWGLOBALMANAGER.configure.userToken;
    }
    modelR.grabActivityId = _grabActivityId;
       [Activity getRushProductList:modelR success:^(GrabActivityRushVo *model) {
        activityStatus = model.activityStatus;
        activityId = model.activityId;
        grabProductList = [NSMutableArray arrayWithArray:model.productList];
        [self.tableView reloadData];

    } failure:^(HttpException *e) {
        if (e.errorCode != -999) {
            if(e.errorCode == -1001){
                [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
            }else{
                [self showInfoView:kWarning39 image:@"ic_img_fail"];
            }
        }

    }];
}
//抢购btn 抢购动作

-(void)purchase:(UIButton *)btn{
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [SVProgressHUD showErrorWithStatus:kWarning12 duration:0.8];
        return;
    }
    [[QWGlobalManager sharedInstance] readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
        PurchaseGrabProductR *modelR = [PurchaseGrabProductR new];
        if(mapInfoModel){
            modelR.cityName = mapInfoModel.city;
        }else{
            modelR.cityName = @"苏州市";
        }
        if (!QWGLOBALMANAGER.loginStatus) {
            LoginViewController * login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            login.isPresentType = YES;
            login.parentNavgationController = self.navigationController;
            UINavigationController * nav = [[QWBaseNavigationController alloc] initWithRootViewController:login];
            [self presentViewController:nav animated:YES completion:nil];
            return;
        }
            
        modelR.token = QWGLOBALMANAGER.configure.userToken;

        GrabPromotionProductVo *vo = grabProductList[btn.tag];
        modelR.pid = vo.promotionId;
        modelR.channel = 1 ;            //抢购渠道1.app 2.H5
        
        NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
        tdParams[@"抢购类型"]=@"非微商抢购";
        tdParams[@"商品名"] =vo.proName;
        tdParams[@"第几个"] = [NSString stringWithFormat:@"%i",btn.tag];
        [QWGLOBALMANAGER statisticsEventId:@"x_qg_sp" withLable:@"抢购" withParams:tdParams];
            
        [Activity postPurchaseProduct:modelR success:^(PurchaseGrabProduct *responModel) {
            if (responModel.apiStatus.intValue == 1 || responModel.apiStatus.intValue == 2) {
                [SVProgressHUD showErrorWithStatus:responModel.apiMessage duration:0.8];
            }else {
                //服务器未返回成功的提示语,默认不显示
//                [SVProgressHUD showSuccessWithStatus:responModel.apiMessage duration:0.8];
                PickPromotionSuccessViewController *viewController = [[PickPromotionSuccessViewController alloc]initWithNibName:@"PickPromotionSuccessViewController" bundle:nil];
                viewController.proDrugId = responModel.proDrugId;
                [self.navigationController pushViewController:viewController animated:YES];
                }
            } failure:^(HttpException *e) {
                if (e.errorCode != -999) {
                    if(e.errorCode == -1001){
                        [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                    }else{
                        [self showInfoView:kWarning39 image:@"ic_img_fail"];
                    }
                }
            }];
        }];

}
//开通微商走新流程，先去抢购详情页
-(void)runToPurchaseDetail:(UIButton *)btn {
    WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    RushProductVo *vo = grabProductList[btn.tag];
    WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
    WebDrugDetailModel *modelDrug = [WebDrugDetailModel new];
    modelLocal.typeLocalWeb = WebLocalTypeToPurchaseDetail;
    modelDrug.proDrugID = vo.proId;
    modelDrug.activityID = activityId;
    modelLocal.modelDrug = modelDrug;
    [vcWebMedicine setWVWithLocalModel:modelLocal];
    
    [self.navigationController pushViewController:vcWebMedicine animated:YES];
}
#pragma mark - 跳转H5
//抢购详情页面
-(void)runToDetial:(UIButton *)btn {
    [self pushIntoWebViewWith:grabProductList[btn.tag]];
}
//跳转H5页面
-(void)pushIntoWebViewWith:(GrabPromotionProductVo *)vo  {
    
    WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    
    [[QWGlobalManager sharedInstance] readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
        
        WebDrugDetailModel *modelDrug = [WebDrugDetailModel new];
        modelDrug.modelMap = mapInfoModel;
        modelDrug.proDrugID = vo.proId;
        modelDrug.promotionID = vo.promotionId;
        modelDrug.activityID = activityId;
        WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
        modelLocal.modelDrug = modelDrug;
        modelLocal.typeLocalWeb = WebPageToWebTypeMedicine;
        [vcWebMedicine setWVWithLocalModel:modelLocal];
        vcWebMedicine.isComeFromPur = YES;
        [self.navigationController pushViewController:vcWebMedicine animated:YES];
        
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
