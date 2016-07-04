//
//  NewMyCollectViewController.m
//  APP
//
//  Created by qw_imac on 16/1/13.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "NewMyCollectViewController.h"
#import "MedicineSellListCell.h"
#import "PostInCircleTableCell.h"
#import "HealthCellStyleThreeImg.h"
#import "HealthCellStyleSmallImg.h"
#import "HealthCellStyleLargeImg.h"
#import "HealthCellStyleOnlyText.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "Forum.h"
#import "Favorite.h"
#import "FavoriteModel.h"
#import "FavoriteModelR.h"
#import "SVProgressHUD.h"
#import "Circle.h"
#import "CircleModel.h"
#import "WebDirectViewController.h"
#import "PostDetailViewController.h"
#import "ExpertPageViewController.h"
#import "UserPageViewController.h"
#define CellStyleSmallImg @"HealthCellStyleSmallImg"
#define CellStyleLargeImg @"HealthCellStyleLargeImg"
#define CellStyleThreeImg @"HealthCellStyleThreeImg"
#define CellStyleOnlyText @"HealthCellStyleOnlyText"

@interface NewMyCollectViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UISegmentedControl  *segment;
    NSInteger           currentIndex;
    NSMutableArray      *postArray;
    
   // NSMutableArray *dragArray;
}
@property (nonatomic,strong) UIScrollView       *scroll;
@property (nonatomic,strong) UITableView        *messageTableView;
@property (nonatomic,strong) UITableView        *postTableView;
@property (nonatomic,assign) NSInteger          intMyCollectMsg;
@property (nonatomic,strong) NSMutableArray     *messageArray;
@property (nonatomic,assign) NSInteger          myPostMsg;
//@property (nonatomic,strong) UITableView *drugTableView;
@end

@implementation NewMyCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    postArray  = [NSMutableArray array];
    self.intMyCollectMsg = 1;
    _myPostMsg = 1;
    self.messageArray = [@[] mutableCopy];
    [self setupUI];
    // Do any additional setup after loading the view.
}
-(void)setupUI {
    [self setupSegment];
    [self setThreeTableView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self segmentAction:segment];
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [self showInfoView:kWarningN2 image:@"网络信号icon"];
    }else {
        [self getMyMsgList];
        [self queryPostData];
    }
     ((QWBaseNavigationController *)self.navigationController).canDragBack = NO;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
     ((QWBaseNavigationController *)self.navigationController).canDragBack = YES;
}
-(void)setThreeTableView {
    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, APP_W, [[UIScreen mainScreen] bounds].size.height -64)];
    self.scroll.contentSize = CGSizeMake(APP_W *2, [[UIScreen mainScreen] bounds].size.height -64);
    self.scroll.pagingEnabled = YES;
    self.scroll.scrollEnabled = NO;
    [self.view addSubview:self.scroll];
    //资讯
    self.messageTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0 , APP_W, [[UIScreen mainScreen] bounds].size.height -64) style:UITableViewStylePlain];
    self.messageTableView.delegate = self;
    self.messageTableView.dataSource = self;
    self.messageTableView.scrollEnabled = YES;
    self.messageTableView.backgroundColor = [UIColor clearColor];
    self.messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //注册cell
    [self.messageTableView registerNib:[UINib nibWithNibName:@"HealthCellStyleSmallImg" bundle:nil] forCellReuseIdentifier:CellStyleSmallImg];
    [self.messageTableView registerNib:[UINib nibWithNibName:@"HealthCellStyleLargeImg" bundle:nil] forCellReuseIdentifier:CellStyleLargeImg];
    [self.messageTableView registerNib:[UINib nibWithNibName:@"HealthCellStyleThreeImg" bundle:nil] forCellReuseIdentifier:CellStyleThreeImg];
    [self.messageTableView registerNib:[UINib nibWithNibName:@"HealthCellStyleOnlyText" bundle:nil] forCellReuseIdentifier:CellStyleOnlyText];
    
    __weak typeof(self) weakSelf = self;
    //下拉刷新
    [self enableSimpleRefresh:self.messageTableView block:^(SRRefreshView *sender) {
        [weakSelf headerRefreshWith:self.messageTableView];
    }];

    [self.scroll addSubview:self.messageTableView];
    //帖子
    self.postTableView =[[UITableView alloc] initWithFrame:CGRectMake(APP_W, 0 , APP_W, [[UIScreen mainScreen] bounds].size.height -64) style:UITableViewStylePlain];
    self.postTableView.delegate = self;
    self.postTableView.dataSource = self;
    self.postTableView.scrollEnabled = YES;
    self.postTableView.backgroundColor = [UIColor clearColor];
    self.postTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 注册cell
    [self.postTableView registerNib:[UINib nibWithNibName:@"PostInCircleTableCell" bundle:nil] forCellReuseIdentifier:@"PostInCircleTableCell"];
    [self enableSimpleRefresh:self.postTableView block:^(SRRefreshView *sender) {
        [weakSelf headerRefreshWith:self.postTableView];
    }];

    [self.scroll addSubview:self.postTableView];
//    //药品
//    self.drugTableView =[[UITableView alloc] initWithFrame:CGRectMake(APP_W*2,0 , APP_W, [[UIScreen mainScreen] bounds].size.height -64) style:UITableViewStylePlain];
//    self.drugTableView.delegate = self;
//    self.drugTableView.dataSource = self;
//    self.drugTableView.scrollEnabled = YES;
//    self.drugTableView.backgroundColor = [UIColor clearColor];
//    [self enableSimpleRefresh:self.drugTableView block:^(SRRefreshView *sender) {
//        [weakSelf headerRefreshWith:self.drugTableView];
//    }];
//
//    [self.scroll addSubview:self.drugTableView];

}


-(void)headerRefreshWith:(UITableView *)tableView {
    if (tableView == self.messageTableView) {
        [self getMyMsgList];
    }else if (tableView == self.postTableView) {
        [self queryPostData];
    }
}



-(void)setupSegment {
    segment = [[UISegmentedControl alloc]initWithItems:@[@"资讯",@"帖子"]];
    segment.frame = CGRectMake(0, 0, 150, 30);
    segment.tintColor = RGBHex(qwColor1);
    segment.backgroundColor = RGBHex(qwColor10);
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowBlurRadius = 1;
    shadow.shadowColor = [UIColor clearColor];
    shadow.shadowOffset = CGSizeMake(1, 1);
    NSDictionary *dicSelected = [NSDictionary dictionaryWithObjectsAndKeys:RGBHex(qwColor4),NSForegroundColorAttributeName,  fontSystem(13.0f),NSFontAttributeName ,shadow,NSShadowAttributeName ,@(0),NSVerticalGlyphFormAttributeName,nil];
    [segment setTitleTextAttributes:dicSelected forState:UIControlStateSelected];
    
 
    NSDictionary *dicNormal = [NSDictionary dictionaryWithObjectsAndKeys:RGBHex(qwColor7),NSForegroundColorAttributeName,  fontSystem(13.0f),NSFontAttributeName ,shadow,NSShadowAttributeName ,@(0),NSVerticalGlyphFormAttributeName,nil];
    [segment setTitleTextAttributes:dicNormal forState:UIControlStateNormal];
    
    [segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    segment.selectedSegmentIndex = 0;
    currentIndex = segment.selectedSegmentIndex;
    self.navigationItem.titleView = segment;
}

#pragma mark - tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.messageTableView) {
        return self.messageArray.count;
    }else if (tableView == self.postTableView){
        return postArray.count;
    }else {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.messageTableView) {
        MyFavMsgListModel *model = self.messageArray[indexPath.row];
        if ([model.showType intValue] == 1) {
            return [self setCellStyleOnlyTextWithIndex:indexPath];
        } else if ([model.showType intValue] == 2) {
            return [self setCellStyleSmallImgWithIndex:indexPath];
        } else if ([model.showType intValue] == 3) {
            return [self setCellStyleThreeImgWithIndex:indexPath];
        } else {
            return [self setCellStyleLargeImgWithIndex:indexPath];
        }

    }else if (tableView == self.postTableView){
        PostInCircleTableCell *cell = (PostInCircleTableCell *)[tableView dequeueReusableCellWithIdentifier:@"PostInCircleTableCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"PostInCircleTableCell" owner:self options:nil][0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // 点击头像行为
        __weak PostCollectVo* weakModel = postArray[indexPath.row];
        cell.userInfoBtn.touchUpInsideBlock = ^{
            
            
            if ([weakModel.posterId isEqualToString:QWGLOBALMANAGER.configure.passPort]) {
                return ;
            }
            
            if (weakModel.posterType == PosterType_YaoShi || weakModel.posterType == PosterType_YingYangShi) {
                ExpertPageViewController *vc = [[UIStoryboard storyboardWithName:@"ExpertPage" bundle:nil] instantiateViewControllerWithIdentifier:@"ExpertPageViewController"];
                vc.hidesBottomBarWhenPushed = YES;
                vc.posterId = weakModel.posterId;
                vc.expertType = weakModel.posterType;
                vc.preVCNameStr = @"收藏";
                vc.nickName = weakModel.nickname;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                UserPageViewController *vc = [[UIStoryboard storyboardWithName:@"UserPage" bundle:nil] instantiateViewControllerWithIdentifier:@"UserPageViewController"];
                vc.hidesBottomBarWhenPushed = YES;
                vc.mbrId = weakModel.posterId;
                [self.navigationController pushViewController:vc animated:YES];
            }
        };
        cell.postCellType = PostCellType_CollectionPost;
        [cell setCell:weakModel];
        return cell;
    }else {
        return nil;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.messageTableView) {
        MyFavMsgListModel *model = self.messageArray[indexPath.row];
        if ([model.showType intValue] == 1) {
            return [self calculateCellStyleOnlyTextWithIndex:indexPath];
        } else if ([model.showType intValue] == 2) {
            return [self calculateCellStyleSmallImgContentWithIndex:indexPath];
        } else if ([model.showType intValue] == 3) {
            return [self calculateCellStyleThreeImgContentWithIndex:indexPath];
        } else {
            return [self calculateCellStyleLargeImgContentWithIndex:indexPath];
        }
    }else if (tableView == self.postTableView){
        return  [tableView fd_heightForCellWithIdentifier:@"PostInCircleTableCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            [cell setCell:postArray[indexPath.row]];
        }];
//        return 230;
    }else {
        return 0;
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.messageTableView) {
        MyFavMsgListModel *modelVO = self.messageArray[indexPath.row];
        
        NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
        tdParams[@"标题"]=modelVO.title;
        [QWGLOBALMANAGER statisticsEventId:@"x_wdsc_zx" withLable:@"我的收藏" withParams:tdParams];
        
        WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
        WebHealthInfoModel *modelHealth = [[WebHealthInfoModel alloc] init];
        WebDirectLocalModel *modelLocal = [[WebDirectLocalModel alloc] init];
        if ([modelVO.artType intValue] == 1) {
            modelHealth.msgID = modelVO.msgID;
            modelHealth.contentType = modelVO.contentType;
            modelLocal.modelHealInfo = modelHealth;
            modelLocal.typeLocalWeb = WebPageToWebTypeInfo;
        } else {
            modelLocal.url = [NSString stringWithFormat:@"%@QWYH/web/message/html/subject.html?id=%@",H5_BASE_URL,modelVO.spclID];
            modelLocal.typeLocalWeb = WebLocalTypeOuterLink;
            //        modelLocal.title = @"专题";
            vcWebDirect.isOtherLinks = YES;
        }
        [vcWebDirect setWVWithLocalModel:modelLocal];
        vcWebDirect.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vcWebDirect animated:YES];
    }else if (tableView == self.postTableView){
        PostCollectVo *vo = postArray[indexPath.row];
        
        NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
        tdParams[@"标题"]=vo.postTitle;
        [QWGLOBALMANAGER statisticsEventId:@"x_wdsc_tz" withLable:@"我的收藏" withParams:tdParams];
        
        PostDetailViewController* vc = [[UIStoryboard storyboardWithName:@"Forum" bundle:nil] instantiateViewControllerWithIdentifier:@"PostDetailViewController"];
        vc.postId = vo.postId;
        vc.preVCNameStr = @"我的收藏";
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        return;
    }

}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
        
        if (tableView == self.messageTableView) {
            MyFavMsgListModel *modelVO = self.messageArray[indexPath.row];
            
            tdParams[@"标题"]=modelVO.title;
            tdParams[@"分类"]=@"咨询";
            [self.messageArray removeObjectAtIndex:indexPath.row];
            [self deleteCollectionWithID:modelVO.msgID withObjType:@"5"];
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
            if (self.messageArray.count == 0) {
                 [self showInfoView:@"没有收藏的资讯" image:@"ic_img_fail"];
            }
        }else if (tableView == self.postTableView){
            PostCollectVo *modelVO = postArray[indexPath.row];
            
            tdParams[@"标题"]=modelVO.postTitle;
            tdParams[@"分类"]=@"帖子";
            [postArray removeObjectAtIndex:indexPath.row];
            [self deleteCollectionWithID:modelVO.postId withObjType:@"10"];
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
            if (postArray.count == 0) {
                [self showInfoView:@"没有收藏的帖子" image:@"ic_img_fail"];
            }
        }
        [QWGLOBALMANAGER statisticsEventId:@"x_wdsc_sc" withLable:@"我的收藏-删除" withParams:tdParams];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
-(void)segmentAction:(UISegmentedControl *)sender {
    [self removeInfoView];
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [self showInfoView:kWarningN2 image:@"网络信号icon"];
    }else {
        switch (sender.selectedSegmentIndex) {
            case 0:
                [QWGLOBALMANAGER statisticsEventId:@"我的收藏_资讯" withLable:nil withParams:nil];
                if (self.messageArray.count == 0) {
                    [self showInfoView:@"没有收藏的资讯" image:@"ic_img_fail"];
                }
                break;
            case 1:
                [QWGLOBALMANAGER statisticsEventId:@"我的收藏_帖子" withLable:nil withParams:nil];
                if (postArray.count == 0) {
                    [self showInfoView:@"没有收藏的帖子" image:@"ic_img_fail"];
                }
                break;
        }
    }
    [self.scroll setContentOffset:CGPointMake((sender.selectedSegmentIndex - currentIndex)*APP_W, 0) animated:NO];
}
#pragma mark - networking
//帖子数据
-(void)queryPostData {
    GetCollectionPostR *modelR = [GetCollectionPostR new];
    modelR.token = QWGLOBALMANAGER.configure.userToken != nil ? QWGLOBALMANAGER.configure.userToken : @"";
    modelR.pageSize = 10000;
    modelR.currPage = _myPostMsg;
    [Forum getCollectionPost:modelR success:^(PostCollectList *model) {
        if ([model.apiStatus intValue] == 0) {
            if (_myPostMsg == 1) {
                [postArray removeAllObjects];
            }
            [postArray addObjectsFromArray:model.postInfoList];
            [self.postTableView reloadData];
        }
        
    } failure:^(HttpException *e) {
        
    }];
}
//资讯数据
- (void)getMyMsgList
{
    FavRequestModelR *modelR = [FavRequestModelR new];
    modelR.token = QWGLOBALMANAGER.configure.userToken != nil ? QWGLOBALMANAGER.configure.userToken : @"";
    modelR.currPage = [NSString stringWithFormat:@"%d",self.intMyCollectMsg];
    modelR.pageSize = @"10000";
    [Favorite getMyCollectMsgWithParams:modelR success:^(MyFavMsgLists *model) {
        [self removeInfoView];
//        if (self.intMyCollectMsg == 1) {
//            [self.messageArray removeAllObjects];
//            if (model.list.count == 0 ) {
//                if (segment.selectedSegmentIndex == 0) {
//                    [self showInfoView:@"没有收藏的资讯" image:@"ic_img_fail"];
//                }
//            }else {
//                self.messageArray = [model.list mutableCopy];
//            }
//        } else {
//            [self.messageArray addObjectsFromArray:model.list];
//        }
        if (_intMyCollectMsg == 1) {
            [_messageArray removeAllObjects];
            if (model.list.count == 0 && segment.selectedSegmentIndex == 0) {
                 [self showInfoView:@"没有收藏的资讯" image:@"ic_img_fail"];
            }
        }
        [_messageArray addObjectsFromArray:model.list];
        [self.messageTableView reloadData];
    } failure:^(HttpException *e) {
        
    }];
}

-(void)deleteCollectionWithID:(NSString *)objId withObjType:(NSString *)objType{
    DelCollectionR *modelR = [DelCollectionR new];
    modelR.token = QWGLOBALMANAGER.configure.userToken != nil ? QWGLOBALMANAGER.configure.userToken : @"";
    modelR.objID = objId;
    modelR.objType = objType;
    [Favorite DelMyCollection:modelR success:^(DelCollectionModel *model) {
        
    } failure:^(HttpException *e) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 资讯Cell Perry
// 三个图片的cell
- (HealthCellStyleThreeImg *)setCellStyleThreeImgWithIndex:(NSIndexPath *)idxPath
{
    HealthCellStyleThreeImg *healthCell = [self.messageTableView dequeueReusableCellWithIdentifier:CellStyleThreeImg];
    MyFavMsgListModel *model = self.messageArray[idxPath.row];
    [healthCell setCell:model];
    healthCell.backgroundColor = RGBHex(qwColor4);
    healthCell.contentView.backgroundColor = RGBHex(qwColor4);
    return healthCell;
}

// 大图cell
- (HealthCellStyleLargeImg *)setCellStyleLargeImgWithIndex:(NSIndexPath *)idxPath
{
    HealthCellStyleLargeImg *healthCell = [self.messageTableView dequeueReusableCellWithIdentifier:CellStyleLargeImg];
    MyFavMsgListModel *model = self.messageArray[idxPath.row];
    [healthCell setCell:model];
    return healthCell;
}

// 小图cell
- (HealthCellStyleSmallImg *)setCellStyleSmallImgWithIndex:(NSIndexPath *)idxPath
{
    HealthCellStyleSmallImg *healthCell = [self.messageTableView dequeueReusableCellWithIdentifier:CellStyleSmallImg];
    MyFavMsgListModel *model = self.messageArray[idxPath.row];
    [healthCell setCell:model];
    return healthCell;
}

// 只含文字cell
- (HealthCellStyleOnlyText *)setCellStyleOnlyTextWithIndex:(NSIndexPath *)idxPath
{
    HealthCellStyleOnlyText *healthCell = [self.messageTableView dequeueReusableCellWithIdentifier:CellStyleOnlyText];
    MyFavMsgListModel *model = self.messageArray[idxPath.row];
    [healthCell setCell:model];
    return healthCell;
}

// 小图cell高度
- (CGFloat)calculateCellStyleSmallImgContentWithIndex:(NSIndexPath *)idxPath
{
    static HealthCellStyleSmallImg *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.messageTableView dequeueReusableCellWithIdentifier:CellStyleSmallImg];
    });
    MyFavMsgListModel *model = self.messageArray[idxPath.row];
    [sizingCell setCell:model];
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.messageTableView.bounds), CGRectGetHeight(sizingCell.bounds));
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGSize sizeFinal = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return sizeFinal.height+1;
}

// 三图
- (CGFloat)calculateCellStyleThreeImgContentWithIndex:(NSIndexPath *)idxPath
{
    static HealthCellStyleThreeImg *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.messageTableView dequeueReusableCellWithIdentifier:CellStyleThreeImg];
    });
    MyFavMsgListModel *model = self.messageArray[idxPath.row];
    [sizingCell setCell:model];
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.messageTableView.bounds), CGRectGetHeight(sizingCell.bounds));
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGSize sizeFinal = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return sizeFinal.height+1;
}

// 大图
- (CGFloat)calculateCellStyleLargeImgContentWithIndex:(NSIndexPath *)idxPath
{
    static HealthCellStyleLargeImg *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.messageTableView dequeueReusableCellWithIdentifier:CellStyleLargeImg];
    });
    MyFavMsgListModel *model = self.messageArray[idxPath.row];
    [sizingCell setCell:model];
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.messageTableView.bounds), CGRectGetHeight(sizingCell.bounds));
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
        sizingCell = [self.messageTableView dequeueReusableCellWithIdentifier:CellStyleOnlyText];
    });
    MyFavMsgListModel *model = self.messageArray[idxPath.row];
    [sizingCell setCell:model];
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.messageTableView.bounds), CGRectGetHeight(sizingCell.bounds));
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGSize sizeFinal = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return sizeFinal.height+1;
}


@end
