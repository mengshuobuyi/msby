//
//  QWShippingAddressExt.m
//  APP
//  积分商城下兑换邮递物品  调本地选择地址页面
//  Created by PerryChen on 1/15/16.
//  Copyright © 2016 carret. All rights reserved.
//

#import "QWShippingAddressExt.h"
#import "ReceiverAddressTableViewController.h"
#import "AddOrChangeAddressInfoViewController.h"
#import "WebDirectViewController.h"
#import "QWGlobalManager.h"
#import "QWLocation.h"
#define SUCCESS 0
#define UNKNOWN_ERROR 1
#define OPEN_SMS_FAIL_ERROR 2
@implementation QWShippingAddressExt
-(void)getAddressInfo:(NSArray *)arguments withDict:(NSDictionary *)options
{
    NSString* callbackId = [arguments objectAtIndex:0];
    self.jsCallbackId_ = callbackId;
    
    ReceiverAddressTableViewController *vc = [ReceiverAddressTableViewController new];
    vc.pageType = PageComeFromH5;

    WebDirectViewController *webView = (WebDirectViewController *)self.webView.delegate;

    __weak typeof(self) weakSelf = self;
    vc.extCallback = ^(NSString *address){
        [weakSelf writeScript:self.jsCallbackId_ messageString:address state:SUCCESS keepCallback:NO];
    };
    vc.refresh = ^{
        [webView actionInformH5:webView.pageType];
    };
    
   
    [webView.navigationController pushViewController:vc animated:YES];
}
-(void)getNewAddress:(NSArray *)arguments withDict:(NSDictionary *)options
{
    [QWGLOBALMANAGER readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
        if(mapInfoModel.locationStatus == LocationError){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"定位失败，无法添加地址" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            return;
        }
    }];
    NSString* callbackId = [arguments objectAtIndex:0];
    self.jsCallbackId_ = callbackId;
    
    AddOrChangeAddressInfoViewController *vc = [AddOrChangeAddressInfoViewController new];
    WebDirectViewController *webView = (WebDirectViewController *)self.webView.delegate;
    vc.styleEdit = StyleAdd;
      __weak typeof(self) weakSelf = self;
    vc.extCallback = ^(NSString *address){
        [weakSelf writeScript:self.jsCallbackId_ messageString:address state:SUCCESS keepCallback:NO];
    };
    vc.refresh = ^{
        [webView actionInformH5:webView.pageType];
    };
    vc.pageType = PageComeFromH5;
   
    [webView.navigationController pushViewController:vc animated:YES];

}
@end
