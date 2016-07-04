//
//  OtherCollectViewController.m
//  wenyao
//
//  Created by Meng on 14-10-2.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "OtherCollectViewController.h"
#import "OtherCollectViewCell.h"
#import "MsgCollectCell.h"
#import "LoginViewController.h"
#import "Favorite.h"
#import "CoupnCollectTableViewCell.h"
#import "CommonDiseaseDetailViewController.h"
#import "WebDirectViewController.h"
#import "MedicineListCell.h"
#import "MGSwipeButton.h"
#import "SVProgressHUD.h"
@interface OtherCollectViewController ()<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate,MGSwipeTableCellDelegate>

@property (nonatomic ,strong) NSMutableArray * dataSource;


@end

@implementation OtherCollectViewController

- (id)init{
    if (self = [super init]) {
        self.tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0 , APP_W, 360) style:UITableViewStylePlain];
        
        [self.tableView setFrame:CGRectMake(0, 0, APP_W, APP_H - NAV_H -35)];
        self.tableView.rowHeight =80;
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

- (void)setCollectType:(OtherCollectType)collectType{
    _collectType = collectType;
    [self viewDidCurrentView];
}


- (void)getCachedList
{
        //本地缓存读取功能
//        MyFavListModel* page = [MyFavListModel getObjFromDBWithKey:key];
//        if(page==nil){
//            [self showInfoView:kWarning12 image:@"网络信号icon.png"];
//            return;
//        }
//        [self.dataSource removeAllObjects];
//        [self removeInfoView];
//        [self.dataSource  addObjectsFromArray:page.list];
//        [self.tableView reloadData];
    
    NSArray *arr=[NSArray array];
    NSString * where = [NSString stringWithFormat:@"token = '%@'",QWGLOBALMANAGER.configure.passPort];
    if (self.collectType == symptomCollect) {
        arr = [MyFavSpmListModel getArrayFromDBWithWhere:where];
    }else if (self.collectType == diseaseCollect){
        arr = [MyFavDiseaseListModel getArrayFromDBWithWhere:where];
    }else if (self.collectType == messageCollect){
        arr = [MyFavAdviceListModel getArrayFromDBWithWhere:where];
    }else if (self.collectType == coupnCollect){
        arr = [MyFavCoupnListModel getArrayFromDBWithWhere:where];
    }else if (self.collectType == medicineCollect) {        // 药品收藏
        arr = [MyFavProductListModel getArrayFromDBWithWhere:where];
    }

    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:arr];
    if (self.dataSource.count > 0) {
        [self removeInfoView];
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
    }else{
        [self showInfoView:kWarning12 image:@"网络信号icon.png"];
    }
    
}

- (void)viewDidCurrentView
{
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.25f];
}

- (void)loadData{
    
    [self removeInfoView];
//    个人的通行证
    NSString *passportAll=QWGLOBALMANAGER.configure.passPort;
    
    
    if (self.collectType == symptomCollect) {
        
        FavoriteModelR *param=[FavoriteModelR new];
        param.token=QWGLOBALMANAGER.configure.userToken;
        param.currPage=@"1";
        param.pageSize = @"1000";
        
//        NSString * key = [NSString stringWithFormat:@"symp_%@_%@",param.currPage,QWGLOBALMANAGER.configure.passPort];
        
        if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
            [self getCachedList];
            return;
        }
        
        
        [Favorite querySpmCollectListWithParams:param success:^(id DFUserModel) {
            [self.dataSource removeAllObjects];
            MyFavListModel *spmList=(MyFavListModel *)DFUserModel;
            [self.dataSource addObjectsFromArray:spmList.list];
            [MyFavSpmListModel deleteAllObjFromDB];
            if (self.dataSource.count == 0) {
                [self showInfoView:@"暂无收藏记录" image:@"ic_img_fail"];
                
            }else{
                //本地缓存
//                spmList.favSomeId = key;
//                [MyFavListModel deleteObjFromDBWithKey:spmList.favSomeId];
//                [MyFavListModel saveObjToDB:spmList];
//                [self.tableView reloadData];
                
                [self.tableView reloadData];
                for (MyFavSpmListModel *model in self.dataSource) {
                    model.favSpmInKey=[NSString stringWithFormat:@"%@_%@",model.spmCode,passportAll];
                    model.token=passportAll;
                    [MyFavSpmListModel saveObjToDB:model];
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
        
    }else if (self.collectType == diseaseCollect){
        
        FavoriteModelR *param=[FavoriteModelR new];
        param.token=QWGLOBALMANAGER.configure.userToken;
        param.currPage=@"1";
        param.pageSize = @"1000";
//        NSString * key = [NSString stringWithFormat:@"disease_%@_%@",param.currPage,QWGLOBALMANAGER.configure.passPort];
        
        if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
            [self getCachedList];
            return;
        }
        
        [Favorite queryDiseaseCollectListWithParams:param success:^(id DFUserModel) {
            [self.dataSource removeAllObjects];
            MyFavListModel *diseaseList=(MyFavListModel *)DFUserModel;
            [self.dataSource addObjectsFromArray:diseaseList.list];
            [MyFavDiseaseListModel deleteAllObjFromDB];
            if (self.dataSource.count == 0) {
                [self showInfoView:@"暂无收藏记录" image:@"ic_img_fail"];
                
            }else{
                //本地缓存18511810729
//                diseaseList.favSomeId = key;
//                [MyFavListModel deleteObjFromDBWithKey:diseaseList.favSomeId];
//                [MyFavListModel saveObjToDB:diseaseList];
//                [self.tableView reloadData];
                [self.tableView reloadData];
                for (MyFavDiseaseListModel *model in self.dataSource) {
                    model.favDiseaseInKey=[NSString stringWithFormat:@"%@_%@",model.diseaseId,passportAll];
                    model.token=passportAll;
                    [MyFavDiseaseListModel saveObjToDB:model];
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
        
    }else if (self.collectType == messageCollect){
        FavoriteModelR *param=[FavoriteModelR new];
        param.token=QWGLOBALMANAGER.configure.userToken;
        param.currPage=@"1";
        param.pageSize = @"1000";
//        NSString * key = [NSString stringWithFormat:@"message_%@_%@",param.currPage,QWGLOBALMANAGER.configure.passPort];
        
        if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
            [self getCachedList];
            return;
        }
        
        [Favorite queryAdviceCollectListWithParams:param success:^(id DFUserModel) {
            [self.dataSource removeAllObjects];
            MyFavListModel *adviceList=(MyFavListModel *)DFUserModel;
            [self.dataSource addObjectsFromArray:adviceList.list];
             [MyFavAdviceListModel deleteAllObjFromDB];
            if (self.dataSource.count == 0) {
                [self showInfoView:@"暂无收藏记录" image:@"ic_img_fail"];
            }else{
                //本地缓存
//                adviceList.favSomeId = key;
//                 [MyFavListModel deleteObjFromDBWithKey:adviceList.favSomeId];
//                [MyFavListModel saveObjToDB:adviceList];
//                [self.tableView reloadData];
                
                [self.tableView reloadData];
                for (MyFavAdviceListModel *model in self.dataSource) {
                    model.favAdviceInKey=[NSString stringWithFormat:@"%@_%@",model.adviceId,passportAll];
                    model.token=passportAll;
                    [MyFavAdviceListModel saveObjToDB:model];
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
    }else if (self.collectType == coupnCollect){
        FavoriteModelR *param=[FavoriteModelR new];
        param.token=QWGLOBALMANAGER.configure.userToken;
        param.currPage=@"1";
        param.pageSize = @"1000";
        
        if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
            [self getCachedList];
            return;
        }
        
    } else if (self.collectType == medicineCollect) {
        // 药品收藏
        FavoriteModelR *param=[FavoriteModelR new];
        param.token=QWGLOBALMANAGER.configure.userToken;
        param.currPage=@"1";
        param.pageSize = @"1000";
        //新增城市和省
        MapInfoModel *mapInfoModel = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
        param.province=mapInfoModel==nil?@"江苏省":mapInfoModel.province;
        param.city=mapInfoModel==nil?@"苏州市":mapInfoModel.city;
        [Favorite queryProductCollectListWithParams:param success:^(id DFUserModel) {
            [self.dataSource removeAllObjects];
            MyFavListModel *medicList=(MyFavListModel *)DFUserModel;
            [self.dataSource addObjectsFromArray:medicList.list];
            [MyFavProductListModel deleteAllObjFromDB];
            if (self.dataSource.count == 0) {
                [self showInfoView:@"暂无收藏记录" image:@"ic_img_fail"];
            }else{
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

- (void)viewInfoClickAction:(id)sender
{
    if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        [self removeInfoView];
        [self loadData];
    }
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.collectType == symptomCollect) {
        return self.dataSource.count;
    }else if (self.collectType == diseaseCollect){
        return self.dataSource.count;
    }else if (self.collectType == messageCollect){
        return self.dataSource.count;
    }else if (self.collectType == coupnCollect){
        return self.dataSource.count;
    }else if (self.collectType == medicineCollect) {
        return self.dataSource.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   if (self.collectType == messageCollect){
        return [MsgCollectCell getCellHeight:nil];
    } else if (self.collectType == coupnCollect){
        return [CoupnCollectTableViewCell getCellHeight:nil];
    } else if (self.collectType == medicineCollect) {
        return [MedicineListCell getCellHeight:nil];
    } else {
        return [OtherCollectViewCell getCellHeight:nil];
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"Identifier";
    static NSString * cellMsgIdentifier = @"MsgIndentifier";
        if (self.collectType == messageCollect)
    {
        MsgCollectCell *cell = (MsgCollectCell *)[tableView dequeueReusableCellWithIdentifier:cellMsgIdentifier];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"MsgCollectCell" owner:self options:nil][0];
        }
        MyFavAdviceListModel *advice = self.dataSource[indexPath.row];
        [cell setCell:advice];
        cell.swipeDelegate = self;
        return cell;
    } else  if (self.collectType == coupnCollect)
    {
        CoupnCollectTableViewCell *cell = (CoupnCollectTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellMsgIdentifier];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"CoupnCollectTableViewCell" owner:self options:nil][0];
        }
        MyFavCoupnListModel *coupn = self.dataSource[indexPath.row];
        cell.swipeDelegate = self;
        [cell setCell:coupn];
        return cell;
    } else if (self.collectType == medicineCollect) {
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
        cell.swipeDelegate = self;
        return cell;
    } else{
        OtherCollectViewCell * cell = (OtherCollectViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"OtherCollectViewCell" owner:self options:nil][0];
        }
        if (self.collectType == symptomCollect)
        {
            MyFavSpmListModel *spm = self.dataSource[indexPath.row];
            [cell setCell:spm];
        }else if (self.collectType == diseaseCollect)
        {
            MyFavDiseaseListModel *disease = self.dataSource[indexPath.row];
            [cell setDiseaseCell:disease];
        }
        cell.swipeDelegate = self;
        return cell;
    }
}


#pragma mark ---- MGSwipeTableCellDelegate ----

-(NSArray*) swipeTableCell:(MGSwipeTableCell*)cell
  swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*)swipeSettings
         expansionSettings:(MGSwipeExpansionSettings*)expansionSettings;
{
    if (direction == MGSwipeDirectionRightToLeft) {
        return [self createRightButtons:1];
    }
    return nil;
}

-(BOOL) swipeTableCell:(MGSwipeTableCell*)cell tappedButtonAtIndex:(NSInteger)index direction:(MGSwipeDirection)direction fromExpansion:(BOOL)fromExpansion
{
    NSIndexPath *indexPath = nil;
    if (index == 0) {
        if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
            [self showError:kWarning12];
            return NO;
        }
        indexPath = [self.tableView indexPathForCell:cell];
        FavoriteCollectR *param=[FavoriteCollectR new];
        param.token=QWGLOBALMANAGER.configure.userToken;
        param.method=@"3";
        
        if([self.dataSource count]>indexPath.row){
            
            NSDictionary * dic = [self.dataSource[indexPath.row] dictionaryModel];
            //取消收藏
            if (self.collectType == symptomCollect)//症状
            {
                
                param.objId = dic[@"spmCode"];
                param.objType = @"6";
            }else
                if (self.collectType == diseaseCollect)//疾病
                {
                    
                    param.objId = dic[@"diseaseId"];
                    param.objType = @"3";
                }else
                    if (self.collectType == messageCollect)//资讯
                    {
                        param.objId = dic[@"adviceId"];
                        param.objType = @"5";
                    }else if (self.collectType == coupnCollect)//优惠活动
                    {
                        param.objId = dic[@"id"];
                        param.objType = @"8";
                    }else if (self.collectType == medicineCollect) {// 药品

                        param.objId = dic[@"id"];
                        param.objType=@"1";
                    }
            [Favorite collectWithParam:param success:^(id DFUserModel) {
                CancleResult *resultModel=(CancleResult *)DFUserModel;
                if ([resultModel.result isEqualToString:@"4"]) {
                    [self showSuccess:@"取消收藏成功"];
                    
                    
                    if (self.collectType == symptomCollect)//症状
                    {
                        MyFavSpmListModel *model=[MyFavSpmListModel parse:dic];
                        [MyFavSpmListModel deleteObjFromDBWithKey:model.favSpmInKey];
                    }else if (self.collectType == diseaseCollect)//疾病
                    {
                        MyFavDiseaseListModel *model=[MyFavDiseaseListModel parse:dic];
                        [MyFavDiseaseListModel deleteObjFromDBWithKey:model.favDiseaseInKey];
                        
                    }else if (self.collectType == messageCollect)//资讯
                    {
                        MyFavAdviceListModel *model=[MyFavAdviceListModel parse:dic];
                        [MyFavAdviceListModel deleteObjFromDBWithKey:model.favAdviceInKey];
                    }else if (self.collectType == coupnCollect)//优惠活动
                    {
                        MyFavCoupnListModel *model=[MyFavCoupnListModel parse:dic];
                        [MyFavCoupnListModel deleteObjFromDBWithKey:model.favCoupnInKey];
                    }else if (self.collectType == medicineCollect) {
                        MyFavProductListModel *model = [MyFavProductListModel parse:dic];
                        [MyFavProductListModel deleteObjFromDBWithKey:model.favProductInKey];
                    }
                }
            } failure:^(HttpException *e) {
                DDLogVerbose(@"%@",e);
            }];
            
            
            [self.dataSource removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
        if (self.dataSource.count == 0) {
            [self showInfoView:@"暂无收藏记录" image:@"ic_img_fail"];
        }

        
    }
    return YES;
}

-(NSArray *) createRightButtons: (int) number
{
    NSMutableArray * result = [NSMutableArray array];
    NSString* titles[1] = {@"删除"};
    UIColor * colors[1] = {RGBHex(qwColor3)};
    for (int i = 0; i < number; ++i)
    {
        MGSwipeButton * button = [MGSwipeButton buttonWithTitle:titles[i] backgroundColor:colors[i] callback:^BOOL(MGSwipeTableCell * sender){
            return YES;
        }];
        [result addObject:button];
    }
    return result;
}




//////////滑动删除//////////
//
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"删除";
//}
//
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewCellEditingStyleDelete;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
//        [self showError:kWarning12];
//        return;
//    }
//    
//    FavoriteCollectR *param=[FavoriteCollectR new];
//    param.token=QWGLOBALMANAGER.configure.userToken;
//    param.method=@"3";
//
//    if([self.dataSource count]>indexPath.row){
//
//    NSDictionary * dic = [self.dataSource[indexPath.row] dictionaryModel];
//        
//        
//       
//        
//    //取消收藏
//    if (self.collectType == symptomCollect)//症状
//    {
//        
//        param.objId = dic[@"spmCode"];
//        param.objType = @"6";
//    }else
//        if (self.collectType == diseaseCollect)//疾病
//    {
//        
//        param.objId = dic[@"diseaseId"];
//        param.objType = @"3";
//    }else
//        if (self.collectType == messageCollect)//资讯
//    {
//        param.objId = dic[@"adviceId"];
//        param.objType = @"5";
//    }else if (self.collectType == coupnCollect)//优惠活动
//    {
//            param.objId = dic[@"id"];
//            param.objType = @"8";
//    }else if (self.collectType == medicineCollect) {// 药品
//        : need update
//        param.objId = dic[@"id"];
//        param.objType=@"1";
//    }
//        [Favorite collectWithParam:param success:^(id DFUserModel) {
//        CancleResult *resultModel=(CancleResult *)DFUserModel;
//            if ([resultModel.result isEqualToString:@"4"]) {
//                [self showSuccess:@"取消收藏成功"];
//                
//                
//                if (self.collectType == symptomCollect)//症状
//                {
//                    MyFavSpmListModel *model=[MyFavSpmListModel parse:dic];
//                    [MyFavSpmListModel deleteObjFromDBWithKey:model.favSpmInKey];
//                }else if (self.collectType == diseaseCollect)//疾病
//                {
//                    MyFavDiseaseListModel *model=[MyFavDiseaseListModel parse:dic];
//                    [MyFavDiseaseListModel deleteObjFromDBWithKey:model.favDiseaseInKey];
//                    
//                }else if (self.collectType == messageCollect)//资讯
//                {
//                    MyFavAdviceListModel *model=[MyFavAdviceListModel parse:dic];
//                    [MyFavAdviceListModel deleteObjFromDBWithKey:model.favAdviceInKey];
//                 }else if (self.collectType == coupnCollect)//优惠活动
//                {
//                    MyFavCoupnListModel *model=[MyFavCoupnListModel parse:dic];
//                    [MyFavCoupnListModel deleteObjFromDBWithKey:model.favCoupnInKey];
//                }else if (self.collectType == medicineCollect) {
//                    MyFavProductListModel *model = [MyFavProductListModel parse:dic];
//                    [MyFavProductListModel deleteObjFromDBWithKey:model.favProductInKey];
//                }
//            }
//                } failure:^(HttpException *e) {
//                    DDLogVerbose(@"%@",e);
//                }];
//    
//    
//    [self.dataSource removeObjectAtIndex:indexPath.row];
//    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
//    }
//    if (self.dataSource.count == 0) {
//         [self showInfoView:@"暂无收藏记录" image:@"ic_img_fail"];
//    }
//}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath*    selection = [self.tableView indexPathForSelectedRow];
    if (selection) {
        [self.tableView deselectRowAtIndexPath:selection animated:YES];
    }
    
    if (self.collectType == symptomCollect)
    {
        MyFavSpmListModel *spm = self.dataSource[indexPath.row];
        NSString *title =spm.name;
        NSString *symbolId = spm.spmCode;
        
        WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
        vcWebDirect.showConsultBtn = YES;
        
        WebSymptomDetailModel *modelSymptom = [[WebSymptomDetailModel alloc] init];
        modelSymptom.symptomId = symbolId;
        
        WebDirectLocalModel *modelLocal = [[WebDirectLocalModel alloc] init];
        modelLocal.modelSymptom = modelSymptom;
        modelLocal.typeLocalWeb = WebPageToWebTypeSympton;
        modelLocal.title = @"详情";
        [vcWebDirect setWVWithLocalModel:modelLocal];
        
        
        vcWebDirect.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vcWebDirect animated:YES];
    
    }else if (self.collectType == diseaseCollect)
    {
        
        MyFavDiseaseListModel *disease=self.dataSource[indexPath.row];
        NSString *type = disease.type;
        if ([type isEqualToString:@"A"]) {
            CommonDiseaseDetailViewController *commonDiseaseDetail = [[CommonDiseaseDetailViewController alloc] init];
            commonDiseaseDetail.diseaseId = disease.diseaseId;
            commonDiseaseDetail.title = disease.cname;
            [self.navigationController pushViewController:commonDiseaseDetail animated:YES];
        }else{
            NSString *diseaseId = disease.diseaseId;
            NSString *title = disease.cname;
            
            WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
            vcWebDirect.showConsultBtn = YES;
            
            WebDiseaseDetailModel *modelDisease = [[WebDiseaseDetailModel alloc] init];
            modelDisease.diseaseId = diseaseId;
            
            WebDirectLocalModel *modelLocal = [[WebDirectLocalModel alloc] init];
            modelLocal.modelDisease = modelDisease;
            modelLocal.title = title;
            modelLocal.typeTitle = WebTitleTypeOnlyShare;
            modelLocal.typeLocalWeb = WebPageToWebTypeDisease;
            [vcWebDirect setWVWithLocalModel:modelLocal];
            
            vcWebDirect.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vcWebDirect animated:YES];
        }
    }else if (self.collectType == messageCollect)
    {
        MyFavAdviceListModel *advicel = self.dataSource[indexPath.row];
        //TODO: Perry Need fix
        WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
        
        WebHealthInfoModel *modelHealth = [[WebHealthInfoModel alloc] init];
        modelHealth.msgID = advicel.adviceId;
        
        WebDirectLocalModel *modelLocal = [[WebDirectLocalModel alloc] init];
        modelLocal.modelHealInfo = modelHealth;
        modelLocal.typeLocalWeb = WebPageToWebTypeInfo;
        [vcWebDirect setWVWithLocalModel:modelLocal];

        vcWebDirect.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vcWebDirect animated:YES];
    }else if (self.collectType == coupnCollect)
    {
//        CouponDeatilViewController *detailViewController = [[CouponDeatilViewController alloc] initWithNibName:@"CouponDeatilViewController" bundle:nil];
//        detailViewController.hidesBottomBarWhenPushed = YES;
//        
//        MyFavCoupnListModel *coupn = self.dataSource[indexPath.row];
//        detailViewController.commonPromotionId = coupn.id;
//        [self.navigationController pushViewController:detailViewController animated:YES];
//        
    }else if (self.collectType == medicineCollect) {
        // 药品收藏

        WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
        MyFavProductListModel * dic = self.dataSource[indexPath.row];
        MapInfoModel *modelMap = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
        WebDrugDetailModel *modelDrug = [WebDrugDetailModel new];
        modelDrug.modelMap = modelMap;
        modelDrug.proDrugID = dic.proId;
        modelDrug.promotionID = dic.promotionId;
        WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
        modelLocal.modelDrug = modelDrug;
        modelLocal.typeLocalWeb = WebPageToWebTypeMedicine;
        [vcWebMedicine setWVWithLocalModel:modelLocal];
        [self.navigationController pushViewController:vcWebMedicine animated:YES];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
