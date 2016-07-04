//
//  FactoryMedicineListViewController.m
//  wenyao
//
//  Created by qw on 14-11-14.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "FactoryMedicineListViewController.h"
#import "MedicineListCell.h"
#import "FactoryModel.h"
#import "WebDirectViewController.h"
#import "Factory.h"

@interface FactoryMedicineListViewController ()<UITableViewDataSource, UITableViewDelegate>

{
    NSMutableArray *arrMedicineList;
    NSInteger numCurPage;
}


@end

@implementation FactoryMedicineListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrMedicineList = [[NSMutableArray alloc] init];
    self.title = @"药品列表";
    numCurPage=1;
    [self.tableMain setFrame:CGRectMake(0, 0, APP_W, APP_H-NAV_H)];
    self.tableMain.delegate=self;
    self.tableMain.dataSource=self;
    [self.view addSubview:self.tableMain];
    [self getAllMedicineList];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)footerRereshing
{
    HttpClientMgr.progressEnabled = NO;
    [self getAllMedicineList];
}


#pragma mark - Http methods
- (void)getAllMedicineList
{
    FactoryProductListModelR *modelR = [FactoryProductListModelR new];
    modelR.factoryCode = self.strFactoryID;
    modelR.currPage = [NSString stringWithFormat:@"%ld",(long)numCurPage];
    modelR.pageSize = @"10";
    modelR.v = @"2.0";
    [Factory queryFactoryProductListWithParam:modelR success:^(id Model) {
        FactoryProductList *productsList = (FactoryProductList *)Model;
        [arrMedicineList addObjectsFromArray:productsList.list];
        
        if(productsList.list.count>0){
            [self.tableMain reloadData];
            numCurPage++;
        }else{
         self.tableMain.footer.canLoadMore=NO;
        }
        [self.tableMain footerEndRefreshing];
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

#pragma mark - UITableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = @"cellIdentifier";
    MedicineListCell * cell = (MedicineListCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MedicineListCell" owner:self options:nil][0];
    }
    FactoryProduct *dicData = arrMedicineList[indexPath.row];
    [cell setFactoryProductCell:dicData];
    
//    if(!dicData.gift) {
//        [cell.giftLabel removeFromSuperview];
//    }
//    if(!dicData.discount) {
//        [cell.foldLabel removeFromSuperview];
//    }
//    if(!dicData.voucher) {
//        [cell.pledgeLabel removeFromSuperview];
//    }
//    if(!dicData.special) {
//        [cell.specialLabel removeFromSuperview];
//    }
    [cell.giftLabel removeFromSuperview];
    [cell.foldLabel removeFromSuperview];
    [cell.pledgeLabel removeFromSuperview];
    [cell.specialLabel removeFromSuperview];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrMedicineList.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FactoryProduct *dicData = arrMedicineList[indexPath.row];
    [self pushToDrugDetailWithDrugID:dicData.proId promotionId:dicData.promotionId];
}

- (void)pushToDrugDetailWithDrugID:(NSString *)drugId promotionId:(NSString *)promotionID{
    
    WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];    
    MapInfoModel *modelMap = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
    WebDrugDetailModel *modelDrug = [WebDrugDetailModel new];
    modelDrug.modelMap = modelMap;
    modelDrug.proDrugID = drugId;
    modelDrug.promotionID = promotionID;
//    modelDrug.showDrug = @"0";
    WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
//    modelLocal.title = @"药品详情";
    modelLocal.modelDrug = modelDrug;
    modelLocal.typeLocalWeb = WebPageToWebTypeMedicine;
    [vcWebMedicine setWVWithLocalModel:modelLocal];
    
    [self.navigationController pushViewController:vcWebMedicine animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MedicineListCell getCellHeight:nil];
}

@end
