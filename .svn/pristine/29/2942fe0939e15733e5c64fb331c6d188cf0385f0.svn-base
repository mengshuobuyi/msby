//
//  QWPageRedirectExt.m
//  APP
//
//  Created by PerryChen on 8/20/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "QWPageRedirectExt.h"
#import "WebDirectViewController.h"
#import "WebDirectModel.h"

#import "CommonDiseaseDetailViewController.h"
#import "QuestionListViewController.h"
#import "DiseaseMedicineListViewController.h"
#import "PickPromotionSuccessViewController.h"
#import "FamliyMedcineViewController.h"
#import "FamilyMedicineListViewController.h"
#import "MoreConsultViewController.h"
#import "ChatViewController.h"
#import "WebCommentViewController.h"
#import "MyCouponDrugViewController.h"
#import "DrugModel.h"
#import "PromotionDrugDetailViewController.h"
#import "WinDetialViewController.h"
#define SUCCESS 0
#define UNKNOWN_ERROR 1
#define OPEN_SMS_FAIL_ERROR 2
@implementation QWPageRedirectExt

//h5跳h5  h5跳原生的接口
-(void)startSkipApp:(NSArray *)arguments withDict:(NSDictionary *)options
{
    NSString* callbackId = [arguments objectAtIndex:0];
    self.jsCallbackId_ = callbackId;
    
    DDLogVerbose(@"teh str params is %@",options);
    
    WebDirectViewController *vcWeb = (WebDirectViewController *)(self.webView.delegate);
    // 根据H5返回获取model
    WebDirectModel *modelDir = [WebDirectModel parse:options Elements:[WebDirectParamsModel class] forAttribute:@"params"];
    
    if ([modelDir.jumpType intValue] == WebDirTypeH5toH5) {//H5跳H5
        [vcWeb jumpToH5Page:modelDir];
            }
    else if ([modelDir.jumpType intValue] == WebDirTypeH5toLocal)//H5跳原生
    {
        [vcWeb jumpToLocalVC:modelDir];
    }
}
@end
