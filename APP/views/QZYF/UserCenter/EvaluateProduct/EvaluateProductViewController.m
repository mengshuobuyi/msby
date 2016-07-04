//
//  EvaluateProductViewController.m
//  APP
//
//  Created by PerryChen on 1/7/16.
//  Copyright © 2016 carret. All rights reserved.
//

#import "EvaluateProductViewController.h"
#import "RatingView.h"
#import "EvaluateProductCell.h"
#import "Orders.h"
#import "CreditModel.h"
#import "QWProgressHUD.h"
@interface EvaluateOrderModel : BaseModel
@property (nonatomic, assign) NSInteger serviceStar;
@property (nonatomic, assign) NSInteger deliveryStar;
@end

@implementation EvaluateOrderModel

@end

static NSInteger maxTextNum = 200;     // 最大文字数
static NSString* const CellIdentifier = @"EvaluateProductCell";
@interface EvaluateProductViewController ()<UITextFieldDelegate, RatingViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewConsultContent;
@property (weak, nonatomic) IBOutlet UITextView *tvConsultContent;
@property (weak, nonatomic) IBOutlet UILabel *lblTips;
@property (weak, nonatomic) IBOutlet UILabel *lblRemainNum;
@property (weak, nonatomic) IBOutlet RatingView *viewRatingService;
@property (weak, nonatomic) IBOutlet RatingView *viewRatingDeliver;
@property (weak, nonatomic) IBOutlet UILabel *lblRateService;
@property (weak, nonatomic) IBOutlet UILabel *lblRateDeliver;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *lblConstraintDeliveryPH;

@property (assign, nonatomic) BOOL showPlaceholder;
@property (assign, nonatomic) CGPoint pointViewCenter;

@property (nonatomic, strong) EvaluateOrderModel *modelEvaluate;

@property (weak, nonatomic) IBOutlet UIButton *btnCommit;
@property (nonatomic, assign) NSInteger touchTag; // 1 是服务 2 是配送
- (IBAction)actionHideKeyboard:(id)sender;
- (IBAction)actionCommit:(id)sender;

@end

@implementation EvaluateProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.modelEvaluate = [[EvaluateOrderModel alloc] init];
    [self.viewRatingService setFullImagesDeselected:@"star_none_big" fullSelected:@"star_full_big" andDelegate:self];
    [self.viewRatingDeliver setFullImagesDeselected:@"star_none_big" fullSelected:@"star_full_big" andDelegate:self];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(actionCommit:)];
    
    self.navigationItem.title = @"评价";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textViewEditChanged:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:nil];
    [self setupUI];
    ((QWBaseNavigationController *)self.navigationController).canDragBack = NO;
}

- (void)setupUI
{
    self.lblTips.textColor = RGBHex(qwColor9);
    self.lblTips.font = fontSystem(kFontS4);
    self.lblRemainNum.textColor = RGBHex(qwColor9);
    self.lblRemainNum.font = fontSystem(kFontS9);
    self.tvConsultContent.textColor = RGBHex(qwColor6);
    self.tvConsultContent.font = fontSystem(kFontS4);
    self.tvConsultContent.textContainerInset = UIEdgeInsetsMake(0, -5, 0, 0);
    self.lblRemainNum.text = [NSString stringWithFormat:@"0/%d",maxTextNum];
    self.lblRateDeliver.textColor = self.lblRateService.textColor = RGBHex(qwColor9);
    self.lblRateDeliver.font = self.lblRateService.font = fontSystem(kFontS4);
    self.btnCommit.layer.cornerRadius = 4.0f;
    self.lblRateService.text = @"好评";
    self.lblRateDeliver.text = @"好评";
    self.modelEvaluate.serviceStar = 5;
    self.modelEvaluate.deliveryStar = 5;
    [self.viewRatingDeliver displayRating:5.0];
    [self.viewRatingService displayRating:5.0];
    if (!self.hasPostSpeed) {
        self.constraintViewHeight.constant = 50;
        self.viewRatingDeliver.hidden = YES;
        self.lblRateDeliver.hidden = YES;
        self.lblConstraintDeliveryPH.hidden = YES;
    } else {
        self.constraintViewHeight.constant = 80;
        self.viewRatingDeliver.hidden = NO;
        self.viewRatingDeliver.hidden = NO;
        self.lblConstraintDeliveryPH.hidden = NO;
    }
}

- (void)actionHideKeyboard:(id)sender
{
    [self.tvConsultContent resignFirstResponder];
}

- (IBAction)actionCommit:(id)sender {
    if (self.modelEvaluate.serviceStar == 0) {
        [self showError:@"请评价服务态度"];
        return;
    }
    if (self.hasPostSpeed) {
        if (self.modelEvaluate.deliveryStar == 0) {
            [self showError:@"请评价交付态度"];
            return;
        }
    }

    
    OrderEvaluateModelR *modelR = [[OrderEvaluateModelR alloc] init];
    modelR.token = QWGLOBALMANAGER.configure.userToken == nil ? @"" : QWGLOBALMANAGER.configure.userToken;
    modelR.orderId = self.orderId;
    modelR.serviceStar = self.modelEvaluate.serviceStar*2;
    modelR.deliveryStar = self.modelEvaluate.deliveryStar*2;
    
    if(StrIsEmpty(self.tvConsultContent.text)){
        modelR.remark = @"";
    }else{
        modelR.remark = self.tvConsultContent.text;
    }
    
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    tdParams[@"服务态度几星"] = [NSString stringWithFormat:@"%d",self.modelEvaluate.serviceStar];
    if (self.hasPostSpeed) {
        tdParams[@"配送速度几星"] = [NSString stringWithFormat:@"%d",self.modelEvaluate.deliveryStar];
    }
    [QWGLOBALMANAGER statisticsEventId:@"x_ddxq_pjtj" withLable:@"订单详情" withParams:tdParams];
    HttpClientMgr.progressEnabled = YES;
    [Orders evaluateOrder:modelR success:^(OrderAppriseModel *model) {
//        [self showSuccess:@"评价成功"];
//        [self ]
        if ([model.taskChanged boolValue]) {
            [QWProgressHUD showSuccessWithStatus:@"评价成功" hintString:[NSString stringWithFormat:@"+%ld",[QWGLOBALMANAGER rewardScoreWithTaskKey:CreditTaskKey_Appraise]] duration:2.0];
            [self performSelector:@selector(popVCAction:) withObject:nil afterDelay:2.0];
        } else {
            [self showSuccess:@"评价成功" completion:^(BOOL finished) {
                [self popVCAction:nil];
            }];

        }
    } failure:^(HttpException *e) {
        [self.tvConsultContent endEditing:YES];
    }];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.pointViewCenter = self.view.center;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    ((QWBaseNavigationController *)self.navigationController).canDragBack = YES;
}
-(void)popVCAction:(id)sender {
    [super popVCAction:sender];
    if (self.refreshDetail) {
        self.refreshDetail();
    }
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
    self.lblRemainNum.text = [NSString stringWithFormat:@"%d/%d",self.tvConsultContent.text.length,maxTextNum];
    if (self.tvConsultContent.text.length == 0) {
        [self setTextViewPlaceholder:YES];
    } else {
        [self setTextViewPlaceholder:NO];
    }
}

// 设置文本框的Placeholder
- (void)setTextViewPlaceholder:(BOOL)didSet
{
    if (didSet&&self.tvConsultContent.text.length == 0) {
        self.lblTips.text = @"请详细描述您的病症或用药信息，药师会尽快为您提供用药方案或建议。";
        self.lblTips.hidden = NO;
        self.showPlaceholder = YES;
    } else {
        self.lblTips.hidden = YES;
        self.showPlaceholder = NO;
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length == 0) {
        [self setTextViewPlaceholder:YES];//显示提示
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (self.showPlaceholder&&self.tvConsultContent.text.length>0) {
        [self setTextViewPlaceholder:NO];//光标键入，消失提示
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (self.tvConsultContent.text.length == 0) {//内容变化进行的操作
        [self setTextViewPlaceholder:YES];
    } else {
        [self setTextViewPlaceholder:NO];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSCharacterSet *doneButtonCharacterSet = [NSCharacterSet newlineCharacterSet];
    NSRange replacementTextRange = [text rangeOfCharacterFromSet:doneButtonCharacterSet];
    NSUInteger location = replacementTextRange.location;
    if (location != NSNotFound){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


#pragma mark - Keyboard methods
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];

}

- (void)keyboardChangeFrame:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration animations:^{
        DDLogVerbose(@"the point is %@",NSStringFromCGPoint(self.view.center));
        DDLogVerbose(@"the consult frame is %@",NSStringFromCGRect(self.viewConsultContent.frame));
        self.view.center = CGPointMake(self.pointViewCenter.x, self.pointViewCenter.y - self.viewConsultContent.frame.origin.y+15);
        [self.view layoutIfNeeded];
    }];
    

}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.view.center = self.pointViewCenter;
    [self.view layoutIfNeeded];
}

- (void)getRateLevel:(NSInteger)level
{
    if (self.touchTag == 1) {
        if (level < 3) {
            self.lblRateService.text = @"差评";
        } else if (level == 3) {
            self.lblRateService.text = @"中评";
        } else {
            self.lblRateService.text = @"好评";
        }
        self.modelEvaluate.serviceStar = level;
    } else if (self.touchTag == 2) {
        if (level < 3) {
            self.lblRateDeliver.text = @"差评";
        } else if (level == 3) {
            self.lblRateDeliver.text = @"中评";
        } else {
            self.lblRateDeliver.text = @"好评";
        }
        self.modelEvaluate.deliveryStar = level;
    }
}

-(void)ratingChangeEnded:(float)newRating
{
    NSInteger intRating = (NSInteger)newRating;
    [self getRateLevel:intRating];
}

- (void)ratingChanged:(float)newRating
{
//    NSInteger intRating = (NSInteger)newRating;
//    [self getRateLevel:intRating];
}

- (void)ratingTouchedWithTag:(NSInteger)touchTag
{
    self.touchTag = touchTag;
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
