//
//  CouponPromotionHomePageViewController.m
//  APP
//
//  Created by 李坚 on 15/8/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "ChannelHomePageViewController.h"
#import "Promotion.h"
#import "ConfigInfo.h"
#import "UIImageView+WebCache.h"
#import "MutableMorePromotionTableViewCell.h"
#import "CouponPromotionTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ComboxView.h"
#import "RightAccessButton.h"
#import "ButtonsView.h"
#import "PromotionActivityDetailViewController.h"
#import "SearchPromotionViewController.h"
#import "XLCycleScrollView.h"
#import "WebDirectViewController.h"
#import "LoginViewController.h"
#import "Activity.h"
#import "ActivityModel.h"
#import "ActivityModelR.h"


@interface ChannelHomePageViewController ()<UITableViewDataSource,UITableViewDelegate,XLCycleScrollViewDatasource,XLCycleScrollViewDelegate>{
    
    NSInteger currentPage;
    
    NSArray                     *BannerArray;
    
    XLCycleScrollView           *cycScrollBanner;       //Banner
}

@property (strong, nonatomic) UITableView *mainTableView;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation ChannelHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.channelName;

    
    currentPage = 1;

    self.dataArray = [NSMutableArray array];

    
    BannerArray = [NSArray array];
    
    //BannerUI
    [self setupBanner];
    
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H - NAV_H)];
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.mainTableView];
    [self.mainTableView addFooterWithTarget:self action:@selector(refreshData)];
    self.mainTableView.footerPullToRefreshText = kWarning6;
    self.mainTableView.footerReleaseToRefreshText = kWarning7;
    self.mainTableView.footerRefreshingText = kWarning9;
    self.mainTableView.footerNoDataText = kWarning44;
    [self.mainTableView addStaticImageHeader];
   

    //请求Banner数据
    [self loadBanner];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //根据条件请求优惠商品数据
    [self loadPromotionData];
    if(BannerArray.count > 0){
        cycScrollBanner.scrollView.scrollEnabled = YES;
        [cycScrollBanner startAutoScroll:5.0f];
    }else{
        cycScrollBanner.scrollView.scrollEnabled = NO;
        [cycScrollBanner stopAutoScroll];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [cycScrollBanner stopAutoScroll];
}

#pragma mark - 底部的分页加载
- (void)refreshData{
    HttpClientMgr.progressEnabled = NO;
    [self loadPromotionData];
}

#pragma mark - 请求Banner数据
- (void)loadBanner{
    
    [[QWGlobalManager sharedInstance] readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
        
        ConfigInfoQueryModelR *modelR = [ConfigInfoQueryModelR new];
        modelR.place = @"4";//(1:首页，2:附近优惠，3:领券中心，4:频道)
        
        if(mapInfoModel){
            modelR.city = mapInfoModel.city;
            modelR.province = mapInfoModel.province;
        }else{
            modelR.city = @"苏州市";
            modelR.province = @"江苏省";
        }
        modelR.channelId=self.channelId;
        modelR.v=@"223";
        
        [ConfigInfo configInfoQueryBanner:modelR success:^(BannerInfoListModel *responModel) {
            
            if(responModel.list && responModel.list.count != 0){
                
                BannerArray = [NSArray arrayWithArray:responModel.list];
        
                self.mainTableView.tableHeaderView = cycScrollBanner;

                [cycScrollBanner reloadData];
            }else{
                self.mainTableView.tableHeaderView = nil;

            }
            
            
        } failure:^(HttpException *e) {
            self.mainTableView.tableHeaderView = nil;
            if(QWGLOBALMANAGER.currentNetWork == kNotReachable) {
                [self showInfoView:kWarning12 image:@"网络信号icon"];
            }
        }];
    }];
}

#pragma mark - 建立BannerUI
- (void)setupBanner{
    
    cycScrollBanner = [[XLCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 120)];
    cycScrollBanner.datasource = self;
    cycScrollBanner.delegate = self;
 
}

#pragma mark - 请求频道商品列表
- (void)loadPromotionData{
    [self removeInfoView];
    [[QWGlobalManager sharedInstance] readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
        ChannelProductListR *modelR = [ChannelProductListR new];
        if (mapInfoModel) {
            modelR.city = mapInfoModel.city;
        }else {
            modelR.city = @"苏州市";
        }
        modelR.page = currentPage;
        modelR.pageSize = 10;
        modelR.channelId = self.channelId;
        [Activity getChannelProductList:modelR success:^(ChannelProductArrayVo *responModel) {
            ChannelProductArrayVo *channelProductList = responModel;
            
            if(currentPage == 1){
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:channelProductList.productList];
            }else{
                [self.dataArray addObjectsFromArray:channelProductList.productList];
            }
            
            if ([channelProductList.apiStatus intValue] == 1 || [channelProductList.apiStatus intValue] == 2) {
                [self showMyInfoView:[NSString stringWithFormat:@"%@",channelProductList.apiMessage]];
                return;
            }
            if (currentPage == 1 && channelProductList.productList.count == 0) {
                [self showMyInfoView:@"对不起，暂无频道优惠商品列表"];
                return;
            }

            if(channelProductList.productList.count>0){
                currentPage++;
                [self.mainTableView reloadData];
            }else{
                self.mainTableView.footer.canLoadMore = NO;
            }
            [self.mainTableView footerEndRefreshing];
        } failure:^(HttpException *e) {
            [self.mainTableView footerEndRefreshing];
        }];
    }];
}

#pragma mark - XLCycScrollViewDelegate
- (NSInteger)numberOfPages{
    
    if(BannerArray.count > 0){
        cycScrollBanner.scrollView.scrollEnabled = YES;
        [cycScrollBanner startAutoScroll:5.0f];
        return BannerArray.count;
    }else{
        cycScrollBanner.scrollView.scrollEnabled = NO;
        [cycScrollBanner stopAutoScroll];
        return 0;
    }
    
}

- (UIView *)pageAtIndex:(NSInteger)index{
    
    BannerInfoModel *model = BannerArray[index];
    
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 120)];
    [view setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"img_banner_nomal"]];
    
    return view;
}

- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index{
    BannerInfoModel *model = BannerArray[index];
    [QWGLOBALMANAGER pushIntoDifferentBannerType:model navigation:self.navigationController bannerLocation:@"优惠商品" selectedIndex:index];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChannelProductVo *vo = self.dataArray[indexPath.row];
    
    return [MutableMorePromotionTableViewCell getCellHeight:vo];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        ChannelProductVo *vo = nil;
        vo = self.dataArray[indexPath.row];
        //进入详情
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
                WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
                modelLocal.modelDrug = modelDrug;
                modelLocal.typeLocalWeb = WebPageToWebTypeMedicine;
                vcWebMedicine.isComeFromChannel = YES;
                [vcWebMedicine setWVWithLocalModel:modelLocal];
                [self.navigationController pushViewController:vcWebMedicine animated:YES];
                
            }];
        }else{
            //跳转到新的活动列表
            PromotionActivityDetailViewController *drugDetail = [[PromotionActivityDetailViewController alloc]init];
            drugDetail.vo = vo;
            [self.navigationController pushViewController:drugDetail animated:YES];
        }

}


- (void)popVCAction:(id)sender{
    [super popVCAction:sender];
    [cycScrollBanner stopAutoScroll];
    cycScrollBanner = nil;
    
}

- (void)showMyInfoView:(NSString *)str{
    
    self.mainTableView.scrollEnabled = NO;
    UIView *footView = [[UIView alloc]init];
    
    if(BannerArray.count > 0){
        footView.frame = CGRectMake(0, 0, APP_W, APP_H - NAV_H - cycScrollBanner.frame.size.height);
    }else{
        footView.frame = CGRectMake(0, 0, APP_W, APP_H - NAV_H);
    }
    
    footView.backgroundColor = RGBHex(qwColor11);
    
    
    UIImageView *cryImage = [[UIImageView alloc]initWithFrame:CGRectMake(APP_W/2 - 75, 20 , 150, 150)];
    cryImage.image = [UIImage imageNamed:@"ic_img_cry"];
    [footView addSubview:cryImage];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, APP_W, 21)];
    label.font = fontSystem(14.0f);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = RGBHex(qwColor7);
    label.text = str;
    label.center = footView.center;
    CGRect rect = label.frame;
    rect.origin.y = cryImage.frame.origin.y + cryImage.frame.size.height +  25;
    label.frame = rect;
    [footView addSubview:label];
    self.mainTableView.tableFooterView = footView;
    self.mainTableView.footerHidden = YES;
    [self.mainTableView setScrollEnabled:NO];
}

@end
