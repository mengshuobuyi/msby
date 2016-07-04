//
//  SearchMedicineListViewController.m
//  wenyao
//
//  Created by Meng on 14/12/2.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "SearchMedicineListViewController.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "Drug.h"
#import "CouponPromotionTableViewCell.h"
#import "Search.h"
#import "PromotionModel.h"
#import "WebDirectViewController.h"
#import "PromotionActivityDetailViewController.h"

@interface SearchMedicineListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger currentPage;
    UIView *_nodataView;
}
@property (nonatomic ,strong) NSMutableArray * dataSource;
@property (nonatomic,strong)UITableView *tableViews;
@end

@implementation SearchMedicineListViewController

- (instancetype)init
{
    if (self = [super init]) {
        UIBarButtonItem *barbutton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(popVCAction:)];
        self.navigationItem.leftBarButtonItem=barbutton;
        self.tableViews=[[UITableView alloc]init];
            [self.tableViews setFrame:CGRectMake(0, 0, APP_W, APP_H -NAV_H)];
        self.tableViews.separatorStyle=UITableViewCellSeparatorStyleNone;
            self.tableViews.dataSource=self;
            self.tableViews.delegate=self;
        [self.tableViews addFooterWithTarget:self action:@selector(footerRereshing)];
        self.tableViews.footerPullToRefreshText =kWarning6;
        self.tableViews.footerReleaseToRefreshText = kWarning7;
        self.tableViews.footerRefreshingText = kWarning8;
        self.tableViews.footerNoDataText = kWarning44;
        self.tableViews.backgroundColor=RGBHex(qwColor11);
        [self.view addSubview:self.tableViews];
        currentPage = 1;
    }
    return self;
}
-(void)popVCAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableViews.rowHeight = 88;
 
    self.dataSource = [NSMutableArray array];
}

- (void)footerRereshing{
    HttpClientMgr.progressEnabled = NO;
    [self setKwId:self.kwId];
}

- (void)setKwId:(NSString *)kwId
{
    _kwId = kwId;
    
    QueryProductByKwIdModelR *productR=[QueryProductByKwIdModelR new];
    productR.kwId=kwId;
    productR.currPage=[NSString stringWithFormat:@"%ld",(long)currentPage];
    productR.pageSize=[NSString stringWithFormat:@"%i",10];

    //新增城市和省
    
    MapInfoModel *mapInfoModel = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
    productR.province=mapInfoModel==nil?@"江苏省":mapInfoModel.province;
    productR.city=mapInfoModel==nil?@"苏州市":mapInfoModel.city;
    productR.v = @"2.0";
    
    
    [Search queryProductByKeyword:productR success:^(id obj) {
        
        KeywordModel *product = obj;
        [self.dataSource addObjectsFromArray:product.list];
        if (product.list.count > 0) {
            currentPage ++;
            [self.tableViews reloadData];
        }else{
            self.tableViews.footer.canLoadMore=NO;
        }
        [self.tableViews footerEndRefreshing];
        
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


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CouponPromotionTableViewCell *cell = (CouponPromotionTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"CouponPromotionTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    DrugVo *vo = self.dataSource[indexPath.row];
    
    [cell.ImagUrl setImageWithURL:[NSURL URLWithString:vo.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
    cell.proName.text = vo.proName;
    cell.spec.text = vo.spec;
    cell.factoryName.text = vo.factory;
    cell.label.text = vo.label;
    if([vo.gift intValue] == 0){
        [cell.gift removeFromSuperview];
    }
    if([vo.discount intValue] == 0){
        [cell.discount removeFromSuperview];
    }
    if([vo.voucher intValue] == 0){
        [cell.voucher removeFromSuperview];
    }
    if([vo.special intValue] == 0){
        [cell.special removeFromSuperview];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CouponPromotionTableViewCell getCellHeight:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *selection = [self.tableViews indexPathForSelectedRow];
    if (selection) {
        [self.tableViews deselectRowAtIndexPath:selection animated:YES];
    }
    DrugVo *product = self.dataSource[indexPath.row];

    
    if(product.multiPromotion){
        
        if([product.multiPromotion intValue] == 0){
            //渠道统计
            ChannerTypeModel *model=[ChannerTypeModel new];
            model.objRemark=product.proName;
            model.objId=product.proId;
            model.cKey=@"e_yp_css";
            [QWGLOBALMANAGER qwChannel:model];
            
            
            
        WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
        [[QWGlobalManager sharedInstance] readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
            WebDrugDetailModel *modelDrug = [WebDrugDetailModel new];
            modelDrug.modelMap = mapInfoModel;
            modelDrug.proDrugID = product.proId;
            modelDrug.promotionID = product.promotionId;
//            modelDrug.showDrug = @"0";
            WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
//            modelLocal.title = @"药品详情";
            modelLocal.modelDrug = modelDrug;
            modelLocal.typeLocalWeb = WebPageToWebTypeMedicine;
            [vcWebMedicine setWVWithLocalModel:modelLocal];
            [self.navigationController pushViewController:vcWebMedicine animated:YES];
        }];
        }else{
            
            //跳转到新的活动列表
            PromotionActivityDetailViewController *drugDetail = [[PromotionActivityDetailViewController alloc]init];
            drugDetail.vo=[self changeModel:product];
            drugDetail.sourceType=@"2";
            [self.navigationController pushViewController:drugDetail animated:YES];
        }
}
}


-(ChannelProductVo *)changeModel:(DrugVo*)model{
    ChannelProductVo *mod=[ChannelProductVo new];
    mod.proId=model.proId;
    mod.proName=model.proName;
    mod.spec=model.spec;
    mod.factoryName=model.factory;
    mod.imgUrl=model.imgUrl;
    mod.multiPromotion=model.multiPromotion;
    return mod;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
