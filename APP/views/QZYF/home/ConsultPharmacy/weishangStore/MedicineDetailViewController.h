//
//  MedicineDetailViewController.h
//  APP
//
//  Created by 李坚 on 16/1/4.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "QWBaseVC.h"
#import "QWWebView.h"
#import "XLCycleScrollView.h"
@interface MedicineDetailViewController : QWBaseVC

@property (weak, nonatomic) IBOutlet UILabel *goodCountLabel;
@property (nonatomic, assign) BOOL pushFromChatView;//是否是从聊天页面跳转进入
@property (nonatomic, strong) NSString *proId;//与药房关联的商品ID
@property (nonatomic, strong) NSString *lastPageName;//上个界面名称，暂时弃用
@end

@interface MedicineHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIView *tishi;
@property (weak, nonatomic) IBOutlet UILabel *signCodeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImage;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *APiceLabel;
@property (weak, nonatomic) IBOutlet UILabel *BPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *proName;
@property (weak, nonatomic) IBOutlet UIImageView *scoreImage;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *signCodeLayout;
@property (weak, nonatomic) IBOutlet UIView *moneyLine;
@property (weak, nonatomic) IBOutlet UIView *footerLine;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerHeight;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerViewConstant;
@property (weak, nonatomic) IBOutlet UILabel *changeInfoLable;


+ (MedicineHeaderView *)getView;
@end

@interface MedicineFooterView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sepeatorViewLayout;
@property (weak, nonatomic) IBOutlet UILabel *drugLabel;

@property (weak, nonatomic) IBOutlet QWWebView *WebCondition;
+ (MedicineFooterView *)getView;
@end
