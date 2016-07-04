//
//  QWPluAppPluginExt.m
//  APP
//
//  Created by PerryChen on 8/25/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "QWPluAppPluginExt.h"
#import "WebDirectModel.h"
#import "WebDirectViewController.h"
#import "QWH5Loading.h"
#import "WXApi.h"
#import "SVProgressHUD.h"

@implementation QWPluAppPluginExt

//h5调用原生代码
-(void)startAppPlugin:(NSArray *)arguments withDict:(NSDictionary *)options
{
    NSString* callbackId = [arguments objectAtIndex:0];
    self.jsCallbackId_ = callbackId;
    
    DDLogVerbose(@"teh str params is %@",options);
    
    WebDirectViewController *vcWeb = (WebDirectViewController *)(self.webView.delegate);
    
    WebPluginModel *modelPlu = [WebPluginModel parse:options Elements:[WebPluginParamsModel class] forAttribute:@"params"];
    
    if ([modelPlu.type intValue] == 1) {
        // title 替换
        vcWeb.title = modelPlu.params.title;
    } else if ([modelPlu.type intValue] == 2) {
        // 打电话
        [vcWeb actionPhoneWithNumber:modelPlu.message];
    } else if ([modelPlu.type intValue] == 3) {
        // 分享
        [vcWeb actionShare:modelPlu];
    } else if ([modelPlu.type intValue] == 4) {
        // 提示框
        [vcWeb showAlertWithMessage:modelPlu.message];
    } else if ([modelPlu.type intValue] == 5) {
        // 隐藏分享按钮
        [vcWeb actionHideShareBtn];
    } else if ([modelPlu.type intValue] == 6) {
        // 显示原生Loading框
        [QWH5LOADING showLoading];
    } else if ([modelPlu.type intValue] == 7) {
        // 隐藏原生loading框
        [QWH5LOADING closeLoading];
    } else if ([modelPlu.type intValue] == 8) {
        // 隐藏原生loading框
        [vcWeb popCurVC];
    } else if ([modelPlu.type intValue] == 9) {
        // 显示分享框
        [vcWeb actionShowShare];
    }else if ([modelPlu.type intValue] == 10) {
        // 支付宝信息传递
        [vcWeb actionWithAliPayInfo:modelPlu.message withObjId:modelPlu.params.objId];
        [QWH5LOADING closeLoading];
    }else if ([modelPlu.type intValue] == 11) {
        // 微信支付信息传递
        if (![WXApi isWXAppInstalled]) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"你还没有安装微信，请选择其他支付方式!" message:@"" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
            [QWH5LOADING closeLoading];
            return;
        }
        [vcWeb actionWithWetChatPayInfo:modelPlu.message withObjId:modelPlu.params.objId];
        [QWH5LOADING closeLoading];
    } else if ([modelPlu.type intValue] == 12) {
        // 显示原生Loading框
        [QWH5LOADING showLoading];
    }else if ([modelPlu.type intValue] == 13) {
        // 中奖纪录地址/电话填写完;pop掉页面刷新
        if(vcWeb.winAlert){
            vcWeb.winAlert();
        }
        [vcWeb popVCAction:nil];
    }   else if ([modelPlu.type intValue] == 14) {
        // title 替换
        vcWeb.title = modelPlu.message;
    }
}
@end
