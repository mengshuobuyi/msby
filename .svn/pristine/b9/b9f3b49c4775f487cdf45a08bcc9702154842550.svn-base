//
//  WebCommentViewController.m
//  APP
//
//  Created by garfield on 15/8/28.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "WebCommentViewController.h"
#import "SVProgressHUD.h"
#import "Subject.h"

static NSInteger maxTextNum = 200;     // 最大文字数

@interface WebCommentViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *lblPlaceHolder;
@property (weak, nonatomic) IBOutlet UILabel *lblRemainNum;

@end

@implementation WebCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"发评论";
    self.lblPlaceHolder.hidden = NO;
    [self.textView becomeFirstResponder];
    self.textView.layer.borderColor = RGBHex(qwColor10).CGColor;
    self.textView.layer.borderWidth = 0.5f;
    self.lblRemainNum.text = [NSString stringWithFormat:@"0/%d",maxTextNum];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItems = nil;
    self.navigationItem.leftBarButtonItem = nil;
    UIBarButtonItem *itemLeft = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelComment:)];
    self.navigationItem.leftBarButtonItem = itemLeft;
    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(commentAction:)];
    self.navigationItem.rightBarButtonItem = itemRight;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textViewEditChanged:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:nil];
}

- (IBAction)commentAction:(id)sender
{
    if ([self.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        [self showText:@"请输入内容" delay:2.0];
        return;
    }
    if ([self.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > maxTextNum) {
        [self showText:@"字数超过限制" delay:2.0];
        return;
    }
    SaveCommentModelR *modelR = [SaveCommentModelR new];
    
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    modelR.device = QWGLOBALMANAGER.deviceToken;
    modelR.content = self.textView.text;
    
    MapInfoModel *mapInfoModel = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
    if([mapInfoModel.city length] > 0) {
        modelR.city = mapInfoModel.city;
        modelR.province = mapInfoModel.province;
    }else{
        modelR.city = @"苏州市";
        modelR.province = @"江苏省";
    }
    if (self.isNewMes) {
        modelR.msgID = self.subjectId;
        [Subject saveInfoDetailComment:modelR success:^(BaseAPIModel *model) {
            if([model.apiStatus integerValue] == 0) {
                [self saveCommentSuccess];
            }else{
                self.successBlock(NO, self.callBackId);
                [SVProgressHUD showErrorWithStatus:model.apiMessage duration:0.8];
            }
        } failure:NULL];
    } else {
        modelR.subjectId = self.subjectId;
        [Subject saveComment:modelR success:^(BaseAPIModel *model) {
            if([model.apiStatus integerValue] == 0) {
                [self saveCommentSuccess];
            }else{
                self.successBlock(NO, self.callBackId);
                [SVProgressHUD showErrorWithStatus:model.apiMessage duration:0.8];
            }
        } failure:NULL];
    }
}

- (void)saveCommentSuccess
{
    [QWGLOBALMANAGER statisticsEventId:@"资讯详情_发表评价" withLable:@"资讯" withParams:nil];
    
    [self showSuccess:@"发送成功" completion:^(BOOL finished) {
        if(self.successBlock) {
            self.successBlock(YES, self.callBackId);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];

}

- (IBAction)cancelComment:(id)sender
{
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"资讯名"] = self.msgTitle;
    [QWGLOBALMANAGER statisticsEventId:@"x_zxxq_plqx" withLable:@"资讯" withParams:tdParams];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.lblPlaceHolder.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView methods

// 监听文本改变
-(void)textViewEditChanged:(NSNotification *)obj
{
    UITextView *textView = (UITextView *)obj.object;
    NSString *toBeString = textView.text;
    NSString *lang = [[textView textInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > maxTextNum) {
                textView.text = [toBeString substringToIndex:maxTextNum];
            }
            [self setRemainWord:textView.text.length];
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > maxTextNum) {
            textView.text = [toBeString substringToIndex:maxTextNum];
        }
        [self setRemainWord:textView.text.length];
    }
}

// 设置剩余输入字数
- (void)setRemainWord:(NSInteger)wordInputted
{
    self.lblRemainNum.text = [NSString stringWithFormat:@"%d/%d",self.textView.text.length,maxTextNum];
    if (self.textView.text.length == 0) {
    } else {
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
