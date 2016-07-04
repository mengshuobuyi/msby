//
//  QuickScanDrugViewController.h
//  wenYao-store
//
//  Created by YYX on 15/6/9.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QWBaseVC.h"
#import "IOSScanView.h"

typedef void(^chooseMedicineBlock)(NSMutableDictionary *);
typedef void (^PassValueBlockOne)(id model);

@interface QuickScanDrugViewController : QWBaseVC<IOSScanViewDelegate>

@property (nonatomic, weak) IBOutlet UIView *scanRectView;

//1代表普通扫码界面     2代表添加到用药     3代表扫码搜索优惠信息
@property (nonatomic, assign) NSUInteger                useType;
@property (nonatomic, copy)   chooseMedicineBlock       completionBolck;

@property(nonatomic, copy)void(^scanBlock)(NSString* scanCode);

@property (nonatomic) NSInteger pageType;
@property (nonatomic, copy) PassValueBlockOne block;

@end
