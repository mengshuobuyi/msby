//
//  MallCouponSuccessViewController.m
//  APP
//  优惠券领取成功页面  3.0.0新增 下方有药房列表
//  Created by 李坚 on 16/1/27.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "MallCouponSuccessViewController.h"
#import "Coupon.h"
#import "SVProgressHUD.h"
#import "myConsultTableViewCell.h"
#import "CouponUseViewController.h"

static NSString *const ConsultCellIdentifier = @"myConsultTableViewCell";


@interface MallCouponSuccessViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSUInteger currPage;
    NSString *branchCount;
}
@property (strong, nonatomic) IBOutlet UIView *successHeadView;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *suitableBranchArr;


@end

@implementation MallCouponSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"领取成功";
    currPage = 1;
    _suitableBranchArr = [NSMutableArray array];
    [_mainTableView registerNib:[UINib nibWithNibName:ConsultCellIdentifier bundle:nil] forCellReuseIdentifier:ConsultCellIdentifier];
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupMicroMallRequest];
    [_mainTableView addFooterWithCallback:^{
        currPage += 1;
        [self setupMicroMallRequest];
    }];
}

- (void)popVCAction:(id)sender
{
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    [QWGLOBALMANAGER statisticsEventId:@"x_yhq_fh" withLable:@"优惠券详情" withParams:tdParams];
    [super popVCAction:sender];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupMicroMallRequest{
    
    [QWGLOBALMANAGER readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) { //add by jxb
        GetOnlineCouponModelR *modelR = [GetOnlineCouponModelR new];
        modelR.couponId = self.couponId;
        modelR.lng = @(mapInfoModel.location.coordinate.longitude);
        modelR.lat = @(mapInfoModel.location.coordinate.latitude);
        modelR.page = [NSString stringWithFormat:@"%d",currPage];
        modelR.pageSize = @"10";
        if(currPage == 1){
            HttpClientMgr.progressEnabled = YES;
        }else{
            HttpClientMgr.progressEnabled = NO;
        }
        [Coupon PickSuccessSuitableBranchs:modelR success:^(SuitableMicroMallBranchListVo *model) {
            
            if([model.apiStatus intValue] == 0){
               
                if(currPage == 1){
                    _successHeadView.frame = CGRectMake(0, 0, APP_W, 168.0f);
                    _mainTableView.tableHeaderView = _successHeadView;
                    [_suitableBranchArr removeAllObjects];
                }
                if(model.suitableBranchs.count > 0){
                    branchCount = model.suitableBranchCount;
                    [_suitableBranchArr addObjectsFromArray:model.suitableBranchs];
                    [_mainTableView reloadData];
                    [_mainTableView.footer endRefreshing];
                }else{
                    [_mainTableView.footer endRefreshing];
                    [_mainTableView.footer setCanLoadMore:NO];
                }
            }else{
                
                
            }
        } failure:^(HttpException *e) {
            [_mainTableView.footer endRefreshing];
            if(e.errorCode!=-999){
                if(e.errorCode == -1001){
                    [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                }else{
                    [self showInfoView:kWarning39 image:@"ic_img_fail"];
                }
            }
        }];
    }];
}

- (UIView *)setupHeadView:(int)branchCount{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 37.0f)];
    view.backgroundColor = RGBHex(qwColor4);
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, APP_W - 30, 37.0f)];
    label.font = fontSystem(kFontS4);
    label.textColor = RGBHex(qwColor6);
    label.text = [NSString stringWithFormat:@"适用药房（%d）",branchCount];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 36.5, APP_W, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [view addSubview:label];
    [view addSubview:line];
    
    return view;
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 37.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self setupHeadView:[branchCount intValue]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _suitableBranchArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [myConsultTableViewCell getCellHeight:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    myConsultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ConsultCellIdentifier];
    
    cell.useButton.hidden = NO;
    cell.useButton.tag = indexPath.row;
    [cell.useButton addTarget:self action:@selector(useCoupon:) forControlEvents:UIControlEventTouchUpInside];
    SuitableMicroMallBranchVo *VO = _suitableBranchArr[indexPath.row];
    cell.branchName.text = VO.branchName;
    [cell.starView displayRating:[VO.stars floatValue]/2.0f];
    cell.address.text = VO.address;
    cell.distance.text = VO.distance;
    
    return cell;
}

- (void)useCoupon:(UIButton *)btn{
    
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"是否开通微商"]=QWGLOBALMANAGER.weChatBusiness ? @"是" : @"否";
    [QWGLOBALMANAGER statisticsEventId:@"x_yhq_sy" withLable:@"优惠券详情" withParams:tdParams];
    
    SuitableMicroMallBranchVo *VO = _suitableBranchArr[btn.tag];
    
    if(StrIsEmpty(VO.branchId)){
        [SVProgressHUD showErrorWithStatus:@"没有branchId无法跳转"];
        return;
    }
    
    if([VO.type intValue] == 3){
        if([self.CouponScope integerValue] == 7){
            [self useMethod];
        }else{

            [QWGLOBALMANAGER pushBranchDetail:VO.branchId withType:VO.type navigation:self.navigationController];
            
        }
    }else{
        [self useMethod];
    }
    
}

//点击去使用,生成二维码界面
- (void)useMethod
{
    CouponShowModelR *modelR = [CouponShowModelR new];
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    modelR.myCouponId = self.myCouponId;
    [Coupon couponShow:modelR success:^(UseMyCouponVoModel *model) {
        if([model.apiStatus integerValue] == 0)
        {
            CouponUseViewController *couponUseViewController = [[CouponUseViewController alloc] initWithNibName:@"CouponUseViewController" bundle:nil];
            couponUseViewController.useModel = model;
            [self.navigationController pushViewController:couponUseViewController animated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:model.apiMessage duration:0.8];
        }
    } failure:NULL];
}
@end
