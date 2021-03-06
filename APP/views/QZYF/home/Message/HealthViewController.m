//
//  HealthViewController.m
//  APP
//
//  Created by  ChenTaiyu on 16/6/23.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "HealthViewController.h"
#import "Consult.h"
#import "SVProgressHUD.h"
#import "MsgBoxHealthCell.h"
#import "DetailSubscriptionListViewController.h"
#import "DiseaseSubList.h"
#import "WebDirectViewController.h"
#import "UITableView+FDTemplateLayoutCellCustomed.h"

@interface HealthViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ReturnIndexView *indexView;

@end

@implementation HealthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setUpRightItem];

    self.title = @"健康指南";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 500) style:UITableViewStylePlain];
    CGRect frame = self.view.bounds;
    frame.size.height -= [UIApplication sharedApplication].statusBarFrame.size.height +
    (self.navigationController ? self.navigationController.navigationBar.frame.size.height : 0) ;
    self.tableView.frame = frame;
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = RGB(242, 244, 247);
    
    UILabel *footer = [UILabel new];
    footer.frame = CGRectMake(0, 0, SCREEN_W, 20);
    self.tableView.tableFooterView = footer;
    
    __weak typeof (self) weakSelf = self;
    [self enableSimpleRefresh:self.tableView block:^(SRRefreshView *sender) {
        if(QWGLOBALMANAGER.currentNetWork == NotReachable)
        {
            [SVProgressHUD showErrorWithStatus:@"网络未连接，请稍后再试" duration:0.8f];
            return;
        }
        [weakSelf refreshConsultList];
    }];
    

    [self getCachedData];
    [self.tableView reloadData];
    [self showinfoViewIfNeeded];

    [self refreshConsultList];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma  mark - data process

- (void)getCachedData
{
// FIXME: NSArray读不出
//    self.dataArr = [MsgBoxHealthItemModel getArrayFromDBWithWhere:nil WithorderBy:@" time desc"];

    
    self.dataArr = [MsgBoxHealthItemModel searchWithWhere:nil orderBy:@" time desc" offset:0 count:0];
    [self convertTagsIfNeeded:self.dataArr];
//    for (MsgBoxHealthItemModel *item in self.dataArr) {
//        TagWithMessage *tag = [TagWithMessage new];
//        tag.UUID = @"kjas7dasdsakasd12312";
//        tag.start = @"0";
//        tag.length = @"3";
//        tag.title = @"asd";
//        tag.tagId = @"123";
//        tag.tagType = @"1"; // "1" = medicine  // outlink // postdetail // other --> dragguide
//        item.tags = @[tag];
//        item.source = @"7";
//        break;
//    }
}

- (void)convertTagsIfNeeded:(NSArray <MsgBoxHealthItemModel *> *)modelArr
{
    for (MsgBoxHealthItemModel *item in modelArr) {
        NSInteger source = item.source.integerValue;
        if (source != 10) { // 不是禁忌，tags用作高亮
            if ([item.tags isKindOfClass:[NSArray class]]) {
                if ([item.tags.firstObject isKindOfClass:[NSDictionary class]]) {
                    item.tags = [TagWithMessage parseArray:item.tags];
                }
            }
        }
    }
}

- (void)refreshConsultList
{
    MsgBoxHealthListModelR *modelR = [MsgBoxHealthListModelR new];
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    modelR.view = @"10000";
    [Consult getMsgBoxHealthListWithParam:modelR success:^(MsgBoxHealthListModel *responModel) {
        [self convertTagsIfNeeded:responModel.notices];
        self.dataArr = responModel.notices;
        [self showinfoViewIfNeeded];
        [self.tableView reloadData];
        [MsgBoxHealthItemModel syncDBWithObjArray:responModel.notices];
        [QWGLOBALMANAGER noticeUnreadLocalWithType:MsgBoxListMsgTypeHealth sessionID:nil isRead:YES];
    } failure:^(HttpException *e) {
        [SVProgressHUD showErrorWithStatus:@"网络错误" duration:0.5];
        [self showinfoViewIfNeeded];
    }];
}

- (void)showinfoViewIfNeeded
{
    if (!self.dataArr.count) {
        [self showInfoView:@"暂无健康指南消息~" image:@"ic_img_fail"];
    } else {
        [self removeInfoView];
    }
}


#ifdef DEBUG
- (NSArray *)fakeData
{
    NSMutableArray *arrM = [NSMutableArray array];
    for (int i = 0; i< 10; i++) {
        MsgBoxHealthItemModel *item = [MsgBoxHealthItemModel new];
        item.id = @"12345";
        item.title = @"XXXXXXXXX店asdbasdgsalihdaskhsalkhdlsakhdsaldsaldsagdasjhlgdsagsagsadsadga";
        item.content = @"您购买的XXXX有XX条饮食禁忌";
        item.formatShowTime = @"2012-12-12";
        item.unread = @"0";
        item.time = @"149812312312";
        item.tags = @[@{@"proName":@"AAAAA", @"taboo":@"不能AAAA……………………不能AAAA……………………不能AAAA……………………不能AAAA……………………不能AAAA……………………不能AAAA……………………不能AAAA……………………不能AAAA……………………不能AAAA……………………"}, @{@"proName":@"BBBBB", @"taboo":@"不能BBBB……………………不能BBBB……………………不能BBBB……………………不能BBBB……………………不能BBBB……………………不能BBBB……………………不能BBBB……………………不能BBBB……………………"}, @{@"proName":@"CCCCC", @"taboo":@"不能CCCC……………………不能CCCC……………………不能CCCC……………………不能CCCC……………………不能CCCC……………………不能CCCC……………………不能CCCC……………………"}]; //???: json? array?
        NSInteger ran = arc4random()%4 + 7;
        item.source = @(ran).stringValue; //来源：7.慢病订阅 8.用药指导 9.购药提醒 10.食物禁忌
        [arrM addObject:item];
    }
    return [arrM copy];
}
#endif


#pragma mark - interaction
- (void)setUpRightItem
{
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width = -6;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-unfold.PNG"] style:UIBarButtonItemStylePlain target:self action:@selector(returnIndex)];
    self.navigationItem.rightBarButtonItems = @[fixed,rightItem];
}

- (void)returnIndex
{
    self.indexView = [[ReturnIndexView alloc] initWithImage:@[@"icon_homepage_news"] title:@[@"首页"]];
    self.indexView.delegate = self;
    [self.indexView show];
}
- (void)RetunIndexView:(ReturnIndexView *)ReturnIndexView didSelectedIndex:(NSIndexPath *)indexPath
{
    [self.indexView hide];
    if (indexPath.row == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self performSelector:@selector(delayPopToHome) withObject:nil afterDelay:0.01];
    }
}

- (void)delayPopToHome
{
    [QWGLOBALMANAGER.tabBar setSelectedIndex:0];
}


- (void)viewInfoClickAction:(id)sender
{
    [self refreshConsultList];
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MsgBoxHealthItemModel *model = self.dataArr[indexPath.row];
    
    UITableViewCell *retCell = nil;
    NSInteger source = model.source.integerValue;
    if (source == 10) {
        MsgBoxHealthDietTipsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MsgBoxHealthDietTipsCell"];
        if (!cell) {
            cell = [MsgBoxHealthDietTipsCell cell];
        }
        [cell setCell:model tableView:tableView indexPath:indexPath ];
        retCell = cell;
    } else if (source == 7) {
        MsgBoxHealthCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"MsgBoxHealthCell3"];
        if (!cell) {
            cell = [MsgBoxHealthCell3 cell];
        }
        [cell setCell:model tableView:tableView indexPath:indexPath ];
        retCell = cell;
    } else if (source == 9) {
        MsgBoxHealthCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"MsgBoxHealthCell4"];
        if (!cell) {
            cell = [MsgBoxHealthCell4 cell];
        }
        [cell setCell:model tableView:tableView indexPath:indexPath ];
        retCell = cell;
    } else if (source == 8) {
        MsgBoxHealthCell5 *cell = [tableView dequeueReusableCellWithIdentifier:@"MsgBoxHealthCell5"];
        if (!cell) {
            cell = [MsgBoxHealthCell5 cell];
        }
        [cell setCell:model tableView:tableView indexPath:indexPath ];
        retCell = cell;
    }
    return retCell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MsgBoxHealthItemModel *model = self.dataArr[indexPath.row];
    NSInteger source = [model source].integerValue;
    if (source == 10) {
        return [MsgBoxHealthDietTipsCell getCachedCellHeightWithModel:model tableView:tableView indexPath:indexPath];
    } else if (source == 7) {
        return [MsgBoxHealthCell3 getCachedCellHeightWithModel:model tableView:tableView indexPath:indexPath];
    }
    else if (source == 9) {
        return [MsgBoxHealthCell4 getCachedCellHeightWithModel:model tableView:tableView indexPath:indexPath];
    }
    else if (source == 8) {
        return [MsgBoxHealthCell5 getCachedCellHeightWithModel:model tableView:tableView indexPath:indexPath];
    }
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - route event
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    if ([eventName isEqualToString:kRouterEventMsgBoxHealthCellLink]) {
        NSString *link = userInfo[@"link"];
        MLEmojiLabelLinkType type = [userInfo[@"type"] integerValue];
        NSIndexPath *indexPath = [self indexPathForCellContainingView:userInfo[@"source"]];
        MsgBoxHealthItemModel *model = self.dataArr[indexPath.row];
        if(type == MLEmojiLabelLinkTypeMedicineDetail)
        {
            [self pushToDrugDetailWithDrugID:[userInfo objectForKey:@"link"] promotionId:@""];
            
        }else if (type == MLEmojiLabelLinkTypeDrugGuide)
        {
            [self pushToSlowDiseaseWithModel:model link:link];
        }
    } else if ([eventName isEqualToString:kRouterEventMsgBoxHealthCellActionBtn]) {
        NSIndexPath *indexPath = [self indexPathForCellContainingView:userInfo[@"source"]];
        MsgBoxHealthItemModel *model = self.dataArr[indexPath.row];
        NSInteger type = model.source.integerValue;
        if (type == 7) {
            [self pushToSlowDiseaseWithModel:model link:nil];
        } else if (type == 9) {
            NSString *drugId;
            id tag = [model.tags firstObject];
            if ([tag isKindOfClass:[NSDictionary class]]) {
                drugId = tag[@"tagId"];
            } else if ([tag isKindOfClass:[TagWithMessage class]]) {
                drugId = [(TagWithMessage *)tag tagId];
            }
            [self pushToDrugDetailWithDrugID:drugId promotionId:@""];
        }
    }
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

- (void)pushToSlowDiseaseWithModel:(MsgBoxHealthItemModel *)model link:(NSString *)link {
    if (!link.length) {
        id tag = [model.tags firstObject];
        if ([tag isKindOfClass:[NSDictionary class]]) {
            link = tag[@"tagId"];
        } else if ([tag isKindOfClass:[TagWithMessage class]]) {
            link = [(TagWithMessage *)tag tagId];
        }
    }
    
    DetailSubscriptionListViewController *detailSubscriptionViewController = [[DetailSubscriptionListViewController alloc] init];
    NSString *title = @"慢病订阅";
    NSArray *tags = nil;
    if ([tags.firstObject isKindOfClass:[NSDictionary class]]) {
        tags = [TagWithMessage parseArray:model.tags];
    } else {
        tags = model.tags;
    }
    for(TagWithMessage *tag in tags)
    {
        if([tag.tagId isEqualToString:link]){
            title = [model.content substringWithRange:NSMakeRange([tag.start integerValue], [tag.length integerValue])];
            break;
        }
    }
    DrugGuideListModel  *modelDrugGuideR = [DrugGuideListModel  new];
    modelDrugGuideR.title = title;
    modelDrugGuideR.guideId  = link;
    detailSubscriptionViewController.modelDrugGuide = modelDrugGuideR;
    
    DiseaseSubList* diseasesublist = [DiseaseSubList getObjFromDBWithKey:link];
    if (diseasesublist) {
        diseasesublist.hasRead = @"YES";
        [DiseaseSubList updateObjToDB:diseasesublist WithKey:link];
    }
    [self.navigationController pushViewController:detailSubscriptionViewController animated:YES];
}


#pragma mark - Assist

- (NSIndexPath *)indexPathForCellContainingView:(UIView *)view {
    while (view != nil) {
        if ([view isKindOfClass:[UITableViewCell class]]) {
            return [self.tableView indexPathForCell:(UITableViewCell *)view];
        } else {
            view = [view superview];
        }
    }
    return nil;
}

- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj
{
    if (type == NotiMsgBoxNeedFetchNewData) { // 有新消息，拉数据
        NSArray *type = data[@"types"];
        if ([type containsObject:@(MsgBoxListMsgTypeHealth)]) {
            [self refreshConsultList];
        }
    }
}

@end