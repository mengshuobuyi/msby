//
//  TaReplyViewController.m
//  wenYao-store
//
//  Created by Yang Yuexia on 16/1/15.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "TaReplyViewController.h"
#import "Circle.h"
#import "CircleModel.h"
#import "MyBackTopicCell.h"
#import "SVProgressHUD.h"
#import "PostDetailViewController.h"

@interface TaReplyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger currentPage;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSMutableArray *dataList;
@end

@implementation TaReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataList = [NSMutableArray array];
    [self setUpTableView];
}

#pragma mark ---- 设置tableView ----
- (void)setUpTableView
{
    self.tableview.tableFooterView = [[UIView alloc] init];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.scrollEnabled = YES;
    self.tableview.backgroundColor = [UIColor clearColor];
    
    [self.tableview addFooterWithTarget:self action:@selector(footerRereshing)];
    self.tableview.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableview.footerReleaseToRefreshText = @"松开加载更多数据了";
    self.tableview.footerRefreshingText = @"正在帮你加载中";
    self.tableview.footerNoDataText=kWarning44;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(expertDidScrollToTop:)]) {
        [self.delegate expertDidScrollToTop:self];
    }
}

#pragma mark ---- 列表代理 ----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 10)];
    v.backgroundColor = RGBHex(qwColor11);
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MyBackTopicCell getCellHeight:self.dataList[indexPath.section]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *circleDetailCell = @"tareplyCell";
    MyBackTopicCell *cell = (MyBackTopicCell *)[tableView dequeueReusableCellWithIdentifier:circleDetailCell];
    if(cell == nil){
        UINib *nib = [UINib nibWithNibName:@"MyBackTopicCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:circleDetailCell];
        cell = (MyBackTopicCell *)[tableView dequeueReusableCellWithIdentifier:circleDetailCell];
    }

    [cell setCellData:self.dataList[indexPath.section] type:2];
    cell.topicBgView.tag = indexPath.section+1;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTopicAction:)];
    [cell.topicBgView addGestureRecognizer:tap];
    return cell;
}

- (void)setUpTableFrame:(CGRect)rect
{
    self.tableview.frame = rect;
}

- (void)currentViewSelected:(void (^)(CGFloat))finishLoading
{
    //他的回帖列表
    currentPage = 1;
    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
    setting[@"userId"] = StrFromObj(self.expertId);
    setting[@"page"] = [NSString stringWithFormat:@"%ld",(long)currentPage];
    setting[@"pageSize"] = @"10";
    [HttpClientMgr setProgressEnabled:NO];
    
    [Circle TeamHisReplyListWithParams:setting success:^(id obj) {
        
        [self removeInfoView];
        [self.dataList removeAllObjects];
        CircleReplayPageModel *page = [CircleReplayPageModel parse:obj Elements:[CircleReplayListModel class] forAttribute:@"postReplyList"];
        if ([page.apiStatus integerValue] == 0) {
            
            [self.dataList addObjectsFromArray:page.postReplyList];
            
            if (self.dataList.count > 0) {
                currentPage ++;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableview reloadData];
                });
                
            }else{
                [self showInfoView:@"暂无相关帖子" image:@"ic_img_fail"];
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:page.apiMessage];
        }
        
    } failure:^(HttpException *e) {
        if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
            [self showInfoView:kWarning12 image:@"网络信号icon"];
        }else
        {
            if(e.errorCode!=-999){
                if(e.errorCode == -1001){
                    [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                }else{
                    [self showInfoView:kWarning39 image:@"ic_img_fail"];
                }
                
            }
        }
    }];
}

- (void)footerRereshing
{
    //药师专栏
    
    if(self.dataList.count == 0) {
        [self showInfoView:@"暂无相关帖子" image:@"ic_img_fail"];
        return;
    }
    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
    setting[@"userId"] = StrFromObj(self.expertId);
    setting[@"page"] = [NSString stringWithFormat:@"%ld",(long)currentPage];
    setting[@"pageSize"] = @"10";
    [HttpClientMgr setProgressEnabled:NO];
    
    [Circle TeamHisReplyListWithParams:setting success:^(id obj) {
        
        [self removeInfoView];
        
        CircleReplayPageModel *listArr = [CircleReplayPageModel parse:obj Elements:[CircleReplayListModel class] forAttribute:@"postReplyList"];
        if ([listArr.apiStatus integerValue] == 0) {
            
            if (listArr.postReplyList.count == 0) {
                [self.tableview.footer setCanLoadMore:NO];
                [self.tableview footerEndRefreshing];
            }
            if (self.dataList.count > 0) {
                currentPage ++;
                [self.dataList addObjectsFromArray:listArr.postReplyList];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableview reloadData];
                });
            }else{
                
                if (currentPage == 1) {
                    [self showInfoView:@"暂无相关帖子" image:@"ic_img_fail"];
                }
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:listArr.apiMessage];
        }
        
    } failure:^(HttpException *e) {
        if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
            [self showInfoView:kWarning12 image:@"网络信号icon"];
        }else
        {
            if(e.errorCode!=-999){
                if(e.errorCode == -1001){
                    [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                }else{
                    [self showInfoView:kWarning39 image:@"ic_img_fail"];
                }
                
            }
        }
    }];
    
}


#pragma mark ---- 点击帖子标题进入帖子详情 ----
- (void)tapTopicAction:(UITapGestureRecognizer *)tap
{
    UIView *vi = tap.view;
    int row = vi.tag - 1;
    
    [QWGLOBALMANAGER statisticsEventId:@"专栏_Ta的回帖原帖标题" withLable:@"圈子" withParams:nil];
    
    PostDetailViewController* postDetailVC = [[UIStoryboard storyboardWithName:@"Forum" bundle:nil] instantiateViewControllerWithIdentifier:@"PostDetailViewController"];
    CircleReplayListModel* topic = self.dataList[row];
    postDetailVC.postId = topic.postId;
    postDetailVC.hidesBottomBarWhenPushed = YES;
    postDetailVC.preVCNameStr = @"Ta的发帖";
    [self.navigationController pushViewController:postDetailVC animated:YES];
    
    if (self.expertType == PosterType_YingYangShi) {
        [QWGLOBALMANAGER statisticsEventId:@"x_yyszl_dj" withLable:@"营养师专栏-点击某个帖子" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"分类":@"回帖"}]];
    }
    else if (self.expertType == PosterType_YaoShi)
    {
        [QWGLOBALMANAGER statisticsEventId:@"x_yszl_dj" withLable:@"营养师专栏-点击某个帖子" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"分类":@"回帖"}]];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
