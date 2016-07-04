//
//  InformationListViewController.m
//  quanzhi
//
//  Created by xiezhenghong on 14-6-24.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "InformationListViewController.h"
#import "InformationTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Constant.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "SBJson.h"
#import "WebDirectViewController.h"
#import "XLCycleScrollView.h"
#import "css.h"
#import "QWGlobalManager.h"
#import "Notification.h"
#import "Healthinfo.h"
#import "CRGradientLabel.h"
#import "LoginViewController.h"

@interface InformationListViewController ()<XLCycleScrollViewDelegate,XLCycleScrollViewDatasource, WebDirectBackDelegate>
{
    XLCycleScrollView *scrollView;
}
@property (nonatomic, strong) NSMutableArray    *likeArray;

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, assign) BOOL loadFromLocal;

@property (nonatomic, assign) NSInteger curPage;

@property (nonatomic, assign) NSInteger numOfLoad;

@property (nonatomic, assign) BOOL needRefresh;

@end

@implementation InformationListViewController

- (id)init
{
    self = [super init];
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.infoList = [NSMutableArray arrayWithCapacity:15];
    self.likeArray = [NSMutableArray arrayWithCapacity:15];
    self.bannerList = [NSMutableArray arrayWithCapacity:3];
    self.curPage = 1;
    self.numOfLoad = 0;
    self.strAdviceID = @"";
    [self setupTableView];
    [self setupHeaderView];
    self.tableMain.hidden = YES;
    [self.tableMain addStaticImageHeader];
    if (QWGLOBALMANAGER.currentNetWork == NotReachable) {
        [self showInfoView:kWarningN2 image:@"网络信号icon"];
    } else {

    }
    self.needRefresh = YES;
    self.selectedIndex = -1;
//    self.tableMain.footerPullToRefreshText = @"上拉可以加载更多数据了";
//    self.tableMain.footerReleaseToRefreshText = @"松开加载更多数据了";
//    self.tableMain.footerRefreshingText = @"正在帮你加载中";
//    self.tableMain.footerNoDataText = kWarning44;
    
    __weak InformationListViewController *weakSelf = self;
    //上拉刷新
    [self.tableMain addFooterWithCallback:^{
        weakSelf.curPage++;
        if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
            
            HttpClientMgr.progressEnabled=NO;
            
        } else {
            [SVProgressHUD showErrorWithStatus:kWarningN2 duration:0.8f];
            [weakSelf.tableMain footerEndRefreshing];
        }
        [weakSelf getHealthyAdviceList];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ((self.strAdviceID.length > 0)&&(self.selectedIndex >= 0)) {
        
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"adviceId"] = self.strAdviceID;
        [Healthinfo getHealthAdviceCountWithParams:param success:^(id obj) {
            HealthInfoReadCountModel *modelCount = (HealthInfoReadCountModel *)obj;
            HealthinfoAdvicel *advicel = self.infoList[self.selectedIndex];
            advicel.readNum = [NSString stringWithFormat:@"%@",modelCount.readCount];
            advicel.pariseNum = [NSString stringWithFormat:@"%@",modelCount.pariseCount];
            [self.tableMain reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.selectedIndex inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
            
        } failure:^(HttpException *e) {
            
        }];
    }
//    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
//        [self showInfoView:@"网络未连接，请重试" image:@"网络信号icon"];
//    }
}

- (void) refresh
{

//    if (QWGLOBALMANAGER.currentNetWork == NotReachable) {
//        [self showInfoView:@"网络未连接，请重试" image:@"网络信号icon"];
//    }
    if (self.needRefresh) {
        self.strAdviceID = @"";
        [self performSelector:@selector(subRefresh) withObject:nil afterDelay:0.5f];
    }
    self.needRefresh = YES;
}

- (void)subRefresh{
    self.tableMain.hidden = NO;
    self.tableMain.footer.canLoadMore = YES;
    DDLogVerbose(@"当前的标签：%@  当前标签id: %@",self.title,self.channelInfo.channelId);
    [self removeInfoView];
    if (QWGLOBALMANAGER.currentNetWork == NotReachable) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"channelId"] = self.channelInfo.channelId;
        param[@"currPage"] = [NSString stringWithFormat:@"%ld",(long)self.curPage];
        param[@"pageSize"] = @"10";
        NSString * key = [NSString stringWithFormat:@"%@_%@",param[@"channelId"],param[@"currPage"]];
         [self getHealthyBannerList];
        HealthinfoAdvicelPage* page = [HealthinfoAdvicelPage getObjFromDBWithKey:key];
        if (page) {
            if (self.curPage == 1)
            {
                [self.infoList removeAllObjects];
            }
            for(id obj in page.list) {
                [self.infoList addObject:obj];
            }
            [self.tableMain reloadData];
            [self.tableMain footerEndRefreshing];
        } else {
            [self showInfoView:kWarningN2 image:@"网络信号icon"];
        }
        
        return;
    } else {
        [self removeInfoView];
        self.curPage = 1;
        self.numOfLoad = 0;
        [self getHealthyAdviceList];
        [self getHealthyBannerList];
    }

//    if(self.bannerList.count == 0)
//    {
//        self.curPage = 1;
////        [self getHealthyBannerList];
//    }
//    else
//    {
////        [self getHealthyBannerList];
//    }
   
//    [self.tableMain reloadData];
}

//所有对象里都有登出的操作
- (void)logoutAction
{
//    if (self.infoList && self.infoList.count > 0) {
//        [self.infoList removeAllObjects];
//    }
//    if (self.bannerList && self.bannerList.count > 0) {
//        [self.bannerList removeAllObjects];
//    }
    [self.tableMain reloadData];
}

#pragma mark -
#pragma mark 初始化ui

- (void)setupTableView
{
    CGRect rect = self.view.frame;
    rect.size.height -= (64 + 35 + 44);
//    self.tableMain = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    self.tableMain.delegate = self;
    self.tableMain.dataSource = self;
    self.tableMain.frame=rect;
//    [self.tableMain setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableMain setBackgroundColor:RGBHex(qwColor11)];
    self.tableMain.rowHeight = 120.0f;
    [self.view addSubview:self.tableMain];
}

- (void)setupHeaderView
{
    scrollView = [[XLCycleScrollView alloc] initWithFrame:CGRectMake(0, 0,APP_W, 118*(APP_W/320.0F))];
    scrollView.delegate = self;
    scrollView.datasource = self;
    self.tableMain.tableHeaderView = scrollView;
}

#pragma mark -
#pragma mark XLCycleScrollViewDelegate  广告条代理

//banner点击的回调
- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
{
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
//        [SVProgressHUD showErrorWithStatus:@"网络未连接，请重试" duration:0.8f];
        return;
    }
    if (self.bannerList.count <= 0) {
        return;
    }
    
    HealthinfoChannelBanner *modelBanner = self.bannerList[index];
    HealthinfoAdvicel *advice = [HealthinfoAdvicel new];
    advice.adviceId = modelBanner.adviceId;
    self.strAdviceID = modelBanner.adviceId;
    self.selectedIndex = -1;
    self.needRefresh = NO;
    WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    
    WebHealthInfoModel *modelHealth = [[WebHealthInfoModel alloc] init];
    modelHealth.msgID = modelBanner.adviceId;
    
    WebDirectLocalModel *modelLocal = [[WebDirectLocalModel alloc] init];
    modelLocal.typeLocalWeb = WebPageToWebTypeInfo;
    [vcWebDirect setWVWithLocalModel:modelLocal];
    
    vcWebDirect.callBackDelegate = self;
    vcWebDirect.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vcWebDirect animated:YES];

}

- (NSInteger)numberOfPages
{
    if (self.bannerList.count <= 0) {
        return 1;
    } else {
        if(self.bannerList.count == 1){
            scrollView.pageControl.hidden = YES;
            return 1;
        }
        else{
        scrollView.pageControl.hidden = NO;
        return [self.bannerList count];
        }
    }
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    if (self.bannerList.count <= 0) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,APP_W, 118*(APP_W/320.0F))];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView setImage:[UIImage imageNamed:@"img_notice_nomal"]];
        return imageView;
    } else {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,APP_W, 118*(APP_W/320.0F))];
        imageView.contentMode = UIViewContentModeScaleAspectFit;//UIViewContentModeScaleAspectFill;//
        HealthinfoChannelBanner* banner = self.bannerList[index];
        [imageView setImageWithURL:[NSURL URLWithString:banner.bannerImgUrl] placeholderImage:[UIImage imageNamed:@"img_notice_nomal"]];
        CRGradientLabel *gradientLabel = [[CRGradientLabel alloc] initWithFrame:CGRectMake(1.8, 118*(APP_W/320.0F) - 25, APP_W-3.6, 20)];
        gradientLabel.gradientColors = @[[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.7f], [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.0f]];
        [imageView addSubview:gradientLabel];
        
        UILabel *bannerTitle=[[UILabel alloc]initWithFrame:CGRectMake(12, 118*(APP_W/320.0F) - 20, APP_W-24, 17)];
        bannerTitle.text=banner.bannerTitle;
        bannerTitle.font = font(kFont2, kFontS3);
        bannerTitle.textColor = [UIColor whiteColor];
        [imageView addSubview:bannerTitle];
        return imageView;
    }
}

#pragma mark -
#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [InformationTableViewCell getCellHeight:nil];
}

- (NSInteger)tableView:(UITableView *)atableView numberOfRowsInSection:(NSInteger)section
{
    if (self.infoList.count > 0) {
        return [self.infoList count];
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)atableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *InformationTableViewCellCellIdentifier = @"InformationTableViewCellCellIdentifier";
    InformationTableViewCell *cell = (InformationTableViewCell *)[atableView dequeueReusableCellWithIdentifier:InformationTableViewCellCellIdentifier];
    if(cell == nil)
    {
        UINib *nib = [UINib nibWithNibName:@"InformationTableViewCell" bundle:nil];
        [atableView registerNib:nib forCellReuseIdentifier:InformationTableViewCellCellIdentifier];
        cell = (InformationTableViewCell *)[atableView dequeueReusableCellWithIdentifier:InformationTableViewCellCellIdentifier];
        
    }
    if (self.infoList.count > 0) {
        HealthinfoAdvicel *mod = self.infoList[indexPath.row];

        [cell setCell:mod];
        [cell.introduction setLabelValue:[QWGLOBALMANAGER replaceSpecialStringWith:mod.introduction]];
        [cell.iconUrl setImageWithURL:[NSURL URLWithString:mod.iconUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
    }

    
    return cell;
}

//其他cell的点击的回调
- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - Delgate of the Health Information ViewCotroller
- (void)needUpdateList:(BOOL)needUp
{
    if (needUp) {
        [self.tableMain reloadData];
    }
}

- (void)needUpdateInfoList:(BOOL)needUp
{
    if (needUp) {
        [self.tableMain reloadData];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark 数据请求
//上拉刷新，每次取10条数据
- (void)getHealthyAdviceList
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"channelId"] = self.channelInfo.channelId;
    param[@"currPage"] = [NSString stringWithFormat:@"%ld",(long)self.curPage];
    param[@"pageSize"] = @"10";
    
    NSString * key = [NSString stringWithFormat:@"%@_%@",param[@"channelId"],param[@"currPage"]];

    if ((self.curPage == 1)&&(QWGLOBALMANAGER.currentNetWork != NotReachable)) {
        [HealthinfoAdvicelPage deleteObjFromDBWithKey:key];
    }
    HealthinfoAdvicelPage* page = [HealthinfoAdvicelPage getObjFromDBWithKey:key];
//    self.tableMain.footer.canLoadMore=[self checkTotal:page.totalRecords.integerValue pageSize:page.pageSize.integerValue pageNum:page.page.integerValue];
    if (QWGLOBALMANAGER.currentNetWork != NotReachable) {
        [self removeInfoView];
        __weak InformationListViewController *weakSelf = self;
        // change by perry: remove loading
//        if (self.numOfLoad <= 0) {
//            [QWLOADING showLoading];
//        }
        self.numOfLoad ++;
        [Healthinfo QueryHealthAdviceListWithParams:param
                                            success:^(id obj){
                                                self.numOfLoad--;
                                                // change by perry: remove loading
//                                                if (self.numOfLoad <= 0) {
//                                                    [QWLOADING removeLoading];
//                                                }
                                                if (obj) {
                                                    HealthinfoAdvicelPage* page = obj;
                                                    //                                              self.tableMain.footer.canLoadMore=[self checkTotal:page.totalRecords.integerValue pageSize:page.pageSize.integerValue pageNum:page.page.integerValue];
                                                    
                                                    
                                                    page.advicePageId = key;
                                                    [HealthinfoAdvicelPage saveObjToDB:page];
                                                    HealthinfoAdvicelPage* curpage = [HealthinfoAdvicelPage getObjFromDBWithKey:key];
                                                    if (weakSelf.curPage == 1)
                                                    {
                                                        [self.infoList removeAllObjects];
                                                    }
                                                    if (page.list.count == 0) {
                                                        self.tableMain.footer.canLoadMore = NO;
                                                    } else {
                                                        for(id obj in page.list) {
                                                            [weakSelf.infoList addObject:obj];
                                                        }
                                                        
                                                    }
                                                    [self.tableMain reloadData];
                                                    
                                                    [self.tableMain footerEndRefreshing];
                                                }
                                            }
                                            failure:^(HttpException *e){
                                                self.numOfLoad--;
                                                // change by perry: remove loading
//                                                if (self.numOfLoad <= 0) {
//                                                    [QWLOADING removeLoading];
//                                                }
                                                if (self.infoList.count == 0) {
                                                    [self showInfoView:kWarning39 image:@"ic_img_fail"];
                                                }
                                                //
                                                [self.tableMain footerEndRefreshing];
                                            }];

    } else {
        if (page) {
            
            if (self.curPage == 1)
            {
                [self.infoList removeAllObjects];
            }
            
            if (page.list.count == 0) {
                self.tableMain.footer.canLoadMore = NO;
            } else {
                for(id obj in page.list) {
                    [self.infoList addObject:obj];
                }
                
            }
            [self.tableMain reloadData];
            
            [self.tableMain footerEndRefreshing];
        }
        else
        {
        }

    }
    
//    HttpClientMgr.progressEnabled=YES;
}

//广告条
- (void)getHealthyBannerList
{

    NSString * where = [NSString stringWithFormat:@"channelId = '%@'",self.channelInfo.channelId];
    
    if (QWGLOBALMANAGER.currentNetWork != NotReachable) {
        [HealthinfoChannelBanner deleteObjFromDBWithWhere:where];
    }
    
    NSArray *modelArray = [HealthinfoChannelBanner getArrayFromDBWithWhere:where];
    
    if (modelArray && [modelArray count]>0) {

        [self.bannerList removeAllObjects];
        if([modelArray count] > 0) {
            [self.bannerList addObjectsFromArray:modelArray];
            if (modelArray.count == 1) {
                scrollView.scrollView.scrollEnabled = NO;
            } else {
                scrollView.scrollView.scrollEnabled = YES;
            }
        }
        else {
            scrollView.scrollView.scrollEnabled = NO;
        }
        [scrollView reloadData];
    }
    else
    {
        [self removeInfoView];
        if (QWGLOBALMANAGER.currentNetWork != NotReachable) {
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            param[@"channelId"] = self.channelInfo.channelId;
            // change by perry: remove loading
//            if (self.numOfLoad <= 0) {
//                [QWLOADING showLoading];
//            }
            self.numOfLoad ++;
            [Healthinfo queryChannelBannerWithParams:param
                                             success:^(id obj){
                                                 self.numOfLoad--;
                                                 // change by perry: remove loading
//                                                 if (self.numOfLoad <= 0) {
//                                                     [QWLOADING removeLoading];
//                                                 }
                                                 NSArray *modelArray = obj;
                                                 if (modelArray) {
                                                     
                                                     for (HealthinfoChannelBanner *banner in modelArray)
                                                     {
                                                         banner.channelId = param[@"channelId"];
                                                     }
                                                     //保存到数据库
                                                     [HealthinfoChannelBanner saveObjToDBWithArray:modelArray];
                                                     
                                                     [self.bannerList removeAllObjects];
                                                     
                                                     if([modelArray count] > 0) {
                                                         [self.bannerList addObjectsFromArray:modelArray];
                                                         if (modelArray.count == 1) {
                                                             scrollView.scrollView.scrollEnabled = NO;
                                                         } else {
                                                             scrollView.scrollView.scrollEnabled = YES;
                                                         }
                                                     }
                                                     else {
                                                         scrollView.scrollView.scrollEnabled = NO;
                                                     }
                                                     [scrollView reloadData];
                                                 }
                                             }
                                             failure:^(HttpException *e){
                                                 self.numOfLoad--;
                                                 // change by perry: remove loading
//                                                 if (self.numOfLoad <= 0) {
//                                                     [QWLOADING removeLoading];
//                                                 }
                                                 if(e.errorCode!=-999){
                                                     if(e.errorCode == -1001){
                                                         [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                                                     }else{
                                                         [self showInfoView:kWarning39 image:@"ic_img_fail"];
                                                     }
                                                     
                                                 }
                                                 DDLogVerbose(@"获取HealthyBannerList失败");
                                             }];
        }
    }
}

- (void)viewInfoClickAction:(id)sender
{
    if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        [self removeInfoView];
        self.numOfLoad = 0;
        [self getHealthyAdviceList];
        [self getHealthyBannerList];
    }
}

#pragma mark -
#pragma mark 处理本视图收到的通知
- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj{
    if (NotifQuitOut == type) {
        [self logoutAction];
    }
}

@end
