//
//  ChangePhoneNumberViewController.m
//  wenyao
//
//  Created by Meng on 14-9-30.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//


/**
 *  未处理的对象
 */

#import "ChangePhoneNumberViewController.h"
#import "SVProgressHUD.h"
#import "LoginViewController.h"
#import "QWGlobalManager.h"
#import "Mbr.h"
#import "QWProgressHUD.h"
#import "AppDelegate.h"
#define BINDPHONE_ALERTWARNING

@interface ChangePhoneNumberViewController ()<UIAlertViewDelegate>
{
    NSTimer *_reGetVerifyTimer;
    BOOL hasShowBindWarning;    // 绑定手机号时，如果手机号被绑定，会跳出一个提示，该字段为了标志是否已经弹出提示
}
@property (nonatomic,strong)NSTimer *reGetVerifyTimer;

@property (strong, nonatomic) IBOutlet UIView *mobileTFContainerView;
@property (strong, nonatomic) IBOutlet UITextField *mobileTF;
@property (strong, nonatomic) IBOutlet UIButton *getVerifyCodeBtn;
@property (strong, nonatomic) IBOutlet UIView *verifyTFContainerView;
@property (strong, nonatomic) IBOutlet UITextField *verifyTF;

@property (strong, nonatomic) IBOutlet UILabel *tipLabel;
@property (strong, nonatomic) IBOutlet UILabel *tip2Label;


@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) IBOutlet UIButton *unBindBtn;

- (IBAction)getVerifyCodeBtnClick:(id)sender;
- (IBAction)submitBtnClick:(id)sender;
- (IBAction)unBindBtnClick:(id)sender;




@end

@implementation ChangePhoneNumberViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"修改手机号";
//        if (iOSv7 && self.view.frame.origin.y==0) {
//            self.edgesForExtendedLayout = UIRectEdgeNone;
//            self.extendedLayoutIncludesOpaqueBars = NO;
//            self.modalPresentationCapturesStatusBarAppearance = NO;
//        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.mobileTF addTarget:self action:@selector(textFiledChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.verifyTF addTarget:self action:@selector(textFiledChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)UIGlobal
{
    self.view.backgroundColor = RGBHex(qwColor11);
    switch (self.changePhoneType) {
        case ChangePhoneType_ChangePhoneNumber:
            self.title = @"修改手机号";
            self.tipLabel.text = @"温馨提示：修改手机号后，账号将于原手机号解绑";
            [self.submitBtn setTitle:@"确认修改" forState:UIControlStateNormal];
            self.unBindBtn.hidden = YES;
            self.tip2Label.hidden = YES;
            break;
        case ChangePhoneType_BindPhoneNumber:
            self.title = @"绑定手机号";
            self.tipLabel.text = nil;
            [self.submitBtn setTitle:@"绑定" forState:UIControlStateNormal];
            self.unBindBtn.hidden = NO;
            self.tip2Label.hidden = NO;
            break;
        default:
            break;
    }
    
    // 如果是第一次第三方登录，需要绑定手机，返回要跳回navi的rootVC
    if (self.isNeedPopToRootVC) {
//        self.tip2Label.hidden = NO;
    }
    else
    {
//        self.tip2Label.hidden = YES;
        self.unBindBtn.hidden = YES;
    }
    
    
    UIColor* borderColor = RGBHex(qwColor10);
    CGFloat cornerRadius = 4;
    CGFloat borderWidth = 1.f / [[UIScreen mainScreen] scale];
    
    // 边框样式
    self.mobileTFContainerView.layer.masksToBounds = YES;
    self.mobileTFContainerView.layer.cornerRadius = cornerRadius;
    self.mobileTFContainerView.layer.borderWidth = borderWidth;
    self.mobileTFContainerView.layer.borderColor = borderColor.CGColor;
    
    self.verifyTFContainerView.layer.masksToBounds = YES;
    self.verifyTFContainerView.layer.cornerRadius = cornerRadius;
    self.verifyTFContainerView.layer.borderWidth = borderWidth;
    self.verifyTFContainerView.layer.borderColor = borderColor.CGColor;
    
    self.getVerifyCodeBtn.layer.masksToBounds = YES;
    self.getVerifyCodeBtn.layer.cornerRadius = cornerRadius;
    
    self.submitBtn.layer.masksToBounds = YES;
    self.submitBtn.layer.cornerRadius = cornerRadius;
    
    // 背景色
    self.getVerifyCodeBtn.backgroundColor = RGBHex(qwColor1);
    self.submitBtn.backgroundColor = RGBHex(qwColor9);
    self.submitBtn.enabled = NO;
    
    // 文字颜色 文字大小
    self.mobileTF.font = [UIFont systemFontOfSize:kFontS1];
    self.mobileTF.textColor = RGBHex(qwColor6);
    
    self.verifyTF.font = [UIFont systemFontOfSize:kFontS1];
    self.verifyTF.textColor = RGBHex(qwColor6);
    
    [self.getVerifyCodeBtn setTitleColor:RGBHex(qwColor4) forState:UIControlStateNormal];
    [self.getVerifyCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:kFontS4]];
    
    self.tipLabel.textColor = RGBHex(qwColor8);
    self.tipLabel.font = [UIFont systemFontOfSize:kFontS5];
    
    self.tip2Label.textColor = RGBHex(qwColor8);
    self.tip2Label.font = [UIFont systemFontOfSize:kFontS5];
    
    [self.submitBtn setTitleColor:RGBHex(qwColor4) forState:UIControlStateNormal];
    [self.submitBtn.titleLabel setFont:[UIFont systemFontOfSize:kFontS3]];
    
    
    [self.unBindBtn setTitleColor:RGBHex(qwColor2) forState:UIControlStateNormal];
    [self.unBindBtn.titleLabel setFont:[UIFont systemFontOfSize:kFontS5]];
    
}

- (void)textFiledChanged:(id)sender
{
    if (!StrIsEmpty(self.mobileTF.text) && !StrIsEmpty(self.verifyTF.text)) {
        self.submitBtn.enabled = YES;
        [UIView animateWithDuration:0.3 animations:^{
            self.submitBtn.backgroundColor = RGBHex(qwColor2);
        }];
    }
    else
    {
        self.submitBtn.enabled = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.submitBtn.backgroundColor = RGBHex(qwColor9);
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(QWGLOBALMANAGER.getChangePhoneTimer) {
        NSMutableDictionary *userInfo = QWGLOBALMANAGER.getChangePhoneTimer.userInfo;
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
    ((QWBaseNavigationController *)self.navigationController).canDragBack = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    ((QWBaseNavigationController *)self.navigationController).canDragBack = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerUser
{
//  校验手机号是否注册过
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"mobile"] = self.mobileTF.text;
    [Mbr registerValidWithParams:param success:^(id obj){
        
        BaseAPIModel *model = [BaseAPIModel parse:obj];
        if([model.apiStatus intValue] == 1 || [model.apiStatus intValue] == 2){
            [SVProgressHUD showErrorWithStatus:model.apiMessage duration:DURATION_SHORT];
        }else{
            [QWGLOBALMANAGER startChangePhoneVerifyCode:self.mobileTF.text];
        }
    }failure:^(HttpException *e){
  //      if(e.Edescription && ![e.Edescription isEqualToString:@""]){
        if (!StrIsEmpty(e.Edescription)) {
            [SVProgressHUD showErrorWithStatus:e.Edescription duration:DURATION_SHORT];
        }else{
            [SVProgressHUD showErrorWithStatus:@"手机号已经被注册" duration:DURATION_SHORT];
        }
    }];
}

//计时器执行方法
- (void)reGetVerifyCodeControl:(NSUInteger)count
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

- (void)updateInfomation
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"token"] = QWGLOBALMANAGER.configure.userToken;
    param[@"newMobile"] = self.mobileTF.text;
    param[@"code"] = self.verifyTF.text;
    // 需求增加： 第三方登录 绑定手机号修改手机号的接口 传参 type 传 11 否则传3
    if (QWGLOBALMANAGER.configure.isThirdLogin) {
        param[@"type"] = @"11";
    }
    else
        param[@"type"] = @"3";
    
    [Mbr changeMobileWithParams:param success:^(id responseObj){
        
        BaseAPIModel *model = [BaseAPIModel parse:responseObj];
        
        if([model.apiStatus intValue] == 0){
            // 重置获取验证码倒计时
            [QWGLOBALMANAGER.getChangePhoneTimer invalidate];
            QWGLOBALMANAGER.getChangePhoneTimer = nil;
            // 绑定手机逻辑
            NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
            tdParams[@"用户等级"]=StrFromInt([QWGlobalManager sharedInstance].configure.mbrLvl);
            [QWGLOBALMANAGER statisticsEventId:@"x_jfrw_bdsjh_bd" withLable:@"积分" withParams:tdParams];
            
            if (self.changePhoneType == ChangePhoneType_BindPhoneNumber) {
//                [SVProgressHUD showSuccessWithStatus:@"手机号绑定成功" duration:DURATION_SHORT];
                if ([responseObj[@"taskChanged"] boolValue]) {
                    [QWProgressHUD showSuccessWithStatus:@"绑定成功!" hintString:[NSString stringWithFormat:@"+%ld", [QWGLOBALMANAGER rewardScoreWithTaskKey:@"BIND"]] duration:DURATION_CREDITREWORD];
                }
                else
                {
                    [SVProgressHUD showSuccessWithStatus:@"手机号绑定成功" duration:DURATION_SHORT];
                }
                
                QWGLOBALMANAGER.configure.mobile = self.mobileTF.text;
                [QWGLOBALMANAGER saveAppConfigure];
                [self popVCAction:nil];
                return;
            }
            // 修改手机逻辑
            [SVProgressHUD showSuccessWithStatus:@"手机号修改成功" duration:DURATION_SHORT];
            [QWGLOBALMANAGER clearAccountInformation];
            
            LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
            loginViewController.isPresentType = YES;
            [APPDelegate.mainVC presentViewController:navgationController animated:YES completion:^{
                [self.navigationController popToRootViewControllerAnimated:NO];
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:model.apiMessage duration:DURATION_SHORT];
        }
        
    } failure:^(HttpException *e) {
        
    }];
}

- (void)checkBindPhoneNumber
{
    NSDictionary* param = @{@"mobile":self.mobileTF.text,
                            @"token":QWGLOBALMANAGER.configure.userToken};
    [Mbr checkBindPhoneNumberValidWithParams:param success:^(id DFUserModel) {
        BaseAPIModel *model = [BaseAPIModel parse:DFUserModel];
        NSString *hasBind;
        if([model.apiStatus intValue] == 0){
            hasBind = @"已绑定";
            [self updateInfomation];
        }else if([model.apiStatus intValue] == 3)
        {
            hasBind = @"未绑定";
#ifdef BINDPHONE_ALERTWARNING
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:kWarning22301 delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            alertView.tag = 1001;
            [alertView show];
#else
            if (hasShowBindWarning) {
                [self updateInfomation];
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:kWarning22301 duration:5];
                hasShowBindWarning = YES;
            }
#endif
            
        }
        else
        {
             hasBind = @"未绑定";
            [SVProgressHUD showErrorWithStatus:model.apiMessage duration:DURATION_SHORT];
        }
//        NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
//        tdParams[@"是否绑定"]=hasBind;
//        [QWGLOBALMANAGER statisticsEventId:@"x_sz_bdsjh" withLable:@"绑定手机号" withParams:tdParams];
    } failure:^(HttpException *e) {
        
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1001) {
        if (buttonIndex == 1) {
            [self updateInfomation];
        }
        else if (buttonIndex == 0)
        {
            [self.view endEditing:YES];
            [self popVCAction:nil];
        }
    }
    else
    {
        if (buttonIndex == 0) {
            LoginViewController * login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            login.isPresentType = YES;
            login.parentNavgationController = self.navigationController;
            UINavigationController * nav = [[QWBaseNavigationController alloc] initWithRootViewController:login];
            [self presentViewController:nav animated:YES completion:nil];
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.mobileTF resignFirstResponder];
    [self.verifyTF resignFirstResponder];
}

- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj
{
    if(type == NotiCountDonwChangePhone) {
        [self reGetVerifyCodeControl:[data integerValue]];
    }
}

- (IBAction)getVerifyCodeBtnClick:(id)sender {
    if (StrIsEmpty(self.mobileTF.text))
    {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号" duration:1];
    }
    else if (![GLOBALMANAGER isPhoneNumber:self.mobileTF.text])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号" duration:1];
    }
    else
    {
        // 绑定手机和修改手机在获取验证码的时候不需要检测此手机时候已经注册了
        [QWGLOBALMANAGER startChangePhoneVerifyCode:self.mobileTF.text];
//        if (self.changePhoneType == ChangePhoneType_BindPhoneNumber) {
//            [QWGLOBALMANAGER startChangePhoneVerifyCode:self.mobileTF.text];
//        }
//        else
//        {
//            [self performSelectorOnMainThread:@selector(registerUser) withObject:nil waitUntilDone:YES];
//        }
    }
}

- (IBAction)submitBtnClick:(id)sender {
    if (StrIsEmpty(self.mobileTF.text))
    {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号" duration:1];
        return;
    }
    if (![GLOBALMANAGER isPhoneNumber:self.mobileTF.text])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号" duration:1];
        return;
    }
    if (StrIsEmpty(self.verifyTF.text)) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码" duration:1];
        return;
    }
    // 绑定手机和修改手机都需要验证手机是否已经被绑定了。
    [self checkBindPhoneNumber];
    
//    if (self.changePhoneType == ChangePhoneType_BindPhoneNumber) {
//        [self checkBindPhoneNumber];
//    }
//    else
//    {
//        [self updateInfomation];
//    }
}

- (void)popVCAction:(id)sender
{
    
    if (self.changePhoneType == ChangePhoneType_BindPhoneNumber) {
        if(self.isPresentType){
            [self dismissViewControllerAnimated:YES completion:NULL];
        }else{
            if (self.isNeedPopToRootVC) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
    else
    {
        [super popVCAction:sender];
    }
    if(self.extCallBack) {
        self.extCallBack(YES);
    }
}

- (IBAction)unBindBtnClick:(id)sender {
    [self popVCAction:nil];
}
@end
