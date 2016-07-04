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
//#import "HealthIndicatorDetailViewController.h"
#import "XLCycleScrollView.h"
//#import "LoginViewController.h"

#import "css.h"
#import "QWGlobalManager.h"

#import "Healthinfo.h"


@interface InformationListViewController ()<XLCycleScrollViewDelegate,XLCycleScrollViewDatasource>
{
    XLCycleScrollView *scrollView;
}
@property (nonatomic, strong) NSMutableArray    *likeArray;

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, assign) BOOL loadFromLocal;

@property (nonatomic, assign) NSInteger curPage;

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
    
    [self setupTableView];
    [self setupHeaderView];
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开加载更多数据了";
    self.tableView.footerRefreshingText = @"正在帮你加载中";
    __weak InformationListViewController *weakSelf = self;
    //上拉刷新
    [self.tableView addFooterWithCallback:^{
        if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
            weakSelf.curPage++;
            [weakSelf getHealthyAdviceList];
        } else {
            [SVProgressHUD showErrorWithStatus:@"网络未连接，请重试" duration:0.8f];
            [weakSelf.tableView footerEndRefreshing];
        }
    }];
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutAction) name:QUIT_OUT object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void) refresh
{
    NSLog(@"当前的标签：%@  当前标签id: %@",self.title,self.channelInfo.channelId);
    
    if(self.infoList.count == 0)
    {
        self.curPage = 1;
        [self getHealthyAdviceList];
    }
    
    if(self.bannerList.count == 0)
    {
        self.curPage = 1;
        [self getHealthyBannerList];
    }
    
    [self.tableView reloadData];
}


//所有对象里都有登出的操作
- (void)logoutAction
{
    if (self.infoList && self.infoList.count > 0) {
        [self.infoList removeAllObjects];
    }
    if (self.bannerList && self.bannerList.count > 0) {
        [self.bannerList removeAllObjects];
    }
}

#pragma mark -
#pragma mark 初始化ui

- (void)setupTableView
{
    CGRect rect = self.view.frame;
    rect.size.height -= (64 + 35 + 44);
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:UIColorFromRGB(0xecf0f1)];
    self.tableView.rowHeight = 120.0f;
    [self.view addSubview:self.tableView];
}

- (void)setupHeaderView
{
    scrollView = [[XLCycleScrollView alloc] initWithFrame:CGRectMake(0, 0,APP_W, 120)];
    scrollView.delegate = self;
    scrollView.datasource = self;
    self.tableView.tableHeaderView = scrollView;
}

#pragma mark -
#pragma mark XLCycleScrollViewDelegate  广告条代理
- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
{
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [SVProgressHUD showErrorWithStatus:@"网络未连接，请重试" duration:0.8f];
        return;
    }
    if (self.bannerList.count <= 0) {
        return;
    }
//    NSDictionary *dicBanner = self.bannerList[index];
//    HealthIndicatorDetailViewController *detailViewController = [[HealthIndicatorDetailViewController alloc] initWithNibName:@"HealthIndicatorDetailViewController" bundle:nil];
//    detailViewController.hidesBottomBarWhenPushed = YES;
//    detailViewController.intFromBanner = 1;
//    detailViewController.guideId = dicBanner[@"adviceId"];
//    detailViewController.infoDict = [dicBanner mutableCopy];
//    [self.navigationController pushViewController:detailViewController animated:YES];
    
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
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,320, 120)];
        [imageView setImage:[UIImage imageNamed:@"news_placeholder"]];
        return imageView;
    } else {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,320, 120)];
        HealthinfoChannelBanner* banner = self.bannerList[index];
        [imageView setImageWithURL:[NSURL URLWithString:banner.bannerImgUrl] placeholderImage:[UIImage imageNamed:@"news_placeholder"]];
        return imageView;
    }
}

#pragma mark -
#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f;
}

- (NSInteger)tableView:(UITableView *)atableView numberOfRowsInSection:(NSInteger)section
{
    return [self.infoList count];
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
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 120 - 0.5, APP_W, 0.5)];
    line.backgroundColor = UIColorFromRGB(0xdbdbdb);
    [cell addSubview:line];
    
    HealthinfoAdvicel *advicel = self.infoList[indexPath.row];
    
    cell.titleLabel.text = advicel.title;
    NSString *strTime = advicel.publishTime;
    
    if (strTime.length >= 10) {
        cell.dateLabel.text = [strTime substringToIndex:10];
    } else {
        cell.dateLabel.text = strTime;
    }
    
    cell.praiseLabel.text = [NSString stringWithFormat:@"%@",advicel.pariseNum];
    cell.readedLabel.text = [NSString stringWithFormat:@"%@",advicel.readNum];
    cell.contentLabel.text = advicel.introduction;

    [cell.avatar setImageWithURL:[NSURL URLWithString:advicel.iconUrl] placeholderImage:[UIImage imageNamed:@"news_placeholder"]];
    
    return cell;
}

- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [atableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (app.currentNetWork == kNotReachable) {
//        [SVProgressHUD showErrorWithStatus:@"网络未连接，请重试" duration:0.8f];
//        return;
//    }
    self.selectedIndex = indexPath.row;
//    HealthIndicatorDetailViewController *detailViewController = [[HealthIndicatorDetailViewController alloc] initWithNibName:@"HealthIndicatorDetailViewController" bundle:nil];
//    detailViewController.hidesBottomBarWhenPushed = YES;
//    detailViewController.infoList = self;
//    detailViewController.infoDict = self.infoList[indexPath.row];
//    [self.navigationController pushViewController:detailViewController animated:YES];
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
    
    HealthinfoAdvicelPage* page = [HealthinfoAdvicelPage getObjFromDBWithKey:key];
    
    if (page) {
        
        if (self.curPage == 1)
        {
            [self.infoList removeAllObjects];
        }
        
        for(id obj in page.data) {
            [self.infoList addObject:obj];
        }
        
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
    }
    else
    {
        __weak InformationListViewController *weakSelf = self;
        
        [Healthinfo QueryHealthAdviceListWithParams:param
                                      success:^(id obj){
                                          
                                          if (obj) {
                                              HealthinfoAdvicelPage* page = obj;
                                              page.advicePageId = key;
                                              [HealthinfoAdvicelPage saveObjToDB:page];
                                              if (weakSelf.curPage == 1)
                                              {
                                                  [self.infoList removeAllObjects];
                                              }
                                              
                                              for(id obj in page.data) {
                                                  [weakSelf.infoList addObject:obj];
                                              }
                                              
                                              [weakSelf.tableView reloadData];
                                              [self.tableView footerEndRefreshing];
                                          }
                                      }
                                      failure:^(HttpException *e){
                                          NSLog(@"获取AdvicelList失败");
                                          [self.tableView footerEndRefreshing];
                                      }];
    }
}

//广告条
- (void)getHealthyBannerList
{
    NSString * where = [NSString stringWithFormat:@"channelId = '%@'",self.channelInfo.channelId];
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
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"channelId"] = self.channelInfo.channelId;
        [Healthinfo queryChannelBannerWithParams:param
                                   success:^(id obj){
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
                                       NSLog(@"获取HealthyBannerList失败");
                                   }];
    }
}

@end
