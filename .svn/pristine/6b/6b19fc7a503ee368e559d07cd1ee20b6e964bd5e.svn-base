//
//  BranchChooseViewController.m
//  APP
//  选择药房，用于第一次启动App且定位成功使用
//  Created by 李坚 on 16/6/13.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "CouponBranchChooseViewController.h"
#import "CouponBranchTableViewCell.h"
#import "CouponTicketDetailPlaceholderCell.h"
#import "ChangeStoreAlertView.h"

static NSString *const CouponBranchTableViewCellIdentifier = @"CouponBranchIdef";
static NSString * const CouponTicketDetailPlaceholderCellIdentifier = @"CouponTicketDetailPlaceholderCell";
@interface CouponBranchChooseViewController ()<UITableViewDelegate,UITableViewDataSource>{
    int curPharmacyPage;
}

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataArr;


@end

@implementation CouponBranchChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择药房";
    
    _dataArr = [NSMutableArray array];
    curPharmacyPage=1;
    _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H - NAV_H)];
    [_mainTableView registerNib:[UINib nibWithNibName:@"CouponBranchTableViewCell" bundle:nil] forCellReuseIdentifier:CouponBranchTableViewCellIdentifier];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"CouponTicketDetailPlaceholderCell" bundle:nil] forCellReuseIdentifier:CouponTicketDetailPlaceholderCellIdentifier];
    _mainTableView.dataSource = self;
    _mainTableView.delegate = self;
    _mainTableView.backgroundColor=RGBHex(qwColor21);
    [_mainTableView addStaticImageHeader];
    [_mainTableView addFooterWithTarget:self action:@selector(refreshData)];
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mainTableView];

    [self loadBranchsData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)loadBranchsData{
    
    [[QWGlobalManager sharedInstance]readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
        CouponNewBranchSuitableModelR *modelR = [CouponNewBranchSuitableModelR new];
        modelR.couponId = self.couponId;
        modelR.page = [NSString stringWithFormat:@"%d",curPharmacyPage];
        modelR.pageSize = @"10";
        if(mapInfoModel == nil){
            modelR.lng = @"120.730435";
            modelR.lat = @"31.273391";
            modelR.city = @"苏州";
        }else{
            modelR.lng = [NSString stringWithFormat:@"%f",mapInfoModel.location.coordinate.longitude];
            modelR.lat = [NSString stringWithFormat:@"%f",mapInfoModel.location.coordinate.latitude];
            modelR.city = mapInfoModel.city;
        }
        modelR.branchId=[QWGLOBALMANAGER getMapBranchId];
        
        [Coupon getNewCouponPharmacy:modelR success:^(id obj) {
            
            CouponBranchVoListModel *couponPharModel = (CouponBranchVoListModel *)obj;
            
            [_dataArr addObjectsFromArray:couponPharModel.suitableBranchs];
            
            if(couponPharModel.suitableBranchs.count>0){
                [_mainTableView reloadData];
                curPharmacyPage++;
            }else{
                _mainTableView.footer.canLoadMore=NO;
            }
            [_mainTableView footerEndRefreshing];
              
        } failure:^(HttpException *e) {
            if(e.errorCode!=-999){
                if(e.errorCode == -1001){
                    [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                }else{
                    [self showInfoView:kWarning39 image:@"ic_img_fail"];
                }
                
            }
            [_mainTableView.footer endRefreshing];
        }];
    }];
 
}

- (void)refreshData{
    HttpClientMgr.progressEnabled = NO;
    [self loadBranchsData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        NSString *strSuitablePhar = @"选择适用药房";
        return [self getPlaceHolderCellWithText:strSuitablePhar isShowImg:NO isStatus:@"3"];
    }else{
        CouponBranchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CouponBranchTableViewCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CouponBranchVoModel *model = _dataArr[indexPath.row-1];
        [cell setCell:model];
        return cell;
    }
    
    
}

- (CouponTicketDetailPlaceholderCell *)getPlaceHolderCellWithText:(NSString *)str isShowImg:(BOOL)isShow isStatus:(NSString*)isStatus
{
    //  1正常的title  2居中的描述 3灰色的title
    CouponTicketDetailPlaceholderCell *cell = (CouponTicketDetailPlaceholderCell *)[self.mainTableView dequeueReusableCellWithIdentifier:CouponTicketDetailPlaceholderCellIdentifier];
    if ([isStatus isEqualToString:@"3"]){
        cell.imgArrow.hidden = !isShow;
        cell.lblContent.text = str;
        cell.lblContent.font = fontSystem(kFontS5);
        cell.lblContent.textColor = RGBHex(qwColor8);
        cell.backView.backgroundColor=RGBHex(qwColor21);
        cell.centerLable.hidden=YES;
        cell.lblContent.hidden = NO;
    }
    
    return cell;
}


#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row==0){
        return 44.0f;
    }else{
        return [CouponBranchTableViewCell getCellHeight:nil];
    
    }
    
   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CouponBranchVoModel *model = _dataArr[indexPath.row-1];
    //弹框alert
    ChangeStoreAlertView *alert=[ChangeStoreAlertView instance];
    alert.alertTitle.text = model.branchName;
    alert.blockDirect = ^(BOOL success) {
        if(!StrIsEmpty(model.branchId)){
            [QWGLOBALMANAGER setMapBranchId:model.branchId branchName:model.branchName];
        }
        [QWGLOBALMANAGER postNotif:NotifChangeBranchFromHomePage data:model.branchName object:nil];
        QWGLOBALMANAGER.tabBar.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:YES];

    };
    alert.blockCancel = ^(BOOL cancel) {
    };
    [alert show];

}


@end
