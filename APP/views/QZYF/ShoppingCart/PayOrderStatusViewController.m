//
//  PayOrderStatusViewController.m
//  APP
//  支付未知页面
//  Created by garfield on 16/3/21.
//  Copyright © 2016年 carret. All rights reserved.
//接口：GetWXPayResult GetAliPayResult去服务器请求数据判断支付结果
//     GetServiceTelLists 客服电话

#import "PayOrderStatusViewController.h"
#import "PayInfo.h"
#import "IndentDetailListViewController.h"
#import "Mbr.h"

@interface PayOrderStatusViewController ()

@end

@implementation PayOrderStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付结果未知";
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItems = nil;
    self.navigationItem.leftBarButtonItem = nil;
    self.branchNameLable.text=self.branchName;
    self.orderLable.text=self.orderCode;
    [self getServiceTel];
    ((QWBaseNavigationController *)self.navigationController).canDragBack = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 取消输入框
    ((QWBaseNavigationController *)self.navigationController).canDragBack = YES;
}


- (IBAction)backToHomePage:(id)sender
{
//    [(UINavigationController *)QWGLOBALMANAGER.tabBar.viewControllers[0] popToRootViewControllerAnimated:NO];
    QWGLOBALMANAGER.tabBar.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)getServiceTel {
    [Mbr queryServiceTelSuccess:^(ServiceTelModel *obj) {
        if ([obj.apiStatus integerValue] == 0) {
            if(obj.list.count>0){
                self.telLable.text = obj.list[0];
            }else{
                self.telLable.text = @"";
            }
        }
    } failure:^(HttpException *e) {
        
    }];
}


- (IBAction)refreshOrderStatus:(id)sender
{
    if([self.type isEqualToString:@"ali"]){//支付宝
        PayInfoModelR *modelR = [PayInfoModelR new];
        modelR.outTradeNo = self.outTradeNo;
        [PayInfo getAliPayResult:modelR success:^(PayInfoModel *responseModel) {
            if(responseModel.result == 3){//支付成功
                [self jumpOrderSome:@"2"];
            }
        } failure:^(HttpException *e) {
            
        }];
    }else if([self.type isEqualToString:@"wx"]){
        PayInfoModelR *modelR = [PayInfoModelR new];
        modelR.tradeSource =@"1";
        modelR.outTradeNo = self.outTradeNo;
        [PayInfo getWXPayResult:modelR success:^(PayInfoModel *responseModel) {
            if(responseModel.result == 3){//支付成功
                [self jumpOrderSome:@"2"];
            }
        } failure:NULL];
    
    }
    
}



-(void)jumpOrderSome:(NSString *)typeStatus{
    
    if([self.isComeFrom isEqualToString:@"1"]){//从订单详情页面进入
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[IndentDetailListViewController class]]) {
                [QWGLOBALMANAGER postNotif:NotifPayStatusAlert data:typeStatus object:nil];
                [self.navigationController popToViewController:temp animated:YES];
                return;
            }
        }
    }else if([self.isComeFrom isEqualToString:@"2"]){//从订单列表进入
        IndentDetailListViewController *indentDetailListViewController = [IndentDetailListViewController new];
        indentDetailListViewController.orderId = self.orderId;
        indentDetailListViewController.isComeFromList = YES;
        indentDetailListViewController.typeAlert=typeStatus;
        [self.navigationController pushViewController:indentDetailListViewController animated:YES];
    }else{//购物车进入
        IndentDetailListViewController *indentDetailListViewController = [IndentDetailListViewController new];
        indentDetailListViewController.orderId = self.orderId;
        indentDetailListViewController.isComeFromCode = YES;
        indentDetailListViewController.typeAlert=typeStatus;
        [self.navigationController pushViewController:indentDetailListViewController animated:YES];
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
