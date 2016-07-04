//
//  QizClosedListViewController.m
//  APP
//
//  Created by PerryChen on 6/5/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "QizOutOfDateListViewController.h"
#import "OutOfDateTableCell.h"
#import "XPChatViewController.h"
#import "Consult.h"
#import "ReturnIndexView.h"
#import "SVProgressHUD.h"
#import "MGSwipeButton.h"

@interface QizOutOfDateListViewController ()<MGSwipeTableCellDelegate>

@property (nonatomic, strong) NSMutableArray  *expireList;
@property (nonatomic, strong) ReturnIndexView *indexView;
@end

@implementation QizOutOfDateListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"过期问题";
    [self setUpRightItem];
    self.expireList = [NSMutableArray arrayWithCapacity:10];
    NSArray *cacheArray = [CustomerConsultVoModel getArrayFromDBWithWhere:nil WithorderBy:@"consultCreateTime desc"];
//    [self removeInfoView];
    if(cacheArray.count > 0) {
        self.expireList = [NSMutableArray arrayWithArray:cacheArray];
        
        [self queryExpireConsultList:QWGLOBALMANAGER.lastTimestampOutOfDate];
    }else{
        [self queryExpireConsultList:@"0"];
    }
    __weak typeof (self) __weakSelf = self;
//    [self.tableView addHeaderWithCallback:^{
//        [__weakSelf queryExpireConsultList:@"0"];
//        [__weakSelf.tableView headerEndRefreshing];
//    }];
    
    [self enableSimpleRefresh:self.tableView block:^(SRRefreshView *sender) {
        [__weakSelf queryExpireConsultList:@"0"];
        [__weakSelf.tableView headerEndRefreshing];
    }];
    
    self.tableView.headerPullToRefreshText = @"下拉刷新";
    self.tableView.headerReleaseToRefreshText = @"松开刷新";
    self.tableView.headerRefreshingText = @"正在刷新";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.expireList = [[CustomerConsultVoModel getArrayFromDBWithWhere:nil WithorderBy:@"consultCreateTime desc"] mutableCopy];
    if (self.expireList.count == 0) {
        [self showInfoView:@"暂无过期问题" image:@"ic_img_fail"];
    } else {
        [self removeInfoView];
    }
    [self.tableView reloadData];
}

- (void)setUpRightItem
{
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width = -6;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-unfold.PNG"] style:UIBarButtonItemStylePlain target:self action:@selector(returnIndex)];
    self.navigationItem.rightBarButtonItems = @[fixed,rightItem];
}

- (void)returnIndex
{
    self.indexView = [ReturnIndexView sharedManagerWithImage:@[@"icon home.PNG",@"ic_img_clean.png"] title:@[@"首页",@"清空问题"] passValue:-1];
    self.indexView.delegate = self;
    [self.indexView show];
}

- (void)RetunIndexView:(ReturnIndexView *)ReturnIndexView didSelectedIndex:(NSIndexPath *)indexPath
{
    [self.indexView hide];
    if (indexPath.row == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self performSelector:@selector(delayPopToHome) withObject:nil afterDelay:0.01];
    }else if(indexPath.row == 1){
        [self clearAllExpireConsult];
    }
}

- (void)delayPopToHome
{
    [QWGLOBALMANAGER.tabBar setSelectedIndex:0];
}

- (void)queryExpireConsultList:(NSString *)timeStamp
{
    HttpClientMgr.progressEnabled=NO;
    
    ConsultExpiredModelR *modelR = [ConsultExpiredModelR new];
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    modelR.point = timeStamp;
    DDLogVerbose(@"the model r is %@",modelR);
    [Consult consultExpiredWithParam:modelR success:^(ConsultCustomerListModel *list) {
        QWGLOBALMANAGER.lastTimestampOutOfDate = list.lastTimestamp;
        if([timeStamp doubleValue] == 0) {
            [CustomerConsultVoModel deleteAllObjFromDB];
        }
        if(list.consults.count > 0) {
            
//            [self.expireList addObjectsFromArray:list.consults];
            [self removeInfoView];
//            [self.tableView reloadData];
            for (CustomerConsultVoModel *modelVo in list.consults) {
                [CustomerConsultVoModel updateObjToDB:modelVo WithKey:[NSString stringWithFormat:@"%@",modelVo.consultId]];
            }
//            [CustomerConsultVoModel saveObjToDBWithArray:list.consults];
        }
        self.expireList = [[CustomerConsultVoModel getArrayFromDBWithWhere:nil WithorderBy:@"consultCreateTime desc"] mutableCopy];
        [self.tableView reloadData];
    } failure:NULL];
}

- (void)clearAllExpireConsult
{
    ConsultExpiredModelR *modelR = [ConsultExpiredModelR new];
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    [Consult consultRemoveAllExpiredWithParam:modelR success:^(BaseAPIModel *model) {
        if([model.apiStatus integerValue] == 0) {
            [self.expireList removeAllObjects];
            [self.tableView reloadData];
            [CustomerConsultVoModel deleteAllObjFromDB];
            [HistoryMessages deleteObjFromDBWithKey:self.strMsgId];
            [self showInfoView:@"暂无过期问题" image:@"ic_img_fail"];
        }else{
            [SVProgressHUD  showErrorWithStatus:model.apiMessage duration:0.8];
        }
    } failure:NULL];
}

-(NSArray *) createRightButtons: (int) number
{
    NSMutableArray * result = [NSMutableArray array];
    NSString* titles[1] = {@" 删除 "};
    UIColor * colors[1] = {[UIColor redColor]};
    for (int i = 0; i < number; ++i)
    {
        MGSwipeButton * button = [MGSwipeButton buttonWithTitle:titles[i] backgroundColor:colors[i] callback:^BOOL(MGSwipeTableCell * sender){
            return YES;
        }];
        if(i == 1) {
            [button setTitleColor:RGBHex(qwColor5) forState:UIControlStateNormal];
        }
        [result addObject:button];
    }
    return result;
}


#pragma mark -
#pragma mark MGSwipeTableCellDelegate
-(NSArray *) swipeTableCell:(MGSwipeTableCell*)cell
  swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*)swipeSettings
         expansionSettings:(MGSwipeExpansionSettings*)expansionSettings;
{
    
    if (direction == MGSwipeDirectionRightToLeft)
        return [self createRightButtons:1];

    return nil;
}

-(BOOL) swipeTableCell:(MGSwipeTableCell*)cell tappedButtonAtIndex:(NSInteger)index direction:(MGSwipeDirection)direction fromExpansion:(BOOL)fromExpansion
{

    if (index == 0)
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        CustomerConsultVoModel *model = self.expireList[indexPath.row];
        NSString *strConsultID = model.consultId;
        ConsultExpiredModelR *modelR = [ConsultExpiredModelR new];
        modelR.token = QWGLOBALMANAGER.configure.userToken;
        modelR.consultId = model.consultId;
        [Consult consultRemoveExpiredWithParam:modelR success:^(BaseAPIModel *model) {
            if([model.apiStatus integerValue] == 0) {
                [CustomerConsultVoModel deleteObjFromDBWithKey:strConsultID];
            }else{
                [SVProgressHUD  showErrorWithStatus:model.apiMessage duration:0.8];
            }
        } failure:NULL];
        [self.expireList removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
        if(self.expireList.count == 0) {
            [HistoryMessages deleteObjFromDBWithKey:self.strMsgId];
            [self showInfoView:@"暂无过期问题" image:@"ic_img_fail"];
        }
    }
    return YES;
}

#pragma mark
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.expireList.count;
}

- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OutOfDateTableCell *cell = [atableView dequeueReusableCellWithIdentifier:@"OutOfDateIdentifier"];
    CustomerConsultVoModel *model = self.expireList[indexPath.row];
    [cell setCell:model];
    cell.swipeDelegate = self;
    return cell;
}

- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [atableView deselectRowAtIndexPath:indexPath animated:YES];
    CustomerConsultVoModel *model = self.expireList[indexPath.row];
    XPChatViewController *messageViewController = [[UIStoryboard storyboardWithName:@"XPChatViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"XPChatViewController"];

    messageViewController.showType = MessageShowTypeTimeout;
    HistoryMessages *historyMsg = [HistoryMessages new];
    historyMsg.consultMessage = model.consultMessage;
    messageViewController.messageSender = [NSString stringWithFormat:@"%@",model.consultId];
    messageViewController.avatarUrl = model.pharAvatarUrl;
    messageViewController.historyMsg = historyMsg;
    [self.navigationController pushViewController:messageViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj
{
    if (type == NotiMessageBoxNeedUpdate) {
        self.expireList = [[CustomerConsultVoModel getArrayFromDBWithWhere:nil WithorderBy:@"consultCreateTime desc"] mutableCopy];
        [self.tableView reloadData];
    }
}
@end
