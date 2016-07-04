//
//  LoginViewController.m
//  WenYao
//
//  Created by Meng on 14-9-2.
//  Copyright (c) 2014年 江苏苏州. All rights reserved.
//

#import "LoginViewController.h"
#import "newRegisterViewController.h"
#import "SVProgressHUD.h"
#import "ForgetPasswdViewController.h"
#import "Constant.h"
#import "QWGlobalManager.h"
#import "Mbr.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "ConstraintsUtility.h"
#import "MAHrLineWithOnePix.h"
#import "ChangePasswdViewController.h"
#import "ChangePhoneNumberViewController.h"         // 绑定手机号
#import "PerfectInformationViewController.h"        // 完善资料
#import "AppDelegate.h"
#import "UIButton+AFNetworking.h"
#import "QWVerifyCodeViewController.h"
#import "UIImage+Tint.h"
#import "EnrollViewController.h"
#define RandomDefaultImageName @"img_eye"
#define AlertViewTag_ResetPassword 20001

@interface LoginViewController ()<UIScrollViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
@property (nonatomic, assign) BOOL isSecurityVerified;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passwdField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

- (IBAction)loginClick:(id)sender;
- (IBAction)forgetPasswdClick:(id)sender;
- (IBAction)registerClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_swichViewHeight;
@property (strong, nonatomic) IBOutlet UIButton *mobileLoginTitleBtn;
@property (strong, nonatomic) IBOutlet UIButton *passwordLoginTitleBtn;
@property (strong, nonatomic) IBOutlet UIView *underLineView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_underLineViewWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_underLineViewCenterX;
@property (strong, nonatomic) IBOutlet MAHrLineWithOnePix *hrLineView;
@property (strong, nonatomic) IBOutlet UIView *mobileTFContainerView;
@property (strong, nonatomic) IBOutlet UITextField *mobileTF;
/**
 *  3.1.1 获取验证码需求改变
 */
@property (strong, nonatomic) IBOutlet UIButton *getVerifyCodeBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_getVerifyCodeBtnTrailing;
@property (strong, nonatomic) IBOutlet UIView *verifyCodeContainerView;
@property (strong, nonatomic) IBOutlet UITextField *verifyCodeTF;
@property (strong, nonatomic) IBOutlet UILabel *tipLabel;
@property (strong, nonatomic) IBOutlet UIButton *mobileLoginBtn;

@property (strong, nonatomic) IBOutlet UIView *passwordLoginContainerView;
@property (strong, nonatomic) IBOutlet UIView *passwordLoginView;
@property (strong, nonatomic) IBOutlet UIView *nameTFContainerView;
@property (strong, nonatomic) IBOutlet UITextField *nameTF;
@property (strong, nonatomic) IBOutlet UIView *passwordTFContainerView;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UIButton *eyeBtn;
@property (strong, nonatomic) IBOutlet UIButton *passwordLoginBtn;
@property (strong, nonatomic) IBOutlet UIButton *forgetPasswordBtn;

@property (strong, nonatomic) IBOutlet UIImageView *randomImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_randomImageViewTrailing;

// 语音验证码
@property (strong, nonatomic) IBOutlet UIView *voiceVerifyCodeContainerView;
@property (strong, nonatomic) IBOutlet UIView *voiceVerifyCodeView1;
@property (strong, nonatomic) IBOutlet UILabel *voiceVerifyTip1;
@property (strong, nonatomic) IBOutlet UIButton *voiceVerifyBtn1;

@property (strong, nonatomic) IBOutlet UIView *voiceVerifyCodeView2;
@property (strong, nonatomic) IBOutlet UILabel *voiceVerifyTip2;
@property (strong, nonatomic) IBOutlet UIButton *voiceVerifyBtn2;


@property (strong, nonatomic) IBOutlet UIView *thirdLoginContainerView;
@property (strong, nonatomic) IBOutlet UILabel *thirdLoginTip;
@property (strong, nonatomic) IBOutlet UIButton *weixinBtn;
@property (strong, nonatomic) IBOutlet UIButton *qqBtn;

@property (strong, nonatomic) IBOutlet UILabel *weixinTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *QQTitleLabel;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_weixinLeading;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_qqTrailing;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_thirdLoginTitleBottom;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_weixinTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_mobileTFContainerTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_verifyCodeTFContainerTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_mobileLoginBtnTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_nameTFContainerTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_passwordTFContainerTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_passwordLoginBtnTop;


// 点击顶部的验证码登录模块
- (IBAction)mobileLoginTitleBtnClick:(UIButton*)sender;
// 点击顶部的密码登录模块
- (IBAction)passwordLoginTitleBtnClick:(UIButton*)sender;
// 点击获取验证码按钮
- (IBAction)getVerifyCodeBtnClick:(UIButton *)sender;
- (IBAction)getVerifyVoiceCodeBtnClick:(id)sender;

// 点击密码可见与否
- (IBAction)passwordVisibleClick:(UIButton *)sender;

// 验证码登录
- (IBAction)mobileLoginBtnClick:(id)sender;
// 密码登陆
- (IBAction)passwordLoginBtnClick:(id)sender;
// 忘记密码
- (IBAction)forgetPasswordBtnClick:(id)sender;

- (IBAction)loginWithWeixinClick:(id)sender;
- (IBAction)loginWithQQClick:(id)sender;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignTFs)];
    [self.view addGestureRecognizer:tapGesture];
    self.scrollView.delegate = self;
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
//    self.scrollView.delaysContentTouches = YES;
    
    [self.mobileTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.verifyCodeTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.nameTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];

    self.title = @"登录";
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 3;
    self.passwdField.secureTextEntry = YES;
    self.registerButton.layer.masksToBounds = YES;
    self.registerButton.layer.cornerRadius = 2;
    self.registerButton.layer.borderColor = RGBHex(qwColor1).CGColor;
    self.registerButton.layer.borderWidth = 1;
    [self.registerButton setTitleColor:RGBHex(qwColor1) forState:UIControlStateNormal];
    
    if (iOSv7 && self.view.frame.origin.y==0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    self.randomImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer* imageTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getRandomImage:)];
    [self.randomImageView addGestureRecognizer:imageTapGesture];
    self.verifyCodeTF.enabled = NO;
    self.isSecurityVerified = QWGLOBALMANAGER.configure.forceSecurityVerifyCode;
}

- (void)setIsSecurityVerified:(BOOL)isSecurityVerified
{
    _isSecurityVerified = isSecurityVerified;
    if (_isSecurityVerified) {
        self.voiceVerifyCodeContainerView.hidden = YES;
        self.constraint_getVerifyCodeBtnTrailing.constant = - 1000;
        self.constraint_randomImageViewTrailing.constant = 15;
        self.verifyCodeTF.placeholder = @"校验码";
        [self.mobileLoginBtn setTitle:@"下一步" forState:UIControlStateNormal];
    }
    else
    {
        self.voiceVerifyCodeContainerView.hidden = NO;
        self.constraint_getVerifyCodeBtnTrailing.constant = 15;
        self.constraint_randomImageViewTrailing.constant = - 1000;
        self.verifyCodeTF.placeholder = @"请输入验证码";
        self.verifyCodeTF.enabled = YES;
        [self.mobileLoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    }
}

- (void)getRandomImage:(UITapGestureRecognizer*)tap
{
    if (![QWGLOBALMANAGER isPhoneNumber:self.mobileTF.text]) {
//        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机格式" duration:DURATION_SHORT];
        return;
    }
    self.verifyCodeTF.text = nil;
    self.verifyCodeTF.enabled = YES;
    [self textFieldChanged:self.verifyCodeTF];
    NSURL* imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/h5/mbr/imageCode?mobile=%@&id=%f", DE_H5_DOMAIN_URL, self.mobileTF.text, [[NSDate new] timeIntervalSince1970]]];
    [self.randomImageView setImageWithURL:imageURL];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [QWGLOBALMANAGER statisticsEventId:@"x_dl_cx" withLable:@"登录界面-出现" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"上级页面":self.preVCNameStr}]];

    [self configureThirdLoginUI];
    if (self.isPresentType) {
        [self naviBackBotton];
    }
    if (!StrIsEmpty([QWUserDefault getStringBy:APP_USERNAME_KEY])) {
        self.nameTF.text = [QWUserDefault getStringBy:APP_USERNAME_KEY];
//        self.passwordTF.text = [QWUserDefault getStringBy:APP_PASSWORD_KEY];
        [self textFieldChanged:self.nameTF];
    }
    
    if(QWGLOBALMANAGER.getValidCodeLoginTimer) {
        NSMutableDictionary *userInfo = QWGLOBALMANAGER.getValidCodeLoginTimer.userInfo;
        NSInteger countDonw = [userInfo[@"countDown"] integerValue];
        self.getVerifyCodeBtn.enabled = NO;
        self.getVerifyCodeBtn.backgroundColor = RGBHex(qwColor9);
        [self.getVerifyCodeBtn setTitle:[NSString stringWithFormat:@"重新发送(%ld)",(long)countDonw] forState:UIControlStateDisabled];
//        self.mobileTF.text = userInfo[@"phoneNumber"];
    }else{
        self.getVerifyCodeBtn.enabled = YES;
        self.getVerifyCodeBtn.backgroundColor = RGBHex(qwColor1);
        [self.getVerifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.isSecurityVerified) {
        // 图片验证码中的无密码登录重置
        [QWGLOBALMANAGER.getValidCodeLoginTimer invalidate];
        QWGLOBALMANAGER.getValidCodeLoginTimer = nil;
        self.verifyCodeTF.text = nil;
        self.verifyCodeTF.enabled = NO;
        [self getRandomImage:nil];
    }
}

// qq 微信没安装的情况下隐藏某个功能，如果都没安装整个视图隐藏
- (void)configureThirdLoginUI
{
    if(![QQApiInterface isQQInstalled] && ![WXApi isWXAppInstalled])
    {
        self.thirdLoginContainerView.hidden = YES;
    }
    else
    {
        self.thirdLoginContainerView.hidden = NO;
        if ([QQApiInterface isQQInstalled]) {
            self.qqBtn.hidden = NO;
            self.QQTitleLabel.hidden = NO;
        }
        else
        {
            self.qqBtn.hidden = YES;
            self.QQTitleLabel.hidden = YES;
        }
        if ([WXApi isWXAppInstalled]) {
            self.weixinBtn.hidden = NO;
            self.weixinTitleLabel.hidden = NO;
        }
        else
        {
            self.weixinBtn.hidden = YES;
            self.weixinTitleLabel.hidden = YES;
        }
    }
}

- (void)UIGlobal
{
    // 背景色
    self.view.backgroundColor = RGBHex(qwColor11);
    // 右上角按钮
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [btn setTitle:@"注册" forState:UIControlStateNormal];
    btn.titleLabel.font = fontSystem(kFontS4);
    [btn setTitleColor:RGBHex(qwColor1) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *registerBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = registerBtn;

//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerClick:)];
    
    [self.passwordLoginContainerView addSubview:self.passwordLoginView];
    PREPCONSTRAINTS(self.passwordLoginView);
    ALIGN_TOPLEFT(self.passwordLoginView, 0);
    ALIGN_BOTTOMRIGHT(self.passwordLoginView, 0);
    
    // 顶部视图高度
    self.constraint_swichViewHeight.constant = 40;
    // 设置顶部视图中“验证码登录”按钮样式
    self.mobileLoginTitleBtn.titleLabel.font = [UIFont systemFontOfSize:kFontS4];
    [self.mobileLoginTitleBtn setTitleColor:RGBHex(qwColor6) forState:UIControlStateNormal];
    [self.mobileLoginTitleBtn setTitleColor:RGBHex(qwColor1) forState:UIControlStateSelected];
    // 设置顶部视图中“密码登录”按钮样式
    self.passwordLoginTitleBtn.titleLabel.font = [UIFont systemFontOfSize:kFontS4];
    [self.passwordLoginTitleBtn setTitleColor:RGBHex(qwColor6) forState:UIControlStateNormal];
    [self.passwordLoginTitleBtn setTitleColor:RGBHex(qwColor1) forState:UIControlStateSelected];
    // 顶部视图下划线样式与位置
    self.underLineView.backgroundColor = RGBHex(qwColor1);
    self.constraint_underLineViewWidth.constant = 96;
    
    // 默认选中“验证码登录”模块
    self.mobileLoginTitleBtn.tintColor = [UIColor clearColor];
    self.passwordLoginTitleBtn.tintColor = [UIColor clearColor];
    self.passwordLoginTitleBtn.selected = YES;
    
    // 边框的样式
    UIColor* borderColor = RGBHex(qwColor10);
    CGFloat borderWidth = 1.f/[[UIScreen mainScreen] scale];
    CGFloat cornerRadius = 4;
    
    self.mobileTFContainerView.layer.masksToBounds = YES;
    self.mobileTFContainerView.layer.borderColor = borderColor.CGColor;
    self.mobileTFContainerView.layer.borderWidth = borderWidth;
    self.mobileTFContainerView.layer.cornerRadius = cornerRadius;
    
    self.getVerifyCodeBtn.layer.masksToBounds = YES;
    self.getVerifyCodeBtn.layer.cornerRadius = cornerRadius;
    
    self.verifyCodeContainerView.layer.masksToBounds = YES;
    self.verifyCodeContainerView.layer.borderColor = borderColor.CGColor;
    self.verifyCodeContainerView.layer.borderWidth = borderWidth;
    self.verifyCodeContainerView.layer.cornerRadius = cornerRadius;
    
    self.nameTFContainerView.layer.masksToBounds = YES;
    self.nameTFContainerView.layer.borderColor = borderColor.CGColor;
    self.nameTFContainerView.layer.borderWidth = borderWidth;
    self.nameTFContainerView.layer.cornerRadius = cornerRadius;
    
    self.passwordTFContainerView.layer.masksToBounds = YES;
    self.passwordTFContainerView.layer.borderColor = borderColor.CGColor;
    self.passwordTFContainerView.layer.borderWidth = borderWidth;
    self.passwordTFContainerView.layer.cornerRadius = cornerRadius;
    
    self.mobileLoginBtn.layer.masksToBounds = YES;
    self.mobileLoginBtn.layer.borderColor = borderColor.CGColor;
    self.mobileLoginBtn.layer.borderWidth = borderWidth;
    self.mobileLoginBtn.layer.cornerRadius = cornerRadius;
    
    self.passwordLoginBtn.layer.masksToBounds = YES;
    self.passwordLoginBtn.layer.borderColor = borderColor.CGColor;
    self.passwordLoginBtn.layer.borderWidth = borderWidth;
    self.passwordLoginBtn.layer.cornerRadius = cornerRadius;
    
    // 文字大小 颜色
    self.mobileTF.font = [UIFont systemFontOfSize:kFontS1];
    self.mobileTF.textColor= RGBHex(qwColor6);
    
    self.verifyCodeTF.font = [UIFont systemFontOfSize:kFontS1];
    self.verifyCodeTF.textColor= RGBHex(qwColor6);
    
    self.nameTF.font = [UIFont systemFontOfSize:kFontS1];
    self.nameTF.textColor= RGBHex(qwColor6);
    
    self.passwordTF.font = [UIFont systemFontOfSize:kFontS1];
    self.passwordTF.textColor= RGBHex(qwColor6);
    
    self.tipLabel.textColor = RGBHex(qwColor8);
    self.tipLabel.font = [UIFont systemFontOfSize:kFontS5];
    
    [self.getVerifyCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:kFontS4]];
    self.getVerifyCodeBtn.backgroundColor = RGBHex(qwColor1);
    [self.getVerifyCodeBtn setTitleColor:RGBHex(qwColor4) forState:UIControlStateNormal];
    
    [self.mobileLoginBtn.titleLabel setFont:[UIFont systemFontOfSize:kFontS3]];
    [self.mobileLoginBtn setTitleColor:RGBHex(qwColor4) forState:UIControlStateNormal];
    [self.passwordLoginBtn.titleLabel setFont:[UIFont systemFontOfSize:kFontS3]];
    [self.passwordLoginBtn setTitleColor:RGBHex(qwColor4) forState:UIControlStateNormal];
    [self.forgetPasswordBtn.titleLabel setFont:[UIFont systemFontOfSize:kFontS5]];
    [self.forgetPasswordBtn setTitleColor:RGBHex(qwColor2) forState:UIControlStateNormal];
//    self.mobileLoginBtn.backgroundColor = RGBHex(qwColor2);
//    self.passwordLoginBtn.backgroundColor = RGBHex(qwColor2);
    self.mobileLoginBtn.backgroundColor = RGBHex(qwColor9);
    self.passwordLoginBtn.backgroundColor = RGBHex(qwColor9);
    self.mobileLoginBtn.enabled = NO;
    self.passwordLoginBtn.enabled = NO;
    
    //语音验证码
    self.voiceVerifyTip1.font = [UIFont systemFontOfSize:kFontS4];
    self.voiceVerifyTip1.textColor = RGBHex(qwColor6);
    
    self.voiceVerifyTip2.font = [UIFont systemFontOfSize:kFontS4];
    self.voiceVerifyTip2.textColor = RGBHex(qwColor6);
    
    self.voiceVerifyBtn1.titleLabel.font = [UIFont systemFontOfSize:kFontS4];
    self.voiceVerifyBtn2.titleLabel.font = [UIFont systemFontOfSize:kFontS4];
    [self.voiceVerifyBtn1 setTitleColor:RGBHex(qwColor5) forState:UIControlStateNormal];
    [self.voiceVerifyBtn2 setTitleColor:RGBHex(qwColor5) forState:UIControlStateNormal];
    
    /*
     去掉语音验证
     */
    // 3.1.1 验证码需求改变
    [self.voiceVerifyCodeContainerView addSubview:self.voiceVerifyCodeView1];
    [self.voiceVerifyCodeContainerView addSubview:self.voiceVerifyCodeView2];
    
    PREPCONSTRAINTS(self.voiceVerifyCodeView1);
    PREPCONSTRAINTS(self.voiceVerifyCodeView2);
    
    CENTER_H(self.voiceVerifyCodeView1);
    ALIGN_TOP(self.voiceVerifyCodeView1, 0);
    ALIGN_BOTTOM(self.voiceVerifyCodeView1, 0);
    
    CENTER_H(self.voiceVerifyCodeView2);
    ALIGN_TOP(self.voiceVerifyCodeView2, 0);
    ALIGN_BOTTOM(self.voiceVerifyCodeView2, 0);
    
    self.voiceVerifyCodeView1.hidden = NO;
    self.voiceVerifyCodeView2.hidden = YES;
    
    // 第三方登陆视图样式
    self.thirdLoginTip.font = [UIFont systemFontOfSize:kFontS5];
    self.thirdLoginTip.textColor = RGBHex(qwColor7);
    self.weixinTitleLabel.font = [UIFont systemFontOfSize:kFontS5];
    self.weixinTitleLabel.textColor = RGBHex(qwColor7);
    self.QQTitleLabel.font = [UIFont systemFontOfSize:kFontS5];
    self.QQTitleLabel.textColor = RGBHex(qwColor7);
    
    // 适配
    self.constraint_mobileTFContainerTop.constant = self.constraint_nameTFContainerTop.constant = AutoValue(15);
    self.constraint_verifyCodeTFContainerTop.constant = self.constraint_passwordTFContainerTop.constant = AutoValue(10);
    self.constraint_mobileLoginBtnTop.constant = self.constraint_passwordLoginBtnTop.constant = AutoValue(45);
    
    self.constraint_weixinLeading.constant = AutoValue(76);
    self.constraint_qqTrailing.constant = AutoValue(76);
    // 针对适配4、4s
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        self.constraint_weixinTop.constant = 10;
        self.constraint_thirdLoginTitleBottom.constant = 10;
    }
    else
    {
        self.constraint_weixinTop.constant = AutoValue(26);
        self.constraint_thirdLoginTitleBottom.constant = AutoValue(29);
    }
}

- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj
{
    if(type == NotiCountDonwValidCodeLogin) {
        [self reGetVerifyCodeControl:[data integerValue]];
    }
    else if (type == NotiCountDonwValidVoiceCodeLogin)
    {
        [self reGetVerifyVoiceCodeView:[data integerValue]];
    }
    else if (type == NotifDismssKeyboard) {
        [self.view endEditing:YES];
    }
    else if (type == NotifAppDidBecomeActive)
    {
        [self configureThirdLoginUI];
    }
    else if (type == NotiGetMobileLoginVerifyCodeSucess)
    {
        //  获取无密码登录验证码成功通知
        QWVerifyCodeViewController* verifyCodeVC = [[QWVerifyCodeViewController alloc] init];
        verifyCodeVC.title = @"登录";
        verifyCodeVC.hasVoiceValid = YES;
        verifyCodeVC.phoneNumber = self.mobileTF.text;
        verifyCodeVC.verifyCodeBlock = ^(NSString* codeValue)
        {
            [self validCodeLoginWithCode:codeValue];
        };
        [self.navigationController pushViewController:verifyCodeVC animated:YES];
    }
    else if (type == NotiGetMobileLoginVerifyCodeFailed)
    {
        // 获取无密码登录验证码失败通知
        self.verifyCodeTF.text = nil;
        [self textFieldChanged:self.verifyCodeTF];
        [self getRandomImage:nil];
    }
}

- (void)reGetVerifyCodeControl:(NSInteger)count
{
    if (count == 0) {
        self.getVerifyCodeBtn.enabled = YES;
        [self.getVerifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.getVerifyCodeBtn.backgroundColor = RGBHex(qwColor1);
    }else{
        self.getVerifyCodeBtn.enabled = NO;
        self.getVerifyCodeBtn.backgroundColor = RGBHex(qwColor9);
        [self.getVerifyCodeBtn setTitle:[NSString stringWithFormat:@"重新发送(%ld)",(long)count] forState:UIControlStateDisabled];
    }
}

- (void)reGetVerifyVoiceCodeView:(NSInteger)count
{
    if (count == 0) {
        self.voiceVerifyCodeView1.hidden = NO;
        self.voiceVerifyCodeView2.hidden = YES;
    }else{
        self.voiceVerifyCodeView1.hidden = YES;
        self.voiceVerifyCodeView2.hidden = NO;
    }
}

- (void) resignTFs
{
    [self.mobileTF resignFirstResponder];
    [self.verifyCodeTF resignFirstResponder];
    [self.nameTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
}

- (void)dealloc
{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)textFieldChanged:(UITextField*)textField
{
    static BOOL getRandomImage = NO;
    if (textField == self.mobileTF) {
        if (self.isSecurityVerified) {
            if (self.mobileTF.text.length > 11) {
                self.mobileTF.text = [self.mobileTF.text substringToIndex:11];
                if (!getRandomImage && [QWGLOBALMANAGER isPhoneNumber:self.mobileTF.text]) {
                    [self getRandomImage:nil];
                    getRandomImage = YES;
                    self.verifyCodeTF.text = nil;
                    self.verifyCodeTF.enabled = YES;
                }
            }
            else if ([QWGLOBALMANAGER isPhoneNumber:self.mobileTF.text])
            {
                self.randomImageView.image = [UIImage imageNamed:RandomDefaultImageName];
                [self getRandomImage:nil];
                getRandomImage = YES;
                self.verifyCodeTF.enabled = YES;
            }
            else
            {
                self.verifyCodeTF.text = nil;
                getRandomImage = NO;
                self.verifyCodeTF.enabled = NO;
                self.randomImageView.image = [UIImage imageNamed:RandomDefaultImageName];
            }
        }
        else
        {
            if (StrIsEmpty(self.mobileTF.text) || StrIsEmpty(self.verifyCodeTF.text)) {
                self.mobileLoginBtn.enabled = NO;
                [UIView animateWithDuration:0.3 animations:^{
                    self.mobileLoginBtn.backgroundColor = RGBHex(qwColor9);
                }];
            }
            else
            {
                self.mobileLoginBtn.enabled = YES;
                [UIView animateWithDuration:0.3 animations:^{
                    self.mobileLoginBtn.backgroundColor = RGBHex(qwColor2);
                }];
            }

        }
    }
    if (textField == self.mobileTF || textField == self.verifyCodeTF) {
        if (StrIsEmpty(self.mobileTF.text) || StrIsEmpty(self.verifyCodeTF.text)) {
            self.mobileLoginBtn.enabled = NO;
            [UIView animateWithDuration:0.3 animations:^{
                self.mobileLoginBtn.backgroundColor = RGBHex(qwColor9);
            }];
        }
        else
        {
            self.mobileLoginBtn.enabled = YES;
            [UIView animateWithDuration:0.3 animations:^{
                self.mobileLoginBtn.backgroundColor = RGBHex(qwColor2);
            }];
        }
    }
    else if (textField == self.nameTF || textField == self.passwordTF)
    {
        if (StrIsEmpty(self.nameTF.text) || StrIsEmpty(self.passwordTF.text)) {
            self.passwordLoginBtn.enabled = NO;
            [UIView animateWithDuration:0.3 animations:^{
                self.passwordLoginBtn.backgroundColor = RGBHex(qwColor9);
            }];
        }
        else
        {
            self.passwordLoginBtn.enabled = YES;
            [UIView animateWithDuration:0.3 animations:^{
                self.passwordLoginBtn.backgroundColor = RGBHex(qwColor2);
            }];
        }

    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (object == self.scrollView && [keyPath isEqualToString:@"contentOffset"]) {
        CGPoint point = [change[@"new"] CGPointValue];
        float p = point.x / self.scrollView.bounds.size.width;
        self.constraint_underLineViewCenterX.constant = p*CGRectGetWidth(self.scrollView.frame)/2;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        CGFloat contentOffsetX = scrollView.contentOffset.x;
        self.passwordLoginTitleBtn.selected = contentOffsetX <= 0;
        self.mobileLoginTitleBtn.selected = contentOffsetX > 0;
    }
}


- (void)backToRoot:(id)sender
{
    if (self.backBlocker) {
        self.backBlocker();
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        if(self.navigationController)
            [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark ---- 登录 ----

- (IBAction)loginClick:(id)sender {
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [SVProgressHUD showErrorWithStatus:@"网络未连接，请重试" duration:0.8f];
        return;
    }
//    [self.nameField resignFirstResponder];
//    [self.passwdField resignFirstResponder];
    [self resignTFs];
    
    if (self.nameField.text.length == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号" duration:DURATION_SHORT];
        
    }else if ((self.nameField.text.length > 0 && self.nameField.text.length < 11)||self.nameField.text.length > 11)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号" duration:DURATION_SHORT];
        
    }else if (self.nameField.text.length == 11)
    {
        if ([QWGLOBALMANAGER isPhoneNumber:self.nameField.text])//如果是手机号
        {
            //判断完手机号后,再判断密码
            if (self.passwdField.text.length == 0)
            {
                [SVProgressHUD showErrorWithStatus:@"请输入密码" duration:DURATION_SHORT];
            }else
                if (self.passwdField.text.length > 0 && self.passwdField.text.length < 6)
            {
                [SVProgressHUD showErrorWithStatus:@"密码至少6位" duration:DURATION_SHORT];
            }else
                if (self.passwdField.text.length >= 6)
            {
                [self performSelectorOnMainThread:@selector(login) withObject:nil waitUntilDone:YES];
            }
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号" duration:DURATION_SHORT];
        }
    }
}

#pragma mark ---- 忘记密码 ----

- (IBAction)forgetPasswdClick:(id)sender
{
    ForgetPasswdViewController * change = [[ForgetPasswdViewController alloc] initWithNibName:@"ForgetPasswdViewController" bundle:nil];
    [self.navigationController pushViewController:change animated:YES];
}

#pragma mark ---- 注册 ----

- (IBAction)registerClick:(id)sender
{
    [QWGLOBALMANAGER statisticsEventId:@"x_dl_zc" withLable:@"登录界面-注册" withParams:nil];
    if (self.isSecurityVerified) {
        EnrollViewController* enrollVC = [[EnrollViewController alloc] init];
        enrollVC.needVerifyFullInfo = self.needVerifyFullInfo;
        enrollVC.isPresentType = self.isPresentType;
        enrollVC.passTokenBlock = self.passTokenBlock;
        [self.navigationController pushViewController:enrollVC animated:YES];
    }
    else
    {
        newRegisterViewController * registerViewController = [[newRegisterViewController alloc] initWithNibName:@"newRegisterViewController" bundle:nil];
        registerViewController.needVerifyFullInfo = self.needVerifyFullInfo;
        registerViewController.isPresentType = self.isPresentType;
        registerViewController.passTokenBlock = self.passTokenBlock;
        [self.navigationController pushViewController:registerViewController animated:YES];
    }
    
}

#pragma mark ---- 注册代理 ----

-(void)returnRegisterNumber:(NSString *)number Password:(NSString *)password
{
    self.nameTF.text = number;
    self.passwordTF.text = password;
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    [self.nameField resignFirstResponder];
//    [self.passwdField resignFirstResponder];
//}

#pragma mark -
#pragma mark 数据请求

- (void)login
{
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [SVProgressHUD showErrorWithStatus:@"网络未连接，请重试" duration:0.8f];
        return;
    }
    //校验注册用户是否已存在
    self.loginButton.enabled = NO;
    //登录
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    param[@"account"] = self.nameField.text;
//    param[@"password"] = self.passwdField.text;
//    param[@"deviceCode"] = QWGLOBALMANAGER.deviceToken;
//    param[@"device"] = IOS_DEVICE; 
    mbrLogin *param=[mbrLogin new];
    param.account = self.nameTF.text;
    param.password = self.passwordTF.text;
    param.device = IOS_DEVICE;
    param.deviceCode = DEVICE_ID;
    param.pushDeviceCode = QWGLOBALMANAGER.deviceToken;
    param.credentials=[AESUtil encryptAESData:self.passwordTF.text app_key:AES_KEY];
    __weak LoginViewController *logvc = self;
    
    [Mbr loginWithParams:param
                 success:^(id obj){
                 	    NSMutableDictionary *params = [NSMutableDictionary dictionary];
                     mbrUser *user = obj;
                     if (user && [user.apiStatus intValue] == 0) {
                         [QWGLOBALMANAGER statisticsEventId:@"x_dlcg" withLable:@"登录成功" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"登录方式":@"密码登录"}]];
                         
                         // 如果是语音验证码登录成功
                         params[@"是否登录成功"] = @"是";
                         [QWUserDefault setBool:YES key:APP_LOGIN_STATUS];
                         [QWUserDefault setString:APPLOGINTYPE_NORMAL key:APP_LOGIN_TYPE];
                         [QWUserDefault setString:self.nameTF.text key:APP_USERNAME_KEY];
                         [QWUserDefault setString:self.passwordTF.text key:APP_PASSWORD_KEY];
                         
                         if (self.passTokenBlock) {
                             self.passTokenBlock(user.token);
                         }

                         [TalkingDataAppCpa onLogin:user.passportId];
                         
                         [QWGLOBALMANAGER loginSuccessWithUserInfo:user];
                         QWGLOBALMANAGER.configure.isThirdLogin = NO;
                         QWGLOBALMANAGER.configure.passWord = self.passwordTF.text;
                         [QWGLOBALMANAGER saveAppConfigure];
                         //通知登录成功
                         [QWGLOBALMANAGER postNotif:NotifLoginSuccess data:nil object:self];
                         [QWGLOBALMANAGER loginSucessCallBack];
                         
                         [QWGLOBALMANAGER saveOperateLog:@"2"];
                         
                         // 检查密码的简单性
                         if ([@"123456" isEqualToString:self.passwordTF.text]) {
                             UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:kWarning30002 delegate:self cancelButtonTitle:@"重新设置" otherButtonTitles:nil];
                             alertView.tag = AlertViewTag_ResetPassword;
                             [alertView show];
                         }
                         else
                         {
                             if(logvc.isPresentType){
                                 [logvc dismissViewControllerAnimated:YES completion:NULL];
                             }else{
                                 // 如果是从登录页面进来而且没有完成完善资料
                                 if (self.needVerifyFullInfo && ![QWGLOBALMANAGER verifyMobileHasLogin:user.mobile] && !user.full) {
                                     // 完善资料
                                     [self gotoPerfectInfoVC];
                                 }
                                 else
                                     [logvc.navigationController popViewControllerAnimated:YES];
                             }
                         }
                         
                         if(self.loginSuccessBlock){
                             self.loginSuccessBlock();
                         }
                         [self loginSuccessAction];
                     }
                     else
                     {
                         //此处需要再处理下
                         params[@"是否登录成功"] = @"否";
                         [SVProgressHUD showErrorWithStatus:user.apiMessage duration:DURATION_SHORT];
                     }
                
                     self.loginButton.enabled = YES;
                 }
                 failure:^(HttpException *e){
                     self.loginButton.enabled = YES;
                     if(e.errorCode == -1001){
                         [SVProgressHUD showErrorWithStatus:kWarning215N26 duration:0.8];
                     }
                 }];
}

// 跳转完善资料
- (void) gotoPerfectInfoVC
{
    PerfectInformationViewController* perfectInfoVC = [[PerfectInformationViewController alloc] init];
    perfectInfoVC.needBacktoNaviRootVC = YES;
    [self.navigationController pushViewController:perfectInfoVC animated:YES];
}
- (void) setTitleBtnsNormal
{
    self.mobileLoginTitleBtn.selected = NO;
    self.passwordLoginTitleBtn.selected = NO;
}

// 选择登录方式 - 验证码登录
- (IBAction)mobileLoginTitleBtnClick:(UIButton*)sender {
    [self setTitleBtnsNormal];
    sender.selected = YES;
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0) animated:YES];
}
// 选择登录方式 - 普通登录
- (IBAction)passwordLoginTitleBtnClick:(UIButton*)sender {
    [self setTitleBtnsNormal];
    sender.selected = YES;
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

// 获取验证码用于验证码登录
- (IBAction)getVerifyCodeBtnClick:(UIButton *)sender {
//    sender.backgroundColor = RGBHex(qwColor10);
    if ([QWGLOBALMANAGER isPhoneNumber:self.mobileTF.text]) {
        [QWGLOBALMANAGER startValidCodeLoginVerifyCode:self.mobileTF.text];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
    }
}

- (IBAction)getVerifyVoiceCodeBtnClick:(id)sender {
    if ([QWGLOBALMANAGER isPhoneNumber:self.mobileTF.text]) {
        // 不需要倒计时了
//        [QWGLOBALMANAGER startVoiceValidCodeToLogin:self.mobileTF.text];
        if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
            [SVProgressHUD showErrorWithStatus:@"网络未连接，请重试" duration:0.8];
            return;
        }
        
        [QWGLOBALMANAGER statisticsEventId:@"x_dl_yyyzm" withLable:@"登录界面-获取语音验证码" withParams:nil];
        
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"mobile"] = self.mobileTF.text;
        param[@"type"] = @"9";
        
        [Mbr sendVoiceVerifyCodeWithParams:param success:^(id resultObj){
            BaseAPIModel* apiModel = resultObj;
            if ([apiModel.apiStatus intValue] == 0){
                [self reGetVerifyVoiceCodeView:1];  // 1 不是倒计时，相当于一个YES标志
            }
            else{
                [SVProgressHUD showErrorWithStatus:@"获取语音验证码失败！" duration:DURATION_LONG];
            }
            
        }failure:^(HttpException *e){
            [SVProgressHUD showErrorWithStatus:e.Edescription duration:DURATION_SHORT];
        }];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
    }

    
}

// 密码是否可见
- (IBAction)passwordVisibleClick:(UIButton *)sender {
    if (sender.selected) {
        [QWGLOBALMANAGER statisticsEventId:@"x_dl_xsmm" withLable:@"登录界面-显示密码" withParams:nil];
    }
    sender.selected = !sender.selected;
    self.passwordTF.secureTextEntry = !sender.selected;
}

// 验证码登录  3.1.1 无密码登录中的 下一步
- (IBAction)mobileLoginBtnClick:(id)sender {
    if (self.isSecurityVerified) {
        [self getSecurityVerifyCode];
    }
    else
    {
        [self loginWithVerifyCode];
    }
}

// 通过图片验证码安全获取登录验证码
- (void)getSecurityVerifyCode
{
    [QWGLOBALMANAGER statisticsEventId:@"x_wmmdl_xyb" withLable:@"无密码登录-下一步" withParams:nil];
    if (![QWGLOBALMANAGER isPhoneNumber:self.mobileTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机格式" duration:DURATION_SHORT];
        return;
    }
    if (StrIsEmpty(self.verifyCodeTF.text)) {
        [SVProgressHUD showErrorWithStatus:@"请输入校验码" duration:DURATION_SHORT];
        return;
    }
    
    // 获取成功发送通知 NotiGetMobileLoginVerifyCodeSucess
    [QWGLOBALMANAGER startValidCodeLoginVerifyCode:self.mobileTF.text imageCode:self.verifyCodeTF.text];
}

// 3.2.1 把无密码登录又放出来了
- (void)loginWithVerifyCode
{
    [QWGLOBALMANAGER statisticsEventId:@"x_dl_yzm" withLable:@"x_dl_yzm" withParams:nil];
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [SVProgressHUD showErrorWithStatus:@"网络未连接，请重试" duration:0.8f];
        return;
    }
    mbrValidCodeLogin* param = [[mbrValidCodeLogin alloc] init];
    param.mobile = self.mobileTF.text;
    param.validCode = self.verifyCodeTF.text;
    param.pushDeviceCode = QWGLOBALMANAGER.deviceToken;
    param.deviceCode = DEVICE_ID;
    param.device = @"2";
    
    __weak LoginViewController *logvc = self;
    [Mbr validCodeLoginWithParams:param success:^(id obj) {
        mbrUser* user = obj;
        if ([user.apiStatus integerValue] == 0) {
            [QWUserDefault setBool:YES key:APP_LOGIN_STATUS];
            [QWUserDefault setString:APPLOGINTYPE_VALIDCODE key:APP_LOGIN_TYPE];
            // 重置获取验证码登录倒计时。
            [QWGLOBALMANAGER.getValidCodeLoginTimer invalidate];
            QWGLOBALMANAGER.getValidCodeLoginTimer = nil;
            [QWGLOBALMANAGER.getVoiceValidCodeLoginTimer invalidate];
            QWGLOBALMANAGER.getValidCodeLoginTimer = nil;
            
            if (self.passTokenBlock) {
                self.passTokenBlock(user.token);
            }
            
            [TalkingDataAppCpa onLogin:user.passportId];
            
            [QWGLOBALMANAGER loginSuccessWithUserInfo:user];
            QWGLOBALMANAGER.configure.isThirdLogin = NO;
            [QWGLOBALMANAGER saveAppConfigure];
            
            //通知登录成功
            [QWGLOBALMANAGER postNotif:NotifLoginSuccess data:nil object:self];
            [QWGLOBALMANAGER loginSucessCallBack];
            
            // 登录日志
            [QWGLOBALMANAGER saveOperateLog:@"2"];
            if(user.reg){
                [QWGLOBALMANAGER saveOperateLog:@"1"];
            }
            
            if(logvc.isPresentType){
                [logvc dismissViewControllerAnimated:YES completion:NULL];
            }else{
                // 如果是从登录页面进来而且没有完成完善资料
                if (self.needVerifyFullInfo && ![QWGLOBALMANAGER verifyMobileHasLogin:user.mobile] && !user.full) {
                    // 完善资料
                    [self gotoPerfectInfoVC];
                }
                else
                    [logvc.navigationController popViewControllerAnimated:YES];
            }
            
            if(self.loginSuccessBlock){
                self.loginSuccessBlock();
            }
            [self loginSuccessAction];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:user.apiMessage];
        }
    } failure:^(HttpException *e) {
        if(e.errorCode == -1001){
            [SVProgressHUD showErrorWithStatus:kWarning215N26 duration:0.8];
        }
    }];
}

- (void)validCodeLoginWithCode:(NSString*)code
{
    [QWGLOBALMANAGER statisticsEventId:@"x_dl_yzm" withLable:@"x_dl_yzm" withParams:nil];
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [SVProgressHUD showErrorWithStatus:@"网络未连接，请重试" duration:0.8f];
        [QWGLOBALMANAGER postNotif:NotifMobileLoginFailed data:nil object:nil];
        return;
    }
    mbrValidCodeLogin* param = [[mbrValidCodeLogin alloc] init];
    param.mobile = self.mobileTF.text;
    param.validCode = code;
    param.pushDeviceCode = QWGLOBALMANAGER.deviceToken;
    param.deviceCode = DEVICE_ID;
    param.device = @"2";
    
    __weak LoginViewController *logvc = self;
    [Mbr validCodeLoginWithParams:param success:^(id obj) {
        mbrUser* user = obj;
        if ([user.apiStatus integerValue] == 0) {
            [QWGLOBALMANAGER statisticsEventId:@"x_dlcg" withLable:@"登录成功" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"登录方式":@"验证码登录"}]];
            
            [QWUserDefault setBool:YES key:APP_LOGIN_STATUS];
            [QWUserDefault setString:APPLOGINTYPE_VALIDCODE key:APP_LOGIN_TYPE];
            
            // 重置获取验证码登录倒计时。
            [QWGLOBALMANAGER.getValidCodeLoginTimer invalidate];
            QWGLOBALMANAGER.getValidCodeLoginTimer = nil;
            [QWGLOBALMANAGER.getVoiceValidCodeLoginTimer invalidate];
            QWGLOBALMANAGER.getValidCodeLoginTimer = nil;
            
            if (self.passTokenBlock) {
                self.passTokenBlock(user.token);
            }
            
            [TalkingDataAppCpa onLogin:user.passportId];
            
            [QWGLOBALMANAGER loginSuccessWithUserInfo:user];
            QWGLOBALMANAGER.configure.isThirdLogin = NO;
            [QWGLOBALMANAGER saveAppConfigure];
            //通知登录成功
            [QWGLOBALMANAGER postNotif:NotifLoginSuccess data:nil object:self];
            [QWGLOBALMANAGER loginSucessCallBack];
            
            // 登录日志
            [QWGLOBALMANAGER saveOperateLog:@"2"];
            if(user.reg){
                [QWGLOBALMANAGER saveOperateLog:@"1"];
            }
            
            if(logvc.isPresentType){
                [logvc dismissViewControllerAnimated:YES completion:NULL];
            }else{
                // 如果是从登录页面进来而且没有完成完善资料
                if (self.needVerifyFullInfo && ![QWGLOBALMANAGER verifyMobileHasLogin:user.mobile] && !user.full) {
                    // 完善资料
                    [self gotoPerfectInfoVC];
                }
                else
                    [logvc.navigationController popToRootViewControllerAnimated:YES];
            }
            
            if(self.loginSuccessBlock){
                self.loginSuccessBlock();
            }
            [self loginSuccessAction];
        }
        else
        {
            [QWGLOBALMANAGER postNotif:NotifMobileLoginFailed data:nil object:nil];
            [SVProgressHUD showErrorWithStatus:user.apiMessage];
        }
    } failure:^(HttpException *e) {
        if(e.errorCode == -1001){
            [SVProgressHUD showErrorWithStatus:kWarning215N26 duration:0.8];
        }
    }];
}

// 普通登录
- (IBAction)passwordLoginBtnClick:(id)sender {
    [QWGLOBALMANAGER statisticsEventId:@"x_dl_mm" withLable:@"登录界面-密码登录" withParams:nil];
    [self login];
}

// 点击忘记密码
- (IBAction)forgetPasswordBtnClick:(id)sender {
    [self forgetPasswdClick:sender];
}
#pragma mark - 第三方登录
#pragma mark  微信登录
- (IBAction)loginWithWeixinClick:(id)sender {
    [QWGLOBALMANAGER statisticsEventId:@"x_dl_wx" withLable:@"登录界面-微信登录" withParams:nil];
    if (![WXApi isWXAppInstalled]) {
        [SVProgressHUD showErrorWithStatus:@"您未安装微信"];
        return;
    }
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    __weak LoginViewController *logvc = self;
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
            mbrTPALogin* param = [[mbrTPALogin alloc] init];
//            param.unionId = snsAccount.usid;
            param.nickName = snsAccount.userName;
            param.headImgUrl = snsAccount.iconURL;
            param.channel = @"1";
            param.pushDeviceCode = QWGLOBALMANAGER.deviceToken;
            param.deviceCode = DEVICE_ID;
            param.device = @"2";
            
            // 获取微信unionid
            __block NSString* unionid;
            NSString* url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@", snsAccount.accessToken, snsAccount.openId];
            NSURL* URL = [NSURL URLWithString:url];
            
            NSURLRequest* request = [NSURLRequest requestWithURL:URL];
            [[QWLoading instance] showLoading];
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                if (connectionError) {
                    [[QWLoading instance] removeLoading];
                    DebugLog(@"get unionid weixin error: %@", connectionError);
                }
                else
                {
                    id obj = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                    if ([obj isKindOfClass:[NSDictionary class]]) {
                        unionid = obj[@"unionid"];
                    }
                }
                
                if (StrIsEmpty(unionid)) {
                    [[QWLoading instance] removeLoading];
                    [SVProgressHUD showErrorWithStatus:@"授权出现错误，请重新登录"];
                    return;
                }
                param.unionId = unionid;
                
                [Mbr tpaLoginWithParams:param success:^(id obj) {
                    mbrUser* user = obj;
                    if ([user.apiStatus integerValue] == 0) {
                        [QWGLOBALMANAGER statisticsEventId:@"x_dlcg" withLable:@"登录成功" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"登录方式":@"微信登录"}]];
                        
                        [QWUserDefault setBool:YES key:APP_LOGIN_STATUS];
                        [QWUserDefault setString:APPLOGINTYPE_WEIXIN key:APP_LOGIN_TYPE];
                        
                        if (self.passTokenBlock) {
                            self.passTokenBlock(user.token);
                        }
                        
                        [TalkingDataAppCpa onLogin:user.passportId];
                        
                        [QWGLOBALMANAGER loginSuccessWithUserInfo:user];
                        QWGLOBALMANAGER.configure.isThirdLogin = YES;
                        [QWGLOBALMANAGER saveAppConfigure];
                        //通知登录成功
                        [QWGLOBALMANAGER postNotif:NotifLoginSuccess data:nil object:self];
                        [QWGLOBALMANAGER loginSucessCallBack];
                                
                        // 登录日志
                        [QWGLOBALMANAGER saveOperateLog:@"2"];
                        if(user.reg){
                            [QWGLOBALMANAGER saveOperateLog:@"1"];
                        }
                        // 如果是第一次第三方登陆，则跳到绑定手机号页面
                        if (QWGLOBALMANAGER.configure.firstTPAL) {
                            ChangePhoneNumberViewController *bindPhoneVC = [[ChangePhoneNumberViewController alloc] initWithNibName:@"ChangePhoneNumberViewController" bundle:nil];
                            bindPhoneVC.isPresentType = self.isPresentType;
                            bindPhoneVC.isNeedPopToRootVC = YES;
                            bindPhoneVC.changePhoneType = ChangePhoneType_BindPhoneNumber;
                            [self.navigationController pushViewController:bindPhoneVC animated:YES];
                        }
                        else if(logvc.isPresentType){
                            [logvc dismissViewControllerAnimated:YES completion:NULL];
                        }else{
                            [logvc.navigationController popViewControllerAnimated:YES];
                        }
                        
                        if(self.loginSuccessBlock){
                            self.loginSuccessBlock();
                        }
                        [self loginSuccessAction];
                    }
                    else
                    {
                        [SVProgressHUD showErrorWithStatus:user.apiMessage];
                    }
                } failure:^(HttpException *e) {
                    if(e.errorCode == -1001){
                        [SVProgressHUD showErrorWithStatus:kWarning215N26 duration:0.8];
                    }
                }];
                
            }];
        }
    });
}
#pragma mark  QQ登录
- (IBAction)loginWithQQClick:(id)sender {
    [QWGLOBALMANAGER statisticsEventId:@"x_dl_qq" withLable:@"登录界面-QQ登录" withParams:nil];
    if (![QQApiInterface isQQInstalled]) {
        [SVProgressHUD showErrorWithStatus:@"您未安装QQ"];
        return;
    }
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    __weak LoginViewController *logvc = self;
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            
            mbrTPALogin* param = [[mbrTPALogin alloc] init];
            param.unionId = snsAccount.usid;
            param.nickName = snsAccount.userName;
            param.headImgUrl = snsAccount.iconURL;
            param.channel = @"2";
            param.pushDeviceCode = QWGLOBALMANAGER.deviceToken;
            param.deviceCode = DEVICE_ID;
            param.device = @"2";
            [Mbr tpaLoginWithParams:param success:^(id obj) {
                mbrUser* user = obj;
                if ([user.apiStatus integerValue] == 0) {
                    [QWGLOBALMANAGER statisticsEventId:@"x_dlcg" withLable:@"登录成功" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"登录方式":@"QQ登录"}]];
                    
                    [QWUserDefault setBool:YES key:APP_LOGIN_STATUS];
                    [QWUserDefault setString:APPLOGINTYPE_QQ key:APP_LOGIN_TYPE];
                    
//                    [QWUserDefault setString:StrIsEmpty(user.mobile) ? user.userName : user.mobile key:APP_USERNAME_KEY];
                    if (self.passTokenBlock) {
                        self.passTokenBlock(user.token);
                    }
                    
                    [TalkingDataAppCpa onLogin:user.passportId];
                    [QWGLOBALMANAGER loginSuccessWithUserInfo:user];
                    QWGLOBALMANAGER.configure.isThirdLogin = YES;
                    [QWGLOBALMANAGER saveAppConfigure];
                    //通知登录成功
                    [QWGLOBALMANAGER postNotif:NotifLoginSuccess data:nil object:self];
                    [QWGLOBALMANAGER loginSucessCallBack];
                    
                    // 登录日志和注册日志
                    [QWGLOBALMANAGER saveOperateLog:@"2"];
                    if(user.reg){
                     [QWGLOBALMANAGER saveOperateLog:@"1"];
                    }
                    
                    
                    // 如果是第一次第三方登陆，则跳到绑定手机号页面
                    if (QWGLOBALMANAGER.configure.firstTPAL) {
                        ChangePhoneNumberViewController *bindPhoneVC = [[ChangePhoneNumberViewController alloc] initWithNibName:@"ChangePhoneNumberViewController" bundle:nil];
                        bindPhoneVC.changePhoneType = ChangePhoneType_BindPhoneNumber;
                        bindPhoneVC.isPresentType = self.isPresentType;
                        bindPhoneVC.isNeedPopToRootVC = YES;
                        [self.navigationController pushViewController:bindPhoneVC animated:YES];
                    }
                    else if(logvc.isPresentType){
                        [logvc dismissViewControllerAnimated:YES completion:NULL];
                    }else{
                        [logvc.navigationController popViewControllerAnimated:YES];
                    }
                    
                    if(self.loginSuccessBlock){
                        self.loginSuccessBlock();
                    }
                    [self loginSuccessAction];
                }
                else
                {
                    [SVProgressHUD showErrorWithStatus:user.apiMessage];
                }

            } failure:^(HttpException *e) {
                if(e.errorCode == -1001){
                    [SVProgressHUD showErrorWithStatus:kWarning215N26 duration:0.8];
                }
            }];
        }});
}

- (void)loginSuccessAction
{
    [QWGLOBALMANAGER getUserBaseInfo];
}

#pragma mark - UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == AlertViewTag_ResetPassword) {
        if (buttonIndex == 0) {
            
            ChangePasswdViewController *changePasswd = [[ChangePasswdViewController alloc] initWithNibName:@"ChangePasswdViewController" bundle:nil];
            changePasswd.isForceChange = YES;
            changePasswd.isPresentType = self.isPresentType;
//            [APPDelegate.mainVC presentViewController:changePasswd animated:YES completion:nil];
            [self.navigationController pushViewController:changePasswd animated:YES];
        }
    }
}

@end