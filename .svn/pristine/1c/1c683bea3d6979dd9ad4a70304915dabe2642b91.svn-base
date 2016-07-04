//
//  EnrollVerifyCodeViewController.m
//  APP
//
//  接口：
//  1./h5/mbr/code/validVerifyCodeOnly4check        验证码校验 <- 不消耗验证码
//  该页面视图特别说明
//  由一个“透明的”文本输入框来控制键盘输入， 4个文本标签每一个来展示其中的一位验证码
//  Created by Martin.Liu on 16/4/21.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "EnrollVerifyCodeViewController.h"
#import "EnrollSetPasswordViewController.h"
#import "Mbr.h"
#import "SVProgressHUD.h"
@interface EnrollVerifyCodeViewController ()
@property (strong, nonatomic) IBOutlet UILabel *tipLabel;   // “验证码短信已发送至”
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel; // 手机号信息

@property (strong, nonatomic) IBOutlet UIView *codeView;
@property (strong, nonatomic) IBOutlet UILabel *code1Label;     // 第一个文本标签，展示第一个验证码
@property (strong, nonatomic) IBOutlet UILabel *code2Label;     // 第二个文本标签，展示第二个验证码
@property (strong, nonatomic) IBOutlet UILabel *code3Label;     // 第三个文本标签，展示第三个验证码
@property (strong, nonatomic) IBOutlet UILabel *code4Label;     // 第四个文本标签，展示第四个验证码
@property (strong, nonatomic) IBOutlet UITextField *codeTF;     // “隐藏”的文本输入框
@property (strong, nonatomic) IBOutlet UILabel *codeTFPlaceHolderLabel;

@property (strong, nonatomic) UIButton *backButton;
@property (nonatomic, strong) UIButton* leftBtn;
@property (nonatomic, strong) UILabel* countDownLabel;
@end

@implementation EnrollVerifyCodeViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"注册";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.phoneNumber.length > 7) {
        self.phoneLabel.text = [[self.phoneNumber stringByReplacingCharactersInRange:NSMakeRange(7, 0) withString:@" "] stringByReplacingCharactersInRange:NSMakeRange(3, 0) withString:@" "];
    }

    // 设置光标颜色为透明
    self.codeTF.tintColor = [UIColor clearColor];
    // 默认弹出键盘
    [self.codeTF becomeFirstResponder];
    // 设置代理，在代理方法里面限制只可输入4个长度
    self.codeTF.delegate = self;
    // 监测文本输入框的变化来控制4个标签的展示， 并在输入完成4个长度的时候做监测操作，如果监测成功跳到下个设置密码页面
    [self.codeTF addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
    // 增加点击空白处，隐藏键盘的手势
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignTFS:)];
    [self.view addGestureRecognizer:tapGesture];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setLeftItem];
    // 获取全局的验证码时间片，并对应显示按钮内容
    if(QWGLOBALMANAGER.getVerifyTimer) {
        NSMutableDictionary *userInfo = QWGLOBALMANAGER.getVerifyTimer.userInfo;
        NSInteger countDonw = [userInfo[@"countDown"] integerValue];
        self.leftBtn.enabled = NO;
        self.countDownLabel.text = [NSString stringWithFormat:@"%lds 后重新获取",(long)countDonw];
    }else{
        self.leftBtn.enabled = YES;
        self.countDownLabel.text = @"重新获取";
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 如果从下一个设置密码的页面返回，置空验证码输入框以及展示的label
    self.codeTF.text = nil;
    [self changedTextField:self.codeTF];
}

- (void)resignTFS:(UITapGestureRecognizer*)tapGesture
{
    [self.view endEditing:YES];
}

- (void)UIGlobal
{
    self.view.backgroundColor = RGBHex(qwColor11);
    self.codeTF.font = [UIFont systemFontOfSize:kFontS5];
}

#pragma UITextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length != 0 && textField.text.length >= 4) {
        return NO;
    }
    return YES;
}

#pragma mark - 监测文本输入框的变化来控制4个标签的展示， 并在输入完成4个长度的时候做监测操作，如果监测成功跳到下个设置密码页面
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
        {
            self.code1Label.text = [text substringWithRange:NSMakeRange(0, 1)];
            self.code2Label.text = [text substringWithRange:NSMakeRange(1, 1)];
            self.code3Label.text = [text substringWithRange:NSMakeRange(2, 1)];
            self.code4Label.text = [text substringWithRange:NSMakeRange(3, 1)];
            
            // 隐藏键盘
            [self.view endEditing:YES];
            
            NSDictionary* param = @{@"mobile":self.phoneNumber,
                                    @"code":text,
                                    @"type":@"1"};
            [Mbr checkVerifyCodeValidWithPrams:param success:^(BaseAPIModel *apiModel) {
                if ([apiModel.apiStatus integerValue] == 0) {
                    EnrollSetPasswordViewController* enrollSetPasswordVC = [[EnrollSetPasswordViewController alloc] init];
                    enrollSetPasswordVC.phoneNumber = self.phoneNumber;
                    enrollSetPasswordVC.verifyCode = text;
                    enrollSetPasswordVC.isPresentType = self.isPresentType;
                    enrollSetPasswordVC.needVerifyFullInfo = self.needVerifyFullInfo;
                    enrollSetPasswordVC.passTokenBlock = self.passTokenBlock;
                    [self.navigationController pushViewController:enrollSetPasswordVC animated:YES];
                }
                else
                {
                    self.codeTF.text = nil;
                    [self changedTextField:self.codeTF];
                    [SVProgressHUD showErrorWithStatus:StrDFString(apiModel.apiMessage, @"验证码错误，请重新输入！") duration:DURATION_LONG];
                }
            } failure:^(HttpException *e) {
                ;
            }];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - 获取通知 获取验证码倒计时通知，刷新左上角倒计时按钮展示
- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj
{
    if (type == NotiCountDonwRegister) {
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
}

@end
