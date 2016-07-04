//
//  MsgConsultListViewController.m
//  APP
//
//  Created by PerryChen on 6/5/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "MsgConsultListViewController.h"
#import "XHDemoWeChatMessageTableViewController.h"
#import "QizOutOfDateListViewController.h"
#import "MsgConsultCell.h"
#import "Consult.h"
#import "ConsultModelR.h"
#import "ConsultModel.h"
#import "QWGlobalManager.h"
#import "SVProgressHUD.h"
#import "NotificationModel.h"
#import "css.h"

#import "IMApi.h"
#import "QWMessage.h"
#import "QWUnreadCountModel.h"
@interface MsgConsultListViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tbViewContent;

@property (strong, nonatomic) NSMutableArray *arrMessageBox;
@property (strong, nonatomic) NSMutableArray *arrServer;
@property (nonatomic, assign) BOOL isScrolling;


@end

@implementation MsgConsultListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrMessageBox = [@[] mutableCopy];
    self.arrServer = [@[] mutableCopy];
    [self.view setBackgroundColor:RGBHex(kColor13)];
    
    [self getCachedMessages];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getCachedMessages];
    [self.tbViewContent reloadData];
}

- (void)refreshContent
{
    [self refreshConsultList];
}

- (void)refreshView
{
    [self getCachedMessages];
    [self.tbViewContent reloadData];
}

#pragma mark - cache methods
- (void)getCachedMessages
{
    self.arrMessageBox = [NSMutableArray arrayWithArray:[HistoryMessages getArrayFromDBWithWhere:nil WithorderBy:@" timestamp desc"]];
}

#pragma mark - Http service
- (void)refreshConsultList
{
    //全量拉取消息盒子数据
    ConsultCustomerModelR *modelR = [ConsultCustomerModelR new];
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    [Consult getConsultCustomerListWithParam:modelR success:^(ConsultCustomerListModel *responModel) {
        ConsultCustomerListModel *listModel = (ConsultCustomerListModel *)responModel;
        [self.arrServer removeAllObjects];
        self.arrServer = [listModel.consults mutableCopy];
        [self syncDBtoLatest:listModel];
    } failure:^(HttpException *e) {
        
    }];
}

- (void)syncDBtoLatest:(ConsultCustomerListModel *)listModel
{
    __weak MsgConsultListViewController *weakSelf = self;
    NSMutableArray *arrLoaded = [NSMutableArray arrayWithArray:listModel.consults];
    NSMutableArray *arrCached = [NSMutableArray arrayWithArray:[HistoryMessages getArrayFromDBWithWhere:nil]];
    NSMutableArray *arrNeedAdded = [@[] mutableCopy];
    NSMutableArray *arrNeedDeleted = [@[] mutableCopy];
    // 删除服务器上没有，本地有的缓存数据
    [arrCached enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        HistoryMessages *modelHis = (HistoryMessages *)obj;
        BOOL isExist = NO;
        for (ConsultCustomerModel *modelConsult in arrLoaded) {
            if ([modelConsult.consultId intValue] == [modelHis.relatedid intValue]) {
                isExist = YES;
                break;
            }
        }
        if (!isExist) {
            [arrNeedDeleted addObject:modelHis];
        }
    }];
    for (HistoryMessages *modelHis in arrNeedDeleted) {
//        if ([modelHis.isOutOfDate intValue]==0) {
            [HistoryMessages deleteObjFromDBWithKey:[NSString stringWithFormat:@"%@",modelHis.relatedid]];
//        }
    }
    // 更新数据问题
    arrCached = [NSMutableArray arrayWithArray:[HistoryMessages getArrayFromDBWithWhere:nil WithorderBy:@"timestamp desc"]];
    __block NSInteger count = 0;
    [arrLoaded enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ConsultCustomerModel *modelConsult = (ConsultCustomerModel *)obj;
        NSUInteger indexFound = [weakSelf valueExists:@"relatedid" withValue:[NSString stringWithFormat:@"%@",modelConsult.consultId] withArr:arrCached];
        if (indexFound != NSNotFound) {
            // 更新Model
            HistoryMessages *modelMessage = [arrCached objectAtIndex:indexFound];
            [QWGLOBALMANAGER convertConsultModelToMessages:modelConsult withModelMessage:&modelMessage];
        } else {
            HistoryMessages *modelMessage = [QWGLOBALMANAGER createNewMessage:modelConsult];
            [arrNeedAdded addObject:modelMessage];
        }
    }];
    [arrCached addObjectsFromArray:arrNeedAdded];
    BOOL hasOutOfDate = NO;
    for (int i = 0; i < arrCached.count; i++) {
        HistoryMessages *model = (HistoryMessages *)arrCached[i];
        [HistoryMessages updateObjToDB:model WithKey:model.relatedid];
        if ([model.isOutOfDate intValue] == 0) {
            count += [model.systemUnreadCounts intValue];
            count += [model.unreadCounts intValue];
        } else {
            hasOutOfDate = YES;
        }
    }
    QWUnreadCountModel *modelUnread = [QWGLOBALMANAGER getUnreadModel];
    if (hasOutOfDate) {
//        modelUnread.bool_ConsultShouldShowRed = @"1";
    }
    if ([modelUnread.count_CounsultUnread intValue]<count) {
        modelUnread.bool_ConsultShouldShowRed = YES;
    }
    modelUnread.count_CounsultUnread = [NSString stringWithFormat:@"%d",count];
    [QWUnreadCountModel updateObjToDB:modelUnread WithKey:QWGLOBALMANAGER.configure.passPort];
    
    [QWGLOBALMANAGER updateRedPoint];

    [self getCachedMessages];
    [self.tbViewContent reloadData];
}

#pragma mark - UITableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MsgConsultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MsgConsultCell"];
    HistoryMessages *msgModel = self.arrMessageBox[indexPath.row];
    [cell setCell:msgModel];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static MsgConsultCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [tableView dequeueReusableCellWithIdentifier:@"MsgConsultCell"];
    });
    HistoryMessages *model = [self.arrMessageBox objectAtIndex:indexPath.row];
    [sizingCell setCell:model];
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(sizingCell.bounds));
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGSize sizeFinal = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return sizeFinal.height+1.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrMessageBox.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (QWGLOBALMANAGER.loginStatus) {
        
        HistoryMessages* msg = self.arrMessageBox[indexPath.row];
        if ([msg.isOutOfDate intValue] == 0) {
            XHDemoWeChatMessageTableViewController *messageViewController = [[XHDemoWeChatMessageTableViewController  alloc] init];
            if(msg) {
                QWGLOBALMANAGER.unReadCount = QWGLOBALMANAGER.unReadCount - [msg.unreadCounts intValue];
                QWGLOBALMANAGER.unReadCount = QWGLOBALMANAGER.unReadCount - [msg.systemUnreadCounts intValue];
                
                msg.unreadCounts = @"0";
                msg.systemUnreadCounts = @"0";
                dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
                dispatch_async(aQueue, ^(void) {
                    [HistoryMessages updateObjToDB:msg WithKey:msg.relatedid];
                });
                
                QWUnreadCountModel *modelUnread = [QWGLOBALMANAGER getUnreadModel];
                modelUnread.count_CounsultUnread = [NSString stringWithFormat:@"%d",[modelUnread.count_CounsultUnread intValue] - [msg.unreadCounts intValue] - [msg.systemUnreadCounts intValue]];
                [QWUnreadCountModel updateObjToDB:modelUnread WithKey:QWGLOBALMANAGER.configure.passPort];
                [QWGLOBALMANAGER updateRedPoint];
            }
            messageViewController.historyMsg = msg;
            if ([msg.consultStatus intValue] == 1) {
                messageViewController.showType = MessageShowTypeNewCreate;
            }else if ([msg.consultStatus intValue] == 2) {
                messageViewController.showType = MessageShowTypeAnswering;
            } else if ([msg.consultStatus intValue] == 3) {
                messageViewController.showType = MessageShowTypeTimeout;
            } else {
                messageViewController.showType = MessageShowTypeClosed;
            }
            messageViewController.messageSender = [NSString stringWithFormat:@"%@",msg.relatedid];
            messageViewController.avatarUrl = msg.avatarurl;
            [self.parentViewController.navigationController pushViewController:messageViewController animated:YES];
        } else {
            msg.isShowRedPoint = @"0";
            [HistoryMessages updateObjToDB:msg WithKey:msg.relatedid];
            [self performSegueWithIdentifier:@"segueOutOfDate" sender:indexPath];
        }
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
    [self getCachedMessages];
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
        case NotifMessageNeedUpdate:
            [self refreshHistory:nil];
            break;
        case NotifQuitOut:
            [self quitAccount:nil];
            break;
        case NotiNewUnreadMessage:
            [self refreshHistory:nil];
            break;
        case NotiMessageBoxUpdateList:      // 刷新列表
        {
            if (self.isScrolling) {
                return;
            }
            if ([data isKindOfClass:[ConsultCustomerListModel class]]) {
                ConsultCustomerListModel *listModel = (ConsultCustomerListModel *)data;
                if (listModel.consults.count <= 0) {
                    return;
                }
                __weak MsgConsultListViewController *weakSelf = self;
                dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
                dispatch_async(aQueue, ^(void) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self getCachedMessages];
                        [self.tbViewContent reloadData];
                    });
                });
            }
        }
            // data 是列表数据
            break;
        case NotiMessageBoxNeedUpdate:
        {
            [self updateAllSendStatus];
            break;
        }
        case NotimessageBoxUpdate:
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


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"segueOutOfDate"]) {
        QizOutOfDateListViewController *vcOutOfDate = (QizOutOfDateListViewController *)segue.destinationViewController;
        NSIndexPath *path = (NSIndexPath *)sender;
        HistoryMessages *msgSelect = self.arrMessageBox[path.row];
        vcOutOfDate.strMsgId = msgSelect.relatedid;
    }
}

@end
