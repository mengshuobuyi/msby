//
//  HealthInfoListViewController.m
//  APP
// 
//  Created by PerryChen on 1/4/16.
//  Copyright © 2016 carret. All rights reserved.
//

#import "HealthInfoListViewController.h"
#import "HealthInfoCell/HealthCellStyleSmallImg.h"
#import "HealthInfoCell/HealthCellStyleLargeImg.h"
#import "HealthInfoCell/HealthCellStyleThreeImg.h"
#import "HealthInfoCell/HealthCellStyleOnlyText.h"

#import "InfoMsg.h"
#import "EvaluateProductViewController.h"
#import "WebDirectViewController.h"

#import "Healthinfo.h"

#define CellStyleSmallImg @"HealthCellStyleSmallImg"
#define CellStyleLargeImg @"HealthCellStyleLargeImg"
#define CellStyleThreeImg @"HealthCellStyleThreeImg"
#define CellStyleOnlyText @"HealthCellStyleOnlyText"

static float ratioScreenW;

@interface HealthInfoListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;
@property (nonatomic, strong) NSMutableArray *arrList;
@property (nonatomic, assign) NSInteger curPage;

@end

@implementation HealthInfoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrList = [@[] mutableCopy];
    ratioScreenW = 320.0f / APP_W;
    
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 7)];
    viewHeader.backgroundColor = RGBHex(qwColor11);
    self.tbViewContent.tableHeaderView = viewHeader;
    [self.tbViewContent registerNib:[UINib nibWithNibName:@"HealthCellStyleSmallImg" bundle:nil] forCellReuseIdentifier:CellStyleSmallImg];
    [self.tbViewContent registerNib:[UINib nibWithNibName:@"HealthCellStyleLargeImg" bundle:nil] forCellReuseIdentifier:CellStyleLargeImg];
    [self.tbViewContent registerNib:[UINib nibWithNibName:@"HealthCellStyleThreeImg" bundle:nil] forCellReuseIdentifier:CellStyleThreeImg];
    [self.tbViewContent registerNib:[UINib nibWithNibName:@"HealthCellStyleOnlyText" bundle:nil] forCellReuseIdentifier:CellStyleOnlyText];

    [self.tbViewContent addFooterWithTarget:self action:@selector(loadMoreFunc)];
  
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self performSelector:@selector(addRefreshTop) withObject:nil afterDelay:1.0f];

}

- (void)addRefreshTop
{
    if([self.tbViewContent viewWithTag:1018] == nil) {
        __weak typeof (self) __weakSelf = self;
        [self enableSimpleRefresh:self.tbViewContent block:^(SRRefreshView *sender) {
            [__weakSelf headerReload];
        }];
    }
}

- (void)refreshData
{
    if (!self.hadLoadInitialData) {
        self.curPage = 1;
        HttpClientMgr.progressEnabled = YES;
        [self requestList];
        self.hadLoadInitialData = NO;
    }
}

- (void)headerReload
{
    self.curPage = 1;
    HttpClientMgr.progressEnabled = NO;
    [self requestList];
//    self.hadLoadInitialData = NO;
}

// 点击背景图
- (void)viewInfoClickAction:(id)sender
{
    self.curPage = 1;
    HttpClientMgr.progressEnabled = YES;
    [self requestList];
}

- (void)requestList
{
    InfoMsgListModelR *modelR = [InfoMsgListModelR new];
    modelR.channelID = self.channelID;
    modelR.currPage = [NSString stringWithFormat:@"%d",self.curPage];
    modelR.pageSize = @"10";
    [InfoMsg getMsgListWithChannelID:modelR success:^(MsgArticleListVO *model) {
        self.hadLoadInitialData = YES;
        [self removeInfoView];
        [self.tbViewContent headerEndRefreshing];
        [self.tbViewContent footerEndRefreshing];
        
        if (self.curPage == 1) {
            if (self.arrList.count > 0) {
                [self.arrList removeAllObjects];
            }
            self.arrList = [[NSMutableArray alloc] initWithArray:model.list];
        } else {
            [self.arrList addObjectsFromArray:model.list];
        }
        if (model.list.count == 0) {
            [self.tbViewContent.footer setCanLoadMore:NO];
        } else {
//            [self.tbViewContent.footer setCanLoadMore:YES];
        }

        [self.tbViewContent reloadData];
    } failure:^(HttpException *e) {
        [self.tbViewContent headerEndRefreshing];
        [self.tbViewContent footerEndRefreshing];
        [self showInfoView:@"暂无数据" image:@"ic_img_fail"];
    }];
}

- (void)loadMoreFunc
{
    self.curPage++;
    HttpClientMgr.progressEnabled = NO;
    [self requestList];
}

- (void)reloadContentData:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MsgArticleVO *model = self.arrList[indexPath.row];
    if ([model.showType intValue] == 1) {
        return [self setCellStyleOnlyTextWithIndex:indexPath];
    } else if ([model.showType intValue] == 2) {
        return [self setCellStyleOneWithIndex:indexPath];
    } else if ([model.showType intValue] == 3) {
        return [self setCellStyleThreeWithIndex:indexPath];
    } else {
        return [self setCellStyleTwoWithIndex:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MsgArticleVO *model = self.arrList[indexPath.row];
    if ([model.showType intValue] == 1) {
        return [self calculateCellStyleOnlyTextWithIndex:indexPath];
    } else if ([model.showType intValue] == 2) {
        return [self calculateCellStyleOneContentWithIndex:indexPath];
    } else if ([model.showType intValue] == 3) {
        return [self calculateCellStyleThreeContentWithIndex:indexPath];
    } else {
        return [self calculateCellStyleTwoContentWithIndex:indexPath];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (HealthCellStyleThreeImg *)setCellStyleThreeWithIndex:(NSIndexPath *)idxPath
{
    HealthCellStyleThreeImg *healthCell = [self.tbViewContent dequeueReusableCellWithIdentifier:CellStyleThreeImg];
    MsgArticleVO *model = self.arrList[idxPath.row];
    [healthCell setCell:model];
    if (self.isTopicChannel) {
        healthCell.viewTopic.hidden = YES;
    }
    return healthCell;
}

- (HealthCellStyleLargeImg *)setCellStyleTwoWithIndex:(NSIndexPath *)idxPath
{
    HealthCellStyleLargeImg *healthCell = [self.tbViewContent dequeueReusableCellWithIdentifier:CellStyleLargeImg];
    MsgArticleVO *model = self.arrList[idxPath.row];
    [healthCell setCell:model];
    if (self.isTopicChannel) {
        healthCell.viewTop.hidden = YES;
    }
    return healthCell;
}

- (HealthCellStyleSmallImg *)setCellStyleOneWithIndex:(NSIndexPath *)idxPath
{
    HealthCellStyleSmallImg *healthCell = [self.tbViewContent dequeueReusableCellWithIdentifier:CellStyleSmallImg];
    MsgArticleVO *model = self.arrList[idxPath.row];
    [healthCell setCell:model];
    if (self.isTopicChannel) {
        healthCell.viewTop.hidden = YES;
    }
    return healthCell;
}

- (HealthCellStyleOnlyText *)setCellStyleOnlyTextWithIndex:(NSIndexPath *)idxPath
{
    HealthCellStyleOnlyText *healthCell = [self.tbViewContent dequeueReusableCellWithIdentifier:CellStyleOnlyText];
    MsgArticleVO *model = self.arrList[idxPath.row];
    [healthCell setCell:model];
    if (self.isTopicChannel) {
        healthCell.viewTop.hidden = YES;
    }
    return healthCell;
}

- (CGFloat)calculateCellStyleOneContentWithIndex:(NSIndexPath *)idxPath
{
    static HealthCellStyleSmallImg *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tbViewContent dequeueReusableCellWithIdentifier:CellStyleSmallImg];
    });
    MsgArticleVO *model = self.arrList[idxPath.row];
    [sizingCell setCell:model];
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tbViewContent.bounds), CGRectGetHeight(sizingCell.bounds));
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGSize sizeFinal = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return sizeFinal.height+1;
}

- (CGFloat)calculateCellStyleThreeContentWithIndex:(NSIndexPath *)idxPath
{
    static HealthCellStyleThreeImg *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tbViewContent dequeueReusableCellWithIdentifier:CellStyleThreeImg];
    });
    MsgArticleVO *model = self.arrList[idxPath.row];
    [sizingCell setCell:model];
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tbViewContent.bounds), CGRectGetHeight(sizingCell.bounds));
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGSize sizeFinal = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return sizeFinal.height+1;
}

- (CGFloat)calculateCellStyleTwoContentWithIndex:(NSIndexPath *)idxPath
{
    static HealthCellStyleLargeImg *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tbViewContent dequeueReusableCellWithIdentifier:CellStyleLargeImg];
    });
    MsgArticleVO *model = self.arrList[idxPath.row];
    [sizingCell setCell:model];
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tbViewContent.bounds), CGRectGetHeight(sizingCell.bounds));
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGSize sizeFinal = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return sizeFinal.height+1;
}

- (CGFloat)calculateCellStyleOnlyTextWithIndex:(NSIndexPath *)idxPath
{
    static HealthCellStyleOnlyText *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tbViewContent dequeueReusableCellWithIdentifier:CellStyleOnlyText];
    });
    MsgArticleVO *model = self.arrList[idxPath.row];
    [sizingCell setCell:model];
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tbViewContent.bounds), CGRectGetHeight(sizingCell.bounds));
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGSize sizeFinal = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return sizeFinal.height+1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MsgArticleVO *modelVO = self.arrList[indexPath.row];
    
//    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
//    tdParams[@"资讯名"]=modelVO.title;
//    tdParams[@"所属频道"] = self.channelName;
//    tdParams[@"阅读数"] = [NSString stringWithFormat:@"%d",modelVO.readCount];
//    [QWGLOBALMANAGER statisticsEventId:@"x_zx_dj" withLable:@"资讯" withParams:tdParams];
    
    [QWGLOBALMANAGER statisticsEventId:@"阅读_点击某个资讯" withLable:@"资讯" withParams:nil];
    
    WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    WebHealthInfoModel *modelHealth = [[WebHealthInfoModel alloc] init];
    WebDirectLocalModel *modelLocal = [[WebDirectLocalModel alloc] init];
    __weak typeof(self) unself = self;

    if ([modelVO.artType intValue] == 1) {
        modelHealth.msgID = modelVO.msgID;
        modelHealth.contentType = modelVO.contentType;
        modelLocal.modelHealInfo = modelHealth;
        modelLocal.typeLocalWeb = WebPageToWebTypeInfo;
        
        NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:10];
        param[@"adviceId"] = modelVO.msgID;
        
        __weak HealthInfoListViewController *weakSelf = self;
        
        [Healthinfo readAdviceWithParams:param
                                 success:^(id obj){
                                     
                                 }
                                 failure:^(HttpException *e){
                                 }];
        
        vcWebDirect.blockInfoList = ^(BOOL success){
            modelVO.readCount = [NSString stringWithFormat:@"%d",[modelVO.readCount intValue]+1];
            [unself.tbViewContent reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        //渠道统计
        ChannerTypeModel *modelre=[ChannerTypeModel new];
        modelre.objRemark=modelVO.title;
        modelre.objId=modelVO.msgID;
        modelre.cKey=@"e_tab_zx";
        [QWGLOBALMANAGER qwChannel:modelre];
    } else {
        modelLocal.url = [NSString stringWithFormat:@"%@QWYH/web/message/html/subject.html?id=%@",H5_BASE_URL,modelVO.spclID];
        modelLocal.typeLocalWeb = WebLocalTypeOuterLink;
        modelLocal.typeTitle = WebTitleTypeOnlyShare;
//        modelLocal.title = @"专题";
        vcWebDirect.isOtherLinks = YES;
    }
    [vcWebDirect setWVWithLocalModel:modelLocal];
    vcWebDirect.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vcWebDirect animated:YES];
    

}

- (void)scrollToTop
{
 
    [self.tbViewContent setContentOffset:CGPointZero animated:YES];
}

@end
