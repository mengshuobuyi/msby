//
//  CouponPromotionHomePageViewController.m
//  APP
//
//  Created by 李坚 on 15/8/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "CouponPromotionHomePageViewController.h"
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
#import "MyMutableMorePromotionTableViewCell.h"
#import "UIScrollView+Extension.h"

@interface CouponPromotionHomePageViewController ()<UITableViewDataSource,UITableViewDelegate,ComboxViewDelegate,ButtonsViewDelegate,XLCycleScrollViewDatasource,XLCycleScrollViewDelegate,MyMutableMorePromotionTableViewCellDelegate>{
    BOOL cityTag;
    BOOL groupTag;
    BOOL promotion;
    
    NSInteger currentPage;
    
    RightAccessButton           *leftButton;            //左边的条件筛选
    RightAccessButton           *rightButton;           //右边的条件筛选
    
    ButtonsView                 *buttonsView;           //左边条件筛选view
    ComboxView                  *rightComboxView;       //右边的条件筛选list
    UIImageView                 *headerView;
    NSArray                     *leftMenuItems;         //左边的条件筛选集合
    NSMutableArray                     *rightMenuItems;        //右边的条件筛选集合
    NSArray                     *BannerArray;
    
    NSInteger                   leftIndex;              //点击索引
    NSInteger                   rightIndex;             //点击索引
    XLCycleScrollView           *cycScrollBanner;       //Banner
    NSIndexPath                 *selectedIndex;          //被选中的cell
}

@property (strong, nonatomic) UITableView *mainTableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UIButton       *topButton;
@property (strong, nonatomic) NSMutableArray *tagArray;
@property (strong, nonatomic) NSMutableArray *groupArray;

@property (strong, nonatomic) NSMutableArray *topArray;     // 置顶的数组   comment by perry

@end

@implementation CouponPromotionHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"优惠商品";
    rightMenuItems = [NSMutableArray array];
    //右上角搜索按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_btn_search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchPromotion:)];
    
    self.navigationItem.rightBarButtonItem = item;
    
    cityTag = NO;
    groupTag = NO;
    promotion = NO;
    currentPage = 1;
    leftIndex = 0;
    rightIndex = -1;
    self.dataArray = [NSMutableArray array];
    self.tagArray = [NSMutableArray array];
    self.groupArray = [NSMutableArray array];
    self.topArray = [NSMutableArray array];         // comment by perry
    
    BannerArray = [NSArray array];
    
    //BannerUI
    [self setupBanner];
    
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H - NAV_H)];
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainTableView addFooterWithTarget:self action:@selector(refreshData)];
    self.mainTableView.backgroundColor = RGBHex(qwColor11);
    [self.mainTableView addStaticImageHeader];
    self.topButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.topButton setImage:[UIImage imageNamed:@"icon_top"] forState:UIControlStateNormal];
    [self.topButton setBackgroundColor:[UIColor clearColor]];
    self.topButton.frame = CGRectMake(APP_W - 45, APP_H - 45 - 64, 30, 30);
    [self.topButton addTarget:self action:@selector(scrollToTop:) forControlEvents:UIControlEventTouchUpInside];
    self.topButton.alpha = 0.0;
    UIView *footView = [[UIView alloc]init];
    footView.backgroundColor = RGBHex(qwColor11);
    self.mainTableView.tableFooterView = footView;
    [self.view addSubview:self.mainTableView];
    
    //头部ui
    [self setupHeaderView];
    //请求Banner数据
    [self loadBanner];
    [self.view addSubview:self.topButton];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [self showInfoView:kWarning12 image:@"网络信号icon"];
        return;
    }
    
    //请求筛选条件
    [self loadTags];
    
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

#pragma mark - 分页加载
- (void)refreshData{
    HttpClientMgr.progressEnabled = NO;

    [self loadPromotionData];
}

#pragma mark - 请求Banner数据
- (void)loadBanner{
    
    [[QWGlobalManager sharedInstance] readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
        
        ConfigInfoQueryModelR *modelR = [ConfigInfoQueryModelR new];
        modelR.place = @"2";
        
        if(mapInfoModel){
            modelR.city = mapInfoModel.city;
            modelR.province = mapInfoModel.province;
        }else{
            modelR.city = @"苏州市";
            modelR.province = @"江苏省";
        }
        
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
        }];
    }];
}

#pragma mark - 建立BannerUI
- (void)setupBanner{
    
    cycScrollBanner = [[XLCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 120)];
    cycScrollBanner.datasource = self;
    cycScrollBanner.delegate = self;
 
}

#pragma mark - 建立HeaderView筛选框UI
- (void)setupHeaderView{
    
    headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 40
                                                               )];
    headerView.tag = 1008;
    headerView.userInteractionEnabled = YES;
    headerView.backgroundColor = RGBHex(qwColor4);
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(APP_W/2, 4, 0.5, 30)];
    line.backgroundColor = RGBHex(qwColor10);
    [headerView addSubview:line];

    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 39.5, APP_W, 0.5)];
    line1.backgroundColor = RGBHex(qwColor10);
    [headerView addSubview:line1];
    
    leftButton = [[RightAccessButton alloc] initWithFrame:CGRectMake(30, 0, APP_W / 2.0 - 60, 40)];
    [headerView addSubview:leftButton];
    rightButton = [[RightAccessButton alloc] initWithFrame:CGRectMake(APP_W / 2.0 + 30, 0, APP_W / 2.0 - 60, 40)];
    [headerView addSubview:rightButton];
    
    UIImageView *accessView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 11)];
    UIImageView *accessView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 11)];
    
    
    [accessView1 setImage:[UIImage imageNamed:@"btn_img_down"]];
    [accessView2 setImage:[UIImage imageNamed:@"btn_img_down"]];
    
    
    leftButton.accessIndicate = accessView1;
    rightButton.accessIndicate = accessView2;

    [leftButton setCustomColor:RGBHex(qwColor7)];
    [rightButton setCustomColor:RGBHex(qwColor7)];
    
    
    
    [leftButton setButtonTitle:@"全部"];
    [rightButton setButtonTitle:@"按药房找"];
    leftButton.customFont = fontSystem(kFontS4);
    rightButton.customFont = fontSystem(kFontS4);
    
    [rightButton addTarget:self action:@selector(showRightTable:) forControlEvents:UIControlEventTouchDown];
    [leftButton addTarget:self action:@selector(showLeftTable:) forControlEvents:UIControlEventTouchDown];
    

    
    rightComboxView = [[ComboxView alloc] initWithFrame:CGRectMake(0, 40, APP_W, [rightMenuItems count]*44)];
    rightComboxView.delegate = self;
    rightComboxView.comboxDeleagte = self;
    rightComboxView.tableView.scrollEnabled = YES;
    
    leftIndex = 0;
    
    buttonsView = [[ButtonsView alloc]initWithFrame:CGRectMake(0, self.mainTableView.frame.origin.y, APP_W, APP_H - NAV_H - 40)];
    buttonsView.alpha = 0.0f;
    buttonsView.delegate = self;
}

#pragma mark - ButtonsView消失回调
- (void)buttonsViewHasRemoved{
    
    self.mainTableView.footerHidden = NO;
    [leftButton changeArrowDirectionUp:NO];
    [leftButton setTitleColor:RGBHex(qwColor7) forState:UIControlStateNormal];
    buttonsView.alpha = 0.0f;
    leftButton.isToggle = NO;
    leftButton.accessIndicate.image = [UIImage imageNamed:@"btn_img_down"];
    self.mainTableView.scrollEnabled = YES;

}
#pragma mark - 展示右边筛选框
- (void)showRightTable:(id)sender{
    
    self.mainTableView.footerHidden = YES;
    [self scrollToSectionHeaderVisible];
    [leftButton changeArrowDirectionUp:NO];
    leftButton.isToggle = NO;
    leftButton.accessIndicate.image = [UIImage imageNamed:@"btn_img_down"];
    [buttonsView removeView];
    
    if(rightButton.isToggle) {
        rightButton.isToggle = NO;
        [rightComboxView dismissView];
        
    }else{
        [rightButton setTitleColor:RGBHex(qwColor2) forState:UIControlStateNormal];
        rightComboxView.frame = CGRectMake(0, 40, APP_W, APP_H);
        if(rightMenuItems.count > 6){
            rightComboxView.tableView.frame = CGRectMake(0, 0, APP_W, 250);
        }else{
            rightComboxView.tableView.frame = CGRectMake(0, 0, APP_W, rightMenuItems.count * 44);
        }
        [rightComboxView.tableView reloadData];
        //筛选橘黄色按钮
        [rightButton changeArrowDirectionUp:YES];
        rightButton.accessIndicate.image = [UIImage imageNamed:@"btn_img_up"];
        [rightComboxView showInView:self.view];
        
        rightButton.isToggle = YES;
    }

}

#pragma mark - 展示左边筛选看ButtonsView
- (void)showLeftTable:(id)sender{
    
    self.mainTableView.footerHidden = YES;

    [self scrollToSectionHeaderVisible];
    [rightButton changeArrowDirectionUp:NO];
    rightButton.isToggle = NO;
    [rightComboxView dismissView];
    
    if(buttonsView.alpha == 0){
        [leftButton setTitleColor:RGBHex(qwColor2) forState:UIControlStateNormal];
        
        [leftButton changeArrowDirectionUp:YES];
        leftButton.accessIndicate.image = [UIImage imageNamed:@"btn_img_up"];
        
        buttonsView.frame = CGRectMake(0, 40, APP_W, APP_H - NAV_H - 40);
        
        NSMutableArray *array = [NSMutableArray array];
    
        for (int i = 0; i < leftMenuItems.count; i ++) {
            TagFilterVo *vo = leftMenuItems[i];
            [array addObject:vo.tagName];
        }

        [array insertObject:@"全部" atIndex:0];
        
        buttonsView.dataArray = array;
        buttonsView.selectIndex = leftIndex;
        [buttonsView setButtons];
        buttonsView.alpha = 0;
        [UIView animateWithDuration:0.4 animations:^{
            buttonsView.alpha = 1;
        } completion:^(BOOL finished) {
            self.mainTableView.scrollEnabled = NO;
            [self.view addSubview:buttonsView];
        }];
    }else{
        
        [leftButton changeArrowDirectionUp:NO];
        leftButton.accessIndicate.image = [UIImage imageNamed:@"btn_img_down"];
        [buttonsView removeView];
    }
}

#pragma mark - ButtonsView中按钮点击回调
- (void)buttonDidSelected:(NSInteger)index{
    leftIndex = index;
    if(index == 0){
        [leftButton setButtonTitle:@"全部"];
    }else{
        TagFilterVo *vo = leftMenuItems[index - 1];
        [leftButton setButtonTitle:vo.tagName];
    }
    [self.mainTableView.footer setCanLoadMore:YES];
    currentPage = 1;
    [self loadPromotionData];
}
#pragma mark - 右边筛选框ComboxView消失回调
- (void)comboxViewDidDisappear:(ComboxView *)combox{

    self.mainTableView.footerHidden = NO;
    if([combox isEqual:rightComboxView]){
        
        [rightButton setTitleColor:RGBHex(qwColor7) forState:UIControlStateNormal];
        
        [rightButton changeArrowDirectionUp:NO];
        //筛选灰色按钮
        rightButton.accessIndicate.image = [UIImage imageNamed:@"btn_img_down"];
        rightButton.isToggle = NO;
        self.mainTableView.scrollEnabled = YES;
        
    }else{
    
        leftButton.isToggle = NO;
        [leftButton changeArrowDirectionUp:YES];
        leftButton.accessIndicate.image = [UIImage imageNamed:@"btn_img_down"];
    }

}

#pragma mark - 请求筛选框数据(左边商品标签和右边药房列表)
- (void)loadTags{
    
    leftButton.userInteractionEnabled = NO;
    rightButton.userInteractionEnabled = NO;
    
    [[QWGlobalManager sharedInstance] readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
        
        TagModelR *modelR = [TagModelR new];
        
        if(mapInfoModel){
            modelR.city = mapInfoModel.city;
        }else{
            modelR.city = @"苏州市";
        }
        
        //商品标签请求
        [Promotion queryNearByPromotionTagWithParams:modelR success:^(id obj) {
            
            TagFilterList *List = obj;
            leftMenuItems = [NSArray arrayWithArray:List.list];
    
            leftButton.userInteractionEnabled = YES;
   
        } failure:^(HttpException *e) {
            leftButton.userInteractionEnabled = YES;
            
        }];
        //药房列表请求
        [Promotion queryNearByPromotionGroupTagWithParams:modelR success:^(id obj) {
            
            GroupFilterList *List = obj;
            
            if(List.list.count != 0){
                
                [rightMenuItems removeAllObjects];
                GroupFilterVo *vo = [GroupFilterVo new];
                vo.groupName = @"全部药房";
                
                [rightMenuItems addObject:vo];
                [rightMenuItems addObjectsFromArray:List.list];
            }
            
            rightButton.userInteractionEnabled = YES;
            
        } failure:^(HttpException *e) {
             rightButton.userInteractionEnabled = YES;
        }];
    }];
}

#pragma mark - 请求优惠商品数据，未筛选/筛选后均走这个方法
- (void)loadPromotionData{
    [self removeInfoView];
    UIView *footView = [[UIView alloc]init];
    footView.backgroundColor = RGBHex(qwColor11);
    self.mainTableView.tableFooterView = footView;
    self.mainTableView.footerHidden = NO;
    self.mainTableView.scrollEnabled = YES;
    
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
        
        modelR.page = currentPage;
        modelR.pageSize = 10;
        
        //fixed by lijian at V3.2.0
        //该处功能点请求接口和逻辑均被替换，筛选老功能请求逻辑代码遗失
        //左边种类筛选栏是否有选中对象
        if(leftIndex != 0){
            TagFilterVo *vo = leftMenuItems[leftIndex - 1];
            modelR.tagCode = vo.tagCode;
        }
        //右边边药房筛选栏是否有选中对象
        if(rightIndex != -1){
            GroupFilterVo *vo = rightMenuItems[rightIndex];
            modelR.groupId = vo.groupId;
        }
        
        if(currentPage == 1){
            [QWLOADING showLoading];
        }else{
            [QWLOADING closeLoading];
        }
        [Promotion queryNewNearByTwoListWithParams:modelR success:^(id obj) {
            [QWLOADING removeLoading];

            // perry comment
            NSMutableArray *keyArray = [NSMutableArray array];
            [keyArray addObject:NSStringFromClass([ChannelProductVo class])];
            [keyArray addObject:NSStringFromClass([ChannelProductVo class])];
            [keyArray addObject:NSStringFromClass([ActivityCategoryVo class])];
            
            NSMutableArray *valueArray = [NSMutableArray array];
            [valueArray addObject:@"normalPromotionList"];
            [valueArray addObject:@"hotPromotionList"];
            [valueArray addObject:@"promotionList"];
            
            
            PromotionProductArrayVo *list = [PromotionProductArrayVo parse:obj ClassArr:keyArray Elements:valueArray];
            
            if([list.apiStatus intValue]==0){
               
                if(currentPage == 1){//页数为一的情况
                    self.mainTableView.contentInsetBottom = 0;
                    self.mainTableView.contentOffsetY = 0;
                    [self.dataArray removeAllObjects];
                    [self.topArray removeAllObjects];
                    [self.topArray addObjectsFromArray:list.hotPromotionList];
                    [self.dataArray addObjectsFromArray:list.normalPromotionList];
                    
                    if(list.normalPromotionList.count == 0){
                        [self showMyInfoView:@"对不起，暂时没有你想要的优惠"];
                        [self.mainTableView reloadData];
                        return;
                    }
                }else{//页数为2的情况
                    
                    if(list.normalPromotionList.count > 0){
                        [self.dataArray addObjectsFromArray:list.normalPromotionList];
                    }
                }

                if(list.normalPromotionList.count < 10){
                    if(currentPage != 1){
                        [self.mainTableView.footer endRefreshing];
                        [self.mainTableView.footer setCanLoadMore:NO];
                    }else{
                        [self.mainTableView.footer endRefreshing];
                    }
                 }else{
                    [self.mainTableView.footer endRefreshing];
                }

                currentPage++;
            }else{
                if([list.apiStatus intValue] == 1){
                    [self showMyInfoView:@"城市名称不能为空"];
                }else{
                    [self showMyInfoView:kWarning215N10];
                }
            }
            [self.mainTableView reloadData];
            

        } failure:^(HttpException *e) {
            [self.mainTableView footerEndRefreshing];
            [QWLOADING closeLoading];
        }];
        
    }];
}

- (void)scrollToSectionHeaderVisible
{
    CGRect rectZero = CGRectZero;
    if (self.topArray.count == 0) {
        rectZero = [self.mainTableView rectForSection:0];
    } else {
        rectZero = [self.mainTableView rectForSection:1];
    }
    
    if(rectZero.origin.y > self.mainTableView.contentOffset.y) {
        [self.mainTableView setContentOffset:CGPointMake(0, rectZero.origin.y) animated:YES];
    }
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

- (void)scrollToTop:(UIButton *)sender
{
    [self.mainTableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [super scrollViewDidScroll:scrollView];
    [UIView animateWithDuration:0.25f animations:^{
        if(scrollView.contentOffset.y > 0) {
            self.topButton.alpha = 1.0f;
        }else{
            self.topButton.alpha = 0.0f;
        }
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:self.mainTableView]) {
        if (self.topArray.count > 0) {
            return 2;
        } else {
            return 1;
        }
    } else {
        return 1;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([tableView isEqual:self.mainTableView]){
        //  置顶array 和 普通array 一样的高度
        ChannelProductVo *vo=nil;
         if (self.topArray.count > 0) {//疯抢商品的时候有两个section
             if(indexPath.section==0){
                 vo = self.topArray[indexPath.row];
             }else{
                 vo = self.dataArray[indexPath.row];
             }
         }else{
             vo = self.dataArray[indexPath.row];
         }
//        return [MyMutableMorePromotionTableViewCell getCellHeight:vo];
        
        return [MutableMorePromotionTableViewCell getCellHeight:vo];
        
    }else{
        return 44.0f;
    }
}



//-(void)expandCell:(NSIndexPath *)selectCellIndex{
//    ChannelProductVo *vo=nil;
//    if (self.topArray.count > 0) {//疯抢商品的时候有两个section
//        if(selectCellIndex.section==0){
//            vo = self.topArray[selectCellIndex.row];
//        }else{
//            vo = self.dataArray[selectCellIndex.row];
//        }
//    }else{
//        vo = self.dataArray[selectCellIndex.row];
//    }
//    if(vo.isSelect){
//        vo.isSelect=NO;
//    }else{
//        vo.isSelect=YES;
//    }
//    
//    [self.mainTableView reloadData];
//}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if([tableView isEqual:self.mainTableView]){
        if (self.topArray.count > 0) {      // 如果有置顶数组
            if (section == 1) {
                return 40;
            }
        } else {
            return 40;
        }
    }else{
        return 0;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if([tableView isEqual:self.mainTableView]){
        if (self.topArray.count > 0) {      // 如果有置顶数组
            if (section == 1) {
                return headerView;
            }
        } else {
            return headerView;
        }
    }else{
        return nil;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([tableView isEqual:self.mainTableView]){
        //comment by perry 如果有置顶，则第一个section返回置顶数组个数
        if (self.topArray.count > 0) {
            if (section == 0) {
                return self.topArray.count;
            } else {
                return self.dataArray.count;
            }
        } else {
            return self.dataArray.count;
        }
    }
 
    if([tableView isEqual:rightComboxView.tableView]){
        return rightMenuItems.count;
    }
    return 0;
}

#pragma mark - MyMutableMorePromotionTableViewCellDelegate
- (void)didSepllCellAtIndexPath:(NSIndexPath *)path{
    
    ChannelProductVo *vo = nil;
    if (self.topArray.count > 0) {
        if (path.section == 0) {
            vo = self.topArray[path.row];
        } else {
            vo = self.dataArray[path.row];
        }
    } else {
        vo = self.dataArray[path.row];
    }
    vo.spellFlag = !vo.spellFlag;
    
    [self.mainTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([tableView isEqual:self.mainTableView]){
        
        //预演
//        static NSString *Identifier = @"MyMutableMorePromotionTableViewCell";
//        MyMutableMorePromotionTableViewCell *cell = (MyMutableMorePromotionTableViewCell *)[self.tableMain dequeueReusableCellWithIdentifier:Identifier];
//        if(cell == nil){
//            UINib *nib = [UINib nibWithNibName:@"MyMutableMorePromotionTableViewCell" bundle:nil];
//            [tableView registerNib:nib forCellReuseIdentifier:Identifier];
//            cell = (MyMutableMorePromotionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Identifier];
//            cell.SpellDelegate = self;
//        }
//        
//        ChannelProductVo *vo = nil;
//        if (self.topArray.count > 0) {
//            if (indexPath.section == 0) {
//                vo = self.topArray[indexPath.row];
//            } else {
//                vo = self.dataArray[indexPath.row];
//            }
//        } else {
//            vo = self.dataArray[indexPath.row];
//        }
//        cell.selectedCell = indexPath;
//        
//        [cell setupCell:vo];
//        return cell;
        
        //2.2.4
        MutableMorePromotionTableViewCell *cell = (MutableMorePromotionTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"MutableMorePromotionTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        

        //comment by perry 如果有置顶数组，则第一个section拿置顶数组的内容
        ChannelProductVo *vo = nil;
        if (self.topArray.count > 0) {
            if (indexPath.section == 0) {
                vo = self.topArray[indexPath.row];
            } else {
                vo = self.dataArray[indexPath.row];
            }
        } else {
            vo = self.dataArray[indexPath.row];
        }
        [cell setupCell:vo];
        return cell;
    }
    
    if([tableView isEqual:rightComboxView.tableView]){
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];//以indexPath来唯一确定cell
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; //出列可重用的cell
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault           reuseIdentifier:CellIdentifier];
        }
        GroupFilterVo *vo = rightMenuItems[indexPath.row];
        
        cell.textLabel.text = vo.groupName;
        
        cell.textLabel.font = fontSystem(14.0f);
        
        if(indexPath.row == rightIndex){
            cell.textLabel.textColor = RGBHex(qwColor2);
            UIImageView *tag = [[UIImageView alloc]initWithFrame:CGRectMake(APP_W - 30, 10, 20, 20)];
            tag.image = [UIImage imageNamed:@"ic_btn_success"];
            cell.accessoryView = tag;
            
        }else{
            cell.accessoryView = nil;
            cell.textLabel.textColor = RGBHex(qwColor6);
        }
        
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([tableView isEqual:self.mainTableView]){
        
        //comment by perry 如果有置顶数组，则第一个section拿置顶数组的内容
        ChannelProductVo *vo = nil;
        if (self.topArray.count > 0) {
            if (indexPath.section == 0) {
                vo = self.topArray[indexPath.row];
            } else {
                vo = self.dataArray[indexPath.row];
            }
        } else {
            vo = self.dataArray[indexPath.row];
        }
        //进入详情
        if(!vo.multiPromotion)
        {
            NSString *pid=@"";
            if(vo.promotionList.count==1){
                ActivityCategoryVo *ov = vo.promotionList[0];
                pid=ov.pid;
                //渠道统计
                ChannerTypeModel *modelTwo=[ChannerTypeModel new];
                modelTwo.objRemark=vo.proName;
                modelTwo.objId=vo.proId;
                modelTwo.cKey=@"e_yhsp_click";
                [QWGLOBALMANAGER qwChannel:modelTwo];
            }
            
            WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
            
            [[QWGlobalManager sharedInstance] readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {

                NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
                tdParams[@"商品内容"]=vo.proName;
                [QWGLOBALMANAGER statisticsEventId:@"x_yhsplb_dj" withLable:@"优惠商品详情" withParams:tdParams];
                
                WebDrugDetailModel *modelDrug = [WebDrugDetailModel new];
                modelDrug.modelMap = mapInfoModel;
                modelDrug.proDrugID = vo.proId;
                modelDrug.promotionID = pid;
                WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
                modelLocal.modelDrug = modelDrug;
                modelLocal.typeLocalWeb = WebPageToWebTypeMedicine;
                [vcWebMedicine setWVWithLocalModel:modelLocal];
                [self.navigationController pushViewController:vcWebMedicine animated:YES];
                
            }];
        }
        else
        {
            //跳转到新的活动列表
            PromotionActivityDetailViewController *drugDetail = [[PromotionActivityDetailViewController alloc]init];
            drugDetail.vo = vo;
            drugDetail.sourceType=@"1";
            //防止后来接口有改动
//            if(![self.groupIdisEqualToString:@""]){
//                drugDetail.groupId=self.groupId;
//            }
            [self.navigationController pushViewController:drugDetail animated:YES];
            
            
        }
    }
 
    if([tableView isEqual:rightComboxView.tableView]){
        
        if(indexPath.row == 0){
            
            rightIndex = -1;
            [rightButton setButtonTitle:@"按药房找"];
            
        }else{
            GroupFilterVo *vo = rightMenuItems[indexPath.row];
            [rightButton setButtonTitle:vo.groupName];
            rightIndex = indexPath.row;
        }
        [self scrollToSectionHeaderVisible];
        [self.mainTableView.footer setCanLoadMore:YES];
        currentPage = 1;
        [self loadPromotionData];
        [rightComboxView dismissView];
    }
}


#pragma mark - 优惠商品搜索按钮触发函数
- (void)searchPromotion:(id)sender{
    
    [buttonsView removeView];
    [rightComboxView dismissView];
    SearchPromotionViewController *searchPromotionView = [[SearchPromotionViewController alloc]initWithNibName:@"SearchPromotionViewController" bundle:nil];
    searchPromotionView.typeIndex=@"1";
    [self.navigationController pushViewController:searchPromotionView animated:YES];
}

- (void)popVCAction:(id)sender{
    [super popVCAction:sender];
    [cycScrollBanner stopAutoScroll];
    cycScrollBanner = nil;
    
}

- (void)showMyInfoView:(NSString *)str{
    
    [self.mainTableView removeFooter];
    
    UIView *footView = [[UIView alloc]init];
    
    if(BannerArray.count > 0){
        footView.frame = CGRectMake(0, 0, APP_W, APP_H - NAV_H - cycScrollBanner.frame.size.height);
    }else{
        footView.frame = CGRectMake(0, 0, APP_W, APP_H - NAV_H);
    }
    
    footView.backgroundColor = RGBHex(qwColor11);
    
    UIImage *infoImg = [UIImage imageNamed:@"ic_img_fail"];
    UIImageView *cryImage = [[UIImageView alloc]initWithFrame:CGRectMake(APP_W/2 - 75, 45 , infoImg.size.width, infoImg.size.height)];
    cryImage.image = infoImg;
    [footView addSubview:cryImage];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, APP_W, 21)];
    label.font = fontSystem(kFontS1);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = RGBHex(qwColor8);
    label.text = str;
    label.center = footView.center;
    CGRect rect = label.frame;
    rect.origin.y = cryImage.frame.origin.y + cryImage.frame.size.height +  25;
    label.frame = rect;
    [footView addSubview:label];
    
    self.mainTableView.tableFooterView = footView;
}

@end
