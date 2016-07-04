//
//  PerfectInformationViewController.m
//  APP
//
//  Created by Martin.Liu on 15/12/1.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "PerfectInformationViewController.h"
#import "ConstraintsUtility.h"
#import "BaseAPIModel.h"
#import "UserInfoModel.h"
#import "Mbr.h"
#import "SVProgressHUD.h"
#import "QWProgressHUD.h"
#import "NSString+MarCategory.h"
#import "NSDate+TKCategory.h"
#import "CreditModel.h"

static const NSInteger NickNameMaxNumberInPerfect = 15;

@interface PerfectInformationViewController ()<UITextFieldDelegate>
{
    mbrMemberInfo *memberInfo;
}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

// 容器
@property (strong, nonatomic) IBOutlet UIView *containerView1;
@property (strong, nonatomic) IBOutlet UIView *containerView2;
@property (strong, nonatomic) IBOutlet UIView *containerView3;
@property (strong, nonatomic) IBOutlet UIView *containerView4;

// 视图
@property (strong, nonatomic) IBOutlet UIView *nickNameView;
@property (strong, nonatomic) IBOutlet UIView *genderView;
@property (strong, nonatomic) IBOutlet UIView *birthdayView;
@property (strong, nonatomic) IBOutlet UIView *emailView;

// 标题 小标题
@property (strong, nonatomic) IBOutlet UILabel *nicknameTitleLB;
@property (strong, nonatomic) IBOutlet UILabel *nicknameSubTitleLB;

@property (strong, nonatomic) IBOutlet UILabel *genderTitleLB;
@property (strong, nonatomic) IBOutlet UILabel *genderSubTItleLB;

@property (strong, nonatomic) IBOutlet UILabel *birthTitleLB;
@property (strong, nonatomic) IBOutlet UILabel *birthSubTitleLB;

@property (strong, nonatomic) IBOutlet UILabel *emailTitleLB;
@property (strong, nonatomic) IBOutlet UILabel *emailSubTitleLB;

// 上一步 下一步 完成 按钮
@property (strong, nonatomic) IBOutlet UIButton *nickNameNextStepBtn;
@property (strong, nonatomic) IBOutlet UIButton *genderPreStepBtn;
@property (strong, nonatomic) IBOutlet UIButton *genderNextStepBtn;
@property (strong, nonatomic) IBOutlet UIButton *birthPreStepBtn;
@property (strong, nonatomic) IBOutlet UIButton *birthNextStepBtn;
@property (strong, nonatomic) IBOutlet UIButton *emailPreStepBtn;
@property (strong, nonatomic) IBOutlet UIButton *finishBtn;

// 昵称文本框
@property (strong, nonatomic) IBOutlet UITextField *nickNameTF;

// 选择性别按钮
@property (strong, nonatomic) IBOutlet UIButton *maleBtn;
@property (strong, nonatomic) IBOutlet UIButton *femaleBtn;


@property (strong, nonatomic) IBOutlet UIView *ageContainerView;
@property (strong, nonatomic) IBOutlet UIView *ageBackView;
// 年龄标签
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
// 生日选择器
@property (strong, nonatomic) IBOutlet UIDatePicker *birthDatePick;
// 出生日期的性别图片 ， 默认状态男性 ， 选中状态女性
@property (strong, nonatomic) IBOutlet UIButton *birthGenderImageBtn;

// email标签
@property (strong, nonatomic) IBOutlet UITextField *emailTF;
// emial的性别图片  ， 默认状态显示男性 ，选中状态显示女性
@property (strong, nonatomic) IBOutlet UIButton *emailGenderImageBtn;

@property (nonatomic, copy) UserInfoModel* userInfo;
@property (nonatomic, strong) NSDateFormatter* dateFormatter;
@property (nonatomic, strong) NSCalendar* calendar;

- (IBAction)closeBtnAction:(id)sender;

- (IBAction)maleBtnAction:(UIButton*)sender;
- (IBAction)femaleBtnAction:(UIButton *)sender;

- (IBAction)preBtnAction:(id)sender;
- (IBAction)nextBtnAction:(id)sender;
- (IBAction)finishBtnAction:(id)sender;

@end

@implementation PerfectInformationViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    // 上一页是登录页面不可右滑
    if (self.needBacktoNaviRootVC) {
        ((QWBaseNavigationController*)self.navigationController).canDragBack = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    ((QWBaseNavigationController*)self.navigationController).canDragBack = YES;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.nickNameTF.delegate = self;
    self.emailTF.delegate = self;
    
    [self.birthDatePick addTarget:self action:@selector(datePickChanged:) forControlEvents:UIControlEventValueChanged];
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignTFs)];
    [self.view addGestureRecognizer:tapGesture];
    // Do any additional setup after loading the view from its nib.
}

- (void)resignTFs
{
    [self.view endEditing:YES];
}

- (void)datePickChanged:(UIDatePicker*)datePick
{
    DebugLog(@"date test ; %@", [self.dateFormatter stringFromDate:datePick.date]);
    NSDate* now = [NSDate new];

    NSDateComponents* nowComponents = [self.calendar components:NSCalendarUnitYear fromDate:now];
    NSDateComponents* birthComponents = [self.calendar components:NSCalendarUnitYear fromDate:datePick.date];
    
    NSInteger nowYear = nowComponents.year;
    NSInteger birthYear = birthComponents.year;
    self.ageLabel.text = [NSString stringWithFormat:@"%ld岁", MAX(1, nowYear - birthYear)];
    
}

- (void)UIGlobal
{
    self.view.backgroundColor = RGBHex(qwColor1);
    [self.containerView1 addSubview:self.nickNameView];
    [self.containerView2 addSubview:self.genderView];
    [self.containerView3 addSubview:self.birthdayView];
    [self.containerView4 addSubview:self.emailView];
    
    PREPCONSTRAINTS(self.nickNameView);
    PREPCONSTRAINTS(self.genderView);
    PREPCONSTRAINTS(self.birthdayView);
    PREPCONSTRAINTS(self.emailView);

    
    ALIGN_TOPLEFT(self.nickNameView, 0);
    ALIGN_BOTTOMRIGHT(self.nickNameView, 0);
    
    ALIGN_TOPLEFT(self.genderView, 0);
    ALIGN_BOTTOMRIGHT(self.genderView, 0);
    
    ALIGN_TOPLEFT(self.birthdayView, 0);
    ALIGN_BOTTOMRIGHT(self.birthdayView, 0);
    
    ALIGN_TOPLEFT(self.emailView, 0);
    ALIGN_BOTTOMRIGHT(self.emailView, 0);
    
    // 上一步 下一步 完成 按钮样式
    CGFloat cornerRadius = 4;
    
    for (UIButton* btn in @[self.genderPreStepBtn, self.birthPreStepBtn, self.emailPreStepBtn]) {
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = cornerRadius;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.backgroundColor = RGBAHex(qwColor1, 0.8);
        btn.titleLabel.font = [UIFont systemFontOfSize:kFontS3];
    }
    for (UIButton* btn in @[self.nickNameNextStepBtn, self.genderNextStepBtn, self.birthNextStepBtn, self.finishBtn]) {
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = cornerRadius;
        [btn setTitleColor:RGBHex(qwColor1) forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:kFontS3];
    }
    
    // 年龄的View圆弧
    self.ageContainerView.layer.masksToBounds = YES;
    self.ageContainerView.layer.cornerRadius = 4;
    self.ageBackView.backgroundColor = RGBHex(qwColor2);
    
    // 昵称文本框 ，邮箱文本框 样式
    self.nickNameTF.textColor = RGBHex(qwColor1);
    self.nickNameTF.font = [UIFont systemFontOfSize:kFontS1];
    self.nickNameTF.returnKeyType = UIReturnKeyNext;
//    self.nickNameTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入昵称" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kFontS1], NSForegroundColorAttributeName:RGBHex(qwColor1)}];
    
    self.emailTF.textColor = RGBHex(qwColor1);
    self.emailTF.font = [UIFont systemFontOfSize:kFontS1];
//    self.emailTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"@" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kFontS1], NSForegroundColorAttributeName:RGBHex(qwColor1)}];
    
    self.emailTF.returnKeyType = UIReturnKeyDone;
    // 年龄标签 生日选择器 样式
    self.ageLabel.textColor = RGBHex(qwColor4);
    self.ageLabel.font = [UIFont boldSystemFontOfSize:kFontS2];
    self.birthDatePick.datePickerMode = UIDatePickerModeDate;
    self.birthDatePick.maximumDate = [NSDate new];
    
    // 标题 小标题 字体大小 颜色
    self.nicknameTitleLB.font = [UIFont boldSystemFontOfSize:kFontS10];
    self.nicknameTitleLB.textColor = RGBHex(qwColor4);
    self.nicknameSubTitleLB.font = [UIFont systemFontOfSize:kFontS5];
    self.nicknameSubTitleLB.textColor = RGBHex(qwColor4);
    
    self.genderTitleLB.font = [UIFont boldSystemFontOfSize:kFontS10];
    self.genderTitleLB.textColor = RGBHex(qwColor4);
    self.genderSubTItleLB.font = [UIFont systemFontOfSize:kFontS5];
    self.genderSubTItleLB.textColor = RGBHex(qwColor4);
    
    self.birthTitleLB.font = [UIFont boldSystemFontOfSize:kFontS10];
    self.birthTitleLB.textColor = RGBHex(qwColor4);
    self.birthSubTitleLB.font = [UIFont systemFontOfSize:kFontS5];
    self.birthSubTitleLB.textColor = RGBHex(qwColor4);
    
    self.emailTitleLB.font = [UIFont boldSystemFontOfSize:kFontS10];
    self.emailTitleLB.textColor = RGBHex(qwColor4);
    self.emailSubTitleLB.font = [UIFont systemFontOfSize:kFontS5];
    self.emailSubTitleLB.textColor = RGBHex(qwColor4);
    
    self.birthDatePick.backgroundColor = [UIColor whiteColor];
    
    self.birthDatePick.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    
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

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return _dateFormatter;
}

- (NSCalendar *)calendar
{
    if (!_calendar) {
        _calendar = [NSCalendar currentCalendar];
    }
    return _calendar;
}

-(void)loadData
{
    if(QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        
        NSMutableDictionary *setting = [NSMutableDictionary dictionary];
        setting[@"token"] = StrFromObj(QWGLOBALMANAGER.configure.userToken);
        [Mbr queryMemberDetailWithParams:setting success:^(id DFUserModel) {
            mbrMemberInfo * info = DFUserModel;
            if([info.apiStatus integerValue] == 0){
                QWGLOBALMANAGER.configure.sex = info.sex;
                QWGLOBALMANAGER.configure.nickName = info.nickName;
                QWGLOBALMANAGER.configure.avatarUrl = info.headImageUrl;
                
                self.nickNameTF.text = QWGLOBALMANAGER.configure.nickName;
                if ([QWGLOBALMANAGER.configure.sex isEqual:@"0"]) {
                    [self maleBtnAction:nil];
                }
                else if ([QWGLOBALMANAGER.configure.sex isEqual:@"1"])
                {
                    [self femaleBtnAction:nil];
                }
                NSDate* date = [self.dateFormatter dateFromString:info.birthday];
                if (!date) {
                    // 若没有生日日期，默认时间1985年10月1日
                    date = [self.dateFormatter dateFromString:@"1985-10-01"];
                }
                if (date) {
                    self.birthDatePick.date = date;
                }

                [self datePickChanged:self.birthDatePick];
                
                self.emailTF.text = info.email;
            }
            
        } failure:^(HttpException *e) {
            
        }];
    }
}


- (IBAction)closeBtnAction:(id)sender {
    if (self.needBacktoNaviRootVC) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
        [self popVCAction:nil];
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)maleBtnAction:(UIButton*)sender {
    self.femaleBtn.selected = NO;
    self.maleBtn.selected = YES;
    
    self.birthGenderImageBtn.selected = self.emailGenderImageBtn.selected = NO;
}

- (IBAction)femaleBtnAction:(UIButton *)sender {
    self.femaleBtn.selected = YES;
    self.maleBtn.selected = NO;
    
    self.birthGenderImageBtn.selected = self.emailGenderImageBtn.selected = YES;
}

- (IBAction)preBtnAction:(id)sender {
    // 如果正在滑动，不执行下面方法
    if ([self valifyIsScroll]) {
        return;
    }
    // 如果正在滑动，不执行下面方法
    if (self.scrollView.contentSize.width - self.scrollView.contentOffset.x > 0) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x - self.scrollView.frame.size.width, 0) animated:YES];
    }
}

- (IBAction)nextBtnAction:(id)sender {
    // 事件监听
    if (sender == self.nickNameNextStepBtn) {
        [QWGLOBALMANAGER statisticsEventId:@"x_jfrw_wszl_xyb" withLable:@"积分任务-完善资料-下一步" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl),@"哪一步":@"昵称",@"选择内容":StrDFString(self.nickNameTF.text, @"")}]];
    }
    else if (sender == self.genderNextStepBtn)
    {
        [QWGLOBALMANAGER statisticsEventId:@"x_jfrw_wszl_xyb" withLable:@"积分任务-完善资料-下一步" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl),@"哪一步":@"性别",@"选择内容":self.femaleBtn.selected ? @"女" : (self.maleBtn.selected ? @"男" : @"")}]];
    }
    else if (sender == self.birthNextStepBtn)
    {
        [QWGLOBALMANAGER statisticsEventId:@"x_jfrw_wszl_xyb" withLable:@"积分任务-完善资料-下一步" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"用户等级":StrFromInt(QWGLOBALMANAGER.configure.mbrLvl),@"哪一步":@"年龄",@"选择内容":StrDFString(self.ageLabel.text, @"1岁")}]];
    }
    
    
    if ([self valifyIsScroll]) {
        return;
    }
    
    // 昵称必填项
    if (sender == self.nickNameNextStepBtn) {
        if (StrIsEmpty(self.nickNameTF.text.mar_trim)) {
            [SVProgressHUD showErrorWithStatus:@"请输入昵称" duration:DURATION_SHORT];
            [self.nickNameTF becomeFirstResponder];
            return;
        }
        if (self.nickNameTF.text.mar_trim.length > NickNameMaxNumberInPerfect) {
            [SVProgressHUD showErrorWithStatus:@"昵称长度不能超过十五个字符" duration:DURATION_LONG];
            return ;
        }
    }
    
    if (self.scrollView.contentSize.width - self.scrollView.contentOffset.x > self.scrollView.frame.size.width) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + self.scrollView.frame.size.width, 0) animated:YES];
    }
}

// 验证scroll是否在滑动
- (BOOL)valifyIsScroll
{
    BOOL isScroll = ((long)self.scrollView.contentOffset.x % (long)self.scrollView.frame.size.width) == 0;

    return !isScroll;
}

#pragma mark - UITextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
//    if (textField == self.emailTF) {
//        [self finishBtnAction:nil];
//    }
//    else
//    {
//        if (textField == self.nickNameTF) {
//            [self nextBtnAction:self.nickNameNextStepBtn];
//        }
//    }
    return NO;
}

- (IBAction)finishBtnAction:(id)sender {
    if (StrIsEmpty(self.nickNameTF.text.mar_trim)) {
        [SVProgressHUD showErrorWithStatus:@"请输入昵称" duration:DURATION_SHORT];
        [self.nickNameTF becomeFirstResponder];
        return;
    }
    
    if (self.nickNameTF.text.mar_trim.length > NickNameMaxNumberInPerfect) {
        [SVProgressHUD showErrorWithStatus:@"昵称长度不能超过十五个字符" duration:DURATION_LONG];
        return ;
    }
    if (!StrIsEmpty(self.emailTF.text) && ![QWGLOBALMANAGER isEmailAddress:self.emailTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"电子邮箱格式错误，请重新输入" duration:DURATION_LONG];
        return;
    }
    

    NSMutableDictionary * setting = [NSMutableDictionary dictionary];
    
    setting[@"token"] = QWGLOBALMANAGER.configure.userToken;
    if (!StrIsEmpty(self.nickNameTF.text.mar_trim)) {
        setting[@"nickName"] = self.nickNameTF.text.mar_trim;
    }
    else
    {
        setting[@"nickName"] = @"";
    }
    
    if (self.maleBtn.selected) {
        setting[@"sex"] = @"0";
    }
    else if(self.femaleBtn.selected)
    {
        setting[@"sex"] = @"1";
    }
    
    setting[@"birthday"] = [self.dateFormatter stringFromDate:self.birthDatePick.date];
    
    if (!StrIsEmpty(self.emailTF.text)) {
        setting[@"email"] = self.emailTF.text;
    }
    else
    {
        setting[@"email"] = @"";
    }
    
    [[HttpClient sharedInstance]put:NW_saveMemberInfo params:setting success:^(id responseObj) {
        SaveMemberInfo *model = [SaveMemberInfo parse:responseObj];
        if([model.apiStatus intValue] == 0){
            if (model.taskChanged) {
                [QWProgressHUD showSuccessWithStatus:@"完善资料" hintString:[NSString stringWithFormat:@"+%ld", [QWGLOBALMANAGER rewardScoreWithTaskKey:CreditTaskKey_Full]] duration:DURATION_CREDITREWORD];
                NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
                tdParams[@"积分奖励"]=StrFromInt([QWGLOBALMANAGER rewardScoreWithTaskKey:CreditTaskKey_Full]);
                tdParams[@"用户等级"] = StrFromInt(QWGLOBALMANAGER.configure.mbrLvl);
                [QWGLOBALMANAGER statisticsEventId:@"x_jfrw_wszl_wc" withLable:@"积分任务-完善资料-完成" withParams:tdParams];
            }
            else
            {
                [SVProgressHUD showSuccessWithStatus:@"保存成功" duration:DURATION_LONG];
            }
            [self closeBtnAction:nil];

        }else{
            [SVProgressHUD showErrorWithStatus:model.apiMessage duration:DURATION_SHORT];
        }
    } failure:^(HttpException *e) {
        [SVProgressHUD showErrorWithStatus:e.Edescription duration:DURATION_SHORT];
    }];
    
}
@end
