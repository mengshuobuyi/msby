//
//  CouponUseViewController.m
//  APP
//
//  Created by garfield on 15/8/20.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "CouponUseViewController.h"
#import "ConponUseSuccessViewController.h"
#import "QRCodeGenerator.h"
#import "WebDirectViewController.h"
#import "QWProgressHUD.h"
#import "CreditModel.h"
@interface CouponUseViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImage;
@property (weak, nonatomic) IBOutlet UILabel *verifyCodeLabel;
@property (nonatomic, copy)   dispatch_source_t  checkMessageTimer;
@property (assign, nonatomic) CGFloat originalBrightNess;
@property (weak, nonatomic) IBOutlet UIView *whiteView;

@end

@implementation CouponUseViewController
@synthesize checkMessageTimer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"使用优惠";
    
    self.verifyCodeLabel.adjustsFontSizeToFitWidth = YES;
    self.whiteView.layer.masksToBounds = YES;
    self.whiteView.layer.cornerRadius = 3.5f;

    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:@"查看使用说明"];
    NSRange contentRange = {0, [content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleThick] range:contentRange];
    
//    self.qrCodeImage.image = [QRCodeGenerator qrImageForString:_useModel.code imageSize:self.qrCodeImage.bounds.size.width Topimg:[UIImage imageNamed:@"QRicon.png"]];

    self.qrCodeImage.image = [QRCodeGenerator qrImageForString:_useModel.code imageSize:self.qrCodeImage.bounds.size.width Topimg:nil];
    
    self.qrCodeImage.layer.magnificationFilter = kCAFilterNearest;
    self.verifyCodeLabel.text = [NSString stringWithFormat:@"%@",_useModel.code];

    
    //定时器轮询拉去该二维码状态,是否已被使用
    [self loopCheckUseStatus];
}

- (void)popVCAction:(id)sender
{
    [super popVCAction:sender];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [QWGLOBALMANAGER brightScreenWithAnimated:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    [self loopCheckUseStatus];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stopCheck];
    [QWGLOBALMANAGER darkScreenwithAnimated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];

}

- (void)loopCheckUseStatus
{
    checkMessageTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(checkMessageTimer, dispatch_time(DISPATCH_TIME_NOW, 5ull*NSEC_PER_SEC), 5ull*NSEC_PER_SEC , DISPATCH_TIME_FOREVER);
    dispatch_source_set_event_handler(checkMessageTimer, ^{
        [self checkOrderStatus];
    });
    dispatch_source_set_cancel_handler(checkMessageTimer, ^{
        DDLogVerbose(@"has been canceled");
    });
    dispatch_resume(checkMessageTimer);
}

- (void)checkOrderStatus
{
    CouponOrderCheckVoModelR *modelR = [CouponOrderCheckVoModelR new];
    modelR.orderId = _useModel.orderId;
    [Coupon couponOrderCheck:modelR success:^(CouponOrderCheckVo *checkModel) {
        if([checkModel.apiStatus integerValue] == 0) {
            //如果被使用,停止定时器,并跳入使用成功界面
            [self stopCheck];
            
//            [QWProgressHUD showSuccessWithStatus:@"购物成功" hintString:[NSString stringWithFormat:@"+%ld",[QWGLOBALMANAGER rewardScoreWithTaskKey:CreditTaskKey_Trade]] duration:2.0];
            
            
            ConponUseSuccessViewController *VC = [[ConponUseSuccessViewController alloc] initWithNibName:@"ConponUseSuccessViewController" bundle:nil];
            VC.checkModel = checkModel;            
            [self.navigationController pushViewController:VC animated:YES];
        }
    } failure:NULL];
}

- (void)stopCheck
{
    dispatch_source_cancel(checkMessageTimer);
}

- (IBAction)checkUserInfo:(id)sender
{
    WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    WebDirectLocalModel *modelLocal = [[WebDirectLocalModel alloc] init];
    modelLocal.typeLocalWeb = WebLocalTypeDiscountExplain;
    [vcWebDirect setWVWithLocalModel:modelLocal];
    
    vcWebDirect.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vcWebDirect animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)applicationWillResignActive:(NSNotification *)notification

{
    [QWGLOBALMANAGER darkScreenwithAnimated:NO];
}

- (void)applicationWillBecomeActive:(NSNotification *)notification{
    [QWGLOBALMANAGER brightScreenWithAnimated:NO];
}
@end
