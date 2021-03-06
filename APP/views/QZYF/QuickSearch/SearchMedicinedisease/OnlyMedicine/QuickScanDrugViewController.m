//
//  QuickScanDrugViewController.m
//  wenYao-store
//
//  Created by YYX on 15/6/9.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QuickScanDrugViewController.h"
#import "QuickScanDrugListViewController.h"
#import "Drug.h"
#import "SVProgressHUD.h"

@interface QuickScanDrugViewController ()
{
    BOOL torchIsOn;
    IOSScanView *   iosScanView;
    NSTimer* timer;
}
@end

@implementation QuickScanDrugViewController

@synthesize scanRectView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"条形码";

    CGRect rect = CGRectMake(0, 0, APP_W, APP_H);
    iosScanView = [[IOSScanView alloc] initWithFrame:rect];
    iosScanView.delegate = self;
    [self.view addSubview:iosScanView];
    
    
    [self setupTorchBarButton];
    [self setupDynamicScanFrame];
    [self configureReadView];
}

- (void)popVCAction:(id)sender{
    
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (iosScanView) {
        [iosScanView startRunning];
    }
    
    ((QWBaseNavigationController *)self.navigationController).canDragBack = NO;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    torchIsOn = NO;
    
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    
    if (iosScanView) {
        [iosScanView stopRunning];
    }
    
    ((QWBaseNavigationController *)self.navigationController).canDragBack = YES;
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

- (void)setupTorchBarButton
{
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Torch.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleTorch:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)reStartScan
{
    if (timer) {
        timer = nil;
    }
    if (iosScanView) {
        [iosScanView startRunning];
    }
}

- (IBAction)toggleTorch:(id)sender
{
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (!torchIsOn) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                torchIsOn = YES;
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
                torchIsOn = NO;
            }
            [device unlockForConfiguration];
        }
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

- (void) IOSScanResult: (NSString*) scanCode WithType:(NSString *)type
{
    //进行业务逻辑处理
    DebugLog(@" IOSScanResult扫到的条码 ===>%@",scanCode);
    
    //AVMetadataObjectTypeQRCode 二维码

    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [self showError:kWarning12];
        return;
    }
    
    if(scanCode.length <= 15){
        [self normalScan:scanCode];
        return;
    }
}

- (void) viewDidAppear: (BOOL) animated
{
    [super viewDidAppear:animated];
    //    [_scanRectView start];
}

- (void)normalScan:(NSString *)proId
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    MapInfoModel *mapInfoModel = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
    param[@"barCode"] = proId;
    param[@"city"]=mapInfoModel.city;
    param[@"province"]=mapInfoModel.province;
    param[@"v"] = @"2";
    //扫码获取商品信息
    [Drug queryProductByBarCodeWithParam:param Success:^(id resultObj){
        DrugScanModel *responseModel = resultObj;
        if([responseModel.apiStatus intValue] == 0){
            ProductModel *model = responseModel.list[0];
            QuickScanDrugListViewController *scan = [[QuickScanDrugListViewController alloc]initWithNibName:@"QuickScanDrugListViewController" bundle:nil];
            scan.product = model;
            [self.navigationController pushViewController:scan animated:YES];
            if (self.block) {
                scan.block = ^(id model){
                    productclassBykwId *product = model;
                    self.block(product);
                };
            }
        }else{
            if ([responseModel.apiStatus intValue]==1) {
                [self showError:responseModel.apiMessage];
            }
            timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(reStartScan) userInfo:nil repeats:NO];
        }
    }failure:^(HttpException *e){
        [SVProgressHUD showErrorWithStatus:e.Edescription duration:DURATION_SHORT];
        timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(reStartScan) userInfo:nil repeats:NO];
    }];
}


@end
