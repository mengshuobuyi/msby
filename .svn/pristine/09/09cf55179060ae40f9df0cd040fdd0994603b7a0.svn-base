//
//  HealthIndicatorViewController.m
//  wenyao
//
//  Created by Meng on 14-9-24.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//
#import "HealthIndicatorViewController.h"
#import "HealthDetailViewController.h"
#import "Health.h"
#import "ReturnIndexView.h"
#import "MessageBoxListViewController.h"
#import "LoginViewController.h"


@interface HealthIndicatorViewController ()<ReturnIndexViewDelegate>
@property (nonatomic, strong) NSMutableArray        *healthArray;
@property (nonatomic, strong) ReturnIndexView *indexView;
@property (nonatomic, strong) UILabel *numLabel;   //数字角标
@property (nonatomic, strong) UILabel *redLabel;   //小红点
@property (assign, nonatomic) int passNumber;

@end

@implementation HealthIndicatorViewController

- (id)init{
    if (self = [super init]) {
        self.title = @"健康指标";
        self.tableMain = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_W, APP_H-NAV_H) style:UITableViewStylePlain];
        self.tableMain.frame = CGRectMake(0, 0, APP_W, APP_H-NAV_H);
        self.tableMain.dataSource=self;
        self.tableMain.delegate=self;
        [self.tableMain addStaticImageHeader];
        [self.tableMain setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:self.tableMain];
         [self.tableMain setFooterHidden:YES];

    }
    return self;
}


- (void)getAllCachedIndicator:(NSString *)key
{
    //本地缓存读取功能
    HealthModel* page = [HealthModel getObjFromDBWithKey:key];
    if(page==nil){
        [self showInfoView:kWarning12 image:@"网络信号icon.png"];
        return;
    }
    [self.healthArray addObjectsFromArray:page.list];
    [self.tableMain reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.passNumber = [QWGLOBALMANAGER updateRedPoint];
//    [self setUpRightItem];
    if (self.healthArray.count > 0) {
        return;
    }
    
    //设置主键
    NSString * key = [NSString stringWithFormat:@"%@",@"healthNorm"];
    
        if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
            [self getAllCachedIndicator:key];
        }else{
            NSMutableDictionary *param=[NSMutableDictionary dictionary];
                [Health queryHealthProgramWithParams:param success:^(id UFModel) {
                    [self.healthArray removeAllObjects];
                    HealthModel *healthNorm = UFModel;
                    [self.healthArray addObjectsFromArray:healthNorm.list];
                    
                    //有网络读取的时候添加到本地缓存
                    healthNorm.normId = key;
                    [HealthModel updateObjToDB:healthNorm WithKey:healthNorm.normId];
                    
                    [self.tableMain reloadData];
                    
                    
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.healthArray = [NSMutableArray arrayWithCapacity:10];
    [self.tableMain setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
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


#pragma mark -
#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (NSInteger)tableView:(UITableView *)atableView numberOfRowsInSection:(NSInteger)section
{
    return [self.healthArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)atableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *HealthIndicator = @"HealthIndicatorIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:HealthIndicator];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HealthIndicator];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.selectedBackgroundView = [[UIView alloc]init];
        cell.selectedBackgroundView.backgroundColor = RGBHex(qwColor10);
    }
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(15, 49.5, APP_W, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [cell addSubview:line];
    
    HealthProgramModel *mod = self.healthArray[indexPath.row];
    cell.textLabel.text = mod.name;
    cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    cell.textLabel.textColor = RGBHex(qwColor6);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath*    selection = [self.tableMain indexPathForSelectedRow];
    if (selection) {
        [self.tableMain deselectRowAtIndexPath:selection animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HealthProgramModel *model = self.healthArray[indexPath.row];
    HealthDetailViewController *detailViewController = [[HealthDetailViewController alloc] init];
    detailViewController.htmlUrl = model.url;
    detailViewController.title = model.name;
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"标题"]=model.name;
    [QWGLOBALMANAGER statisticsEventId:@"x_fx_jkzb_dj" withLable:@"发现" withParams:tdParams];
    [self.navigationController pushViewController:detailViewController animated:YES];
}


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
