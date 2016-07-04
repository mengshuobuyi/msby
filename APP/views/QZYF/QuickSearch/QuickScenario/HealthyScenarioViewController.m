//
//  HealthyScenarioViewController.m
//  wenyao
//
//  Created by Meng on 14-9-29.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "HealthyScenarioViewController.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "HealthyScenarioCell.h"
#import "AppDelegate.h"
#import "HealthySlideViewController.h"
#import "ReturnIndexView.h"
#import "Drug.h"
#import "MessageBoxListViewController.h"
#import "LoginViewController.h"

@interface HealthyScenarioViewController ()<ReachabilityDelegate>
@property (nonatomic, strong) NSMutableArray *regularList;
@property (nonatomic, strong) ReturnIndexView *indexView;
@property (nonatomic, strong) UILabel *numLabel;   //数字角标
@property (nonatomic, strong) UILabel *redLabel;   //小红点
@property (assign, nonatomic) int passNumber;

@end

@implementation HealthyScenarioViewController

- (id)init
{
    if (self = [super init]) {
        self.title = @"健康方案";
        self.regularList = [NSMutableArray array];
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H-NAV_H) style:UITableViewStylePlain];
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        [self.tableView addStaticImageHeader];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
       [self.view addSubview:self.tableView];
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    self.passNumber = [QWGLOBALMANAGER updateRedPoint];
//    [self setUpRightItem];
    
    if (self.regularList.count > 0) {
        return;
    }
    HealthyScenarioModelR *model = [HealthyScenarioModelR new];
    model.currClassId = @"-";
    model.currPage = @"1";
    model.pageSize = @"0";
    
    //设置主键
    NSString * key = [NSString stringWithFormat:@"Remand_%@_%@",model.currClassId,model.currPage];

    if(QWGLOBALMANAGER.currentNetWork==kNotReachable){
        
            if (self.regularList.count > 0) {
                [self.regularList removeAllObjects];
            }
            //读取本地缓存
            HealthyScenarioListModel* page = [HealthyScenarioListModel getObjFromDBWithKey:key];
            if(page==nil){
                [self showInfoView:kWarning12 image:@"网络信号icon.png"];
                return;
            }
            [self.regularList addObjectsFromArray:page.list];
            [self.tableView reloadData];
        
    }else{
        
            [Drug queryRecommendClassWithParam:model success:^(id UFModel) {
                [self.regularList removeAllObjects];
                HealthyScenarioListModel *scneario = UFModel;
                [self.regularList addObjectsFromArray:scneario.list];
                
                //添加到本地缓存
                scneario.scenarioId=key;
                [HealthyScenarioListModel updateObjToDB:scneario WithKey:scneario.scenarioId];
                
                [self.tableView reloadData];
            } failure:^(HttpException *e) {
                if(e.errorCode!=-999){
                    if(e.errorCode == -1001){
                        [self showInfoView:kWarning215N26 image:@"ic_img_fail"];
                    }else{
                        [self showInfoView:kWarning39 image:@"ic_img_fail"];
                    }
                    
                }
                return;
            }];
    }
    
}

#pragma mark -
#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HealthyScenarioCell getCellHeight:nil];
}

- (NSInteger)tableView:(UITableView *)atableView numberOfRowsInSection:(NSInteger)section
{
    return self.regularList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)atableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *RegularTableCellIdentifier = @"RegularTableCellIdentifier";
    HealthyScenarioCell * cell = (HealthyScenarioCell *)[tableView dequeueReusableCellWithIdentifier:RegularTableCellIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"HealthyScenarioCell" owner:self options:nil][0];
    }
    HealthyScenarioModel *scenario = self.regularList[indexPath.row];
    [cell setCell:scenario];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (app.currentNetWork == kNotReachable) {
//        [SVProgressHUD showErrorWithStatus:@"当前暂无网络,请稍后重试!" duration:0.8f];
//        return;
//    }
    NSIndexPath *selection = [self.tableView indexPathForSelectedRow];
    if (selection) {
        [self.tableView deselectRowAtIndexPath:selection animated:YES];
    }

    //点击传值
    HealthySlideViewController *healthySlide = [[HealthySlideViewController alloc]init];
    
    HealthyScenarioModel *scenario = self.regularList[indexPath.row];
    
    healthySlide.title = scenario.name;
    healthySlide.infoDict = scenario.dictionaryModel;
    
    [self.navigationController pushViewController:healthySlide animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    
}

#pragma mark---------------------------------------------跳转到首页-----------------------------------------------

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
    [[QWGlobalManager sharedInstance].tabBar setSelectedIndex:0];
}
#pragma mark---------------------------------------------跳转到首页-----------------------------------------------

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
