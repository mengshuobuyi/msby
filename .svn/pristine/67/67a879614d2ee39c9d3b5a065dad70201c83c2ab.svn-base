//
//  ResortViewController.m
//  APP
//
//  Created by PerryChen on 1/4/16.
//  Copyright © 2016 carret. All rights reserved.
//

#import "ResortViewController.h"

#import "InfoMsg.h"

#import "BYDetailsList.h"
#import "BYListItem.h"
#import "BYDeleteBar.h"
#import "BYScroller.h"
#import "NSArray+Map.h"

@interface ResortViewController ()
{
}

@property (nonatomic,strong) BYDetailsList *detailsList;    // 详情列表

@property (nonatomic,assign) BOOL isInOperate;              // 用户在操作中，此时如果有get请求，不更新列表

@end

@implementation ResortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"资讯";
    self.listTop = [[NSMutableArray alloc] init];
    self.listBottom = [[NSMutableArray alloc] init];
    self.listBottomTwo = [[NSMutableArray alloc] init];
    // 读取缓存
    [self loadCacheData];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItems = nil;
    self.navigationItem.hidesBackButton = YES;
    ((QWBaseNavigationController *)self.navigationController).canDragBack = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    ((QWBaseNavigationController *)self.navigationController).canDragBack = YES;
}

/**
 *  设置频道列表页面
 */
- (void)setupChannelListView
{
    DDLogVerbose(@"the arr is %@",self.listTop);
    // 取消按钮的图片
    UIView *viewImg = [self.view viewWithTag:100];
    if (viewImg) {
        [viewImg removeFromSuperview];
    }
    UIImageView *imgViewCancel = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenW - kBtnCancelWidth - kBtnCancelRight+5, kBtnCancelTop+5, kBtnCancelWidth-10, kBtnCancelHeight-10)];
    imgViewCancel.image = [UIImage imageNamed:@"health_btn_img_close"];
    imgViewCancel.tag = 100;
    [self.view addSubview:imgViewCancel];
    
    // 取消按钮
    UIView *viewBtn = [self.view viewWithTag:101];
    if (viewBtn) {
        [viewBtn removeFromSuperview];
    }
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCancel.frame = CGRectMake(kScreenW - kBtnCancelWidth - kBtnCancelRight, kBtnCancelTop-5, kBtnCancelWidth+20, kBtnCancelHeight+10);
    btnCancel.tag = 101;
    [btnCancel addTarget:self
                  action:@selector(popToPre) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCancel];
    
    // 频道列表
    if (self.detailsList) {
        [self.detailsList removeFromSuperview];
        self.detailsList = nil;
    }
    
    __weak typeof(self) unself = self;
    if (!self.detailsList) {
        self.detailsList = [[BYDetailsList alloc] initWithFrame:CGRectMake(0, 2 * kBtnCancelTop + kBtnCancelHeight, kScreenW, kScreenH-2*kBtnCancelTop-64.0f)];
        self.detailsList.listAll = [NSMutableArray arrayWithObjects:self.listTop,self.listBottom,self.listBottomTwo, nil];

        // 从资讯主页面传过来，如果设值了，则将上一页面选择的频道高亮。
        if (self.itemSelect) {
            [self.detailsList itemRespondFromListBarClickWithItemName:self.itemSelect];
        }
        
        self.detailsList.opertionFromItemBlock = ^(animateType type, ResortItem *item, int index){
            // 点击某个频道的事件
            unself.isInOperate = YES;
            // 重置点击频道的数据类型
            if (type == FromTopToBottomHead) {
                item.dataType = @"3";           // 从我的频道点击到疾病频道
            } else if (type == FromTopToCenterHead) {
                item.dataType = @"2";           // 从我的频道点击到资讯频道
            } else if (type == FromBottomToTopLast || type == FromCenterToTopLast){
                item.dataType = @"1";           // 从疾病频道和资讯频道跳转到我的频道
            }
            // 用户点击了用户频道
            if (topViewClick == type) {
                unself.itemSelect = item;
                [unself popToPre];
            }
        };
        [self.view addSubview:self.detailsList];
    }
}
/**
 *  断网的点击事件
 *
 *  @param sender 断网BUTTON
 */
- (void)viewInfoClickAction:(id)sender
{
    [self requestAllChannels];
}

/**
 *   读取缓存
 */
- (void)loadCacheData
{
    __weak typeof(self) wSelf = self;
    [QWLOADING showLoading];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        wSelf.listTop = (NSMutableArray *)[ResortItem getArrayFromDBWithWhere:@"dataType = '1'"];       // 我选择的频道
        wSelf.listBottom = (NSMutableArray *)[ResortItem getArrayFromDBWithWhere:@"dataType = '2'"];    // 资讯频道
        wSelf.listBottomTwo = (NSMutableArray *)[ResortItem getArrayFromDBWithWhere:@"dataType = '3'"]; // 疾病频道
        if (wSelf.listTop.count == 0) {             // 如果没有数据
            if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
                // 请求数据
                [wSelf requestAllChannels];
            } else {
                // 显示无网页面
                [QWLOADING removeLoading];
                [wSelf showInfoView:kWarning12 image:@"网络信号icon"];
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [QWLOADING removeLoading];
                // 设置列表页
                [wSelf setupChannelListView];
                if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
                    // 同步频道列表
                    [QWGLOBALMANAGER syncInfoChannelList:NO];
                }
            });
        }
    });
}

/**
 *  缓存所有频道
 */
- (void)saveCacheData
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [ResortItem deleteAllObjFromDB];
        for (ResortItem *item in self.listTop) {
            item.dataType = @"1";
        }
        for (ResortItem *item in self.listBottom) {
            item.dataType = @"2";
        }
        for (ResortItem *item in self.listBottomTwo) {
            item.dataType = @"3";
        }
        [ResortItem saveObjToDBWithArray:self.listTop];
        [ResortItem saveObjToDBWithArray:self.listBottom];
        [ResortItem saveObjToDBWithArray:self.listBottomTwo];
    });
}

/**
 *  请求所有频道
 */
- (void)requestAllChannels
{
    InfoMsgQueryUserNotAddChannelModelR *modelR = [InfoMsgQueryUserNotAddChannelModelR new];
    modelR.token = QWGLOBALMANAGER.configure.userToken == nil ? @"" : QWGLOBALMANAGER.configure.userToken;
    modelR.device = DEVICE_ID;
    [InfoMsg getNotAddedHealthInfoChannelList:modelR success:^(MsgChannelListVO *model) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [QWLOADING removeLoading];
            [self removeInfoView];
            [self.listTop removeAllObjects];
            [self.listBottom removeAllObjects];
            [self.listBottomTwo removeAllObjects];
            if (model.list.count <= 0) {
                [self showInfoView:@"缺少数据" image:@"ic_img_fail"];
                return ;
            }
            for (int i = 0; i < model.list.count; i++) {
                MsgChannelVO *modelVO = model.list[i];
                ResortItem *item = [ResortItem new];
                item.strTitle = modelVO.channelName;
                item.strID = modelVO.channelID;
                if ([modelVO.type intValue] == 1) {
                    item.olocation = ocenter;
                } else {
                    item.olocation = obottom;
                }
                // 标示所有频道已经同步好了
                item.updatedStatus = @"Y";
                item.dataType = @"1";               // 用户添加的频道
                if ([item.strTitle isEqualToString:@"热点"]) {
                    item.olocation = otop;
                }
                [self.listTop addObject:item];
            }
            for ( int i = 0; i < model.listNoAdd.count; i++) {
                MsgChannelVO *modelVO = model.listNoAdd[i];
                ResortItem *item = [ResortItem new];
                item.strTitle = modelVO.channelName;
                item.strID = modelVO.channelID;
                if ([modelVO.type intValue] == 1) {
                    item.olocation = ocenter;
                    item.dataType = @"2";           // 资讯频道
                    [self.listBottom addObject:item];
                } else {
                    item.olocation = obottom;
                    item.dataType = @"3";           // 疾病频道
                    [self.listBottomTwo addObject:item];
                }
            }
            // 设置频道列表UI
            [self setupChannelListView];
            // 保存数据
            [self saveCacheData];
        });
    } failure:^(HttpException *e) {
        [QWLOADING removeLoading];
    }];
}


/**
 *  更新用户添加的频道列表
 */
- (void)updateChannelList
{
    [QWGLOBALMANAGER updateInfoChannelList:self.listTop];
//    [QWGLOBALMANAGER syncInfoChannelList:NO];
//    InfoMsgUpdateUserChannelModelR *modelR = [InfoMsgUpdateUserChannelModelR new];
//    modelR.token = QWGLOBALMANAGER.configure.userToken == nil ? @"" : QWGLOBALMANAGER.configure.userToken;
//    modelR.device = DEVICE_ID;
//    ResortItem *itemOne = self.listTop[0];
//    NSMutableString *str = [[NSMutableString alloc] initWithString:itemOne.strID];
//    for (int i = 1; i < self.listTop.count; i++) {
//        ResortItem *itemOne = self.listTop[i];
//        [str appendString:[NSString stringWithFormat:@"%@%@",SeparateStr,itemOne.strID]];
//    }
//    modelR.list = str;
//    [InfoMsg updateUserMsgList:modelR success:^(MsgChannelListVO *model) {
//        if (model.list.count >0) {
//            [QWGLOBALMANAGER saveInfoChannelList:model needUpdateList:NO];
//        }
//    } failure:^(HttpException *e) {
//        
//    }];
}

- (void)popToPre
{
    // 界面跳转动画
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
    
    if (self.isInOperate) {
        // 有任何操作
        if (self.resortRefresh) {
            NSInteger intIndexSelect = -1;
            if (self.itemSelect) {
                // 设置选择的频道id
                for (int i = 0; i < self.detailsList.topView.count; i++) {
                    BYListItem *itemTop = self.detailsList.topView[i];
                    if ([itemTop.item.strID isEqualToString:self.itemSelect.strID]) {
                        intIndexSelect = i;
                        break;
                    }
                }
            }
            if (intIndexSelect < 0) {
                intIndexSelect = 0;
            }
            // 过滤出用户选择的频道
            // 用户添加的频道
            self.listTop = (NSMutableArray *)[(NSArray *)self.detailsList.topView mapObjectsUsingBlock:^id(id obj, NSUInteger idx) {
                BYListItem *itemObj = (BYListItem *)obj;
                return itemObj.item;
            }];
            // 资讯频道
            self.listBottom = (NSMutableArray *)[(NSArray *)self.detailsList.centerView mapObjectsUsingBlock:^id(id obj, NSUInteger idx) {
                BYListItem *itemObj = (BYListItem *)obj;
                return itemObj.item;
            }];
            // 疾病频道
            self.listBottomTwo = (NSMutableArray *)[(NSArray *)self.detailsList.bottomView mapObjectsUsingBlock:^id(id obj, NSUInteger idx) {
                BYListItem *itemObj = (BYListItem *)obj;
                return itemObj.item;
            }];
            
            if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {      // 有网络
                [self.listTop enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    ResortItem *itemS = (ResortItem *)obj;
                    itemS.updatedStatus = @"Y";
                }];
                // 更新资讯频道表
                [self updateChannelList];
            } else {                                                    // 没有网络
                // 置未同步位
                [self.listTop enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    ResortItem *itemS = (ResortItem *)obj;
                    itemS.updatedStatus = @"N";
                }];
                [self saveCacheData];
            }
            // 通知上一个页面刷新数据
            self.resortRefresh(self.listTop, self.listBottom, self.listBottomTwo, intIndexSelect ,self.itemSelect);
        }
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


@end
