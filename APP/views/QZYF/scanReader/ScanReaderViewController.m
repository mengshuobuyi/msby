//
//  ScanReaderViewController.m
//  APP
//
//  Created by qw on 15/2/27.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "ScanReaderViewController.h"
#import "QWcss.h"
#import "QWGlobalManager.h"
#import "Constant.h"
#import "SVProgressHUD.h"
#import "Coupon.h"
#import "ScanDrugViewController.h"
//#import "CouponGenerateViewController.h"
#import "Drug.h"
#import "MallScanDrugViewController.h"
#import "WebDirectViewController.h"

@interface ScanReaderViewController ()
{
    IOSScanView *   iosScanView;
    NSTimer* timer;
}

@end

@implementation ScanReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"条码扫描";

    //默认关闭闪光灯
    self.torchMode = NO;
    CGRect rect = CGRectMake(0, 0, APP_W, APP_H);
    iosScanView = [[IOSScanView alloc] initWithFrame:rect];
    iosScanView.delegate = self;
    [self.view addSubview:iosScanView];
    
    [self setupTorchBarButton];
    [self setupDynamicScanFrame];
    [self configureReadView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //self.useType = Enum_Scan_Items_Preferential;
    if (iosScanView) {
        [iosScanView startRunning];
    }
    
    ((QWBaseNavigationController *)self.navigationController).canDragBack = NO;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    
    if (iosScanView) {
        [iosScanView stopRunning];
    }
    
    ((QWBaseNavigationController *)self.navigationController).canDragBack = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark  初始化界面布局

- (void)configureReadView
{
    CGFloat scanWidth = APP_W/2+100;
    UILabel *desrciption = [[UILabel alloc] initWithFrame:CGRectMake(0,0, APP_W, 30)];
    CGPoint point = CGPointMake(APP_W/2, (APP_H+scanWidth)/2);
    desrciption.center = point;
    desrciption.textColor = RGBHex(qwColor4);
    desrciption.font = fontSystem(kFontS4);
    desrciption.textAlignment = NSTextAlignmentCenter;
    desrciption.text = @"将条码放到取景框内,即可自动扫描";
    [self.view addSubview:desrciption];
}

- (void)setupDynamicScanFrame
{
    float backalpha = 0.4;
    
    CGFloat scanWidth = APP_W/2+100;
    
    CGRect viewRect1 = CGRectMake(0,0, (APP_W - scanWidth )/ 2, APP_H);
    UIView* view1 = [[UIView alloc] initWithFrame:viewRect1];
    [view1 setBackgroundColor:[UIColor blackColor]];
    view1.alpha = backalpha;
    [self.view addSubview:view1];
    
    CGRect viewRect2 = CGRectMake((APP_W - scanWidth )/ 2,0, scanWidth, (APP_H-scanWidth)/2-40);
    UIView* view2 = [[UIView alloc] initWithFrame:viewRect2];
    [view2 setBackgroundColor:[UIColor blackColor]];
    view2.alpha = backalpha;
    [self.view addSubview:view2];
    
    CGRect viewRect3 = CGRectMake((APP_W + scanWidth )/2,0, (APP_W - scanWidth )/ 2, APP_H);
    UIView* view3 = [[UIView alloc] initWithFrame:viewRect3];
    [view3 setBackgroundColor:[UIColor blackColor]];
    view3.alpha = backalpha;
    [self.view addSubview:view3];
    
    CGRect viewRect4 = CGRectMake((APP_W - scanWidth )/ 2,(APP_H+scanWidth)/2-40, scanWidth, (APP_H-scanWidth/2));
    UIView* view4 = [[UIView alloc] initWithFrame:viewRect4];
    [view4 setBackgroundColor:[UIColor blackColor]];
    view4.alpha = backalpha;
    [self.view addSubview:view4];
    
    
    CGRect scanMaskRect = CGRectMake((APP_W - scanWidth )/ 2,(APP_H-scanWidth)/2-40, scanWidth, scanWidth);
    UIImageView *scanImage = [[UIImageView alloc] initWithFrame:scanMaskRect];
    [scanImage setImage:[UIImage imageNamed:@"line_normal"]];
    [self.view addSubview:scanImage];
    
    UIImageView *scanLineImage = [[UIImageView alloc] initWithFrame:CGRectMake((APP_W - scanWidth)/ 2,(APP_H-scanWidth)/2-40, scanWidth, 6)];
    [scanLineImage setImage:[UIImage imageNamed:@"line_two"]];
    scanLineImage.center = CGPointMake(APP_W/2, (APP_H-scanWidth)/2-40);
    [self.view addSubview:scanLineImage];
    
    [self runSpinAnimationOnView:scanLineImage duration:3 positionY:scanWidth repeat:CGFLOAT_MAX];
}

- (void)runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration positionY:(CGFloat)positionY repeat:(float)repeat;
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: positionY];
    rotationAnimation.duration = duration;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
    rotationAnimation.autoreverses = YES;
    [view.layer addAnimation:rotationAnimation forKey:@"position"];
}

#pragma mark -
#pragma mark  右上角按钮 闪光灯
- (void)setupTorchBarButton
{
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Torch.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleTorch:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)toggleTorch:(id)sender
{
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (!self.torchMode) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                self.torchMode = YES;
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
                self.torchMode = NO;
            }
            [device unlockForConfiguration];
        }
    }
}

#pragma mark -
#pragma mark  扫码结果回调

- (void) IOSScanResult: (NSString*) scanCode WithType:(NSString *)type
{
    //进行业务逻辑处理
    DebugLog(@" IOSScanResult扫到的条码 ===>%@",scanCode);
    
    if(self.useType == Enum_Scan_Items_OnlyCode){
        if(self.scanBlock){
            [self.navigationController popViewControllerAnimated:NO];
            self.scanBlock(scanCode);
        }
        return;
    }
    
    if(self.useType == Enum_Scan_Items_FromHome){
        
        if (([scanCode hasPrefix:@"http://"])||([scanCode hasPrefix:@"https://"])) {
            
            WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
            WebDirectLocalModel *modelLocal = [[WebDirectLocalModel alloc] init];
            modelLocal.url = scanCode;
            modelLocal.typeLocalWeb = WebLocalTypeOuterLink;
            //此外链不要分享
            modelLocal.typeTitle = WebTitleTypeNone;
            [vcWebDirect setWVWithLocalModel:modelLocal];
            vcWebDirect.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vcWebDirect animated:YES];
        }else{
            MallScanDrugViewController *VC = [[MallScanDrugViewController alloc]initWithNibName:@"MallScanDrugViewController" bundle:nil];
            VC.scanCode = scanCode;
            [self.navigationController pushViewController:VC animated:YES];
        }
        return;
    }
    
    //AVMetadataObjectTypeQRCode 二维码
    [self DealResult:scanCode];
}

#pragma mark -
#pragma mark  根据扫描结果进行业务逻辑处理

- (void)promotionScan:(NSString *)scanCode{
    
    if(self.promotionCallBack){
        [QWLOADING showLoading];
        self.promotionCallBack(scanCode);
        if(self.NeedPopBack){
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)DealResult:(NSString *)scanCode
{
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [self showError:kWarning12];
        return;
    }
    if(self.useType == Enum_Scan_Items_Preferential) {//优惠码逻辑
        
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        MapInfoModel *mapInfoModel = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
        param[@"barCode"] = scanCode;
        
        if(mapInfoModel){
            //if(mapInfoModel.city && ![mapInfoModel.city isEqualToString:@""]){
            if(!StrIsEmpty(mapInfoModel.city)){
                param[@"city"] = mapInfoModel.city;
            }
            //if(mapInfoModel.province && ![mapInfoModel.province isEqualToString:@""]){
            if(!StrIsEmpty(mapInfoModel.province)){
                param[@"province"] = mapInfoModel.province;
            }
        }
        param[@"v"] = @"2.0";
        //扫码获取商品信息
        [Drug queryProductByBarCodeWithParam:param
                                     Success:^(id resultObj){
                                         DrugScanModel* modelScan = (DrugScanModel*)resultObj;
                                         if (([modelScan.apiStatus intValue]==0) && [modelScan.list count]>0) {
                                             //获取优惠信息
                                             if(self.NeedPopBack){
                                                 //来自优惠商品的扫码，有结果了需要pop
                                                 if(self.promotionCallBack){
                                                     self.promotionCallBack(modelScan.list[0]);
                                                 }
                                                 [self.navigationController popViewControllerAnimated:YES];
                                                 return;
                                             }
                                             
                                         }
                                         else if(self.useType == Enum_Scan_Items_Promotion)//优惠商品搜索
                                         {
                                             ProductModel* product = modelScan.list[0];
                                             [self promotionScan:product.proName];
                                         }
                                         else
                                         {
                                             if(self.NeedPopBack){
                                                 //来自优惠商品的扫码，有结果了需要pop
                                                 if(self.promotionCallBack){
                                                     self.promotionCallBack(nil);
                                                 }

                                                 [self.navigationController popViewControllerAnimated:YES];
                                                 return;
                                             }
                                             self.useType = Enum_Scan_Items_Normal;
                                             [self normalScan:scanCode];
                                         }
                                     }
                                     failure:^(HttpException *e){
                                         [self showError:e.Edescription];
//                                         [SVProgressHUD showErrorWithStatus:e.Edescription duration:DURATION_SHORT];
                                     }];
    }else{
        [self normalScan:scanCode];
    }
}

//优惠信息
//- (void)pushToGenerateView:(NSString *)proId barCode:(NSString *)barCode
//{
//    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
//    if(QWGLOBALMANAGER.loginStatus){
//        setting[@"token"] = QWGLOBALMANAGER.configure.userToken;
//    }
//    setting[@"proId"] = proId;
//    
//    NSString *province = [QWUserDefault getObjectBy:APP_PROVIENCE_NOTIFICATION];
//    NSString *city = [QWUserDefault getObjectBy:APP_CITY_NOTIFICATION];
//    if(province && ![province isEqualToString:@""]){
//        setting[@"province"] = province;//省名称
//    }
//    if(city && ![city isEqualToString:@""]){
//        setting[@"city"] = city;//市名称
//    }
//    
//    CouponGenerateViewController *generateView = [[CouponGenerateViewController alloc]initWithNibName:@"CouponGenerateViewController" bundle:nil];
//    [Coupon promotionScanWithParms:setting success:^(id MFModel) {
//        
//        CouponEnjoyModel *mode = (CouponEnjoyModel *)MFModel;
//        //
//        /**
//         *  0 正常
//         -10 商品不存在
//         -11 商品不适用
//         -2 活动未开始
//         -1 活动已结束
//         -4 活动异常
//         -13 总次数不足
//         -14 总人次不足
//         */
//        if([mode.status intValue] == 0 || [mode.status intValue] == -13 || [mode.status intValue] == -14){
//            
//            generateView.type = [mode.status integerValue];
//            
//            if([mode.status intValue] != 0){
//                
//                generateView.sorryText = mode.msg;
//            }
//            generateView.enjoy = mode;
//            //传值：商品编码
//            generateView.proId = proId;
//            generateView.delegatePopVC = self.delegatePopVC;
//            [self.navigationController pushViewController:generateView animated:YES];
//        }else{
//            self.useType = Enum_Scan_Items_Normal;
//            [self normalScan:barCode];
//        }
//        
//    } failure:^(HttpException *e) {
//        self.useType = Enum_Scan_Items_Normal;
//        [self normalScan:barCode];
//    }];
//    
//}

- (void)normalScan:(NSString *)proId
{

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    MapInfoModel *mapInfoModel = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
    param[@"barCode"] = proId;
    if(mapInfoModel){
        //if(mapInfoModel.city && ![mapInfoModel.city isEqualToString:@""]){
        if(!StrIsEmpty(mapInfoModel.city)){
            param[@"city"] = mapInfoModel.city;
        }
       // if(mapInfoModel.province && ![mapInfoModel.province isEqualToString:@""]){
        if(!StrIsEmpty(mapInfoModel.province)){
            param[@"province"] = mapInfoModel.province;
        }
    }
    param[@"v"] = @"2.0";
    //扫码获取商品信息
    [Drug queryProductByBarCodeWithParam:param
                                 Success:^(id resultObj){
                                     DrugScanModel* modelScan = (DrugScanModel*)resultObj;
                                     if (([modelScan.apiStatus intValue]==0) && [modelScan.list count]>0) {
                                         if(!self.scanBlock){
                                             if(self.useType == Enum_Scan_Items_Preferential||self.useType == Enum_Scan_Items_Normal) {
                                                 ScanDrugViewController *scanDrugViewController = [[ScanDrugViewController alloc] init];
                                                 scanDrugViewController.drugList = modelScan.list;
                                                 scanDrugViewController.userType = self.useType;
                                                 scanDrugViewController.delegatePopVC = self.delegatePopVC;
                                                 if(self.completionBolck){
                                                     scanDrugViewController.completionBolck = self.completionBolck;
                                                 }
                                                 [self.navigationController pushViewController:scanDrugViewController animated:YES];
                                             }
                                             else if(self.useType == Enum_Scan_Items_Promotion)//优惠商品搜索
                                             {
                                                 ProductModel* product = modelScan.list[0];
                                                 [self promotionScan:product.proName];
                                             }
                                             else{
                                                 //获取药品的用法
                                                 ProductModel* product = modelScan.list[0];
                                                 [self getProductUsage:product];
                                             }
                                         }else{
                                             self.scanBlock(proId);
                                         }
                                     }
                                     else{
//                                         [self.navigationController popViewControllerAnimated:NO];
//                                         if ([modelScan.apiMessage isEqualToString:@"未搜索到此商品"]) {
//                                        [self showError:@"条码扫描不是全维药品"];
                                         
                                         //chage  by  shen
                                         if ([modelScan.apiStatus intValue]==1) {
                                               [self showError:modelScan.apiMessage];
                                         }
                                      
                                         // chage by  shen
                                         //******************
                                         //add by meng
                                         timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(reStartScan) userInfo:nil repeats:NO];
                                         //******************
//                                         }
//                                         [self showError:modelScan.apiMessage];
                                     }
                                 }
                                 failure:^(HttpException *e){
                                     [SVProgressHUD showErrorWithStatus:e.Edescription duration:DURATION_SHORT];
                                 }];
}
// add by meng 逻辑:在未
- (void)reStartScan
{
    if (timer) {
        timer = nil;
    }
    if (iosScanView) {
        [iosScanView startRunning];
    }
}

//获取药品的用法
-(void)getProductUsage:(ProductModel*)product
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"proId"] = product.proId;
    //获取商品的用法用量
    [Drug getProductUsageWithParam:param
                           Success:^(id resultObj){
                               
                               ProductUsage *body = resultObj;
                               if (body) {
                                   if(self.addMedicineUsageBolck)
                                   {
                                       self.addMedicineUsageBolck(product,body);
                                   }
                                   
                               }
                               [self.navigationController popViewControllerAnimated:NO];
                           }
                           failure:^(HttpException *e){
                               [SVProgressHUD showErrorWithStatus:e.Edescription duration:1.2f];
                           }];
}

@end