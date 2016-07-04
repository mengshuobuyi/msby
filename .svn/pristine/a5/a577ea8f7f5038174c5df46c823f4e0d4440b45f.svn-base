//
//  SendPostHistoryViewController.m
//  APP
//
//  Created by Martin.Liu on 16/1/12.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "SendPostHistoryViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
//#import "PostInCircleTableCell.h"
#import "MySendPostTableCel.h"
#import "PostDetailViewController.h"
#import "Forum.h"
#import "MGSwipeButton.h"
#import "SVProgressHUD.h"
#define SendPostHistoryPageSize 10

NSString *const kMySendPostCellIdentifier = @"MySendPostTableCel";

@interface SendPostHistoryViewController ()<UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray* postArray;

@end

@implementation SendPostHistoryViewController
{
    NSInteger pageIndex;
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"我的发帖";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = self.tableView.backgroundColor = RGBHex(qwColor11);
    [self.tableView registerNib:[UINib nibWithNibName:@"MySendPostTableCel" bundle:nil] forCellReuseIdentifier:kMySendPostCellIdentifier];
    [self configTableView];
    [self loadData];
}

- (NSMutableArray *)postArray
{
    if (!_postArray) {
        _postArray = [NSMutableArray array];
    }
    return _postArray;
}

- (void)loadData
{
    pageIndex = 0;
    [self.tableView.footer setCanLoadMore:YES];
    GetMyPostListR* getMyPostListR = [GetMyPostListR new];
    getMyPostListR.token = self.token;
    getMyPostListR.page = pageIndex + 1;
    getMyPostListR.pageSize = SendPostHistoryPageSize;
    [Forum getMyPostList:getMyPostListR success:^(NSArray *postList) {
        if (pageIndex == 0) {
            [self.postArray removeAllObjects];
        }
        if (pageIndex == 0 && postList.count == 0) {
            [self showInfoView:@"您还没有发过帖子" image:@"ic_img_fail"];
        }
        if (postList.count > 0) {
            pageIndex++;
            [self removeInfoView];
        }
        [self.postArray addObjectsFromArray:postList];
        if (postList.count < SendPostHistoryPageSize) {
            [self.tableView.footer setCanLoadMore:NO];
        }
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
    } failure:^(HttpException *e) {
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        DebugLog(@"getMyPostList error : %@", e);
    }];
}

- (void)loadMoreData
{
    GetMyPostListR* getMyPostListR = [GetMyPostListR new];
    getMyPostListR.token = self.token;
    getMyPostListR.page = pageIndex + 1;
    getMyPostListR.pageSize = SendPostHistoryPageSize;
    [Forum getMyPostListWithoutProgress:getMyPostListR success:^(NSArray *postList) {
        if (pageIndex == 0) {
            [self.postArray removeAllObjects];
        }
        if (pageIndex == 0 && postList.count == 0) {
            [self showInfoView:@"您还没有发过帖子" image:@"ic_img_fail"];
        }
        if (postList.count > 0) {
            pageIndex++;
            [self removeInfoView];
        }
        [self.postArray addObjectsFromArray:postList];
        if (postList.count < SendPostHistoryPageSize) {
            [self.tableView.footer setCanLoadMore:NO];
        }
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
    } failure:^(HttpException *e) {
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        DebugLog(@"getMyPostList error : %@", e);
    }];
}

- (void)viewInfoClickAction:(id)sender
{
    [self loadData];
}

- (void)configTableView
{
    __weak __typeof(self) weakSelf = self;
    [self enableSimpleRefresh:self.tableView block:^(SRRefreshView *sender) {
        pageIndex = 0;
        [weakSelf loadMoreData];
    }];
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreData)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.postArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MySendPostTableCel* cell = [tableView dequeueReusableCellWithIdentifier:kMySendPostCellIdentifier forIndexPath:indexPath];
    cell.postCellType = PostCellType_MineSendPost;
    [self configure:cell indexPath:indexPath];
    cell.swipeDelegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:kMySendPostCellIdentifier configuration:^(id cell) {
        [self configure:cell indexPath:indexPath];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.postArray.count) {
        QWPostModel* postModel = self.postArray[indexPath.row];
        
        [QWGLOBALMANAGER statisticsEventId:@"x_wdft_dj" withLable:@"我的发帖-点击某个帖子" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"帖子名":StrDFString(postModel.postTitle, @"帖子名")}]];
        
        PostDetailViewController* postDetailVC = (PostDetailViewController*)[[UIStoryboard storyboardWithName:@"Forum" bundle:nil] instantiateViewControllerWithIdentifier:@"PostDetailViewController"];
        postDetailVC.hidesBottomBarWhenPushed = YES;
        postDetailVC.postId = postModel.postId;
        postDetailVC.preVCNameStr = @"我的发帖";
        [self.navigationController pushViewController:postDetailVC animated:YES];
    }
}

- (void)configure:(id)cell indexPath:(NSIndexPath*)indexPath
{
    QWPostModel* postModel = self.postArray[indexPath.row];
    [cell setCell:postModel];
}

#pragma mark ---- MGSwipeTableCellDelegate  start  ----

-(NSArray*) swipeTableCell:(MGSwipeTableCell*)cell
  swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*)swipeSettings
         expansionSettings:(MGSwipeExpansionSettings*)expansionSettings;
{
    if (direction == MGSwipeDirectionRightToLeft) {
        return [self createRightButtons:1];
    }
    return nil;
}

-(BOOL) swipeTableCell:(MGSwipeTableCell*)cell tappedButtonAtIndex:(NSInteger)index direction:(MGSwipeDirection)direction fromExpansion:(BOOL)fromExpansion
{
    NSIndexPath *indexPath = nil;
    if (index == 0) {
        if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
            [SVProgressHUD showErrorWithStatus:@"网络异常,请稍后重试" duration:DURATION_SHORT];
            return NO;
        }
        indexPath = [self.tableView indexPathForCell:cell];
        if (indexPath.row < self.postArray.count) {
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定要删除该帖子吗？一经删除，不可恢复哦" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
            alertView.tag = indexPath.row;
            [alertView show];
        }
    }
    return YES;
}

-(NSArray *) createRightButtons: (int) number
{
    NSMutableArray * result = [NSMutableArray array];
    NSString* titles[1] = {@"删除"};
    UIColor * colors[1] = {RGBHex(qwColor3)};
    for (int i = 0; i < number; ++i)
    {
        MGSwipeButton * button = [MGSwipeButton buttonWithTitle:titles[i] backgroundColor:colors[i] callback:^BOOL(MGSwipeTableCell * sender){
            return YES;
        }];
        [result addObject:button];
    }
    return result;
}

#pragma mark ---- MGSwipeTableCellDelegate  end  ----

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSInteger index = alertView.tag;
        if (index < self.postArray.count) {
            QWPostModel* postModel = self.postArray[index];
            DeletePostInfoR* deletePostInfoR = [DeletePostInfoR new];
            deletePostInfoR.token = QWGLOBALMANAGER.configure.userToken;
            deletePostInfoR.poster = QWGLOBALMANAGER.configure.passPort;
            deletePostInfoR.postId = postModel.postId;
            deletePostInfoR.teamId = postModel.teamId;
            deletePostInfoR.postTitle = postModel.postTitle;
            
            [Forum delPostInfo:deletePostInfoR success:^(BaseAPIModel *baseAPIModel) {
                if ([baseAPIModel.apiStatus integerValue] == 0) {
                    [QWGLOBALMANAGER postNotif:NotifDeletePostSuccess data:nil object:nil];
                    [SVProgressHUD showSuccessWithStatus:@"帖子删除成功!"];
                }
                else
                {
                    NSString* errorMessage = StrIsEmpty(baseAPIModel.apiMessage) ? @"删除失败!" : baseAPIModel.apiMessage;
                    [SVProgressHUD showErrorWithStatus:errorMessage];
                }
            } failure:^(HttpException *e) {
                DebugLog(@"delete post error : %@", e);
            }];
        }
    }
}

- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj
{
    if (NotifDeletePostSuccess == type) {
        [self loadData];
    }
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
