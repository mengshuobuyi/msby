//
//  RecommenderScanViewController.m
//  APP
//  扫码添加我的推荐人页面
//  Created by 李坚 on 16/5/9.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "RecommenderScanViewController.h"

@interface RecommenderScanViewController ()<IOSScanViewDelegate>
{
    IOSScanView *   iosScanView;
    NSTimer* timer;
}

@property (nonatomic, assign) BOOL torchMode;          //控制闪光灯的开关
@end

@implementation RecommenderScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
    if(self.scanBlock){
        self.scanBlock(scanCode);
        [self.navigationController popViewControllerAnimated:NO];
    }
    return;
}

@end
