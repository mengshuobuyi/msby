//
//  EnrollSetPasswordViewController.m
//  APP
//
//  接口：
//  1.api/mbr/user/register             用户注册
//  2.api/mbr/user/login                登录
//  Created by Martin.Liu on 16/4/15.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "EnrollSetPasswordViewController.h"
#import "PerfectInformationViewController.h"
#import "SVProgressHUD.h"
#import "Mbr.h"
@interface EnrollSetPasswordViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *passwordView;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UIButton *eyeBtn;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;

- (IBAction)eyeBtnAction:(UIButton *)sender;
- (IBAction)submitBtnAction:(id)sender;

@end

@implementation EnrollSetPasswordViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"注册";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 监测密码输入框变化
    [self.passwordTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
    self.passwordTF.delegate = self;
    [self textFieldChanged:self.passwordTF];
}

- (void)UIGlobal
{
    self.view.backgroundColor = RGBHex(qwColor11);
    self.submitBtn.layer.masksToBounds = YES;
    self.submitBtn.layer.cornerRadius = 4.0f;
    self.passwordView.layer.masksToBounds = YES;
    self.passwordView.layer.cornerRadius = 4.0f;
    self.passwordView.layer.borderWidth = 0.5f;
    self.passwordView.layer.borderColor = RGBHex(qwColor10).CGColor;
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.passwordTF && textField.text.length >= 16) {
        return NO;
    }
    return YES;
}

#pragma mark 密码文本框改变
- (void)textFieldChanged:(UITextField*)textField
{
    if (textField == self.passwordTF) {
        if ([self checkValid]) {
            self.submitBtn.enabled = YES;
            self.submitBtn.backgroundColor = RGBHex(qwColor2);
        }
        else
        {
            self.submitBtn.enabled = NO;
            self.submitBtn.backgroundColor = RGBHex(qwColor9);
        }
    }
}

// 密码要求需要6-16个字符之间
- (BOOL) checkValid
{
    return self.passwordTF.text.length >= 6 && self.passwordTF.text.length <= 16;
}

// 密码是否明文可见
- (IBAction)eyeBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.passwordTF.secureTextEntry = !sender.selected;
}

- (IBAction)submitBtnAction:(id)sender {
    [QWGLOBALMANAGER statisticsEventId:@"x_zc_dlbzc" withLable:@"注册-登录并注册" withParams:nil];
    
    if (![self checkValid]) {
        [SVProgressHUD showErrorWithStatus:@"请输入6-16位数字或字母密码" duration:DURATION_SHORT];
        return;
    }
    
    // 检测密码简单性
    if ([@"123456" isEqualToString:self.passwordTF.text]) {
        [SVProgressHUD showErrorWithStatus:kWarning30001];
        return;
    }
    
    [self.view endEditing:YES];
    self.submitBtn.enabled = NO;
    
    MapInfoModel *mapModel = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
    MbrRegisterR *modelR = [MbrRegisterR new];
    modelR.mobile = self.phoneNumber;
    modelR.password = self.passwordTF.text;
    modelR.code = self.verifyCode;
    modelR.device = DEVICE_ID;
    modelR.deviceType = IOS_DEVICE;
    BOOL locationSucces = [QWUserDefault getBoolBy:kLocationSuccess];
    if (locationSucces) {
        modelR.city = mapModel.city;
    }else
    {
        modelR.city = @"";
    }
    modelR.credentials=[AESUtil encryptAESData:self.passwordTF.text app_key:AES_KEY];
    [Mbr mbrRegisterParams:modelR success:^(id obj) {
        
        if ([obj[@"apiStatus"] integerValue] == 0) {
            
            if([QWGLOBALMANAGER.registerAccount isEqualToString:self.phoneNumber]){
                QWGLOBALMANAGER.registerAccount = nil;
            }
            [QWUserDefault setString:self.phoneNumber key:APP_USERNAME_KEY];
            //逻辑需确认！！！
            [QWGLOBALMANAGER saveOperateLog:@"1"];
            [TalkingDataAppCpa onRegister:obj[@"passportId"]];
            mbrLogin *param=[mbrLogin new];
            param.account       = self.phoneNumber;
            param.password      = self.passwordTF.text;
            param.device        = IOS_DEVICE;
            param.deviceCode    = DEVICE_ID;
            param.pushDeviceCode= QWGLOBALMANAGER.deviceToken;
            param.credentials=[AESUtil encryptAESData:self.passwordTF.text app_key:AES_KEY];
            [self loginWith:param];
        }else{
            if([obj[@"apiStatus"] integerValue] == 4){
                [SVProgressHUD showErrorWithStatus:@"验证码错误" duration:0.8];
            }else{
                [SVProgressHUD showErrorWithStatus:obj[@"apiMessage"] duration:0.8];
            }
            self.submitBtn.enabled = YES;
        }
        
    } failure:^(HttpException *e) {
        self.submitBtn.enabled = YES;
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
                                 [self.navigationController popToRootViewControllerAnimated:YES];
                         }
                     }
                     else
                     {
                         params[@"是否注册成功"] = @"否";
                         //此处需要再处理下
                         [SVProgressHUD showErrorWithStatus:user.apiMessage duration:DURATION_SHORT];
                     }
                     
                     self.submitBtn.enabled = YES;
                 }
                 failure:^(HttpException *e){
                     self.submitBtn.enabled = YES;
                 }];
}

// 跳转完善资料
- (void) gotoPerfectInfoVC
{
    PerfectInformationViewController* perfectInfoVC = [[PerfectInformationViewController alloc] init];
    perfectInfoVC.needBacktoNaviRootVC = YES;
    [self.navigationController pushViewController:perfectInfoVC animated:YES];
}



@end
