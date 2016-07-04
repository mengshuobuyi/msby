//
//  MedicineCollectViewController.m
//  wenyao
//
//  Created by Meng on 14-10-2.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "MedicineCollectViewController.h"
#import "MedicineListCell.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "LoginViewController.h"
#import "Favorite.h"
#import "FactoryModel.h"
#import "QWGlobalManager.h"
#import "FavoriteModel.h"
#import "WebDirectViewController.h"

@interface MedicineCollectViewController ()<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong) NSMutableArray * dataSource;

@end

@implementation MedicineCollectViewController

- (id)init{
    if (self = [super init]) {
        self.tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_W, APP_H-NAV_H - 35) style:UITableViewStylePlain];
        self.tableView.rowHeight = 88;
        if (iOSv7 && self.view.frame.origin.y==0) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
        }
        self.dataSource = [NSMutableArray array];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = RGBHex(qwColor11);
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.view addSubview:self.tableView];
    }
    return self;
}




- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self viewDidCurrentView];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        LoginViewController * login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        login.isPresentType = YES;
        login.parentNavgationController = self.navigationController;
        UINavigationController * nav = [[QWBaseNavigationController alloc] initWithRootViewController:login];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MedicineListCell getCellHeight:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"cellIdentifier";
    MedicineListCell * cell = (MedicineListCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MedicineListCell" owner:self options:nil][0];
    }

    MyFavProductListModel *product = self.dataSource[indexPath.row];
    [cell setMyFavCell:product];
    if(!product.gift) {
        [cell.giftLabel removeFromSuperview];
    }
    if(!product.discount) {
        [cell.foldLabel removeFromSuperview];
    }
    if(!product.voucher) {
        [cell.pledgeLabel removeFromSuperview];
    }
    if(!product.special) {
        [cell.specialLabel removeFromSuperview];
    }
    
    return cell;
}

//////////滑动删除//////////

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [self showError:kWarning12];
        return;
    }
    
        //取消收藏
    MyFavProductListModel * dic = self.dataSource[indexPath.row];
    FavoriteCollectR *param=[FavoriteCollectR new];
    param.token=QWGLOBALMANAGER.configure.userToken;
    param.method=@"3";
    param.objId = dic.id;
    param.objType=@"1";
    
    [Favorite collectWithParam:param success:^(id DFUserModel) {
        CancleResult *resultModel=(CancleResult *)DFUserModel;
        if ([resultModel.result isEqualToString:@"4"]) {
        [SVProgressHUD showSuccessWithStatus:@"取消收藏成功" duration:DURATION_SHORT];
            //缓存的更新
            [MyFavProductListModel deleteObjFromDBWithKey:dic.favProductInKey];
            
        }
    }failure:^(HttpException *e) {
        
    }];
    

    
    [self.dataSource removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    if (self.dataSource.count == 0) {
         [self showInfoView:@"暂无收藏记录" image:@"ic_img_fail"];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSIndexPath*    selection = [self.tableView indexPathForSelectedRow];
    if (selection) {
        [self.tableView deselectRowAtIndexPath:selection animated:YES];
    }

    MyFavProductListModel * dic = self.dataSource[indexPath.row];
    [self pushToDrugDetailWithDrugID:dic.proId promotionId:dic.promotionId];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidCurrentView{
    FavoriteModelR *param=[FavoriteModelR new];
    param.token=QWGLOBALMANAGER.configure.userToken;
    param.currPage=@"1";
    param.pageSize = @"200";
    
//    NSString * key = [NSString stringWithFormat:@"medicine_%@_%@",param.currPage,QWGLOBALMANAGER.configure.passPort];
    
    
    //新增城市和省
    MapInfoModel *mapInfoModel = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
    param.province=mapInfoModel==nil?@"江苏省":mapInfoModel.province;
    param.city=mapInfoModel==nil?@"苏州市":mapInfoModel.city;
    
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        
        //旧方法的缓存（list）
//        MyFavListModel* page = [MyFavListModel getObjFromDBWithKey:key];
//        if(page==nil){
//            [self showInfoView:kWarning12 image:@"网络信号icon.png"];
//            return;
//        }
//        [self.dataSource removeAllObjects];
//        [self removeInfoView];
//        [self.dataSource  addObjectsFromArray:page.list];
//        [self.tableView reloadData];
        
        NSString * where = [NSString stringWithFormat:@"token = '%@'",QWGLOBALMANAGER.configure.passPort];
        NSArray *arr = [MyFavProductListModel getArrayFromDBWithWhere:where];
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:arr];
        if (self.dataSource.count > 0) {
            [self removeInfoView];
            [self.tableView reloadData];
            [self.tableView footerEndRefreshing];
        }else{
            [self showInfoView:kWarning12 image:@"网络信号icon.png"];
        }
        
    } else {
        [Favorite queryProductCollectListWithParams:param success:^(id DFUserModel) {
            [self.dataSource removeAllObjects];
            MyFavListModel *medicList=(MyFavListModel *)DFUserModel;
            [self.dataSource addObjectsFromArray:medicList.list];
            [MyFavProductListModel deleteAllObjFromDB];
            if (self.dataSource.count == 0) {
                [self showInfoView:@"暂无收藏记录" image:@"ic_img_fail"];
            }else{
                //本地缓存
//                medicList.favSomeId = key;
//                [MyFavListModel deleteObjFromDBWithKey:medicList.favSomeId];
//                [MyFavListModel saveObjToDB:medicList];
//                [self.tableView reloadData];
                [self.tableView reloadData];
               
                for (MyFavProductListModel *model in self.dataSource) {
                    model.favProductInKey=[NSString stringWithFormat:@"%@_%@",model.id,QWGLOBALMANAGER.configure.passPort];
                    model.token=QWGLOBALMANAGER.configure.passPort;
                    [MyFavProductListModel saveObjToDB:model];
                }
                
                
                
            }
        } failure:^(HttpException *e) {
            if(e.errorCode!=-999){
                if(e.errorCode == -1001){
                    [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                }else{
                    [self showInfoView:kWarning39 image:@"ic_img_fail"];
                }
            }
        }];
    }
    
}



@end
