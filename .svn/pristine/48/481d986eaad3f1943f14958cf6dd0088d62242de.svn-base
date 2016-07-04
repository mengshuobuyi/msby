//
//  MyPageViewController.m
//  APP
//
//  Created by qw on 15/2/27.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "MyPageViewController.h"
#import "UserCenterViewCell.h"
#import "UIImageView+WebCache.h"

#import "QWcss.h"
#import "QWGlobalManager.h"

#import "Mbr.h"

#import "LoginViewController.h"


@interface MyPageViewController ()<UITableViewDataSource,UITableViewDelegate,BeforeAndAfterLoginViewDelegate>
{
    NSString *          storeCount;                 //某个数据记录
    NSArray *           titleArr;                   //tableview的列表项
    NSArray *           imageArr;                   //tableview的列表项前置的小图片
}

@property (nonatomic ,strong) UITableView *tableView;               //主视图

@property (nonatomic ,strong) UIButton *consultButton;
@property (nonatomic ,strong) UIButton *attentedButton;

@property (nonatomic ,strong) BeforeLoginView *beforeLoginView;     //登录前的view
@property (nonatomic ,strong) AfterLoginView *afterLoginView;       //登录后的view

@property (nonatomic, strong) UIImageView *imageBudgeView;

@end

@implementation MyPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
//    [QWGLOBALMANAGER postNotif:EnumNotifQuickOut data:@"yqy" object:self];

    
    self.title = @"我的";
    
    storeCount = @"0";
    self.view.backgroundColor = UICOLOR(242, 242, 242);
    self.tableView.backgroundColor = [UIColor clearColor];
    
    if (iOSv7 && self.view.frame.origin.y==0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    
    titleArr = @[@[@"我关注的药房",@"我的优惠订单"],@[@"我的收藏",@"我的用药"],@[@"关于问药"]];
    imageArr = @[@[@"MyPharmacy.png",@"MyOrder.png"],@[@"Mycollect.png",@"MyMedication.png"],@[@"AboutWenYao.png"]];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting.png"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClick)];
    
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    //登陆之前的view
    self.beforeLoginView = [[BeforeLoginView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 80)];
    self.beforeLoginView.delegate = self;
    
    //登陆之后的view
    self.afterLoginView = [[AfterLoginView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 80)];
    self.afterLoginView.delegate = self;
    
    self.tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0 , APP_W, 360) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    [self.view addSubview:self.tableView];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.afterLoginView.headImageView.image = [UIImage imageNamed:@"my_default_person_icon.png"];
    storeCount = @"0";
    
    [self requestPersonInfo];
    
//    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"BeRead"];
//    if ([str isEqualToString:@"1"]) {
//        QWGLOBALMANAGER.myCenterBudge.hidden = YES;
//    }else
//    {
//        QWGLOBALMANAGER.myCenterBudge.hidden = NO;
//    }
    
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr = titleArr[section];
    
    return arr.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 10)];
    bgView.backgroundColor = UICOLOR(242, 242, 242);
    UILabel *topLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, APP_W, 0.5)];
    topLine.backgroundColor = [UIColor grayColor];
    topLine.alpha = 0.5;
    [bgView addSubview:topLine];
    
    
    UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, APP_W, 0.5)];
    bottomLine.backgroundColor = [UIColor grayColor];
    bottomLine.alpha = 0.5;
    [bgView addSubview:bottomLine];
    
    return bgView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    UserCenterViewCell *cell = (UserCenterViewCell *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"UserCenterViewCell" owner:self options:nil][0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.titleLabel.font = fontSystem(15);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *str = titleArr[indexPath.section][indexPath.row];
    NSString *imageName = imageArr[indexPath.section][indexPath.row];
    if (indexPath.section == 0 && indexPath.row == 0) {
        if (![storeCount isEqualToString:@"0"]) {
            str = [NSString stringWithFormat:@"%@(%@)",str,storeCount];
        }
    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        self.imageBudgeView = [[UIImageView alloc] initWithFrame:CGRectMake(112, 21, 8, 8)];
        self.imageBudgeView.layer.cornerRadius = 4.0f;
        self.imageBudgeView.layer.masksToBounds = YES;
        self.imageBudgeView.backgroundColor = [UIColor redColor];
        [cell.contentView addSubview:self.imageBudgeView];
        self.imageBudgeView.hidden = YES;
        
        NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"BeRead"];
        if ([str isEqualToString:@"1"]) {
            self.imageBudgeView.hidden = YES;
        }else
        {
            self.imageBudgeView.hidden = NO;
        }
    }
    
    cell.titleLabel.text = str;
    cell.titleImageView.image = [UIImage imageNamed:imageName];
    return cell;
}

//登陆跳转
- (void)loginButtonClick
{
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    loginViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginViewController animated:YES];
}

//设置跳转
- (void)rightBarButtonClick
{
//    //    [MobClick event:@"a-shezhi"];
//    QZSettingViewController *setting =[[QZSettingViewController alloc] init];
//    setting.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:setting animated:YES];
}

- (void)personHeadImageClick
{
//    //    [MobClick event:@"a-grzl"];
//    PersonInformationViewController *personInfoViewController =[[PersonInformationViewController alloc] init];
//    personInfoViewController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:personInfoViewController animated:YES];
}

#pragma mark -
#pragma mark 数据请求
- (void)requestPersonInfo
{
    //已登录
    if (QWGLOBALMANAGER.loginStatus) {
        self.tableView.tableHeaderView = self.afterLoginView;

        if(QWGLOBALMANAGER.currentNetWork != kNotReachable) {
            
//            [[HTTPRequestManager sharedInstance] queryMemberDetail:@{@"token":APPDelegate.configureList[APP_USER_TOKEN]} completionSuc:^(id resultObj) {
//                
//                if ([resultObj[@"result"] isEqualToString:@"OK"]) {
//                    [APPDelegate.configureList addEntriesFromDictionary:resultObj[@"body"]];
//                    [APPDelegate saveAppConfigure];
//                    NSString *mobile = [NSString stringWithFormat:@"%@",resultObj[@"body"][@"mobile"]];
//                    NSString *nickName = [NSString stringWithFormat:@"%@",resultObj[@"body"][@"nickName"]];
//                    NSString *imageUrl = [NSString stringWithFormat:@"%@",resultObj[@"body"][@"headImageUrl"]];
//                    NSString *name = nil;
//                    if (nickName.length != 0)
//                    {
//                        APPDelegate.configureList[APP_NICKNAME_KEY] = nickName;
//                        name = nickName;
//                    }else{
//                        if (mobile.length != 0) {
//                            APPDelegate.configureList[APP_NICKNAME_KEY] = mobile;
//                            name = mobile;
//                        }
//                    }
//                    self.afterLoginView.nameLabel.text = name;
//                    if (imageUrl.length > 0) {
//                        [self.afterLoginView.headImageView setImageWithURL:[NSURL URLWithString:imageUrl]];
//                        
//                        [[SDImageCache sharedImageCache] storeImage:self.afterLoginView.headImageView.image forKey:APPDelegate.configureList[@"headImageUrl"] toDisk:YES];
//                        
//                        
//                    }
//                    
//                    [self requestStoreCollectList];
//                }else if ([resultObj[@"result"] isEqualToString:@"FAIL"]){
//                    if ([resultObj[@"msg"] isEqualToString:@"1"]) {
//                        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:ALERT_MESSAGE delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                        alertView.tag = 999;
//                        alertView.delegate = self;
//                        [alertView show];
//                        return;
//                    }else{
//                        [SVProgressHUD showErrorWithStatus:resultObj[@"msg"] duration:DURATION_SHORT];
//                    }
//                }
//                //NSLog(@"afterTitle = %@",afterTitle);
//            } failure:^(id failMsg) {
//                NSLog(@"%@",failMsg);
//            }];
        }
        else
        {
            if(QWGLOBALMANAGER.configure.nickName)
            {
                //UIImage *img = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:QWGLOBALMANAGER.configureList[@"headImageUrl"]];
                
                //[self.afterLoginView.headImageView setImage:img];
            }
            
        }
    }else{
        self.tableView.tableHeaderView = self.beforeLoginView;
        [self.tableView reloadData];
    }
}

@end

@implementation BeforeLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //登录前
        self.frame = frame;
        
        UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        loginButton.backgroundColor = [UIColor clearColor];
        loginButton.frame = CGRectMake((APP_W-100)/2, 20, 100, 40);
        loginButton.layer.masksToBounds = YES;
        [loginButton.layer setBorderColor:GREENTCOLOR.CGColor];
        [loginButton.layer setBorderWidth:1];
        loginButton.layer.cornerRadius = 5.0f;
        [loginButton setTitleColor:GREENTCOLOR forState:UIControlStateNormal];
        [loginButton setTitle:@"注册/登录" forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:loginButton];
    }
    return self;
}

- (void)loginButtonClick
{
    if ([self.delegate respondsToSelector:@selector(loginButtonClick)]) {
        [self.delegate loginButtonClick];
    }
}

@end


@implementation AfterLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        //登录后
        
        self.frame = frame;
        
        UIImage *headImage = [UIImage imageNamed:@"我_个人默认头像.png"];
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImageClick)];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] init];
        [tap2 addTarget:self action:@selector(headImageClick)];
        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 50, 50)];
        self.headImageView.image = [UIImage imageNamed:@"我_个人默认头像.png"];
        self.headImageView.userInteractionEnabled = YES;
        [self.headImageView convertIntoCircular];
        [self.headImageView addGestureRecognizer:tap2];
        self.headImageView.image = headImage;
        [self addSubview:self.headImageView];
        
        
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, (80-15)/2, APP_W-90, 15)];
        self.nameLabel.userInteractionEnabled = YES;
        [self.nameLabel addGestureRecognizer:tap1];
        self.nameLabel.font = fontSystem(16);
        [self addSubview:self.nameLabel];
        
        UIImage *imageArr = [UIImage imageNamed:@"向右箭头.png"];
        UIImageView *imageArrow = [[UIImageView alloc] initWithFrame:CGRectMake(self.nameLabel.frame.origin.x + self.nameLabel.frame.size.width-2, (80-imageArr.size.height)/2, imageArr.size.width, imageArr.size.height)];
        imageArrow.image = imageArr;
        [self addSubview:imageArrow];
        
        [self addGestureRecognizer:tap1];
        
    }
    return self;
}

- (void)headImageClick
{
    if ([self.delegate respondsToSelector:@selector(personHeadImageClick)]) {
        [self.delegate personHeadImageClick];
    }
}

@end
