//
//  newRegisterViewController.m
//  APP
//
//  Created by 李坚 on 15/10/28.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "newRegisterViewController.h"
#import "SVProgressHUD.h"
#import "Mbr.h"
#import "ServeInfoViewController.h"
#import "PerfectInformationViewController.h"
@interface newRegisterViewController ()<UITextFieldDelegate>{
    
    NSTimer *_reGetVerifyTimer;
    
    BOOL telFlag;
    BOOL codeFlag;
    BOOL pwFlag;
}
@property (weak, nonatomic) IBOutlet UIView *telNumberView;
@property (weak, nonatomic) IBOutlet UIView *codeView;
@property (weak, nonatomic) IBOutlet UIView *passWordView;

@property (weak, nonatomic) IBOutlet UITextField *telNumberField;
@property (weak, nonatomic) IBOutlet UIButton *CodeButton;

@property (weak, nonatomic) IBOutlet UILabel *telPlaceholderLabel;
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (weak, nonatomic) IBOutlet UILabel *codePlaceholderLabel;
@property (weak, nonatomic) IBOutlet UIButton *showPWButton;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLaytout;

@property (weak, nonatomic) IBOutlet UITextField *passWordField;
@property (weak, nonatomic) IBOutlet UILabel *passWordPlaceholderLabel;
@property (weak, nonatomic) IBOutlet UIImageView *eyeImage;

@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *conformButton;
@property (weak, nonatomic) IBOutlet UIButton *protocolButton;

@property (assign, nonatomic) BOOL isShowPWD;

@end

@implementation newRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"注册问药账号";
    [self layerButton];
    [self layerField:self.telNumberView];
    [self layerField:self.codeView];
    [self layerField:self.passWordView];
    
    self.telNumberField.delegate = self;
    self.codeField.delegate = self;
    //self.passWordField.delegate = self;
    
    self.passWordField.font = fontSystem(14.0f);
    
    self.registerButton.enabled = NO;
    [self.CodeButton addTarget:self action:@selector(generateCode) forControlEvents:UIControlEventTouchUpInside];
    self.isShowPWD = YES;
    [self showPW:nil];
    [self.registerButton addTarget:self action:@selector(registerValid) forControlEvents:UIControlEventTouchUpInside];
    
    [self.conformButton addTarget:self action:@selector(selectedButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.conformButton.selected = YES;
    [self.protocolButton addTarget:self action:@selector(serveInformationClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.showPWButton addTarget:self action:@selector(showPW:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyborad)];
    [self.view addGestureRecognizer:tap];
    
}


- (void)hideKeyborad{
    
    [self.telNumberField    resignFirstResponder];
    [self.codeField         resignFirstResponder];
    [self.passWordField     resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    if(QWGLOBALMANAGER.registerAccount){
        self.telNumberField.text = QWGLOBALMANAGER.registerAccount;
    }
    
    if(self.telNumberField.text .length > 0){
        self.telPlaceholderLabel.hidden = YES;
    }
    
    [self.telNumberField addTarget:self action:@selector(telNumberChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.codeField addTarget:self action:@selector(telNumberChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.passWordField addTarget:self action:@selector(telNumberChanged:) forControlEvents:UIControlEventEditingChanged];
    
    if(QWGLOBALMANAGER.getVerifyTimer) {
        NSMutableDictionary *userInfo = QWGLOBALMANAGER.getVerifyTimer.userInfo;
        NSInteger countDonw = [userInfo[@"countDown"] integerValue];
        [self.codeLabel setBackgroundColor:RGBHex(qwColor9)];
        self.codeLabel.text = [NSString stringWithFormat:@"重新发送(%d)",countDonw];
    }else{
        [self.codeLabel setBackgroundColor:RGBHex(qwColor1)];
        self.codeLabel.text = @"获取验证码";
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

#pragma mark - TextField输入监视，
- (void)telNumberChanged:(UITextField *)field{
    
    if(field.text.length > 0){
        
        if([field isEqual:self.telNumberField]){
            self.telPlaceholderLabel.hidden = YES;
        }
        if([field isEqual:self.codeField]){
            self.codePlaceholderLabel.hidden = YES;
        }
        if([field isEqual:self.passWordField]){
            self.passWordPlaceholderLabel.hidden = YES;
        }
    }else{
        if([field isEqual:self.telNumberField]){
            self.telPlaceholderLabel.hidden = NO;
        }
        if([field isEqual:self.codeField]){
            self.codePlaceholderLabel.hidden = NO;
        }
        if([field isEqual:self.passWordField]){
            self.passWordPlaceholderLabel.hidden = NO;
        }
    }

//    if([field isEqual:self.telNumberField]){
//        if(field.text.length == 11){
//            telFlag = YES;
//        }else{
//            telFlag = NO;
//        }
//    }
//    if([field isEqual:self.codeField]){
//        if(field.text.length == 6){
//            codeFlag = YES;
//        }else{
//            codeFlag = NO;
//        }
//    }
//    if([field isEqual:self.passWordField]){
//        if(field.text.length >= 6){
//            pwFlag = YES;
//        }else{
//            pwFlag = NO;
//        }
//    }
    
//    if([field isEqual:self.telNumberField]){
        if(self.telNumberField.text.length == 11){
            telFlag = YES;
        }else{
            telFlag = NO;
        }
//    }
//    if([field isEqual:self.codeField]){
        if(self.codeField.text.length > 0){
            codeFlag = YES;
        }else{
            codeFlag = NO;
        }
//    }
//    if([field isEqual:self.passWordField]){
        if(self.passWordField.text.length >= 6){
            pwFlag = YES;
        }else{
            pwFlag = NO;
        }
//    }
    
    if(telFlag && codeFlag && pwFlag){
        self.registerButton.backgroundColor = RGBHex(qwColor2);
        self.registerButton.enabled = YES;
    }else{
        self.registerButton.backgroundColor = RGBHex(qwColor9);
        self.registerButton.enabled = NO;
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 验证码生成请求
-(void)generateCode{
    
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [SVProgressHUD showErrorWithStatus:@"网络未连接，请重试" duration:0.8f];
        return;
    }
    
    if (self.telNumberField.text.length == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空" duration:1];
    }else if ((self.telNumberField.text.length > 0 && self.telNumberField.text.length < 11)||self.telNumberField.text.length > 11)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号" duration:1];
    }else if (self.telNumberField.text.length == 11)
    {
        if ([QWGLOBALMANAGER isPhoneNumber:self.telNumberField.text])//如果是手机号
        {
            //校验手机号是否注册过
            [Mbr registerValidWithParams:@{@"mobile":self.telNumberField.text} success:^(id DFUserModel) {
                BaseAPIModel *model = [BaseAPIModel parse:DFUserModel];
                
                //change by yang
                
                if ([model.apiStatus integerValue] == 2) {
                    [SVProgressHUD showErrorWithStatus:@"手机号已被注册" duration:DURATION_SHORT];
                }else
                {
                    QWGLOBALMANAGER.registerAccount = self.telNumberField.text;
                    [QWGLOBALMANAGER startRgisterVerifyCode:self.telNumberField.text];
                }
            } failure:^(HttpException *e) {
                
            }];
            
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号" duration:1];
        }
    }
}

#pragma mark - 注册数据请求
-(void)registerValid{
    
    //断网容错
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [SVProgressHUD showErrorWithStatus:@"网络未连接，请重试" duration:0.8f];
        return;
    }
    //检查手机号码
    if (self.telNumberField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空" duration:DURATION_SHORT];
        return;
    }
    if (self.telNumberField.text.length > 11 || ![QWGLOBALMANAGER isPhoneNumber:self.telNumberField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号" duration:DURATION_SHORT];
        return;
    }
    
    //检查验证码
    if (self.codeField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码" duration:DURATION_SHORT];
        return;
    }
    //检查密码
    if (self.passWordField.text.length < 6 || self.passWordField.text.length > 16) {
        [SVProgressHUD showErrorWithStatus:@"请输入6-16位数字或字母密码" duration:DURATION_SHORT];
        return;
    }
    
    //检查协议
    if(!self.conformButton.selected){
        [SVProgressHUD showErrorWithStatus:@"请同意服务条款" duration:DURATION_SHORT];
        return;
    }
    // 检测密码简单性
    if ([@"123456" isEqualToString:self.passWordField.text]) {
        [SVProgressHUD showErrorWithStatus:kWarning30001];
        return;
    }
    [self hideKeyborad];
    //开始注册
    self.registerButton.enabled = NO;
    
    MapInfoModel *mapModel = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
    MbrRegisterR *modelR = [MbrRegisterR new];
    modelR.mobile = self.telNumberField.text;
    modelR.password = self.passWordField.text;
    modelR.code = self.codeField.text;
    modelR.device = DEVICE_ID;
    modelR.deviceType = IOS_DEVICE;
    BOOL locationSucces = [QWUserDefault getBoolBy:kLocationSuccess];
    if (locationSucces) {
        modelR.city = mapModel.city;
    }else
    {
        modelR.city = @"";
    }
    modelR.credentials=[AESUtil encryptAESData:self.passWordField.text app_key:AES_KEY];
    [Mbr mbrRegisterParams:modelR success:^(id obj) {
        
        if ([obj[@"apiStatus"] integerValue] == 0) {
            
            if([QWGLOBALMANAGER.registerAccount isEqualToString:self.telNumberField.text]){
                QWGLOBALMANAGER.registerAccount = nil;
            }
            [QWUserDefault setString:self.telNumberField.text key:APP_USERNAME_KEY];
            //逻辑需确认！！！
            [QWGLOBALMANAGER saveOperateLog:@"1"];
            [TalkingDataAppCpa onRegister:obj[@"passportId"]];
            mbrLogin *param=[mbrLogin new];
            param.account       = self.telNumberField.text;
            param.password      = self.passWordField.text;
            param.device        = IOS_DEVICE;
            param.deviceCode    = DEVICE_ID;
            param.pushDeviceCode= QWGLOBALMANAGER.deviceToken;
            param.credentials=[AESUtil encryptAESData:self.passWordField.text app_key:AES_KEY];
            [self loginWith:param];
        }else{
            if([obj[@"apiStatus"] integerValue] == 4){
                [SVProgressHUD showErrorWithStatus:@"验证码错误" duration:0.8];
            }else{
                [SVProgressHUD showErrorWithStatus:obj[@"apiMessage"] duration:0.8];
            }
            self.registerButton.enabled = YES;
        }
        
    } failure:^(HttpException *e) {
        self.registerButton.enabled = YES;
    }];
}

#pragma mark - 登录操作
- (void)loginWith:(mbrLogin *)param{
    
    [Mbr loginWithParams:param
                 success:^(id obj){
                     mbrUser *user = obj;
                     NSMutableDictionary *params = [NSMutableDictionary dictionary];
                     if (user && [user.apiStatus intValue] == 0) {
                         params[@"是否注册成功"] = @"是";
                         [QWUserDefault setBool:YES key:APP_LOGIN_STATUS];
                         [QWUserDefault setString:param.account key:APP_USERNAME_KEY];
                         [QWUserDefault setString:param.password key:APP_PASSWORD_KEY];
                         
                         
                         if (self.passTokenBlock) {
                             self.passTokenBlock(user.token);
                         }
                         
                         [QWGLOBALMANAGER loginSuccessWithUserInfo:user];
                         QWGLOBALMANAGER.configure.passWord = param.password;
                         QWGLOBALMANAGER.configure.isThirdLogin = NO;
                         [QWGLOBALMANAGER saveAppConfigure];
                         
                         //通知登录成功
                         [QWGLOBALMANAGER postNotif:NotifLoginSuccess data:nil object:self];
                         [QWGLOBALMANAGER loginSucessCallBack];
                         [QWGLOBALMANAGER stopCountDownRegisterTimer:nil];
                         
                         
                         //登录日志
                         [QWGLOBALMANAGER saveOperateLog:@"2"];
                         
                         if (self.isPresentType) {
                             [self dismissViewControllerAnimated:YES completion:^{
                                 
                             }];
                         }
                         else
                         {
                             // 如果是从登录页面进来都完善资料
                             if (self.needVerifyFullInfo && !user.full) {
                                 // 只做缓存用的
                                 [QWGLOBALMANAGER verifyMobileHasLogin:user.mobile];
                                 [self gotoPerfectInfoVC];
                             }
                             else
                                 [self.navigationController popViewControllerAnimated:YES];
                         }
                     }
                     else
                     {
                         params[@"是否注册成功"] = @"否";
                         //此处需要再处理下
                         [SVProgressHUD showErrorWithStatus:user.apiMessage duration:DURATION_SHORT];
                     }
                    
                     self.registerButton.enabled = YES;
                 }
                 failure:^(HttpException *e){
                     self.registerButton.enabled = YES;
                 }];
}

// 跳转完善资料
- (void) gotoPerfectInfoVC
{
    PerfectInformationViewController* perfectInfoVC = [[PerfectInformationViewController alloc] init];
    perfectInfoVC.needBacktoNaviRootVC = YES;
    [self.navigationController pushViewController:perfectInfoVC animated:YES];
}

#pragma mark - UI构造
- (void)layerButton{
    
    self.registerButton.layer.masksToBounds = YES;
    self.registerButton.layer.cornerRadius = 4.0f;
    self.codeLabel.layer.masksToBounds = YES;
    self.codeLabel.layer.cornerRadius = 4.0f;
    
    self.leftLaytout.constant = (APP_W - 295)/2;
    [self.eyeImage setImage:[UIImage imageNamed:@"icon_login_on"]];
//    [self.eyeImage setBackgroundColor:[UIColor greenColor]];
    
}

#pragma mark - 显示/隐藏密码
- (void)showPW:(id)sender {
    
    DDLogVerbose(@"显示/隐藏密码");
    [self.passWordField resignFirstResponder];
//    self.eyeImage.image
    if (self.isShowPWD) {
        [self.passWordField setSecureTextEntry:YES];
        self.isShowPWD = NO;
        [self.eyeImage setImage:[UIImage imageNamed:@"icon_login_on"]];
        [self.passWordField setNeedsDisplay];
    } else {
        [self.passWordField setSecureTextEntry:NO];
        [self.eyeImage setImage:[UIImage imageNamed:@"login_icon_eye_click"]];
        self.isShowPWD = YES;
        [self.passWordField setNeedsDisplay];
    }

    
}


- (void)layerField:(UIView *)view{
    
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 4.0f;
    view.layer.borderWidth = 0.5f;
    view.layer.borderColor = RGBHex(qwColor10).CGColor;
}

//- (void)layerErrorField:(UITextField *)field error:(BOOL)flag{
//    
//    if(flag){
//        field.layer.borderColor = RGBHex(qwColor10).CGColor;
//    }else{
//        field.layer.borderColor = RGBHex(qwColor3).CGColor;
//    }
//}

#pragma mark - 接收验证码定时器通知
- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj
{
    if(type == NotiCountDonwRegister) {
        [self reGetVerifyCodeControl:[data integerValue]];
    }
}

#pragma mark - 计时器执行方法
- (void)reGetVerifyCodeControl:(NSInteger)count
{
    if (count == 0) {
        self.CodeButton.userInteractionEnabled = YES;
        [self.codeLabel setBackgroundColor:RGBHex(qwColor1)];
        self.codeLabel.text = @"获取验证码";
    }else{
        self.CodeButton.userInteractionEnabled = NO;
        [self.codeLabel setBackgroundColor:RGBHex(qwColor9)];
        self.codeLabel.text = [NSString stringWithFormat:@"重新发送(%d)",count];
    }
}

#pragma mark - 服务条款点击状态
- (void)selectedButtonClick{
    
    if (self.conformButton.selected) {
        [self.conformButton setSelected:NO];
        [self.conformButton setImage:[UIImage imageNamed:@"icon_login_selected"] forState:UIControlStateNormal];
    }else{
        [self.conformButton setSelected:YES];
        [self.conformButton setImage:[UIImage imageNamed:@"icon_login_rest"] forState:UIControlStateNormal];
    }
}

#pragma mark - 用户协议
- (void)serveInformationClick:(id)sender{
    
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [SVProgressHUD showErrorWithStatus:@"网络未连接，请重试" duration:0.8f];
        return;
    }
    ServeInfoViewController * serverInfo = [[ServeInfoViewController alloc] init];
    serverInfo.webRequestType = WebRequestTypeServeClauses;
    [self.navigationController pushViewController:serverInfo animated:YES];
}
@end
