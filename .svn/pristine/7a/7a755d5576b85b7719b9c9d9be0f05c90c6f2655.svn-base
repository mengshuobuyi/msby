//
//  EnrollViewController.m
//  APP
//
//  接口：
//  1.h5/mbr/imageCode                      获取校验码图片
//  2.h5/mbr/code/sendCodeByImageVerify     获取短信验证码
//  Created by Martin.Liu on 16/4/15.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "EnrollViewController.h"
#import "SVProgressHUD.h"
#import "ServeInfoViewController.h"
#import "Mbr.h"
#import "EnrollVerifyCodeViewController.h"
#import "EnrollSetPasswordViewController.h"
#define EnrollRandomDefaultImageName @"img_eye"
@interface EnrollViewController ()
@property (strong, nonatomic) IBOutlet UIView *phoneView;
@property (strong, nonatomic) IBOutlet UIView *checkCodeView;
@property (strong, nonatomic) IBOutlet UITextField *mobileTF;
@property (strong, nonatomic) IBOutlet UITextField *checkCodeTF;

@property (strong, nonatomic) IBOutlet UIImageView *randomImageView;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;

@property (weak, nonatomic) IBOutlet UIButton *conformButton;
@property (weak, nonatomic) IBOutlet UIButton *protocolButton;

- (IBAction)nextBtnAction:(id)sender;
- (IBAction)conformBtnACtion:(UIButton*)sender;
- (IBAction)protocolBtnAction:(id)sender;

@end

@implementation EnrollViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"注册";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 检测手机输入框和校验码输入框中文本的变化
    [self.mobileTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.checkCodeTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    // 默认选中同意协议
    self.conformButton.selected = YES;
    
    self.randomImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer* imageTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getRandomImage:)];
    [self.randomImageView addGestureRecognizer:imageTapGesture];
    self.checkCodeTF.enabled = NO;
    self.nextBtn.backgroundColor = RGBHex(qwColor9);
    self.nextBtn.enabled = NO;
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignTFS:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)resignTFS:(UITapGestureRecognizer*)tapGesture
{
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 重置获取验证码时间片（用于下个页面返回的时候）
    [QWGLOBALMANAGER.getVerifyTimer invalidate];
    QWGLOBALMANAGER.getVerifyTimer = nil;
    self.checkCodeTF.text = nil;
    self.checkCodeTF.enabled = NO;
    [self getRandomImage:nil];
}

- (void)UIGlobal
{
    [self layerField:self.phoneView];
    [self layerField:self.checkCodeView];
    self.nextBtn.layer.masksToBounds = YES;
    self.nextBtn.layer.cornerRadius = 4.0f;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)layerField:(UIView *)view{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 4.0f;
    view.layer.borderWidth = 0.5f;
    view.layer.borderColor = RGBHex(qwColor10).CGColor;
}

#pragma mark 获取验证码方法
- (void)getRandomImage:(UITapGestureRecognizer*)tap
{
    if (![QWGLOBALMANAGER isPhoneNumber:self.mobileTF.text]) {
//        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机格式" duration:DURATION_SHORT];
        return;
    }
    self.checkCodeTF.text = nil;
    self.checkCodeTF.enabled = YES;
    [self textFieldChanged:self.checkCodeTF];
    NSURL* imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/h5/mbr/imageCode?mobile=%@&id=%f", DE_H5_DOMAIN_URL, self.mobileTF.text, [[NSDate new] timeIntervalSince1970]]];
    [self.randomImageView setImageWithURL:imageURL];
}

#pragma mark 文本框内容发生变化
- (void)textFieldChanged:(UITextField*)textField
{
    static BOOL getRandomImage = NO;
    if (textField == self.mobileTF) {
        // 限制手机输入框最多可输入11个长度
        if (self.mobileTF.text.length > 11) {
            self.mobileTF.text = [self.mobileTF.text substringToIndex:11];
            if (!getRandomImage && [QWGLOBALMANAGER isPhoneNumber:self.mobileTF.text]) {
                [self getRandomImage:nil];
                getRandomImage = YES;
                self.checkCodeTF.text = nil;
                self.checkCodeTF.enabled = YES;
            }
        }
        // 如果手机输入框中内容符合手机格式，自动后去校验码
        else if ([QWGLOBALMANAGER isPhoneNumber:self.mobileTF.text])
        {
            self.randomImageView.image = [UIImage imageNamed:EnrollRandomDefaultImageName];
            [self getRandomImage:nil];
            getRandomImage = YES;
            self.checkCodeTF.enabled = YES;
        }
        else
        {
            getRandomImage = NO;
            self.checkCodeTF.text = nil;
            self.checkCodeTF.enabled = NO;
            self.randomImageView.image = [UIImage imageNamed:EnrollRandomDefaultImageName];
        }
    }
    // 如果手机号和校验码输入框都未空则按钮不可用。
    if (StrIsEmpty(self.mobileTF.text) || StrIsEmpty(self.checkCodeTF.text)) {
        self.nextBtn.backgroundColor = RGBHex(qwColor9);
        self.nextBtn.enabled = NO;
    }
    else
    {
        self.nextBtn.backgroundColor = RGBHex(qwColor2);
        self.nextBtn.enabled = YES;
    }
}

- (IBAction)nextBtnAction:(id)sender {
    [QWGLOBALMANAGER statisticsEventId:@"x_zc_xyb" withLable:@"注册-下一步" withParams:nil];
    if (![QWGLOBALMANAGER isPhoneNumber:self.mobileTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机格式" duration:DURATION_SHORT];
        return;
    }
    
    if (StrIsEmpty(self.checkCodeTF.text)) {
        [SVProgressHUD showErrorWithStatus:@"请输入校验码" duration:DURATION_SHORT];
        return;
    }
    
    if (!self.conformButton.selected) {
        [SVProgressHUD showErrorWithStatus:@"请同意服务条款" duration:DURATION_SHORT];
        [self.view endEditing:YES];
        return;
    }
    // 隐藏键盘
    [self.view endEditing:YES];
    
    //校验手机号是否注册过
    [Mbr registerValidWithParams:@{@"mobile":self.mobileTF.text} success:^(id DFUserModel) {
        BaseAPIModel *model = [BaseAPIModel parse:DFUserModel];
        
        //change by yang
        
        if ([model.apiStatus integerValue] == 2) {
            [SVProgressHUD showErrorWithStatus:@"手机号已被注册" duration:DURATION_SHORT];
        }else
        {
            // NotiGetRegisterVerifyCodeSucess 通知
            [QWGLOBALMANAGER startRgisterVerifyCode:self.mobileTF.text imageCode:self.checkCodeTF.text];
        }
    } failure:^(HttpException *e) {
        
    }];
    
    
}

#pragma mark 同意协议的按钮行为
- (IBAction)conformBtnACtion:(UIButton*)sender {
    sender.selected = !sender.selected;
}

#pragma mark 用户协议
- (IBAction)protocolBtnAction:(id)sender {
    // 用户协议
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [SVProgressHUD showErrorWithStatus:@"网络未连接，请重试" duration:0.8f];
        return;
    }
    ServeInfoViewController * serverInfo = [[ServeInfoViewController alloc] init];
    serverInfo.webRequestType = WebRequestTypeServeClauses;
    [self.navigationController pushViewController:serverInfo animated:YES];
}

- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj
{
    if (type == NotiGetRegisterVerifyCodeSucess) {
        EnrollVerifyCodeViewController* verifyCodeVC = [[EnrollVerifyCodeViewController alloc] init];
        verifyCodeVC.title = @"注册";
        verifyCodeVC.phoneNumber = self.mobileTF.text;
        verifyCodeVC.isPresentType = self.isPresentType;
        verifyCodeVC.needVerifyFullInfo = self.needVerifyFullInfo;
        verifyCodeVC.passTokenBlock = self.passTokenBlock;
        [self.navigationController pushViewController:verifyCodeVC animated:YES];
    }
    else if (type == NotiGetRegisterVerifyCodeFailed)
    {
        self.checkCodeTF.text = nil;
        [self textFieldChanged:self.checkCodeTF];
        [self getRandomImage:nil];
    }
}
@end
