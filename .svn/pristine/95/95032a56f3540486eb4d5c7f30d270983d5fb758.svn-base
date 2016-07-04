//
//  SuitableDrugViewController.m
//  APP
//
//  Created by 李坚 on 15/8/28.
//  Copyright (c) 2015年 carret. All rights reserved.
//
/**
 *  领券中心优惠券，我的优惠券中的适用商品页面
 *
 *  @return <#return value description#>
 */
#import "SuitableDrugViewController.h"
#import "Coupon.h"
#import "WebDirectViewController.h"
#import "CouponDrugTableViewCell.h"

@interface SuitableDrugViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    NSMutableArray *dataArray;
}

@property (strong, nonatomic) UITableView *mainTableView;

@end

@implementation SuitableDrugViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"适用商品";
    
    if(QWGLOBALMANAGER.currentNetWork == kNotReachable){
        [self showInfoView:kWarning12 image:@"网络信号icon"];
        return;
    }
    
    dataArray = [NSMutableArray array];
    
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H - NAV_H)];
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    [self.view addSubview:self.mainTableView];
    UIView *footView = [[UIView alloc]init];
    footView.backgroundColor = RGBHex(qwColor11);
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.tableFooterView = footView;
    
    [self loadData];
}

#pragma mark - HTTPRequest
- (void)loadData{
    
    onlineCouponModelR *modelR = [onlineCouponModelR new];
    modelR.couponId = self.couponId;
    
    [Coupon suitableDrug:modelR success:^(id obj) {
        
        CouponProductVoListModel *couponList = obj;
        if(couponList.suitableProducts.count != 0){
            
            [dataArray addObjectsFromArray:couponList.suitableProducts];
            [self.mainTableView reloadData];
        } else {
            [self showError:couponList.apiMessage];
        }
        
    } failure:^(HttpException *e) {
        
        
        
    }];
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [CouponDrugTableViewCell getCellHeight:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *ConsultPharmacyIdentifier = @"CouponDrugTableViewCell";
    CouponDrugTableViewCell *cell = (CouponDrugTableViewCell *)[tableView dequeueReusableCellWithIdentifier:ConsultPharmacyIdentifier];
    if(cell == nil){
        UINib *nib = [UINib nibWithNibName:@"CouponDrugTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:ConsultPharmacyIdentifier];
        cell = (CouponDrugTableViewCell *)[tableView dequeueReusableCellWithIdentifier:ConsultPharmacyIdentifier];
        cell.selectedBackgroundView = [[UIView alloc]init];
        cell.selectedBackgroundView.backgroundColor = RGBHex(qwColor10);
    }

    cell.centerConstant.constant = 0;
    
    CouponProductVoModel *drug = dataArray[indexPath.row];
    
    NSString *imgUrl = [NSString stringWithFormat:@"%@",drug.productLogo];
    
    [cell.logoImage setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
    cell.nameLabel.text = drug.productName;
    cell.ruleLabel.text = drug.spec;
    cell.promotionLabel.text = drug.factory;
    
    cell.priceLabel.hidden = YES;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //跳转药品详情（h5）
    
    CouponProductVoModel *drug = dataArray[indexPath.row];
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"商品内容"]=drug.productName;
    [QWGLOBALMANAGER statisticsEventId:@"x_yhsplb_dj" withLable:@"优惠商品" withParams:tdParams];
    WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    [[QWGlobalManager sharedInstance] readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
        WebDrugDetailModel *modelDrug = [WebDrugDetailModel new];
        modelDrug.modelMap = mapInfoModel;
        modelDrug.proDrugID = drug.productId;
        modelDrug.promotionID = @"";
        WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
        modelLocal.typeLocalWeb = WebPageToWebTypeMedicine;
        modelLocal.modelDrug = modelDrug;
        [vcWebMedicine setWVWithLocalModel:modelLocal];
        [self.navigationController pushViewController:vcWebMedicine animated:YES];
    }];
}

@end
