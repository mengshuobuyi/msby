//
//  CouponSuccessViewController.m
//  APP
//
//  Created by garfield on 15/8/20.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "CouponSuccessViewController.h"
#import "Coupon.h"
#import "SVProgressHUD.h"
#import "CouponUseViewController.h"
#import "MyCouponQuanViewController.h"
#import "ReturnIndexView.h"
#import "MessageBoxListViewController.h"

@interface CouponSuccessViewController ()

@property (weak, nonatomic) IBOutlet UILabel *noneLabel;
@property (weak, nonatomic) IBOutlet UILabel *nonDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *useButton;

@property (nonatomic, strong) UILabel *numLabel;   //数字角标
@property (nonatomic, strong) UILabel *redLabel;   //小红点
@property (nonatomic, strong) ReturnIndexView *indexView;
@property (assign, nonatomic) int passNumber;


@end

@implementation CouponSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.useButton.layer.masksToBounds = NO;
    self.useButton.layer.cornerRadius = 5.0;
    self.title = @"领取成功";
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //判断是否为预领取券

//    if(self.myCouponModel){
//        
//        self.useButton.backgroundColor = RGBHex(qwColor9);
//        [self.useButton setTitle:@"未到使用期" forState:UIControlStateNormal];
//        self.useButton.enabled = NO;
//        self.noneLabel.hidden = NO;
//        self.nonDateLabel.hidden = NO;
////        self.nonDateLabel.text = [NSString stringWithFormat:@"使用时间：%@-%@",self.myCouponModel.beginDate,self.myCouponModel.endDate];
//    }else{
    

//    }
    //根据券类型设置btn和label显示
    if ([self.myCouponModel.status intValue] == 0) {
        [self setUI];
    } else {
        self.noneLabel.hidden = YES;
        self.nonDateLabel.hidden = YES;
    }
    
    
    self.passNumber = [QWGLOBALMANAGER updateRedPoint];
    //显示右上角...
//    [self setUpRightItem];
     ((QWBaseNavigationController *)self.navigationController).canDragBack = NO;

}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    ((QWBaseNavigationController *)self.navigationController).canDragBack = YES;
}

-(void)setUI {

    
        self.noneLabel.hidden = NO;
        self.nonDateLabel.hidden = NO;
        self.nonDateLabel.text = [NSString stringWithFormat:@"%@ - %@",self.myCouponModel.begin,self.myCouponModel.end];
        [self.useButton setTitle:@"未到使用期" forState:UIControlStateNormal];
        self.useButton.backgroundColor = RGBHex(qwColor9);
        self.useButton.enabled = NO;
    
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

//点击去使用,生成二维码界面
- (IBAction)useMethod:(id)sender
{
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"是否开通微商"]=QWGLOBALMANAGER.weChatBusiness ? @"是" : @"否";
    [QWGLOBALMANAGER statisticsEventId:@"x_yhq_sy" withLable:@"优惠券详情" withParams:tdParams];
    
    CouponShowModelR *modelR = [CouponShowModelR new];
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    modelR.myCouponId = _myCouponModel.myCouponId;
    [Coupon couponShow:modelR success:^(UseMyCouponVoModel *model) {
        if([model.apiStatus integerValue] == 0)
        {
            CouponUseViewController *couponUseViewController = [[CouponUseViewController alloc] initWithNibName:@"CouponUseViewController" bundle:nil];
            couponUseViewController.useModel = model;
            [self.navigationController pushViewController:couponUseViewController animated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:model.apiMessage duration:0.8];
        }
    } failure:NULL];
    
}

- (void)popVCAction:(id)sender
{
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    [QWGLOBALMANAGER statisticsEventId:@"x_yhq_fh" withLable:@"优惠券详情" withParams:tdParams];
    if (self.extCallback!=nil) {
        self.extCallback(YES);
    }
    [super popVCAction:sender];
}

//查看我的优惠
- (IBAction)checkMyPriviledge:(id)sender
{
    MyCouponQuanViewController *myCouponQuanViewController = [MyCouponQuanViewController new];
    myCouponQuanViewController.popToRootView = NO;
    [self.navigationController pushViewController:myCouponQuanViewController animated:YES];
}

- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj
{
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
