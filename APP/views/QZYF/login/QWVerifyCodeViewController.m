//
//  QWVerifyCodeViewController.m
//  APP
//
//  Created by Martin.Liu on 16/4/15.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "QWVerifyCodeViewController.h"
#import "ConstraintsUtility.h"
#import "SVProgressHUD.h"
#import "Mbr.h"
@interface QWVerifyCodeViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *tipLabel;   // “验证码短信已发送至”
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel; // 手机号信息

@property (strong, nonatomic) IBOutlet UIView *codeView;
@property (strong, nonatomic) IBOutlet UILabel *code1Label;
@property (strong, nonatomic) IBOutlet UILabel *code2Label;
@property (strong, nonatomic) IBOutlet UILabel *code3Label;
@property (strong, nonatomic) IBOutlet UILabel *code4Label;
@property (strong, nonatomic) IBOutlet UITextField *codeTF;
@property (strong, nonatomic) IBOutlet UILabel *codeTFPlaceHolderLabel;

// 语音验证码
@property (strong, nonatomic) IBOutlet UIView *voiceVerifyCodeContainerView;
@property (strong, nonatomic) IBOutlet UIView *voiceVerifyCodeView1;
@property (strong, nonatomic) IBOutlet UILabel *voiceVerifyTip1;
@property (strong, nonatomic) IBOutlet UIButton *voiceVerifyBtn1;

@property (strong, nonatomic) IBOutlet UIView *voiceVerifyCodeView2;
@property (strong, nonatomic) IBOutlet UILabel *voiceVerifyTip2;
@property (strong, nonatomic) IBOutlet UIButton *voiceVerifyBtn2;

@property (strong, nonatomic) UIButton *backButton;
@property (nonatomic, strong) UIButton* leftBtn;
@property (nonatomic, strong) UILabel* countDownLabel;

@end

@implementation QWVerifyCodeViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
//        self.title = @"无密码登录";
    }
    return self;
}

#pragma mark ---- 设置左侧按钮 ----
- (void)setLeftItem
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 130, 44)];
    bgView.backgroundColor = [UIColor clearColor];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(0, 0, 30, 44);
    [self.backButton setImage:[UIImage imageNamed:@"nav_btn_back"] forState:UIControlStateNormal];
    [self.backButton setImage:[UIImage imageNamed:@"nav_btn_back_sel"] forState:UIControlStateHighlighted];
    [self.backButton setImage:[UIImage imageNamed:@"nav_btn_back_sel"] forState:UIControlStateSelected];
    [self.backButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    
    [self.backButton addTarget:self action:@selector(popVCAction:) forControlEvents:UIControlEventTouchUpInside];
    self.backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.backButton.backgroundColor=[UIColor clearColor];
    [bgView addSubview:self.backButton];
    
    
    self.countDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 100, 44)];
    self.countDownLabel.textColor = [UIColor whiteColor];
    self.countDownLabel.font = [UIFont systemFontOfSize:13];
    self.countDownLabel.backgroundColor = [UIColor clearColor];
    [bgView addSubview:self.countDownLabel];
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(30, 0, 100, 44);
    [self.leftBtn addTarget:self action:@selector(popVCAction:) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.leftBtn.backgroundColor=[UIColor clearColor];
    [bgView addSubview:self.leftBtn];
    
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width = -13;
    UIBarButtonItem* btnItem = [[UIBarButtonItem alloc] initWithCustomView:bgView];
    self.navigationItem.leftBarButtonItems = @[fixed,btnItem];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    if (self.phoneNumber.length >= 7) {
//        self.tipLabel.text = [NSString stringWithFormat:@"验证码短信已发送至 %@", [self.phoneNumber stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"xxxx"]];
//    }
//    else
//        self.tipLabel.text = [NSString stringWithFormat:@"验证码短信已发送至 %@", StrDFString(self.phoneNumber, @"1xxxxxxxxxxxx")];
    
//    self.tipLabel.text = [NSString stringWithFormat:@"验证码短信已发送至 %@", StrDFString(self.phoneNumber, @"1xxxxxxxxxxxx")];

    if (self.phoneNumber.length > 7) {
        self.phoneLabel.text = [[self.phoneNumber stringByReplacingCharactersInRange:NSMakeRange(7, 0) withString:@" "] stringByReplacingCharactersInRange:NSMakeRange(3, 0) withString:@" "];
    }
    
    self.codeTF.tintColor = [UIColor clearColor];
    [self.codeTF becomeFirstResponder];
    self.codeTF.delegate = self;
    [self.codeTF addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignTFS:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setLeftItem];
    
    if(QWGLOBALMANAGER.getValidCodeLoginTimer) {
        NSMutableDictionary *userInfo = QWGLOBALMANAGER.getValidCodeLoginTimer.userInfo;
        NSInteger countDonw = [userInfo[@"countDown"] integerValue];
        self.leftBtn.enabled = NO;
        self.countDownLabel.text = [NSString stringWithFormat:@"%lds 后重新获取",(long)countDonw];
    }else{
        self.leftBtn.enabled = YES;
        self.countDownLabel.text = @"重新获取";
    }
}

- (void)popVCAction:(id)sender
{
    [super popVCAction:sender];
}

- (void)resignTFS:(UITapGestureRecognizer*)tapGesture
{
    [self.view endEditing:YES];
}


- (void)UIGlobal
{
    self.view.backgroundColor = RGBHex(qwColor11);
    self.codeTF.font = [UIFont systemFontOfSize:kFontS5];
    
    self.voiceVerifyTip1.font = [UIFont systemFontOfSize:kFontS4];
    self.voiceVerifyTip1.textColor = RGBHex(qwColor8);
    
    self.voiceVerifyTip2.font = [UIFont systemFontOfSize:kFontS4];
    self.voiceVerifyTip2.textColor = RGBHex(qwColor8);
    
    // 语音验证
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
    
    if (self.hasVoiceValid) {
        self.voiceVerifyCodeView1.hidden = NO;
        self.voiceVerifyCodeView2.hidden = YES;
    }
    else
    {
        self.voiceVerifyCodeView1.hidden = NO;
        self.voiceVerifyCodeView2.hidden = NO;
    }
}

#pragma UITextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length != 0 && textField.text.length >= 4) {
        return NO;
    }
    return YES;
}

- (void)changedTextField:(UITextField*)textField
{
    NSString* text = textField.text;
    self.codeTFPlaceHolderLabel.hidden = !StrIsEmpty(text);
    switch (text.length) {
        case 0:
            self.code1Label.text = nil;
            self.code2Label.text = nil;
            self.code3Label.text = nil;
            self.code4Label.text = nil;
            break;
        case 1:
            self.code1Label.text = [text substringWithRange:NSMakeRange(0, 1)];
            self.code2Label.text = nil;
            self.code3Label.text = nil;
            self.code4Label.text = nil;
            break;
        case 2:
            self.code1Label.text = [text substringWithRange:NSMakeRange(0, 1)];
            self.code2Label.text = [text substringWithRange:NSMakeRange(1, 1)];
            self.code3Label.text = nil;
            self.code4Label.text = nil;
            break;
        case 3:
            self.code1Label.text = [text substringWithRange:NSMakeRange(0, 1)];
            self.code2Label.text = [text substringWithRange:NSMakeRange(1, 1)];
            self.code3Label.text = [text substringWithRange:NSMakeRange(2, 1)];
            self.code4Label.text = nil;
            break;
        case 4:
            self.code1Label.text = [text substringWithRange:NSMakeRange(0, 1)];
            self.code2Label.text = [text substringWithRange:NSMakeRange(1, 1)];
            self.code3Label.text = [text substringWithRange:NSMakeRange(2, 1)];
            self.code4Label.text = [text substringWithRange:NSMakeRange(3, 1)];
            if (self.verifyCodeBlock) {
                // 隐藏键盘
                [self.view endEditing:YES];
                self.verifyCodeBlock(text);
            }
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getVerifyVoiceCodeBtnClick:(id)sender {
    if ([QWGLOBALMANAGER isPhoneNumber:self.phoneNumber]) {
        // 不需要倒计时了
        //        [QWGLOBALMANAGER startVoiceValidCodeToLogin:self.mobileTF.text];
        if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
            [SVProgressHUD showErrorWithStatus:@"网络未连接，请重试" duration:0.8];
            return;
        }
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"mobile"] = self.phoneNumber;
        param[@"type"] = @"9";
        
        [Mbr sendVoiceVerifyCodeWithParams:param success:^(id resultObj){
            BaseAPIModel* apiModel = resultObj;
            if ([apiModel.apiStatus intValue] == 0){
                [self reGetVerifyVoiceCodeView:1];  // 1 不是倒计时，相当于一个YES标志
            }
            else{
                [SVProgressHUD showErrorWithStatus:StrDFString(apiModel.apiMessage, @"获取语音验证码失败！") duration:DURATION_LONG];
            }
            
        }failure:^(HttpException *e){
            [SVProgressHUD showErrorWithStatus:e.Edescription duration:DURATION_SHORT];
        }];
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

- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj
{
    if (type == NotiCountDonwValidCodeLogin) {
        if ([data integerValue] <= 0) {
            self.leftBtn.enabled = YES;
            self.countDownLabel.text = @"重新获取";
        }
        else
        {
            self.leftBtn.enabled = NO;
            self.countDownLabel.text = [NSString stringWithFormat:@"%lds 后重新获取",(long)[data integerValue]];
        }
        
    }
    else if (type == NotifMobileLoginFailed)
    {
        // 无密码登录失败
        self.codeTF.text = nil;
        [self changedTextField:self.codeTF];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
