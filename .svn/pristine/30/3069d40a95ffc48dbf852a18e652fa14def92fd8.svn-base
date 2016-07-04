//
//  DetailSubscriptionListViewController.m
//  wenyao
//
//  Created by Pan@QW on 14-9-25.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "DetailSubscriptionListViewController.h"
#import "AppDelegate.h"
#import "UIScrollView+MJRefresh.h"
#import "SVProgressHUD.h"
#import "DrugGuideModelR.h"
#import "DrugGuideApi.h"
#import "css.h"
#import "ReturnIndexView.h"
#import "MessageBoxListViewController.h"
#import "LoginViewController.h"

@interface DetailSubscriptionListViewController ()<UITableViewDataSource,UITableViewDelegate, UIWebViewDelegate>

@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, strong) NSMutableArray *arrAllMsg;
@property (nonatomic, strong) DrugGuideMsgLogModel *modelMsgLog;
@property (nonatomic, strong) UILabel *numLabel;   //数字角标
@property (nonatomic, strong) UILabel *redLabel;   //小红点
@property (nonatomic, strong) ReturnIndexView *indexView;
@property (assign, nonatomic) int passNumber;


@end

@implementation DetailSubscriptionListViewController
@synthesize tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (iOSv7 && self.view.frame.origin.y==0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    self.arrAllMsg = [@[] mutableCopy];
    self.curPage = 1;
    self.title = self.modelDrugGuide.title;
    [self setupWebView];
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [self showInfoView:kWarning12 image:@"网络信号icon.png"];
    } else {
        [self showInfoView:kWarning30 image:@"ic_img_fail"];
//        [self queryMsgLogList];
        [self loadHTMLContent];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.passNumber = [QWGLOBALMANAGER updateRedPoint];
//    [self setUpRightItem];
}

- (void)setUpRightItem
{
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width = -15;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    
    //三个点button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(5, -2, 50, 40);
    [button setImage:[UIImage imageNamed:@"icon-unfold.PNG"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(returnIndex) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:button];
    
    //数字角标
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(38, 1, 18, 18)];
    self.numLabel.backgroundColor = RGBHex(qwColor3);
    self.numLabel.layer.cornerRadius = 9.0;
    self.numLabel.textColor = [UIColor whiteColor];
    self.numLabel.font = [UIFont systemFontOfSize:11];
    self.numLabel.textAlignment = NSTextAlignmentCenter;
    self.numLabel.layer.masksToBounds = YES;
    self.numLabel.text = @"10";
    self.numLabel.hidden = YES;
    [rightView addSubview:self.numLabel];
    
    //小红点
    self.redLabel = [[UILabel alloc] initWithFrame:CGRectMake(43, 10, 8, 8)];
    self.redLabel.backgroundColor = RGBHex(qwColor3);
    self.redLabel.layer.cornerRadius = 4.0;
    self.redLabel.layer.masksToBounds = YES;
    self.redLabel.hidden = YES;
    [rightView addSubview:self.redLabel];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItems = @[fixed,rightItem];
    
    if (self.passNumber > 0)
    {
        //显示数字
        self.numLabel.hidden = NO;
        self.redLabel.hidden = YES;
        if (self.passNumber > 99) {
            self.passNumber = 99;
        }
        self.numLabel.text = [NSString stringWithFormat:@"%d",self.passNumber];
        
    }else if (self.passNumber == 0)
    {
        //显示小红点
        self.numLabel.hidden = YES;
        self.redLabel.hidden = NO;
        
    }else if (self.passNumber < 0)
    {
        //全部隐藏
        self.numLabel.hidden = YES;
        self.redLabel.hidden = YES;
    }

}
- (void)returnIndex
{
    self.indexView = [ReturnIndexView sharedManagerWithImage:@[@"ic_img_notice",@"icon home.PNG"] title:@[@"消息",@"首页"] passValue:self.passNumber];
    self.indexView.delegate = self;
    [self.indexView show];
}
- (void)RetunIndexView:(ReturnIndexView *)ReturnIndexView didSelectedIndex:(NSIndexPath *)indexPath
{
    [self.indexView hide];
    
    if (indexPath.row == 0)
    {
        if(!QWGLOBALMANAGER.loginStatus) {
            LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
            loginViewController.isPresentType = YES;
            [self presentViewController:navgationController animated:YES completion:NULL];
            return;
        }
        
        MessageBoxListViewController *vcMsgBoxList = [[UIStoryboard storyboardWithName:@"MessageBoxListViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MessageBoxListViewController"];
        
        vcMsgBoxList.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vcMsgBoxList animated:YES];
        
    }else if (indexPath.row == 1)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self performSelector:@selector(delayPopToHome) withObject:nil afterDelay:0.01];
    }
    
}
- (void)delayPopToHome
{
    [QWGLOBALMANAGER.tabBar setSelectedIndex:0];
}

- (void)loadHTMLContent
{
    [self removeInfoView];

    NSString *strLoadURL = DiseasePageURL(self.modelDrugGuide.guideId, QWGLOBALMANAGER.configure.userToken);//[NSString stringWithFormat:@"http://192.168.5.33:8183/app/html/subscibe.html?attentionId=%@&drugGuideId=%@&token=%@",self.modelDrugGuide.attentionId,self.modelDrugGuide.guideId,QWGLOBALMANAGER.configure.userToken];
//    NSString *strLoadURL = [NSString stringWithFormat:@"http://192.168.5.33:8183/app/html/subscibe.html?attentionId=f9697f52f171097ae040a8c02200552b&drugGuideId=0601232f9f186d4be050007f01006808&token=bc92bd7bc2e534ec9a540b7c9ba975f2f"];
    DDLogVerbose(@"##### the url is %@",strLoadURL);
    [self.wbViewContent loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strLoadURL]]];
}

- (void)queryMsgLogList
{
    [self removeInfoView];
    DrugMsgLogListModelR *modelR = [[DrugMsgLogListModelR alloc] init];
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    modelR.drugGuideId = self.modelDrugGuide.guideId;
    modelR.currPage = [NSString stringWithFormat:@"%ld", (long)self.curPage];
    modelR.pageSize = @"10";
    [DrugGuideApi queryMsgLogList:modelR success:^(id model) {
        if (model != nil) {
            [self removeInfoView];
 
            DrugGuideMsgLogModel *modelNew = (DrugGuideMsgLogModel *)model;
            if (modelNew.list.count == 0) {
                self.tableView.footer.canLoadMore = NO;
            } else {
                for (int i = 0; i < modelNew.list.count; i++) {
                    DrugGuideMsgLogListModel *model = modelNew.list[i];
                    if (i == 0) {
                        model.expanded = @"1";
                        break;
                    }
                }
                [self.arrAllMsg addObjectsFromArray:modelNew.list];
                [self.tableView reloadData];
            }
        } else {
            self.tableView.footer.canLoadMore = NO;
        }
        [self.tableView footerEndRefreshing];
    } failure:^(HttpException *err) {
        [self showInfoView:kWarning39 image:@"ic_img_fail"];
        [self.tableView footerEndRefreshing];
    }];
}

- (void)viewInfoClickAction:(id)sender
{
    if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        [self removeInfoView];
        [self queryMsgLogList];
    }
}

- (void)setupTableView
{
    
    self.view.frame = CGRectMake(0, 0, APP_W, self.view.frame.size.height - 64);
    CGRect rect = self.view.frame;
    self.tableView = [[UIFolderTableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = RGBHex(qwColor11);
    [self.tableView setBackgroundColor:RGBHex(qwColor11)];
    self.tableView.rowHeight = 44.0f;
    [self.view addSubview:self.tableView];
    
    __weak DetailSubscriptionListViewController *weakSelf = self;
    [self.tableView addFooterWithCallback:^{
        weakSelf.curPage ++;
        [weakSelf queryMsgLogList];
    }];
    self.tableView.footerPullToRefreshText = kWarning16;
    self.tableView.footerReleaseToRefreshText = kWarning17;
    self.tableView.footerRefreshingText = kWarning9;
    self.tableView.footerNoDataText = kWarning44;
}

- (void)setupWebView
{
    self.view.frame = CGRectMake(0, 0, APP_W, self.view.frame.size.height - 64);
    CGRect rect = self.view.frame;
    self.wbViewContent = [[UIWebView alloc] initWithFrame:rect];
    self.wbViewContent.delegate = self;
    [self.wbViewContent setBackgroundColor:RGBHex(qwColor11)];
    [self.view addSubview:self.wbViewContent];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [QWLOADING removeLoading];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [QWLOADING showLoading];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [QWLOADING removeLoading];
}


#pragma mark -
#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        return 44.0f;
    }else{
        DrugGuideMsgLogListModel *model = self.arrAllMsg[indexPath.section];
        UIView *contentView = [self createViewFromDictionary:model];
        return contentView.frame.size.height;
    }
}

- (NSInteger)tableView:(UITableView *)atableView numberOfRowsInSection:(NSInteger)section
{
    DrugGuideMsgLogListModel *model = self.arrAllMsg[section];
    if([model.expanded isEqualToString:@"1"]){
        return 2;
    }else{
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)atableView
{
    return self.arrAllMsg.count;
}

- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *DetailsubscriptionIdentifier = @"DetailsubscriptionCellIdentifier";
    UITableViewCell *cell = [atableView dequeueReusableCellWithIdentifier:DetailsubscriptionIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DetailsubscriptionIdentifier];
    }
    [[cell.contentView viewWithTag:999] removeFromSuperview];
    DrugGuideMsgLogListModel *model = self.arrAllMsg[indexPath.section];
    if(indexPath.row == 0){
        cell.textLabel.text = model.title;
        cell.textLabel.font = fontSystem(16);
        cell.textLabel.textColor = RGBHex(qwColor6);
        UILabel *accessoryView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 20)];
        accessoryView.text = [model.sendTime substringToIndex:10];
        accessoryView.font = [UIFont systemFontOfSize:12.0];
        accessoryView.textColor = RGBHex(qwColor9);
        cell.accessoryView = accessoryView;
    }else{
        cell.accessoryView = nil;
        cell.textLabel.text = @"";
        UIView *contentView = [self createViewFromDictionary:model];
        contentView.tag = 999;
        [cell.contentView addSubview:contentView];
    }
    return cell;
}

- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [atableView deselectRowAtIndexPath:indexPath animated:YES];
    DrugGuideMsgLogListModel *model = self.arrAllMsg[indexPath.section];
    if([model.expanded isEqualToString:@"1"]){
        model.expanded = @"0";
    }else{
        model.expanded = @"1";
    }
    [self.tableView reloadData];
    if ([model.expanded isEqualToString:@"1"]) {
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

#pragma mark - 创建view
- (UIView *)createViewFromDictionary:(DrugGuideMsgLogListModel *)model
{
    // 设置点击喜欢按钮
    UIView *contentView = [[UIView alloc] init];
    [contentView setBackgroundColor:RGBHex(qwColor11)];
    NSString *strContent = [QWGLOBALMANAGER replaceSpecialStringWith:model.content];
    CGSize size = [QWGLOBALMANAGER sizeText:strContent font:fontSystem(kFontS4) limitWidth:APP_W-20];
    //[ sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(APP_W-20, 1999)];
    contentView.frame = CGRectMake(0, 0, APP_W, size.height + 15);
    //contentLabel
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.text = strContent;
    contentLabel.numberOfLines = 0;
    contentLabel.font = fontSystem(14);
    contentLabel.textColor = RGBHex(qwColor7);
    contentLabel.frame = CGRectMake(10, 0, APP_W-20, size.height);
    [contentView addSubview:contentLabel];
    
    //button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"普通喜欢icon.png"] forState:UIControlStateNormal];
    NSUInteger tag = [self.arrAllMsg indexOfObject:model];
    //    button.tag = tag;
    [button addTarget:self action:@selector(likeClick:) forControlEvents:UIControlEventTouchDown];
//    button.frame = CGRectMake(270, contentLabel.frame.origin.y + contentLabel.frame.size.height-10, 12, 12);
    button.frame = CGRectMake(270, contentLabel.frame.origin.y + contentLabel.frame.size.height, 12, 12);

    [contentView addSubview:button];
    
    //btnClick
    UIButton *btnClick = [UIButton buttonWithType:UIButtonTypeCustom];
    btnClick.tag = tag;
    [btnClick addTarget:self action:@selector(likeClick:) forControlEvents:UIControlEventTouchDown];
    btnClick.frame = CGRectMake(260, contentLabel.frame.origin.y + contentLabel.frame.size.height-10, 50, 32);

//    btnClick.frame = CGRectMake(260, contentLabel.frame.origin.y + contentLabel.frame.size.height - 20, 50, 32);
    [contentView addSubview:btnClick];

    //numberLabel
//    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(290, contentLabel.frame.origin.y + contentLabel.frame.size.height-12, 14, 14)];
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(290, contentLabel.frame.origin.y + contentLabel.frame.size.height-2, 14, 14)];
    numberLabel.text = [NSString stringWithFormat:@"%@",model.likeNumber];
    numberLabel.textColor = [UIColor grayColor];
    numberLabel.font = [UIFont systemFontOfSize:13.5];
    [contentView addSubview:numberLabel];
    
    if([model.likeStatus intValue] == 0){
        [button setImage:[UIImage imageNamed:@"普通喜欢icon"] forState:UIControlStateNormal];
    }else{
        [button setImage:[UIImage imageNamed:@"已喜欢icon"] forState:UIControlStateNormal];
    }
    return contentView;
}

- (void)likeClick:(UIButton *)sender
{
    __block DrugGuideMsgLogListModel *modelList = self.arrAllMsg[sender.tag];
    DrugGuideLikeCountModelR *modelR = [[DrugGuideLikeCountModelR alloc] init];
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    modelR.objId = modelList.msgId;
    modelR.objType = @"2";
    __weak DetailSubscriptionListViewController *weakSelf = self;
    if ([modelList.likeStatus intValue] == 0) {
        [DrugGuideApi addLikeNum:modelR success:^(id model) {
            DDLogVerbose(@"MODEL %@", model);
            modelList.likeStatus = @"1";
            modelList.likeNumber = [NSString stringWithFormat:@"%d",[modelList.likeNumber intValue]+1];
            [weakSelf.tableView reloadData];
        } failure:^(HttpException *err) {
            
        }];
    } else {
        [DrugGuideApi minusLikeNum:modelR success:^(id model) {
            DDLogVerbose(@"MODEL %@", model);
            modelList.likeStatus = @"0";
            modelList.likeNumber = [NSString stringWithFormat:@"%d",[modelList.likeNumber intValue]-1];
            [weakSelf.tableView reloadData];
        } failure:^(HttpException *err) {
            
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj{
    if (NotiWhetherHaveNewMessage == type) {
        
        NSString *str = data;
        self.passNumber = [str integerValue];
        self.indexView.passValue = self.passNumber;
        [self.indexView.tableView reloadData];
        if (self.passNumber > 0)
        {
            //显示数字
            self.numLabel.hidden = NO;
            self.redLabel.hidden = YES;
            if (self.passNumber > 99) {
                self.passNumber = 99;
            }
            self.numLabel.text = [NSString stringWithFormat:@"%d",self.passNumber];
            
        }else if (self.passNumber == 0)
        {
            //显示小红点
            self.numLabel.hidden = YES;
            self.redLabel.hidden = NO;
            
        }else if (self.passNumber < 0)
        {
            //全部隐藏
            self.numLabel.hidden = YES;
            self.redLabel.hidden = YES;
        }
    }
}



@end
