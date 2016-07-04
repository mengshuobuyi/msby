//
//  UserPageViewController.m
//  wenYao-store
//
//  Created by Yang Yuexia on 16/1/15.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "UserPageViewController.h"
#import "UserPageCell.h"
#import "UserPagePostViewController.h"
#import "UserPageReplyViewController.h"
#import "UserPageAttenCircleViewController.h"
#import "MyFollowExpertViewController.h"
#import "Circle.h"
#import "CircleModel.h"
#import "SVProgressHUD.h"

@interface UserPageViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *tableHeaderView;
@property (weak, nonatomic) IBOutlet UIImageView *headerIcon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIView *lvlBgView;
@property (weak, nonatomic) IBOutlet UILabel *lvlLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *name_layout_width;
@property (strong, nonatomic) NSMutableArray *titleList;
@property (strong, nonatomic) ExpertMemInfoModel *infoModel;

@end

@implementation UserPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [QWGLOBALMANAGER statisticsEventId:@"用户个人主页页面_出现" withLable:@"营养师专栏-Ta的回帖" withParams:nil];
    
    self.titleList = [NSMutableArray arrayWithObjects:@[@"Ta的发帖",@"Ta的回帖"],@[@"Ta关注的圈子",@"Ta关注的专家"], nil];
    self.tableView.tableHeaderView = self.tableHeaderView;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.infoModel = [ExpertMemInfoModel new];
    [self queryUserInfo];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [QWGLOBALMANAGER statisticsEventId:@"x_yyzl_cx" withLable:@"用户专栏-出现" withParams:nil];
}

- (void)queryUserInfo
{
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [SVProgressHUD showErrorWithStatus:kWarning12];
        return;
    }
    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
    setting[@"mbrId"] = StrFromObj(self.mbrId);
    setting[@"tokenFlag"] = @"N";
    [Circle TeamMyInfoWithParams:setting success:^(id obj) {
        
        ExpertMemInfoModel *model = [ExpertMemInfoModel parse:obj];
        if ([model.apiStatus integerValue] == 0) {
            if (model.silencedFlag) {
                [self showInfoView:@"该用户被禁言" image:@"ic_img_cry"];
            }else{
                self.infoModel = model;
                [self setUpTableHeaderView];
                [self.tableView reloadData];
            }
            
            
        }else{
            [SVProgressHUD showErrorWithStatus:model.apiMessage];
        }
    } failure:^(HttpException *e) {
        
    }];
}

- (void)setUpTableHeaderView
{
    self.headerIcon.layer.cornerRadius = 27.5;
    self.headerIcon.layer.masksToBounds = YES;
    [self.headerIcon setImageWithURL:[NSURL URLWithString:self.infoModel.headImageUrl] placeholderImage:[UIImage imageNamed:@"expert_ic_people"]];
    self.name.text = self.infoModel.nickName;
    CGSize size=[self.name.text sizeWithFont:fontSystem(kFontS1) constrainedToSize:CGSizeMake(APP_W-50, CGFLOAT_MAX)];
    self.name_layout_width.constant = size.width+4;
    self.lvlLabel.text = [NSString stringWithFormat:@"V%d",self.infoModel.mbrLvl];
    
    if (self.infoModel.sex == 0) {
        self.sexImageView.hidden = NO;
        [self.sexImageView setImage:[UIImage imageNamed:@"home_ic_man"]];
    }else if (self.infoModel.sex == 1){
        self.sexImageView.hidden = NO;
        [self.sexImageView setImage:[UIImage imageNamed:@"home_ic_woman"]];
    }else{
        self.sexImageView.hidden = YES;
    }
}

#pragma mark ---- 列表代理 ----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 7;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 7)];
    vv.backgroundColor = RGBHex(qwColor11);
    return vv;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [(NSArray *)self.titleList[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserPageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserPageCell"];
    cell.title.text = self.titleList[indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        //Ta的发帖
        [QWGLOBALMANAGER statisticsEventId:@"x_yyzl_ft" withLable:@"用户专栏-Ta的发帖" withParams:nil];
        
        [QWGLOBALMANAGER statisticsEventId:@"用户个人主页_Ta的发帖按键" withLable:@"营养师专栏-Ta的回帖" withParams:nil];
        
        UserPagePostViewController *vc = [[UIStoryboard storyboardWithName:@"UserPage" bundle:nil] instantiateViewControllerWithIdentifier:@"UserPagePostViewController"];
        vc.expertId = self.infoModel.id;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.section == 0 && indexPath.row == 1){
        
        //Ta的回帖
        [QWGLOBALMANAGER statisticsEventId:@"x_yyzl_ht" withLable:@"用户专栏-Ta的回帖" withParams:nil];

        [QWGLOBALMANAGER statisticsEventId:@"用户个人主页_Ta的回帖按键" withLable:@"营养师专栏-Ta的回帖" withParams:nil];
        
        UserPageReplyViewController *vc = [[UIStoryboard storyboardWithName:@"UserPage" bundle:nil] instantiateViewControllerWithIdentifier:@"UserPageReplyViewController"];
        vc.expertId = self.infoModel.id;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.section == 1 && indexPath.row == 0){
        
        //Ta关注的圈子
        [QWGLOBALMANAGER statisticsEventId:@"x_yyzl_qz" withLable:@"用户专栏-Ta关注的圈子" withParams:nil];
        
        [QWGLOBALMANAGER statisticsEventId:@"用户个人主页_Ta关注的圈子按键" withLable:@"营养师专栏-Ta的回帖" withParams:nil];
        
        UserPageAttenCircleViewController *vc = [[UIStoryboard storyboardWithName:@"UserPage" bundle:nil] instantiateViewControllerWithIdentifier:@"UserPageAttenCircleViewController"];
        vc.hidesBottomBarWhenPushed = YES;
        vc.userId = self.infoModel.id;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.section == 1 && indexPath.row == 1){
        
        //Ta关注的专家
        [QWGLOBALMANAGER statisticsEventId:@"x_yyzl_zj" withLable:@"用户专栏-Ta关注的专家" withParams:nil];
        
        [QWGLOBALMANAGER statisticsEventId:@"用户个人主页_Ta关注的专家按键" withLable:@"营养师专栏-Ta的回帖" withParams:nil];
        
        MyFollowExpertViewController *vc = [[UIStoryboard storyboardWithName:@"MyFollowExpert" bundle:nil] instantiateViewControllerWithIdentifier:@"MyFollowExpertViewController"];
        vc.hidesBottomBarWhenPushed = YES;
        vc.jumpType = 2;
        vc.userId = self.infoModel.id;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
