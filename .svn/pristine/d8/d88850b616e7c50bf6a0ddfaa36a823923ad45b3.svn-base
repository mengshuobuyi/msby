//
//  UsePromotionViewController.m
//  APP
//
//  Created by 李坚 on 15/8/26.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "UsePromotionViewController.h"
#import "QRCodeGenerator.h"
#import "Promotion.h"
#import "UsePromotionSuccessViewController.h"
#import "WebDirectViewController.h"
#import "SVProgressHUD.h"
#import "QWProgressHUD.h"
#import "CreditModel.h"
@interface UsePromotionViewController (){
    NSTimer *myTimer;
    
    int TimeOut;
    
}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *QRView;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UIView *whiteView;

@end

//生成二维码的页面
@implementation UsePromotionViewController
- (IBAction)useHelp:(id)sender {
    WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];

    WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
    modelLocal.typeLocalWeb = WebLocalTypeCouponProductManual;
    [vcWebMedicine setWVWithLocalModel:modelLocal];
    [self.navigationController pushViewController:vcWebMedicine animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"使用优惠";
    
    self.titleLabel.font = fontSystem(kFontS4);
    
    self.codeLabel.adjustsFontSizeToFitWidth = YES;
    self.whiteView.layer.masksToBounds = YES;
    self.whiteView.layer.cornerRadius = 3.5f;
    
    TimeOut = 0;
    self.codeLabel.text = [NSString stringWithFormat:@"%@",self.verifyCode];
    
    //UIImage *imgs=[UIImage imageNamed:@"QRicon.png"];
    
    self.QRView.image = [QRCodeGenerator qrImageForString:self.verifyCode imageSize:self.QRView.bounds.size.width Topimg:nil];
    self.QRView.layer.magnificationFilter = kCAFilterNearest;
    
    myTimer = [NSTimer timerWithTimeInterval:3.0  target:self selector:@selector(loopCheck) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop]addTimer:myTimer forMode:NSDefaultRunLoopMode];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [QWGLOBALMANAGER brightScreenWithAnimated:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [myTimer invalidate];
    [QWGLOBALMANAGER darkScreenwithAnimated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)applicationWillResignActive:(NSNotification *)notification

{
    [QWGLOBALMANAGER darkScreenwithAnimated:NO];
}

- (void)applicationWillBecomeActive:(NSNotification *)notification{
    [QWGLOBALMANAGER brightScreenWithAnimated:NO];
}

//每三秒执行一次
- (void)loopCheck{

//    if(TimeOut == 30){//30s内如果未扫码，pop到上一个页面
//
//        [self.navigationController popViewControllerAnimated:YES];
//    }
    
    LoopCheckModelR *modelR = [LoopCheckModelR new];
    modelR.orderId = self.orderId;
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    
    [Promotion loopCheck:modelR success:^(id obj) {
        
        LoopCheckVo *model = obj;
        if([model.apiStatus intValue] != 0){
            
            DDLogVerbose(@"%@",model.apiMessage);
            
        }else{
            [myTimer invalidate];
            //表示验证通过
            
//            [QWProgressHUD showSuccessWithStatus:@"购物成功" hintString:[NSString stringWithFormat:@"+%ld",[QWGLOBALMANAGER rewardScoreWithTaskKey:CreditTaskKey_Trade]] duration:2.0];
            UsePromotionSuccessViewController *useSuccessView = [[UsePromotionSuccessViewController alloc]initWithNibName:@"UsePromotionSuccessViewController" bundle:nil];
            useSuccessView.checkModel = model;
            useSuccessView.orderId = self.orderId;
            
            //渠道统计
            ChannerTypeModel *modelTwo=[ChannerTypeModel new];
            modelTwo.objRemark=model.proName;
            modelTwo.objId=model.proId;
            modelTwo.cKey=@"e_jy";
            [QWGLOBALMANAGER qwChannel:modelTwo];
            
            [self.navigationController pushViewController:useSuccessView animated:YES];
        }
        
    } failure:^(HttpException *e) {
        
    }];
    
    TimeOut += 3;
}

- (void)popVCAction:(id)sender{
    [super popVCAction:sender];
}

@end
