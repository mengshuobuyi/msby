//
//  ScanReaderViewController.h
//  APP
//
//  Created by qw on 15/2/27.
//  Copyright (c) 2015年 carret. All rights reserved.
//


/**
 *  条码扫描界面
 */

#import "QWBaseVC.h"
#import "IOSScanView.h"
#import "DrugModel.h"


typedef enum  Enum_Scan_Items {
    Enum_Scan_Items_Normal   = 0,                   //普通扫码界面
    Enum_Scan_Items_Add = 1,                        //添加到用药
    Enum_Scan_Items_Preferential = 2,               //搜索优惠信息
    Enum_Scan_Items_Promotion = 3,                  //搜索优惠信息
    Enum_Scan_Items_OnlyCode = 4,                   //只获取Code
    Enum_Scan_Items_FromHome = 5,                   //首页扫码
}Scan_Items;


typedef void(^chooseMedicineBlock)(ProductModel *);
typedef void(^addMedicineUsageBlock)(ProductModel *productModel,ProductUsage *productUsage);
typedef void(^scanPromotionBlock)(NSString *scanCode);


@interface ScanReaderViewController : QWBaseVC<IOSScanViewDelegate>

@property (nonatomic, strong) IBOutlet  UIView  *readerView;

@property (assign) Scan_Items                useType;
@property (nonatomic, copy)   chooseMedicineBlock       completionBolck;
@property (nonatomic, copy)   addMedicineUsageBlock     addMedicineUsageBolck;
@property (nonatomic, copy)   scanPromotionBlock     promotionCallBack;

@property (assign, nonatomic) BOOL NeedPopBack;

@property (nonatomic, assign) BOOL torchMode;          //控制闪光灯的开关

@property(nonatomic, copy)void(^scanBlock)(NSString* scanCode);

@end