//
//  EvaluateStoreViewController.m
//  APP
//
//  Created by garfield on 15/8/30.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "EvaluateStoreViewController.h"
#import "XPChatViewController.h"
#import "RatingView.h"
#import "SVProgressHUD.h"
#import "Appraise.h"


@interface EvaluateStoreViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *headerContainer;
@property (weak, nonatomic) IBOutlet RatingView *ratingView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UIButton   *submitButton;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyboardConstraint;
@property (weak, nonatomic) IBOutlet UILabel *titleHint;

@end

@implementation EvaluateStoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.submitButton.layer.masksToBounds = NO;
    self.submitButton.layer.cornerRadius = 5.0;
    self.title = self.modelR.branchName;
    self.questionLabel.text = self.modelR.consultMessage;
    self.modelR.consultMessage = nil;
    [self.ratingView setImagesDeselected:@"star_none_big" partlySelected:@"star_half_big" fullSelected:@"star_full_big" andDelegate:nil];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapConsultMessage:)];
    [_headerContainer addGestureRecognizer:gesture];
    [self checkAppraiseStatus];
    if(_shouldHideTop) {
        self.headerContainer.hidden = YES;
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitEvaluate:)];
}

- (void)checkAppraiseStatus
{
    GetAppraiseModelR *modelR = [GetAppraiseModelR new];
    modelR.consultId = self.modelR.consultId;
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    [Appraise appraiseByConsultGetParams:modelR success:^(AppraiseByConsultGetModel *model) {
        [self hiddenSubmitAction:model];
    } failure:NULL];
}

- (void)hiddenSubmitAction:(AppraiseByConsultGetModel *)getModel
{
    if(getModel.remark.length > 0 || getModel.star > 0) {
        self.bottomView.hidden = YES;
        [self.textView setBackgroundColor:[UIColor clearColor]];
        self.textView.text = getModel.remark;
        self.textView.textAlignment = NSTextAlignmentCenter;
        self.keyboardConstraint.constant = 20;
        self.hintLabel.hidden = YES;
        [self.ratingView displayRating:getModel.star / 2.0];
        self.textView.userInteractionEnabled = NO;
        self.ratingView.userInteractionEnabled = NO;
        self.titleHint.text = @"您已成功评价";
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ((QWBaseNavigationController *)self.navigationController).canDragBack = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    ((QWBaseNavigationController *)self.navigationController).canDragBack = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (IBAction)dismissKeyboard:(id)sender
{
    [_textView resignFirstResponder];
}


- (void)keyboardWillShow:(NSNotification*)aNotification
{
    if(SCREEN_H == 480) {
        _keyboardConstraint.constant = -20.0;
    }else{
        _keyboardConstraint.constant = 5.0;
    }
    [UIView animateWithDuration:0.3f animations:^{
        [self.view layoutIfNeeded];
    }];
    self.hintLabel.hidden = YES;
}

- (void)keyboardWillHide:(NSNotification*)aNotification
{
    _keyboardConstraint.constant = 70.0;
    [UIView animateWithDuration:0.3f animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)tapConsultMessage:(UITapGestureRecognizer *)gesture
{
    __block XPChatViewController *popViewController = nil;
    __block NSArray *viewControllers = self.navigationController.viewControllers;
    [viewControllers enumerateObjectsUsingBlock:^(UIViewController *vc, NSUInteger idx, BOOL *stop) {
        if([vc isKindOfClass:[XPChatViewController class]]) {
            XPChatViewController *XPViewController = (XPChatViewController *)vc;
            if ([XPViewController.branchId isEqualToString:_modelR.branchId]) {
                popViewController = XPViewController;
                *stop = YES;
            }
        }
    }];
    
    if(popViewController) {
        [self.navigationController popToViewController:popViewController animated:YES];
    }else{
        XPChatViewController *messageViewController = [[UIStoryboard storyboardWithName:@"XPChatViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"XPChatViewController"];
        messageViewController.messageSender = _modelR.consultId;
        if(self.textView.userInteractionEnabled == NO) {
            messageViewController.showType = MessageShowTypeClosed;
            messageViewController.historyMsg = _historyMsg;
            messageViewController.historyMsg.consultMessage = @"您的咨询服务已经结束,欢迎再次咨询!";
        }else{
            messageViewController.showType = MessageShowTypeClosedWithoutEvaluate;
            messageViewController.historyMsg = _historyMsg;
        }
        
        [self.navigationController pushViewController:messageViewController animated:YES];
    }
}

- (IBAction)submitEvaluate:(id)sender
{
    if(_textView.text.length > 100) {
        [SVProgressHUD showErrorWithStatus:@"评论长度不得大于100字" duration:0.8];
        return;
    }else if (_textView.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"评论内容不得为空" duration:0.8];
        return;
    }
    _modelR.token = QWGLOBALMANAGER.configure.userToken;
    _modelR.star = [NSString stringWithFormat:@"%.0f",floor(self.ratingView.rating * 2.0)];
    _modelR.remark = self.textView.text;
    [Appraise appraiseByConsultWithParams:_modelR success:^(AppraiseByConsultModel *resultObj) {
        if ([resultObj.apiStatus integerValue] == 0) {
            if(self.successBlock) {
                self.successBlock();
            }
            if(_shouldHideTop) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:resultObj.apiMessage duration:0.8];
        }
    } failure:NULL];
}

#pragma mark -
#pragma mark UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    NSString *newString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if(newString.length > 0) {
        self.hintLabel.hidden = YES;
    }else{
        self.hintLabel.hidden = NO;
    }
    return YES;
}

- (IBAction)cancelAppraiseAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
