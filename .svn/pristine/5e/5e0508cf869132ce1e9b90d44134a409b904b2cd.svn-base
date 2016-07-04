//
//  SearchPromotionViewController.m
//  APP
//
//  Created by 李坚 on 15/8/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "SearchPromotionViewController.h"
#import "Promotion.h"
#import "PromotionActivityDetailViewController.h"
#import "WebDirectViewController.h"
#import "ScanReaderViewController.h"
#import "coupon.h"
#import "MutableMorePromotionTableViewCell.h"
#import "SVProgressHUD.h"
#import "QYPhotoAlbum.h"

@interface SearchPromotionViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>{
    UITextField* m_searchField;
}

@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation SearchPromotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if([self.typeIndex isEqualToString:@"2"]){
        self.scanView.hidden=YES;
    }
    
    
    self.dataArray = [NSMutableArray array];
    
    self.searchView.frame = CGRectMake(0, 0, APP_W, 44);
    self.searchBarView.tintColor = [UIColor blueColor];
    self.searchBarView.backgroundColor = RGBHex(qwColor1);
    self.searchBarView.placeholder = @"优惠商品搜索";
    self.searchBarView.delegate = self;
    
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    
    UIView *footView = [[UIView alloc]init];
    footView.backgroundColor = RGBHex(qwColor11);
    self.mainTableView.tableFooterView = footView;
    
    if (iOSv7) {
        UIView* barView = [self.searchBarView.subviews objectAtIndex:0];
        [[barView.subviews objectAtIndex:0] removeFromSuperview];
        UITextField* searchField = [barView.subviews objectAtIndex:0];
        searchField.font = [UIFont systemFontOfSize:13.0f];
        [searchField setReturnKeyType:UIReturnKeySearch];
        m_searchField = searchField;
    } else {
        [[self.searchBarView.subviews objectAtIndex:0] removeFromSuperview];
        UITextField* searchField = [self.searchBarView.subviews objectAtIndex:0];
        searchField.delegate = self;
        searchField.font = [UIFont systemFontOfSize:13.0f];
        [searchField setReturnKeyType:UIReturnKeySearch];
        m_searchField = searchField;
    }
    [self.cancelButton addTarget:self action:@selector(popAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.searchBarView becomeFirstResponder];
    [self.navigationController.navigationBar addSubview:self.searchView];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.searchBarView resignFirstResponder];
    [self.searchView removeFromSuperview];
    
}

- (void)popAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self removeInfoView];
    if([self.searchBarView.text isEqualToString:@""]){
        
        [self.dataArray removeAllObjects];
        [self.mainTableView reloadData];
    }else{
        
        if([self.typeIndex isEqualToString:@"2"]){
            [self searchStoreloadData:self.searchBarView.text];
        }else{
            [self searchloadData:self.searchBarView.text];
        }
        
        
    }
}


- (void)searchStoreloadData:(NSString*)content{
    
    [[QWGlobalManager sharedInstance] readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
        
        pharmacyProductModelR *modelR = [pharmacyProductModelR new];
        modelR.branchId = self.storeId;
        modelR.currPage = @1;
        modelR.pageSize = @1000;
        modelR.index=content;
        
        [Coupon pharmacyCouponDrugNew:modelR success:^(id obj) {
            
            BranchPromotionProListVo *quan = (BranchPromotionProListVo *)obj;
            [self.dataArray addObjectsFromArray:quan.pros];
            if(quan.pros == nil || quan.pros.count == 0){
                [self showInfoView:@"很遗憾，您搜索的药品暂无优惠~" image:@"ic_img_fail"];
            }
            [self.mainTableView footerEndRefreshing];
            [self.mainTableView reloadData];
            
            
        } failure:^(HttpException *e) {
            [self.mainTableView footerEndRefreshing];
            [SVProgressHUD showErrorWithStatus:e.Edescription duration:0.5];
        }];
        
    }];
    
}



- (void)searchloadData:(NSString*)content{
    
    [[QWGlobalManager sharedInstance] readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
        
        NewNearByPromotionModelR *modelR = [NewNearByPromotionModelR new];
        
        if(mapInfoModel){
            modelR.longitude = @(mapInfoModel.location.coordinate.longitude);
            modelR.latitude = @(mapInfoModel.location.coordinate.latitude);
            modelR.city = mapInfoModel.city;
        }else{
            modelR.longitude = @(120.730435);
            modelR.latitude = @(31.273391);
            modelR.city = @"苏州市";
        }

        modelR.page = 1;
        modelR.pageSize = 1000;
        
        modelR.keyword = content;
        
        [Promotion queryNewNearByPromotionListWithParams:modelR success:^(id obj) {
            
            PromotionProductArrayVo *promotionList = obj;
            [QWLOADING removeLoading];
            if(promotionList.normalPromotionList == nil || promotionList.normalPromotionList.count == 0){
                [self showInfoView:@"很遗憾，您搜索的药品暂无优惠~" image:@"ic_img_fail"];
            }
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:promotionList.normalPromotionList];
            [self.mainTableView reloadData];
            
        } failure:^(HttpException *e) {
            
        }];
        
    }];

}


#pragma mark - TableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.searchBarView resignFirstResponder];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChannelProductVo *vo = self.dataArray[indexPath.row];

    return [MutableMorePromotionTableViewCell getCellHeight:vo];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MutableMorePromotionTableViewCell *cell = (MutableMorePromotionTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"MutableMorePromotionTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    ChannelProductVo *vo = self.dataArray[indexPath.row];
    cell.selectedCell=indexPath;
    [cell setupCell:vo];
    return cell;
}

-(void)expandCell:(NSIndexPath *)selectCellIndex{
    
    ChannelProductVo *vo = self.dataArray[selectCellIndex.row];

    if(vo.isSelect){
        vo.isSelect=NO;
    }else{
        vo.isSelect=YES;
    }
    
    [self.mainTableView reloadData];

}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.searchBarView resignFirstResponder];
    ChannelProductVo *vo = self.dataArray[indexPath.row];
    //非多个活动
    if(!vo.multiPromotion)
    {
        
        NSString *pid=@"";
        if(vo.promotionList.count==1){
            ActivityCategoryVo *ov = vo.promotionList[0];
            pid=ov.pid;
        }
        WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
        
        [[QWGlobalManager sharedInstance] readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
            WebDrugDetailModel *modelDrug = [WebDrugDetailModel new];
            modelDrug.modelMap = mapInfoModel;
            modelDrug.proDrugID = vo.proId;
            modelDrug.promotionID = pid;
//            modelDrug.showDrug = @"0";
            WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
//            modelLocal.title = @"药品详情";
            modelLocal.modelDrug = modelDrug;
            modelLocal.typeLocalWeb = WebPageToWebTypeMedicine;
            [vcWebMedicine setWVWithLocalModel:modelLocal];
            [self.navigationController pushViewController:vcWebMedicine animated:YES];
        }];
    }
    else
    {
        
        //进入新的活动页面
        //跳转到新的活动列表
        PromotionActivityDetailViewController *drugDetail = [[PromotionActivityDetailViewController alloc]init];
        drugDetail.vo=vo;
        if([self.typeIndex isEqualToString:@"2"]){//2是药房下面的
            drugDetail.branchId=self.storeId;
        }
        [self.navigationController pushViewController:drugDetail animated:YES];
        
    }
}

- (IBAction)pushToScanView:(id)sender {
    [self.dataArray removeAllObjects];
    [self.mainTableView reloadData];
    [self.searchBarView resignFirstResponder];
    [self.searchBarView resignFirstResponder];
    
    if (![QYPhotoAlbum checkCameraAuthorizationStatus]) {
        [QWGLOBALMANAGER getCramePrivate];
        return;
    }
    
    ScanReaderViewController *scanReaderView = [[ScanReaderViewController alloc]initWithNibName:@"ScanReaderViewController" bundle:nil];
    scanReaderView.useType = Enum_Scan_Items_Promotion;
    scanReaderView.NeedPopBack = YES;
    [self.navigationController pushViewController:scanReaderView animated:YES];
    scanReaderView.promotionCallBack = ^(NSString *scanCode){
        
        self.searchBarView.text = scanCode;
        [self searchloadData:scanCode];
        
    };
}




@end
