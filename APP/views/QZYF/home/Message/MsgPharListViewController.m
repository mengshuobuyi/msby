//
//  MsgPharListViewController.m
//  APP
//
//  Created by PerryChen on 6/5/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "MsgPharListViewController.h"
#import "MsgPharConsultCell.h"
#import "ConsultPTP.h"
#import "ConsultPTPR.h"
#import "ConsultPTPModel.h"
#import "SVProgressHUD.h"
#import "QWGlobalManager.h"
#import "PTPWeChatMessageTableViewController.h"
#import "QWUnreadCountModel.h"
@interface MsgPharListViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tbViewContent;
@property (strong, nonatomic) NSMutableArray *arrP2PMsgList;
@property (strong, nonatomic) NSMutableArray *arrServer;
@property (nonatomic, assign) BOOL isScrolling;
@end

@implementation MsgPharListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrP2PMsgList = [@[] mutableCopy];
    self.arrServer = [@[] mutableCopy];
    [self.view setBackgroundColor:RGBHex(kColor13)];
    [self getAllCachedP2PList];
    [self.tbViewContent reloadData];
    __weak typeof (self) weakSelf = self;
    [self.tbViewContent addHeaderWithCallback:^{
        [weakSelf.tbViewContent headerEndRefreshing];
        if(QWGLOBALMANAGER.currentNetWork == NotReachable)
        {
            [SVProgressHUD showErrorWithStatus:@"网络未连接，请稍后再试" duration:0.8f];
            return;
        }
        [weakSelf refreshConsultList];
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self refreshConsultList];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)refreshContent
{
    [self refreshConsultList];
}

- (void)refreshView
{
    [self getAllCachedP2PList];
    [self.tbViewContent reloadData];
}

#pragma mark - cache methods
- (void)getAllCachedP2PList
{
    self.arrP2PMsgList = [NSMutableArray arrayWithArray:[PharMsgModel getArrayFromDBWithWhere:nil WithorderBy:@" sessionLatestTime desc"]];
}

#pragma mark - Http service
- (void)refreshConsultList
{
    //全量拉取
    GetAllSessionModelR *modelR = [GetAllSessionModelR new];
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    modelR.point = @"0";
    modelR.view = @"10000";
    modelR.viewType = @"-1";
    [ConsultPTP getAllSessionList:modelR success:^(MessageList *responModel) {
        self.arrServer = responModel.messages;
        [self syncDBtoLatest:responModel];
    } failure:^(HttpException *e) {
        
    }];
}

- (void)syncDBtoLatest:(MessageList *)listModel
{
    __weak MsgPharListViewController *weakSelf = self;
    NSMutableArray *arrLoaded = [NSMutableArray arrayWithArray:listModel.messages];
    NSMutableArray *arrCached = [NSMutableArray arrayWithArray:[PharMsgModel getArrayFromDBWithWhere:nil]];
    NSMutableArray *arrNeedAdded = [@[] mutableCopy];
    NSMutableArray *arrNeedDeleted = [@[] mutableCopy];
    // 删除服务器上没有，本地有的缓存数据
    [arrCached enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        PharMsgModel *modelHis = (PharMsgModel *)obj;
        BOOL isExist = NO;
        for (MessageItemVo *modelConsult in arrLoaded) {
            if ([modelConsult.branchId intValue] == [modelHis.branchId intValue]) {
                isExist = YES;
                break;
            }
        }
        if (!isExist) {
            [arrNeedDeleted addObject:modelHis];
        }
    }];
    for (PharMsgModel *modelHis in arrNeedDeleted) {
        [PharMsgModel deleteObjFromDBWithKey:[NSString stringWithFormat:@"%@",modelHis.branchId]];
    }
    // 更新数据问题
    arrCached = [NSMutableArray arrayWithArray:[PharMsgModel getArrayFromDBWithWhere:nil WithorderBy:@" sessionLatestTime desc"]];
    __block NSInteger count = 0;
    [arrLoaded enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        MessageItemVo *modelSession = (MessageItemVo *)obj;
        NSUInteger indexFound = [weakSelf valueExists:@"branchId" withValue:[NSString stringWithFormat:@"%@",modelSession.branchId] withArr:arrCached];
        if (indexFound != NSNotFound) {
            // 更新Model
            PharMsgModel *modelMessage = [arrCached objectAtIndex:indexFound];
            [QWGLOBALMANAGER convertSessionModelToMsg:modelSession withModelMsg:&modelMessage];
        } else {
            PharMsgModel *modelMessage = [QWGLOBALMANAGER createNewMsg:modelSession];
            [arrNeedAdded addObject:modelMessage];
        }
    }];
    
    [arrCached addObjectsFromArray:arrNeedAdded];
    for (int i = 0; i < arrCached.count; i++) {
        PharMsgModel *model = (PharMsgModel *)arrCached[i];
        [PharMsgModel updateObjToDB:model WithKey:model.branchId];
        count += [model.unreadCounts intValue];
        count += [model.systemUnreadCounts intValue];
    }
    QWUnreadCountModel *modelUnread = [QWGLOBALMANAGER getUnreadModel];
    if ([modelUnread.count_PTPUnread intValue]<count) {
        modelUnread.bool_PTPShouldShowRed = YES;
    }
    modelUnread.count_PTPUnread = [NSString stringWithFormat:@"%d",count];
    [QWUnreadCountModel updateObjToDB:modelUnread WithKey:QWGLOBALMANAGER.configure.passPort];
    
    [QWGLOBALMANAGER updateRedPoint];

    [self getAllCachedP2PList];
    [self.tbViewContent reloadData];
}


#pragma mark - UITableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MsgPharConsultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MsgPharConsultCell"];
    PharMsgModel *msgModel = self.arrP2PMsgList[indexPath.row];
    [cell setCell:msgModel];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static MsgPharConsultCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [tableView dequeueReusableCellWithIdentifier:@"MsgPharConsultCell"];
    });
    PharMsgModel *model = [self.arrP2PMsgList objectAtIndex:indexPath.row];
    [sizingCell setCell:model];
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(sizingCell.bounds));
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGSize sizeFinal = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return sizeFinal.height+1.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrP2PMsgList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (QWGLOBALMANAGER.loginStatus) {
        PharMsgModel* msg = self.arrP2PMsgList[indexPath.row];
        PTPWeChatMessageTableViewController *messageViewController = [[PTPWeChatMessageTableViewController  alloc] init];
        if(msg) {
            QWGLOBALMANAGER.unReadCount = QWGLOBALMANAGER.unReadCount - [msg.unreadCounts intValue];
            QWGLOBALMANAGER.unReadCount = QWGLOBALMANAGER.unReadCount - [msg.systemUnreadCounts intValue];
            msg.unreadCounts = @"0";
            msg.systemUnreadCounts = @"0";
            dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
            dispatch_async(aQueue, ^(void) {
                [PharMsgModel updateObjToDB:msg WithKey:msg.branchId];
            });
            QWUnreadCountModel *modelUnread = [QWGLOBALMANAGER getUnreadModel];
            modelUnread.count_PTPUnread = [NSString stringWithFormat:@"%d",[modelUnread.count_PTPUnread intValue] - [msg.unreadCounts intValue] - [msg.systemUnreadCounts intValue]];
            [QWUnreadCountModel updateObjToDB:modelUnread WithKey:QWGLOBALMANAGER.configure.passPort];
            [QWGLOBALMANAGER updateRedPoint];
        }
        messageViewController.pharMsgModel = msg;
        messageViewController.consultType = Enum_SendConsult_Common;
//        if ([msg.consultStatus intValue] == 1) {
//            messageViewController.showType = MessageShowTypeNewCreate;
//        }else if ([msg.consultStatus intValue] == 2) {
//            messageViewController.showType = MessageShowTypeAnswering;
//        } else if ([msg.consultStatus intValue] == 3) {
//            messageViewController.showType = MessageShowTypeTimeout;
//        } else {
//            messageViewController.showType = MessageShowTypeClosed;
//        }
//        messageViewController.messageSender = [NSString stringWithFormat:@"%@",msg.relatedid];
        messageViewController.avatarUrl = msg.imgUrl;
        messageViewController.branchId = msg.branchId;
        [self.parentViewController.navigationController pushViewController:messageViewController animated:YES];
    }
    
}


#pragma mark -
#pragma mark 处理本视图收到的通知
- (void)quitAccount:(NSNotification *)noti
{
    [self.tbViewContent reloadData];
}
- (void)refreshHistory:(NSNotification *)noti
{
    //查找所有的历史消息
    [self getAllCachedP2PList];
    [self.tbViewContent reloadData];
}
// 通知列表更新发送状态
- (void)updateAllSendStatus
{
//    NSArray *paths = [self.tbViewContent indexPathsForVisibleRows];
//    [self.tbViewContent reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tbViewContent reloadData];
}
- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj{
    
    //接收登陆成功的通知
    
    switch (type) {
        case NotifLoginSuccess:
        case NotifPTPMsgNeedUpdate:
        case NotifMessageOfficial:
            [self refreshHistory:nil];
            break;
        case NotifQuitOut:
            [self quitAccount:nil];
            break;
        case NotiNewUnreadPTPMsg:
            [self refreshHistory:nil];
            break;
        case NotiMessagePTPUpdateList:      // 刷新列表
        {
            if (self.isScrolling) {
                return;
            }
            if ([data isKindOfClass:[ConsultCustomerListModel class]]) {
                ConsultCustomerListModel *listModel = (ConsultCustomerListModel *)data;
                if (listModel.consults.count <= 0) {
                    return;
                }
                __weak MsgPharListViewController *weakSelf = self;
                dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
                dispatch_async(aQueue, ^(void) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self getAllCachedP2PList];
                        NSArray *paths = [weakSelf.tbViewContent indexPathsForVisibleRows];
                        [weakSelf.tbViewContent reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
                    });
                });
            }
        }
            // data 是列表数据
            break;
        case NotiMessagePTPNeedUpdate:
        {
            [self updateAllSendStatus];
            break;
        }
        case NotimessageBoxPharUpdate:
        {
            [self refreshHistory:nil];
            break;
        }
        default:
            break;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.isScrolling = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.isScrolling = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.isScrolling = YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
