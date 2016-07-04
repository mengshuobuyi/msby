//
//  OrderDetailViewController.m
//  wenyao
//
//  Created by Meng on 15/2/13.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "ReturnIndexView.h"
#import "AppDelegate.h"
#import "MessageBoxListViewController.h"
#import "LoginViewController.h"

@interface OrderDetailViewController ()<ReturnIndexViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UILabel *activityName;
@property (weak, nonatomic) IBOutlet UILabel *activityType;
@property (weak, nonatomic) IBOutlet UILabel *activityContent;
@property (weak, nonatomic) IBOutlet UILabel *proQuantity;
@property (weak, nonatomic) IBOutlet UILabel *unitPrice;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UILabel *buyStore;
@property (weak, nonatomic) IBOutlet UILabel *buyTime;
@property (weak, nonatomic) IBOutlet UILabel *referPhone;
@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;
@property (weak, nonatomic) IBOutlet UILabel *phone;

@property (strong, nonatomic) ReturnIndexView *indexView;
@property (weak, nonatomic) IBOutlet UILabel *payMoney;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIView *line3;

@property (nonatomic, strong) UILabel *numLabel;   //数字角标
@property (nonatomic, strong) UILabel *redLabel;   //小红点
@property (assign, nonatomic) int passNumber;



@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view from its nib.
    if(QWGLOBALMANAGER.currentNetWork == kNotReachable){
        
        [self showInfoView:@"网络未连接，请重试" image:@"网络信号icon.png"];
    }else{
        [self subViewDidLoad];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.passNumber = [QWGLOBALMANAGER updateRedPoint];
//    [self setUpRightItem];
}

- (void)viewInfoClickAction:(id)sender{
    
    if(QWGLOBALMANAGER.currentNetWork != kNotReachable){
        
        [self removeInfoView];
        [self subViewDidLoad];
    }
}

- (void)subViewDidLoad{
    
   
        [self removeInfoView];
        self.activityName.text = [QWGLOBALMANAGER replaceSpecialStringWith:self.order.title];
        self.activityContent.text = [QWGLOBALMANAGER replaceSpecialStringWith:self.order.desc];
    
    
        NSString *type = [NSString stringWithFormat:@"%@",self.order.type];
        NSString *typeStr = nil;
        NSString *couponStr = nil;
        
        //优惠券类型
        if ([type isEqualToString:@"1"]) {//1:折扣券
            typeStr = @"折扣";
            self.totalPrice.text = [NSString stringWithFormat:@"%.2f元",[self.order.pay floatValue]];
            couponStr = [NSString stringWithFormat:@"本订单已优惠%.2f元",[self.order.discount floatValue]];
            [self.payMoney removeFromSuperview];
            [self.totalPrice removeFromSuperview];
        }
        if ([type isEqualToString:@"2"]){//2:代金券
            typeStr = @"抵现";
            self.totalPrice.text = [NSString stringWithFormat:@"%.2f元",[self.order.pay floatValue]];
            couponStr = [NSString stringWithFormat:@"本订单已优惠%.2f元",[self.order.discount floatValue]];
            [self.payMoney removeFromSuperview];
            [self.totalPrice removeFromSuperview];
        }
        if ([type isEqualToString:@"3"]){//3:买赠券
            typeStr = @"买赠";
            self.payMoney.text = @"赠送商品：";
            self.totalPrice.text = [NSString stringWithFormat:@"%d件",[self.order.totalLargess intValue]];
            couponStr = [NSString stringWithFormat:@"本订单已享受%d次优惠",[self.order.useTimes intValue]];
        }
        
        self.activityType.text = typeStr;
        self.proQuantity.text = [NSString stringWithFormat:@"%@",self.order.quantity];
        self.unitPrice.text = [NSString stringWithFormat:@"%.2f元",[self.order.price floatValue]];
        
//        NSNumber *priceNumber = self.activityDict[@"price"];
//        NSNumber *quantityNumber = self.activityDict[@"quantity"];
//        
//        int price =  [priceNumber intValue];
//        int quantity = [quantityNumber intValue];
//        self.totalPrice.text = [NSString stringWithFormat:@"%d元",price * quantity];
        
        self.buyStore.text = self.order.branch;
        self.buyTime.text = self.order.date;
        
        NSString *phoneNumber = self.order.inviter;
        if(phoneNumber.length > 0){

            self.referPhone.text = self.order.inviter;
        }
        else{
            [self.phone removeFromSuperview];
            [self.referPhone removeFromSuperview];
        }
        
        if(couponStr){
            self.noticeLabel.hidden = NO;
            self.noticeLabel.text = couponStr;
        }
        else{
            self.noticeLabel.hidden = YES;
        }
        
  

    CGRect rec = self.footerView.frame;
    rec.origin.y = self.noticeLabel.frame.origin.y + self.noticeLabel.frame.size.height + 15;
    self.footerView.frame = rec;
    
    CGRect rect = self.line.frame;
    rect.size.height = 0.5f;
    self.line.frame = rect;
    
    rect = self.line2.frame;
    rect.size.height = 0.5f;
    self.line2.frame = rect;
    
    rect = self.line3.frame;
    rect.size.height = 0.5f;
    self.line3.frame = rect;

    self.mainScrollView.contentSize = CGSizeMake(320, APP_H + [QWGLOBALMANAGER getTextSizeWithContent:self.activityContent.text WithUIFont:fontSystem(14.0f) WithWidth:229].height);
    [self.mainScrollView addSubview:self.mainView];
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



- (void)didReceiveMemoryWarning {
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
