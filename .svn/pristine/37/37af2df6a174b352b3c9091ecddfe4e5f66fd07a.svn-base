//
//  CouponMedicineListViewController.m
//  APP
//
//  Created by garfield on 15/8/24.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "CouponMedicineListViewController.h"
#import "MedicineListCell.h"
#import "Coupon.h"
#import "WebDirectViewController.h"

static NSString  *const MedicineListCellIdentifier = @"MedicineListCellIdentifier";

@interface CouponMedicineListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray     *dataSource;

@end

@implementation CouponMedicineListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"适用商品";
    [self setupTableView];
    [self queryMedicineList];
}

- (void)queryMedicineList
{
    CouponProductSuitableModelR *modelR = [CouponProductSuitableModelR new];
    modelR.couponId = _couponId;
    [Coupon couponProductSuitable:modelR success:^(CouponProductVoListModel *listModel) {
        if([listModel.apiStatus integerValue] == 0) {
            self.dataSource = listModel.suitableProducts;
            [self.tableView reloadData];
        }
    } failure:NULL];
}

- (void)setupTableView
{
    UINib *cell = [UINib nibWithNibName:@"MedicineListCell" bundle:nil];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:cell forCellReuseIdentifier:MedicineListCellIdentifier];
}

#pragma mark -
#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MedicineListCell getCellHeight:nil];
}

- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MedicineListCell * cell = (MedicineListCell *)[atableView dequeueReusableCellWithIdentifier:MedicineListCellIdentifier forIndexPath:indexPath];
    CouponProductVoModel *productVoModel = self.dataSource[indexPath.row];
    [cell.headImageView setImageWithURL:[NSURL URLWithString:productVoModel.productLogo] placeholderImage:[UIImage imageNamed:@"药品默认图片.png"]];
    cell.proName.text = productVoModel.productName;
    cell.spec.text = productVoModel.spec;
    cell.factory.text = productVoModel.factory;
    [cell.giftLabel removeFromSuperview];
    [cell.foldLabel removeFromSuperview];
    [cell.pledgeLabel removeFromSuperview];
    [cell.specialLabel removeFromSuperview];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CouponProductVoModel *productVoModel = self.dataSource[indexPath.row];
    
    WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    MapInfoModel *modelMap = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
    WebDrugDetailModel *modelDrug = [WebDrugDetailModel new];
    modelDrug.modelMap = modelMap;
    modelDrug.proDrugID = productVoModel.productId;
    modelDrug.promotionID = @"";
    WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
    modelLocal.typeLocalWeb = WebPageToWebTypeMedicine;
    modelLocal.modelDrug = modelDrug;
    [vcWebMedicine setWVWithLocalModel:modelLocal];
    [self.navigationController pushViewController:vcWebMedicine animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}


@end
