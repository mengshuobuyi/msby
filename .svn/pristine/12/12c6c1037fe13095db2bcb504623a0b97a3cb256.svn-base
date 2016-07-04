//
//  FactoryList.m
//  quanzhi
//
//  Created by ZhongYun on 14-6-22.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "FactoryListViewController.h"
#import "FactoryDetailViewController.h"
#import "ReturnIndexView.h"
#import "FactoryTableViewCell.h"
#import "MessageBoxListViewController.h"
#import "LoginViewController.h"

@interface FactoryListViewController ()<ReturnIndexViewDelegate>
{
    NSMutableArray* m_data;
    int m_currPage;

}
@property (strong, nonatomic) ReturnIndexView *indexView;
@property (nonatomic, strong) UILabel *numLabel;   //数字角标
@property (nonatomic, strong) UILabel *redLabel;   //小红点
@property (assign, nonatomic) int passNumber;

@end

@implementation FactoryListViewController

- (void)dealloc
{

}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableMain setFrame:CGRectMake(0, 0, APP_W, APP_H-NAV_H)];
    self.tableMain.backgroundColor = RGBHex(qwColor11);
    self.tableMain.bounces = YES;
    self.tableMain.delegate = self;
    self.tableMain.dataSource = self;
    [self.tableMain addStaticImageHeader];
    [self.view addSubview:self.tableMain];
    
    self.title = @"品牌展示";
    m_currPage=1;
    m_data = [[NSMutableArray alloc] init];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.passNumber= [QWGLOBALMANAGER updateRedPoint];
//    [self setUpRightItem];
    [self loadData];
}

- (void)footerRereshing
{
    HttpClientMgr.progressEnabled = NO;
    [self loadData];
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



- (void)loadData
{
    FactoryModelR *modelR = [FactoryModelR new];
    modelR.currPage = [NSString stringWithFormat:@"%d",m_currPage];
    modelR.pageSize = @"10";
    
    //设置主键
    NSString * key = [NSString stringWithFormat:@"%@",modelR.currPage];
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        //本地缓存读取功能
        FactoryListModel* page = [FactoryListModel getObjFromDBWithKey:key];
        if(page==nil){
            if(m_currPage==1){
                [self showInfoView:kWarning12 image:@"网络信号icon.png"];
            }else{
                [self showError:kWarning12];
                [self.tableMain footerEndRefreshing];
            }
            
        return;
        }
        [m_data addObjectsFromArray:page.list];
        [self.tableMain reloadData];
        m_currPage++;
        [self.tableMain footerEndRefreshing];
    } else {
        [Factory queryFactoryListWithParam:modelR success:^(id UFModel) {
            
            FactoryListModel *factoryList = (FactoryListModel *)UFModel;
            
            [m_data addObjectsFromArray:factoryList.list];
            
            factoryList.factoryId=key;
            [FactoryListModel updateObjToDB:factoryList WithKey:factoryList.factoryId];
            
            
            if(factoryList.list.count>0){
                [self.tableMain reloadData];
                m_currPage++;
            }else{
             self.tableMain.footer.canLoadMore=NO;
            }
            [self.tableMain footerEndRefreshing];
            
            
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


- (void)viewInfoClickAction:(id)sender
{
    if (QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        [self removeInfoView];
        [self loadData];
    }
}



#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [FactoryTableViewCell getCellHeight:nil];
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
    FactoryDetailModel *factory = (FactoryDetailModel *)m_data[indexPath.row];
    FactoryDetailViewController* vc = [[FactoryDetailViewController alloc] init];
    vc.factoryId = factory.code;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return m_data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"FactoryTableViewCell";
    
    FactoryTableViewCell *cell = (FactoryTableViewCell *)[self.tableMain dequeueReusableCellWithIdentifier:Identifier];
    if(cell == nil){
        UINib *nib = [UINib nibWithNibName:@"FactoryTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:Identifier];
        cell = (FactoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:Identifier];
    }
    
    FactoryModel *factory = m_data[indexPath.row];
    
    [cell setCell:factory];
    
    return cell;
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
