//
//  QZSettingViewController.m
//  wenyao
//
//  Created by Meng on 15/1/21.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "QZSettingViewController.h"
#import "MessageSettingViewController.h"
#import "ChangePasswdViewController.h"
#import "SVProgressHUD.h"
#import "SDImageCache.h"
#import "AppDelegate.h"
#import "ReturnIndexView.h"
#import "HomePageViewController.h"

#import "MessageBoxListViewController.h"
#import "LoginViewController.h"
#import "SetPasswordViewController.h"
#define F_TITLE  14
#define F_DESC   12

#define kTableRowHeight     45

@interface QZSettingViewController()<ReturnIndexViewDelegate>

{
    NSArray *titleArray;

}
@property (nonatomic, strong) UIButton *quitOut;//退出按钮
@property (nonatomic, strong) NSString * cacheBulk;

@property (nonatomic, strong) ReturnIndexView *indexView;
@property (nonatomic, strong) UILabel *numLabel;   //数字角标
@property (nonatomic, strong) UILabel *redLabel;   //小红点
@property (assign, nonatomic) int passNumber;

@end

@implementation QZSettingViewController

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"设置";
    
    
    self.quitOut = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.quitOut setFrame:CGRectMake(10, kTableRowHeight * 3 + 20, APP_W-20, 40)];
    [self.quitOut addTarget:self action:@selector(quitOutClick) forControlEvents:UIControlEventTouchUpInside];
    [self.quitOut setBackgroundImage:[UIImage imageNamed:@"btnLogoutPressed_new"] forState:UIControlStateNormal];
    [self.quitOut setBackgroundImage:[UIImage imageNamed:@"btnLogoutPressed_new"] forState:UIControlStateHighlighted];
    [self.quitOut setBackgroundImage:[UIImage imageNamed:@"btnLogoutPressed_new"] forState:UIControlStateSelected];
    [self.quitOut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.quitOut setTitleColor: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.5] forState:UIControlStateHighlighted];
     [self.quitOut setTitleColor: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.5] forState:UIControlStateSelected];
    [self.quitOut setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [self.view addSubview:self.quitOut];
    
    long long cacheSize = [SDImageCache sharedImageCache].getSize;
    float tempSize = 0 ;
    if (cacheSize>1024*1024) {
        tempSize = cacheSize/1024/1024;
        self.cacheBulk = [NSString stringWithFormat:@"%.fMB",tempSize];
    }else
    {
        tempSize = cacheSize/1024;
        self.cacheBulk = [NSString stringWithFormat:@"%.fKB",tempSize];
    }
    
    [self setupTableView];
    

}


- (void)popVCAction:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
 
}

- (void)setupTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    self.tableView.rowHeight = 45;
    self.tableView.scrollEnabled = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = RGBHex(qwColor4);
    self.tableView.tableFooterView = view;
    [self.view addSubview:self.tableView];
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
    [QWGLOBALMANAGER.tabBar setSelectedIndex:0];
}
#pragma mark---------------------------------------------跳转到首页-----------------------------------------------



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self naviLeftBottonImage:[UIImage imageNamed:@"nav_btn_back"] highlighted:[UIImage imageNamed:@"nav_btn_back_sel"] action:@selector(popVCAction:)];
    
    self.passNumber = [QWGLOBALMANAGER updateRedPoint];
//    [self setUpRightItem];
    
    if (QWGLOBALMANAGER.loginStatus) {
        if (!QWGLOBALMANAGER.configure.setPwd) {
            titleArray = @[@"消息提醒",@"设置登录密码",@"清理缓存"];
        }
        else
            titleArray = @[@"消息提醒",@"修改密码",@"清理缓存"];
        [self.tableView reloadData];
    }else{
        titleArray = @[@"消息提醒",@"清理缓存"];
    }
    
    if (QWGLOBALMANAGER.loginStatus) {
        self.quitOut.hidden = NO;
        [self.tableView setFrame:CGRectMake(0, 0, APP_W, kTableRowHeight * 3)];
    }else{
        self.quitOut.hidden = YES;
        [self.tableView setFrame:CGRectMake(0, 0, APP_W, kTableRowHeight * 2)];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationItem.leftBarButtonItem = nil;
    
}

//退出当前账号
- (void)quitOutClick
{
    [QWUserDefault setBool:NO key:APP_LOGIN_STATUS];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:@"apploginloginstatus"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"apppasswordkey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [QWGLOBALMANAGER clearAccountInformation];
    self.quitOut.hidden = YES;
    QWGLOBALMANAGER.loginStatus = NO;
    [QWGLOBALMANAGER unOauth];
    titleArray = @[@"消息提醒",@"清理缓存"];
    CGRect rect = self.tableView.frame;
    rect.size.height -= 45.0f;
    self.tableView.frame = rect;
    [self.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
    /**
     *  防止以后UI会变，先留着，别删. add by perry
     
     UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"不了" otherButtonTitles:@"好的", nil];
     
     NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"CustomLogoutAlertView" owner:self options:nil];
     CustomLogoutAlertView *viewLogout = [nibViews objectAtIndex:0];
     if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
     [alertV setValue:viewLogout forKey:@"accessoryView"];
     }else{
     [alertV addSubview:viewLogout];
     }
     alertV.tag = 998;
     [alertV show];
     */
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if (QWGLOBALMANAGER.loginStatus) {
        count = 3;
    }else{
        count = 2;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.font = fontSystem(16.0f);
    cell.textLabel.text = titleArray[indexPath.row];
    if (QWGLOBALMANAGER.loginStatus) {
        if (indexPath.row == 2) {
            [self makeRightAccessoryViewWithCell:cell];
        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }else{
        if (indexPath.row == 1) {
            [self makeRightAccessoryViewWithCell:cell];
        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    return cell;
}

//定义cell右侧AccessoryView,显示缓存大小
- (void)makeRightAccessoryViewWithCell:(UITableViewCell *)cell{
    
    CGSize feelSize = [QWGLOBALMANAGER sizeText:self.cacheBulk font:fontSystem(kFontS5) limitWidth:90.0f];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(APP_W - 105.0f, 15.0f, 90.0f, feelSize.height)];
    label.textColor = RGBHex(qwColor8);
    label.textAlignment = NSTextAlignmentRight;
    if ([self.cacheBulk isEqualToString:@"Zero KB"]) {
        self.cacheBulk = @"0KB";
    }
    label.text = self.cacheBulk;
    label.font = [UIFont systemFontOfSize:F_DESC];
    [cell.contentView addSubview:label];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (QWGLOBALMANAGER.loginStatus) {
        if (indexPath.row == 0) {
            MessageSettingViewController *setting = [[MessageSettingViewController alloc] init];
            [self.navigationController pushViewController:setting animated:YES];
        }else if (indexPath.row == 1){
            if (!QWGLOBALMANAGER.configure.setPwd) {
                SetPasswordViewController* setPasswordVC = [[SetPasswordViewController alloc] initWithNibName:@"SetPasswordViewController" bundle:nil];
                [self.navigationController pushViewController:setPasswordVC animated:YES];
            }
            else
            {
                ChangePasswdViewController *changePasswd = [[ChangePasswdViewController alloc] initWithNibName:@"ChangePasswdViewController" bundle:nil];
                [self.navigationController pushViewController:changePasswd animated:YES];
            }
        }else if (indexPath.row){
            [self clearMemoryWithIndexPath:indexPath];
        }
    }else{
        if (indexPath.row == 0) {
            MessageSettingViewController *setting = [[MessageSettingViewController alloc] init];
            [self.navigationController pushViewController:setting animated:YES];
        }else if (indexPath.row){
            [self clearMemoryWithIndexPath:indexPath];
        }
    }
    
}

#pragma mark    ------ 清理缓存 ------

- (void)clearMemoryWithIndexPath:(NSIndexPath *)indexPath{
    if (([self.cacheBulk isEqualToString:@"0kb"])||([self.cacheBulk isEqualToString:@"0KB"])) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"已经没有缓存啦!"];
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //        NSString * cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        //        NSArray * files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
        //        for (NSString * p in files) {
        //            NSError * error;
        //            NSString * path = [cachPath stringByAppendingPathComponent:p];
        //            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        //                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        //            }
        //        }
        
        [[SDImageCache sharedImageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearMemory];
        
        [self performSelectorOnMainThread:@selector(clearCachesSuccess:) withObject:indexPath waitUntilDone:YES];
    });
}

- (void)clearCachesSuccess:(NSIndexPath *)indexPath{
    [SVProgressHUD dismiss];
    [SVProgressHUD showSuccessWithStatus:@"缓存清理完成"];
    self.cacheBulk = @"0KB";
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (NSString *)folderSizeAtPath:(NSString *)folderPath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator * childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    DDLogVerbose(@"folder path is %@,folder is %lld", folderPath,folderSize);
    return [NSByteCountFormatter stringFromByteCount:folderSize countStyle:NSByteCountFormatterCountStyleDecimal];
}



- (long long)fileSizeAtPath:(NSString *)folderPath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:folderPath]) {
        return [[manager attributesOfItemAtPath:folderPath error:nil] fileSize];
    }
    return 0;
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
