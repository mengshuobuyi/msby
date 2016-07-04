//
//  HotPostViewController.m
//  APP
//
//  Created by Martin.Liu on 15/12/29.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "HotPostViewController.h"
#import "PostTableCell.h"
#import "AllCircleViewController.h"             // 全部圈子
#import "PostDetailViewController.h"            // 帖子详情
#import "SendPostViewController.h"              // 发帖
#import "CircleDetailViewController.h"               // 圈子
#import "UITableView+FDTemplateLayoutCell.h"
#import "WebDirectViewController.h"
// 通告用到的
#import "AutoScrollView.h"
#import "ActivityModel.h"
#import "ExpertPageViewController.h"
#import "UserPageViewController.h"

#import "Forum.h"
#import "LoginViewController.h"
#import "SVProgressHUD.h"
#import "UIImage+Tint.h"

#define HotPostPageSize 10

@interface HotPostViewController ()<UITableViewDataSource, UITableViewDelegate, AutoScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *tableHeaderView;

@property (strong, nonatomic) IBOutlet UIImageView *firstCircleImageView;
@property (strong, nonatomic) IBOutlet UILabel *firstCircleTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *firstCircleSubTitleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *secondCircleImageView;
@property (strong, nonatomic) IBOutlet UILabel *secondCircleTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *secondCircleSubTitleLabel;

@property (strong, nonatomic) IBOutlet AutoScrollView *noticeScrollView;
@property (strong, nonatomic) IBOutlet UIButton *moreCircleBtn;
@property (strong, nonatomic) IBOutlet UIImageView *moreRightArrwoImageView;

@property (nonatomic, strong) NSArray* cirCleArray;   // 两个圈子
@property (nonatomic, strong) NSArray* noticePushArray;   // 两个圈子
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_NoticeViewHeight;  // default is 53

- (IBAction)allCircleBtnAction:(id)sender;
- (IBAction)firstCircleBtnAction:(id)sender;
- (IBAction)secondCircleBtnAction:(id)sender;
- (IBAction)sendPostBtnAction:(id)sender;

@property (nonatomic, strong) NSMutableArray* postArray;

@end

@implementation HotPostViewController
{
    NSMutableArray* titleArray;
    
    NSInteger pageIndex;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    titleArray = [NSMutableArray array];
    self.tableView.backgroundColor = RGBHex(qwColor11);
    
    [self setupTableView];
    
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self loadCatchData];
    });
}

- (void)UIGlobal
{
    self.noticeScrollView.delegate = self;
    self.noticeScrollView.ButtonColor = RGBHex(qwColor6);
    [self.noticeScrollView setupView];
    
    [self.moreCircleBtn setTitleColor:RGBHex(qwColor1) forState:UIControlStateNormal];
    self.moreRightArrwoImageView.image = [[UIImage imageNamed:@"ic_rightarrowgreen"] imageWithTintColor:RGBHex(qwColor1)];
    
    self.firstCircleImageView.layer.masksToBounds = YES;
    self.firstCircleImageView.layer.cornerRadius = 2;
    self.secondCircleImageView.layer.masksToBounds = YES;
    self.secondCircleImageView.layer.cornerRadius = 2;
    self.firstCircleImageView.layer.borderWidth = self.secondCircleImageView.layer.borderWidth = 1.0/[UIScreen mainScreen].scale;
    self.firstCircleImageView.layer.borderColor = self.secondCircleImageView.layer.borderColor = RGBHex(qwColor10).CGColor;
    self.firstCircleTitleLabel.font= self.secondCircleTitleLabel.font = [UIFont systemFontOfSize:kFontS1];
    self.firstCircleTitleLabel.textColor = self.secondCircleTitleLabel.textColor = RGBHex(qwColor6);
    self.firstCircleSubTitleLabel.font = self.secondCircleSubTitleLabel.font = [UIFont systemFontOfSize:kFontS4];
    self.firstCircleSubTitleLabel.textColor = self.secondCircleSubTitleLabel.textColor = RGBHex(qwColor8);
}

- (void)hiddenNoticeView:(BOOL)hidden animation:(BOOL)animated
{
    self.constraint_NoticeViewHeight.constant = hidden ? 0 : 53;
    CGRect tableHearderViewFrame = self.tableHeaderView.frame;
    tableHearderViewFrame.size.height = [self.tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    self.tableHeaderView.frame = tableHearderViewFrame;
    self.tableView.tableHeaderView = self.tableHeaderView;
}

- (NSMutableArray *)postArray
{
    if (!_postArray) {
        _postArray = [NSMutableArray array];
    }
    return _postArray;
}

- (void) loadData
{
    GetHotPostR* getHotPost = [GetHotPostR new];
    getHotPost.token = QWGLOBALMANAGER.configure.userToken;
    getHotPost.page = pageIndex + 1;
    getHotPost.pageSize = HotPostPageSize;
    [Forum gethotPostWithoutProgress:getHotPost success:^(QWCircleHotInfo *responModel) {
        [self removeInfoView];
        if ([responModel.apiStatus integerValue] == 0) {
            QWCircleHotInfo* circleHotInfo = responModel;
            if (pageIndex == 0) {
                [self saveHotPostInfo:responModel];
                [self.postArray removeAllObjects];
            }
            if (circleHotInfo.postInfoList.count > 0 ) {
                pageIndex ++;
            }
            [self.postArray addObjectsFromArray:circleHotInfo.postInfoList];
            [self.tableView.footer setCanLoadMore:(circleHotInfo.postInfoList.count >= HotPostPageSize)];
            self.cirCleArray = circleHotInfo.teamList;
            self.noticePushArray = circleHotInfo.noticePushList;
            [self.tableView reloadData];
            [self endHeaderRefresh];
            if ([self.tableView.footer isRefreshing]) {
                [self.tableView footerEndRefreshing];
            }
        }
    } failure:^(HttpException *e) {
        [self.tableView reloadData];
        if ([self.tableView.footer isRefreshing]) {
            [self.tableView footerEndRefreshing];
        }
        [self endHeaderRefresh];
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
        DebugLog(@"getTeamHot error : %@", e);
    }];
}

/**
 *  3.1.0 保存热议缓存
 *
 */
#pragma mark - 展示缓存数据， 第一次viewdidload的时候用
- (void)loadCatchData
{
    QWCircleHotInfo* hotInfo = [self getHotInfoCatch];
    if (hotInfo) {
        if (self.postArray.count == 0) {
            [self.postArray addObjectsFromArray:hotInfo.postInfoList];
            self.cirCleArray = hotInfo.teamList;
            self.noticePushArray = hotInfo.noticePushList;
            [self.tableView reloadData];
        }
    }
}

#pragma mark - 获取本地热议缓存数据
- (QWCircleHotInfo*)getHotInfoCatch
{
    NSArray* hotInfoArray = [QWCircleHotInfo getArrayFromDBWithWhere:nil];
    if (hotInfoArray.count > 0) {
        return hotInfoArray[0];
    }
    return nil;
}

#pragma mark - 热议缓存数据保存本地
- (void)saveHotPostInfo:(QWCircleHotInfo*)hotInfo
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [QWCircleHotInfo deleteAllObjFromDB];
        [hotInfo saveToDB];
    });
}

- (void) loadMoreData
{
    GetHotPostR* getHotPost = [GetHotPostR new];
    getHotPost.token = QWGLOBALMANAGER.configure.userToken;
    getHotPost.page = pageIndex + 1;
    getHotPost.pageSize = HotPostPageSize;
    [Forum gethotPostWithoutProgress:getHotPost success:^(QWCircleHotInfo *responModel) {
        [self removeInfoView];
        if ([responModel.apiStatus integerValue] == 0) {
            QWCircleHotInfo* circleHotInfo = responModel;
            if (pageIndex == 0) {
                [self saveHotPostInfo:responModel];
                [self.postArray removeAllObjects];
            }
            if (circleHotInfo.postInfoList.count > 0) {
                pageIndex ++;
            }
            [self.postArray addObjectsFromArray:circleHotInfo.postInfoList];
            self.cirCleArray = circleHotInfo.teamList;
            self.noticePushArray = circleHotInfo.noticePushList;
            [self.tableView reloadData];
            if (circleHotInfo.postInfoList.count < HotPostPageSize) {
                [self.tableView.footer setCanLoadMore:NO];
            }
            [self endHeaderRefresh];
            if ([self.tableView.footer isRefreshing]) {
                [self.tableView footerEndRefreshing];
            }
        }
    } failure:^(HttpException *e) {
        [self.tableView reloadData];
        if ([self.tableView.footer isRefreshing]) {
            [self.tableView footerEndRefreshing];
        }
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
        DebugLog(@"getTeamHot error : %@", e);
    }];
}

- (void)viewInfoClickAction:(id)sender
{
    pageIndex = 0;
    [self loadData];
}

- (void)setupTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:@"PostTableCell" bundle:nil] forCellReuseIdentifier:@"PostTableCell"];
    __weak __typeof(self) weakSelf = self;
   [self enableSimpleRefresh:self.tableView block:^(SRRefreshView *sender) {
       pageIndex = 0;
       [weakSelf.tableView.footer setCanLoadMore:YES];
       [weakSelf loadMoreData];
   }];
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreData)];
}


- (void)setCirCleArray:(NSArray *)cirCleArray
{
    _cirCleArray = cirCleArray;
    if (cirCleArray.count > 0) {
        QWCircleModel* firstCircle = cirCleArray[0];
        [self.firstCircleImageView setImageWithURL:[NSURL URLWithString:firstCircle.teamLogo] placeholderImage:ForumCircleImage];
        self.firstCircleTitleLabel.text = firstCircle.teamName;
        if (firstCircle.master > 0) {
            self.firstCircleSubTitleLabel.text = [NSString stringWithFormat:@"%ld个专家圈主", firstCircle.master];
        }
        else
        {
            self.firstCircleSubTitleLabel.text = @"暂无专家圈主";
        }
    }
    else
    {
        [self.firstCircleImageView setImage: ForumCircleImage];
        self.firstCircleTitleLabel.text = nil;
        self.firstCircleSubTitleLabel.text = nil;
    }
    if (cirCleArray.count > 1) {
        QWCircleModel* secondCircle = cirCleArray[1];
        [self.secondCircleImageView setImageWithURL:[NSURL URLWithString:secondCircle.teamLogo] placeholderImage:ForumCircleImage];
        self.secondCircleTitleLabel.text = secondCircle.teamName;
        if (secondCircle.master > 0) {
            self.secondCircleSubTitleLabel.text = [NSString stringWithFormat:@"%ld个专家圈主", secondCircle.master];
        }
        else
        {
            self.secondCircleSubTitleLabel.text = @"暂无专家圈主";
        }
    }
    else
    {
        [self.secondCircleImageView setImage: ForumCircleImage];
        self.secondCircleTitleLabel.text = nil;
        self.secondCircleSubTitleLabel.text = nil;
    }
}

- (void)setNoticePushArray:(NSArray *)noticePushArray
{
    _noticePushArray = noticePushArray;
    [titleArray removeAllObjects];
    for (QWNoticePushModel* noticePushModel in _noticePushArray) {
        BranchActivityVo* notice = [[BranchActivityVo alloc] init];
        notice.title = noticePushModel.noticeTitle;
        [titleArray addObject:notice];
    }
    self.noticeScrollView.dataArray = titleArray;
    [self.noticeScrollView setupView];
    [self hiddenNoticeView:titleArray.count == 0 animation:NO];
}

#pragma mark - AutoScrollView Delegate
- (void)didSelectedButtonAtIndex:(NSInteger)index
{
    if (index < self.noticePushArray.count) {
        QWNoticePushModel* noticePushModel = self.noticePushArray[index];
        switch (noticePushModel.columnType) {
            case 1: // 外链
            {
                NSString* noticiName = StrIsEmpty(noticePushModel.noticeTitle) ? @"H5外链" : noticePushModel.noticeTitle;
                [QWGLOBALMANAGER statisticsEventId:@"x_qz_tg" withLable:@"圈子-通告" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"通告名":noticiName,@"通告类型":@"H5"}]];
                
                WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
                WebDirectLocalModel *modelLocal = [[WebDirectLocalModel alloc] init];
                modelLocal.url = noticePushModel.noticeContent;
                modelLocal.typeLocalWeb = WebLocalTypeOuterLink;
                modelLocal.title = noticePushModel.noticeTitle;
                vcWebDirect.isOtherLinks = YES;
                [vcWebDirect setWVWithLocalModel:modelLocal];
//                vcWebDirect.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vcWebDirect animated:YES];
            }
                break;
            case 10:  // 帖子详情
            {
                NSString* noticiName = StrIsEmpty(noticePushModel.noticeTitle) ? @"帖子详情" : noticePushModel.noticeTitle;
                [QWGLOBALMANAGER statisticsEventId:@"x_qz_tg" withLable:@"圈子-通告" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"通告名":noticiName,@"通告类型":@"帖子详情"}]];
                
                PostDetailViewController* postDetailVC = (PostDetailViewController*)[[UIStoryboard storyboardWithName:@"Forum" bundle:nil] instantiateViewControllerWithIdentifier:@"PostDetailViewController"];
                postDetailVC.hidesBottomBarWhenPushed = YES;
                postDetailVC.postId = noticePushModel.noticeContent;
                postDetailVC.preVCNameStr = @"热议";
                [self.navigationController pushViewController:postDetailVC animated:YES];
            }
            default:
                break;
        }
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.postArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostTableCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PostTableCell" forIndexPath:indexPath];
    cell.postCellType = PostCellType_HotDiscuss;
    [self configure:cell indexPath:indexPath];
    return cell;
}

- (void) configure:(PostTableCell*)cell indexPath:(NSIndexPath*)indexPath
{
    __weak QWPostModel* postModel = self.postArray[indexPath.row];
    cell.userInfoBtn.touchUpInsideBlock = ^{
        DebugLog(@"go to user detial : %@", postModel.posterId);
        
        
        if ([postModel.posterId isEqualToString:QWGLOBALMANAGER.configure.passPort]) {
            return ;
        }
        
        if (postModel.posterType == PosterType_YaoShi || postModel.posterType == PosterType_YingYangShi) {
            ExpertPageViewController *vc = [[UIStoryboard storyboardWithName:@"ExpertPage" bundle:nil] instantiateViewControllerWithIdentifier:@"ExpertPageViewController"];
            vc.hidesBottomBarWhenPushed = YES;
            vc.posterId = postModel.posterId;
            vc.expertType = (int)postModel.posterType;
            vc.preVCNameStr = @"热议";
            vc.nickName = postModel.nickname;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            UserPageViewController *vc = [[UIStoryboard storyboardWithName:@"UserPage" bundle:nil] instantiateViewControllerWithIdentifier:@"UserPageViewController"];
            vc.hidesBottomBarWhenPushed = YES;
            vc.mbrId = postModel.posterId;
            [self.navigationController pushViewController:vc animated:YES];
        }
        // @property (nonatomic, assign) NSInteger posterType;     // 发帖人类型(1:普通用户, 2:马甲, 3:药师, 4:营养师),
    };
    [cell setCell:postModel];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:@"PostTableCell" cacheByIndexPath:indexPath configuration:^(id cell) {
        [self configure:cell indexPath:indexPath];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.postArray.count) {
        QWPostModel* postModel =  self.postArray[indexPath.row];
        
        [QWGLOBALMANAGER statisticsEventId:@"x_qz_dj" withLable:@"圈子-点击某个帖子" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"是否登录":StrFromInt(QWGLOBALMANAGER.loginStatus),@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl),@"帖子名":StrDFString(postModel.postTitle, @"帖子名"),@"圈子名":StrDFString(postModel.teamName, @"圈子名")}]];
        
        PostDetailViewController* postDetailVC = (PostDetailViewController*)[[UIStoryboard storyboardWithName:@"Forum" bundle:nil] instantiateViewControllerWithIdentifier:@"PostDetailViewController"];
        postDetailVC.hidesBottomBarWhenPushed = YES;
        postDetailVC.postId = postModel.postId;
        postDetailVC.preVCNameStr = @"热议";
        [self.navigationController pushViewController:postDetailVC animated:YES];
    }
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

- (IBAction)allCircleBtnAction:(id)sender {
    AllCircleViewController* allCirCleVC = (AllCircleViewController*)[[UIStoryboard storyboardWithName:@"Forum" bundle:nil] instantiateViewControllerWithIdentifier:@"AllCircleViewController"];
    allCirCleVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:allCirCleVC animated:YES];
}

- (IBAction)firstCircleBtnAction:(id)sender {
    //
    DebugLog(@"click first circle");
    if (self.cirCleArray.count < 1) {
        return;
    }
    // 进入圈子详情
    CircleDetailViewController *vc = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleDetailViewController"];
    vc.hidesBottomBarWhenPushed = YES;
    if (self.cirCleArray.count > 0) {
        QWCircleModel* circleModel = self.cirCleArray[0];
        vc.teamId  = circleModel.teamId;
        vc.title = [NSString stringWithFormat:@"%@圈",circleModel.teamName];
        [QWGLOBALMANAGER statisticsEventId:@"x_qz_dyg" withLable:@"圈子-第一个圈子" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"是否登录":StrFromInt(QWGLOBALMANAGER.loginStatus),@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl),@"圈子名":StrDFString(circleModel.teamName, @"圈子名称")}]];
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)secondCircleBtnAction:(id)sender {
    DebugLog(@"click second circle");
    if (self.cirCleArray.count < 2) {
        return;
    }
    CircleDetailViewController *vc = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleDetailViewController"];
    vc.hidesBottomBarWhenPushed = YES;
    if (self.cirCleArray.count > 1) {
        QWCircleModel* circleModel = self.cirCleArray[1];
        vc.teamId = circleModel.teamId;
        vc.title = [NSString stringWithFormat:@"%@圈",circleModel.teamName];
        [QWGLOBALMANAGER statisticsEventId:@"x_qz_deg" withLable:@"圈子-第二个圈子" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"是否登录":StrFromInt(QWGLOBALMANAGER.loginStatus),@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl),@"圈子名":StrDFString(circleModel.teamName, @"圈子名称")}]];
    }
    [self.navigationController pushViewController:vc animated:YES];
}
/**
 *  4.0.0 UNAVAILABLE
 */
//- (IBAction)sendPostBtnAction:(id)sender {
//    if(!QWGLOBALMANAGER.loginStatus) {
//        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
//        UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
//        loginViewController.isPresentType = YES;
//        loginViewController.loginSuccessBlock = ^{
//            if (QWGLOBALMANAGER.configure.flagSilenced) {
//                [SVProgressHUD showErrorWithStatus:@"您已被禁言"];
//                return;
//            }
//            SendPostViewController* sendPostVC = [[UIStoryboard storyboardWithName:@"Forum" bundle:nil] instantiateViewControllerWithIdentifier:@"SendPostViewController"];
//            sendPostVC.hidesBottomBarWhenPushed = YES;
//            sendPostVC.needChooseCircle = YES;
//            sendPostVC.preVCNameStr = @"热议";
//            [self.navigationController pushViewController:sendPostVC animated:YES];
//        };
//        [self presentViewController:navgationController animated:YES completion:NULL];
//        return;
//    }
//    
//    if (QWGLOBALMANAGER.configure.flagSilenced) {
//        [SVProgressHUD showErrorWithStatus:@"您已被禁言"];
//        return;
//    }
//    SendPostViewController* sendPostVC = [[UIStoryboard storyboardWithName:@"Forum" bundle:nil] instantiateViewControllerWithIdentifier:@"SendPostViewController"];
//    sendPostVC.hidesBottomBarWhenPushed = YES;
//    sendPostVC.needChooseCircle = YES;
//    sendPostVC.preVCNameStr = @"热议";
//    [self.navigationController pushViewController:sendPostVC animated:YES];
//}
@end
