//
//  FeedbackViewController.m
//  APP
//
//  Created by qwfy0006 on 15/3/16.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "FeedbackViewController.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "FeedBackModelR.h"
#import "FeedBack.h"

@interface FeedbackViewController ()<UITextViewDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UILabel *placeholder;


@property (weak, nonatomic) IBOutlet UILabel *limitWord;


@property (weak, nonatomic) IBOutlet UITextField *QQTextField;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *anchorHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewLeadingConstraint;



@property (weak, nonatomic) IBOutlet UIButton *QQButton;

- (IBAction)QQButtonClick:(id)sender;

@end

@implementation FeedbackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"意见反馈";
        if (iOSv7 && self.view.frame.origin.y==0) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
        }
        
        UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleBordered target:self action:@selector(rightButtonClick)];
        self.navigationItem.rightBarButtonItem = rightButton;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textView.delegate = self;
    UITapGestureRecognizer *tapReco = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
//    [self.scrollView addGestureRecognizer:tapReco];
    [self.contentView addGestureRecognizer:tapReco];
    self.placeholder.textColor = RGBHex(qwColor9);
    self.placeholder.font = fontSystem(kFontS4);
    self.limitWord.textColor = RGBHex(qwColor9);
    self.limitWord.font = fontSystem(kFontS5);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.anchorHeightConstraint.constant = self.view.frame.size.height;
}

- (void)hideKeyboard
{
    [self.textView resignFirstResponder];
    [self.QQTextField resignFirstResponder];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
//    self.scrollView.contentSize = CGSizeMake(APP_W, 0);
//    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.anchorHeightConstraint.constant = self.view.frame.size.height;
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
//    self.scrollView.contentSize = CGSizeMake(APP_W, 0);
//    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.anchorHeightConstraint.constant = self.view.frame.size.height;
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(!HIGH_RESOLUTION){
//        self.scrollView.contentSize = CGSizeMake(APP_W, self.view.frame.size.height);
//        [self.scrollView setContentOffset:CGPointMake(0, 120) animated:YES];
        self.anchorHeightConstraint.constant = self.view.frame.size.height+120;
        self.contentViewLeadingConstraint.constant = -120;
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    //    self.scrollView.contentSize = CGSizeMake(APP_W, 0);
    //    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.anchorHeightConstraint.constant = self.view.frame.size.height;
    self.contentViewLeadingConstraint.constant = 0;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
//    self.scrollView.contentSize = CGSizeMake(APP_W, 0);
//    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.anchorHeightConstraint.constant = self.view.frame.size.height;
    self.contentViewLeadingConstraint.constant = 0;
    return YES;
}

- (void)rightButtonClick
{
    [QWGLOBALMANAGER statisticsEventId:@"意见反馈_提交" withLable:nil withParams:nil];
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [SVProgressHUD showErrorWithStatus:@"网络未连接，请重试" duration:0.8f];
        return;
    }
    
    if (self.textView.text.length == 0){
        [SVProgressHUD showErrorWithStatus:@"反馈内容不能为空" duration:DURATION_SHORT];
    }else{
        DDLogVerbose(@"the text length is %d",self.textView.text.length);
        if (self.textView.text.length > 300) {
            [SVProgressHUD showErrorWithStatus:@"反馈内容不能超过300字" duration:DURATION_SHORT];
            return;
        }
        if (self.QQTextField.text.length > 50) {
            [SVProgressHUD showErrorWithStatus:@"QQ号或邮箱长度不能超过50位!" duration:DURATION_SHORT];
            return;
        }
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"意见内容"] = StrFromObj(self.textView.text);
        FeedBackModelR *model = [FeedBackModelR new];
        model.content = StrFromObj(self.textView.text);
        model.source = @"5";
        model.type = @"1";
        model.contact = self.QQTextField.text;
        if (QWGLOBALMANAGER.configure.userToken) {
            model.token = QWGLOBALMANAGER.configure.userToken;
        }
        
        
        [FeedBack SubmitFeedbackWithParams:model success:^(id obj) {
            
            if ([obj[@"apiStatus"] integerValue] == 0) {
                [QWGLOBALMANAGER updateUnreadCount:[NSString stringWithFormat:@"%ld",(long)[QWGLOBALMANAGER getAllUnreadCount]]];
                [SVProgressHUD showSuccessWithStatus:@"反馈成功" duration:DURATION_SHORT];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } failure:^(HttpException *e) {
            
        }];
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        LoginViewController * login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        login.isPresentType = YES;
        login.parentNavgationController = self.navigationController;
        UINavigationController * nav = [[QWBaseNavigationController alloc] initWithRootViewController:login];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length == 0) {
        self.placeholder.text = @"请提出您的宝贵意见，我们会及时进行解决~~";
       
        CGFloat length = textView.text.length;
        int len = 300-length;
        if (len < 0) {
            len = 0;
        }
        self.limitWord.text = [NSString stringWithFormat:@"您还可以输入%d个字",len];
    }else{
        self.placeholder.text = @"";
        CGFloat length = textView.text.length;
        int len = 300-length;
        if (len < 0) {
            len = 0;
        }
        self.limitWord.text = [NSString stringWithFormat:@"您还可以输入%d个字",len];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    NSString *temp = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if (temp.length > 300) {
        textView.text = [temp substringToIndex:300];
        return NO;
    }
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.textView resignFirstResponder];
    [self.QQTextField resignFirstResponder];
}

- (IBAction)QQButtonClick:(id)sender {
}

@end
