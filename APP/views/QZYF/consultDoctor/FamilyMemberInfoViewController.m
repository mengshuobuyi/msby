//
//  FamilyMemberInfoViewController.m
//  APP
//
//  Created by PerryChen on 8/20/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "FamilyMemberInfoViewController.h"
#import "FamilyMedicine.h"
#import "FamilyMedicineR.h"
#import "FamilyMedicineModel.h"

#import "MemberAgeCell.h"
#import "MemberAllergyCell.h"
#import "MemberDiseaseListCell.h"
#import "MemberGenderCell.h"
#import "MemberNameCell.h"
#import "MemberPregnancyCell.h"

#import "CustomDatePicker.h"
#import "SVProgressHUD.h"
#import "MemberDiseaseListViewController.h"
#import "XPChatViewController.h"
#import "LoginViewController.h"
#import "Consult.h"
#import "StoreModel.h"
//float FrameOfY = 0;
float Kfont = 12.0f;
//float btnX = 10.0f;
@interface FamilyMemberInfoViewController ()<UITableViewDataSource, UITableViewDelegate, ChangeAllergyDelegate, ChangeGenderDelegate, ChangePregnancyDelegate, CustomDatePickerDelegate, MemberDiseaseListDelegate, UITextFieldDelegate>
{

}

@property (nonatomic, assign) BOOL isShowDisease;
@property (weak, nonatomic) IBOutlet UITableView *tbViewContent;

@property (nonatomic, strong) FamilyMemberDetailVo *memberDetail;       // 成员详情信息

@property (nonatomic, strong) CustomDatePicker *pickerBirth;            // 选择时间的控件

@property (nonatomic, strong) NSArray *arrDiseases;                     // 选择的慢病

@property (nonatomic, strong) NSMutableArray *arrDisNames;              // 慢病订阅名称

@property (nonatomic, assign) BOOL hasEnteredEditDisease;

@property (weak, nonatomic) IBOutlet UIView *tbViewFooter;

@property (weak, nonatomic) IBOutlet UIButton *btnSaveAndCommit;

@property (nonatomic, assign) BOOL isClickedBtn;
@property (nonatomic, assign) BOOL hasEnterTheDisease;

- (IBAction)actionSubmitInfo:(UIButton *)sender;

@end

@implementation FamilyMemberInfoViewController
// 计算年龄
- (NSInteger)ageWithDateOfBirth:(NSDate *)date;
{
    // 出生日期转换 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    
    return iAge;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrDisNames = [@[] mutableCopy];
    self.btnSaveAndCommit.layer.cornerRadius = 5.0f;
    self.btnSaveAndCommit.layer.masksToBounds = YES;
    self.isClickedBtn = NO;
    // 如果是新增成员
    if (self.enumTypeEdit == MemberViewTypeAdd) {
        self.memberDetail = [[FamilyMemberDetailVo alloc] init];
        self.memberDetail.sex = @"M";
        self.memberDetail.allergy = @"N";
        self.memberDetail.pregnancy = @"N";
        self.memberDetail.slowDiseases = @[];
        [self.tbViewContent reloadData];
        
    } else {

    }
    // 设置页面标题
    if (self.enumTypeEdit == MemberViewTypeAdd) {
        self.navigationItem.title = @"添加成员";
    } else if (self.enumTypeEdit == MemberViewTypeComplete) {
        self.navigationItem.title = @"完善资料";
    } else if (self.enumTypeEdit == MemberViewTypeEdit) {
        self.navigationItem.title = @"编辑资料";
    }
    if (self.isFromConsultDoctor) {
    } else {
        // 从家庭成员入口进来
//        [self naviRightBotton:@"保存" action:@selector(saveMemberInfo)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveMemberInfo)];
    }
    [self getMemberInfo];
    // 初始化时间控件
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"CustomDatePicker" owner:self options:nil];
    self.pickerBirth = [nibViews objectAtIndex: 0];
    NSString *strCurDate = [self convertDateToString:[NSDate date] withFormatStr:@"yyyy-MM-dd"];
    NSDate *curD = [self convertStringToDate:strCurDate withFormatStr:@"yyyy-MM-dd"];
    self.pickerBirth.datePicker.maximumDate = curD;
    self.pickerBirth.pickerDelegate = self;
    
    // Do any additional setup after loading the view.
}

// 判断是否需要显示怀孕
- (BOOL)judgeNeedShowPregnancy
{
    BOOL shouldShow = YES;
    NSInteger intYear = 0;
    if (self.memberDetail.birthday.length > 0) {
        NSArray *arrDate = [self.memberDetail.birthday componentsSeparatedByString:@"-"];
        if (arrDate.count == 3) {
            NSDate *datePic = [self convertStringToDate:self.memberDetail.birthday withFormatStr:@"yyyy-MM-dd"];
            intYear = [self ageWithDateOfBirth:datePic];
        } else {
            NSDate *datePic = [self convertStringToDate:self.memberDetail.birthday withFormatStr:@"yyyy-MM"];
            intYear = [self ageWithDateOfBirth:datePic];
        }
    }
    if (([self.memberDetail.sex isEqualToString:@"F"])&&(intYear>14)) {
        shouldShow = YES;
    } else {
        shouldShow = NO;
    }
    return shouldShow;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 如果是添加成员进来，那么自动弹出键盘
    if ((self.enumTypeEdit == MemberViewTypeAdd)&&self.hasEnterTheDisease==NO) {
        [self performSelector:@selector(popTheNameTF) withObject:nil afterDelay:0.5f];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(popTheNameTF) object:nil];
    [self.view endEditing:YES];
}

// 检查提交前的信息
- (BOOL)checkAllRequiredInfo
{
    [self.view endEditing:YES];
    BOOL allFixed = YES;
    NSString *strErr = @"";
    if (self.memberDetail.name.length <= 0) {
        strErr = @"未填写名字";
        allFixed = NO;
    } else if ((![self.memberDetail.sex isEqualToString:@"F"])&&(![self.memberDetail.sex isEqualToString:@"M"])) {
        strErr = @"未选择性别";
        allFixed = NO;
    } else if (self.memberDetail.birthday.length <= 0) {
        strErr = @"未选择生日";
        allFixed = NO;
    } else if (self.memberDetail.name.length > 10) {
        strErr = @"称呼最多10个字";
        allFixed = NO;
    }
    if (allFixed == NO) {
        [self showError:strErr];
    }
    return allFixed;
}

//将慢病ID
- (NSString *)convertSlowIdsToStr:(NSArray *)arrDises
{
    NSString *strDis = @"";
    NSMutableArray *arrIds = [@[] mutableCopy];
    for (SlowDiseaseVo *modelVo in arrDises) {
        [arrIds addObject:modelVo.slowId];
    }
    strDis = [arrIds componentsJoinedByString:SeparateStr];
    return strDis;
}

- (void)loginButtonClick
{
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    loginViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginViewController animated:YES];
}

// 拼接显示咨询标题的字符串
- (NSString *)jointTheStringWithModel:(FamilyMemberDetailVo *)modelVo
{
    NSMutableString *strNeedShow = [@"" mutableCopy];
    [strNeedShow appendString:@"("];
    if ([modelVo.sex isEqualToString:@"M"]) {
        [strNeedShow appendString:@"男"];
    } else if ([modelVo.sex isEqualToString:@"F"]) {
        [strNeedShow appendString:@"女"];
    }
    if ([modelVo.age intValue] >= 0) {
        [strNeedShow appendFormat:@", %@%@",modelVo.age,modelVo.unit];
    }
    if (modelVo.slowDiseases.count > 0) {
        for (SlowDiseaseVo *modelDisease in modelVo.slowDiseases) {
            [strNeedShow appendString:[NSString stringWithFormat:@", %@",modelDisease.name]];
        }
    }
    if ([modelVo.pregnancy isEqualToString:@"Y"]) {
        [strNeedShow appendFormat:@", 已怀孕"];
    }
    if ([modelVo.allergy isEqualToString:@"Y"]) {
        [strNeedShow appendFormat:@", 有药物过敏史"];
    }
    [strNeedShow appendString:@")"];
    return [NSString stringWithFormat:@"%@",strNeedShow];
}

// 提交到聊天页面
- (void)submitToChat
{
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [self showError:kWarning12];
        self.isClickedBtn = NO;
        return;
    }
    if(!QWGLOBALMANAGER.loginStatus){
        [self loginButtonClick];
        return;
    }
    
    ConsultDocModelR *modelR = [ConsultDocModelR new];
    MapInfoModel *mapInfoModel = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    self.strConsultTitle = [NSString stringWithFormat:@"%@ %@",self.strConsultTitle,[self jointTheStringWithModel:self.memberDetail]];
    modelR.title = self.strConsultTitle;
    if(mapInfoModel==nil){
        modelR.lon = [NSString stringWithFormat:@"%f",DEFAULT_LONGITUDE];
        modelR.lat = [NSString stringWithFormat:@"%f",DEFAULT_LATITUDE];
        modelR.city =@"苏州市";
    }else{
        modelR.city= mapInfoModel.city;
        modelR.lon = [NSString stringWithFormat:@"%f",mapInfoModel.location.coordinate.longitude];
        modelR.lat = [NSString stringWithFormat:@"%f",mapInfoModel.location.coordinate.latitude];
    }
    modelR.location = @"1";
    [Consult postConsultDoctorWithParam:modelR success:^(id UFModel) {
        ConsultDocModel *couponlist = (ConsultDocModel *)UFModel;
        if ([couponlist.apiStatus intValue]==1001003 || [couponlist.apiStatus intValue]==1001002) {
            [self loginButtonClick];
            self.isClickedBtn = NO;
            return;
        }else if([couponlist.apiStatus intValue]==0){
            [QWGLOBALMANAGER appHadConsult];
            XPChatViewController *xpVC = [[UIStoryboard storyboardWithName:@"XPChatViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"XPChatViewController"];
            ConsultInfoModel *model = [ConsultInfoModel new];
            model.title = modelR.title;
            model.list = [self.arrPhotos mutableCopy];
            model.consultId = couponlist.consultId;
            model.firstConsultId = [NSString stringWithFormat:@"%@",((ConsultDetailModel *)couponlist.details[0]).detailId];
            xpVC.showType = MessageShowTypeNewCreate;
            xpVC.messageSender = [NSString stringWithFormat:@"%@",couponlist.consultId];
            xpVC.consultInfo = model;
            xpVC.avatarUrl = model.storeModel.imgUrl;
            if (self.navigationController.viewControllers.count>=2) {
                xpVC.delegatePopVC=[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
            }
            [self.navigationController pushViewController:xpVC animated:YES];
        }else{
            [self showError:couponlist.apiMessage];
            self.isClickedBtn = NO;
        }
    }failure:^(HttpException *e) {
        [self showError:kWarning39];
        self.isClickedBtn = NO;
    }];

}

// 保存成员信息
- (void)saveMemberInfo
{
    if (QWGLOBALMANAGER.currentNetWork == NotReachable) {
        [SVProgressHUD showErrorWithStatus:kWarning12 duration:0.8f];
        return;
    }
    if (self.isClickedBtn == YES) {
        return;
    }
    
    if (![self checkAllRequiredInfo]) {
        return;
    }
    if ([self judgeNeedShowPregnancy]) {
        
    } else {
        self.memberDetail.pregnancy = @"N";
    }
    self.isClickedBtn = YES;
    if (self.enumTypeEdit == MemberViewTypeAdd) {
        // 添加成员
        AddFamilyMemberR *modelR = [AddFamilyMemberR new];
        modelR.name = self.memberDetail.name;
        modelR.sex = self.memberDetail.sex;
        modelR.birthday = self.memberDetail.birthday;
        modelR.allergy = self.memberDetail.allergy;
        modelR.pregnancy = self.memberDetail.pregnancy;
        modelR.slowIds = [self convertSlowIdsToStr:self.memberDetail.slowDiseases];
        modelR.token = QWGLOBALMANAGER.configure.userToken;
        [FamilyMedicine addFamilyMember:modelR success:^(id member) {
            if (!self.isFromConsultDoctor) {
                [QWGLOBALMANAGER postNotif:NOtifSaveFamilyInfo data:nil object:self];
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                self.memberDetail = (FamilyMemberDetailVo *)member;
                QWGLOBALMANAGER.selectedFamilyMemberID = self.memberDetail.memberId;
                [self submitToChat];
            }
        } failure:^(HttpException *e) {
//            [self showError:e.description];
            self.isClickedBtn = NO;
        }];
    } else {
        // 保存成员
        UpdateFamilyMemberR *modelR = [UpdateFamilyMemberR new];
        modelR.memberId = self.memberDetail.memberId;
        modelR.name = self.memberDetail.name;
        modelR.sex = self.memberDetail.sex;
        modelR.birthday = self.memberDetail.birthday;
        modelR.allergy = self.memberDetail.allergy;
        modelR.pregnancy = self.memberDetail.pregnancy;
        modelR.token = QWGLOBALMANAGER.configure.userToken;
        modelR.slowIds = [self convertSlowIdsToStr:self.memberDetail.slowDiseases];
        [FamilyMedicine updateFamilyMember:modelR success:^(id member) {
            if (!self.isFromConsultDoctor) {
                [QWGLOBALMANAGER postNotif:NOtifSaveFamilyInfo data:nil object:self];
                [self.navigationController popViewControllerAnimated:YES];
            } else {
            self.memberDetail = (FamilyMemberDetailVo *)member;
            QWGLOBALMANAGER.selectedFamilyMemberID = self.memberDetail.memberId;
            [self submitToChat];
            }
        } failure:^(HttpException *e) {
            self.isClickedBtn = NO;
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 根据Id获取成员信息
- (void)getMemberInfo
{
    if (self.strMemID.length <= 0) {
        return;
    }
    GetMemberInfoR *modelR = [GetMemberInfoR new];
    modelR.memberId = self.strMemID;
    [FamilyMedicine getMemberInfo:modelR success:^(id member) {
        self.memberDetail = (FamilyMemberDetailVo *)member;
        if (self.memberDetail.slowDiseases.count > 0) {
            self.isShowDisease = YES;
            for (SlowDiseaseVo *modelVo in self.memberDetail.slowDiseases) {
                [self.arrDisNames addObject:modelVo.name];
            }
        } else {
            self.isShowDisease = NO;
        }
        [self.tbViewContent reloadData];
    } failure:^(HttpException *e) {
        
    }];
}

- (void)popTheNameTF
{
    MemberNameCell *cellName = (MemberNameCell *)[self.tbViewContent cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cellName.tfName becomeFirstResponder];
}

- (NSString *)convertDateToString:(NSDate *)date withFormatStr:(NSString *)strFormatter
{
    NSString *strDate = @"";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:strFormatter];
    strDate = [formatter stringFromDate:date];
    return strDate;
}

- (NSDate *)convertStringToDate:(NSString *)str withFormatStr:(NSString *)strFormatter
{
    NSDate *dateCur = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:strFormatter];
    dateCur = [formatter dateFromString:str];
    return dateCur;
}



#pragma mark - UITableView methods
- (void)changeAllergy:(BOOL)isAllergy
{
    if (isAllergy) {
        self.memberDetail.allergy = @"Y";
    } else {
        self.memberDetail.allergy = @"N";
    }
    [self.tbViewContent reloadData];
}

- (void)changeGender:(BOOL)isMan
{
    if (isMan) {
        self.memberDetail.sex = @"M";
    } else {
        self.memberDetail.sex = @"F";
    }
    [self judgeNeedShowPregnancy];
    [self.tbViewContent reloadData];
}
- (void)changePregnancy:(BOOL)isPregnancy
{
    if (isPregnancy) {
        self.memberDetail.pregnancy = @"Y";
    } else {
        self.memberDetail.pregnancy = @"N";
    }
    [self.tbViewContent reloadData];
}

- (void)cancelSelecteDate
{
    [self.view endEditing:YES];
}

// 从时间控件返回时间
- (void)selectDateInPicker:(NSDate *)dateCurrent
{
    NSString *str;
    str= [self convertDateToString:dateCurrent withFormatStr:@"yyyy-MM-dd"];
    self.memberDetail.birthday = str;
    [self judgeNeedShowPregnancy];
    [self.tbViewContent reloadData];
    [self.view endEditing:YES];
}

// 通过代理，设置是否传染病
- (void)setAllergyCellData:(MemberAllergyCell *)cell
{
    cell.cellDelegate = self;
    cell.btnTrue.selected = NO;
    cell.btnFalse.selected = NO;
    if ([self.memberDetail.allergy isEqualToString:@"U"]) {
        cell.btnFalse.selected = YES;
    } else if ([self.memberDetail.allergy isEqualToString:@"Y"]) {
        cell.btnTrue.selected = YES;
    } else {
        cell.btnFalse.selected = YES;
    }
}

// 通过代理，设置是否怀孕
- (void)setPregnancyCellData:(MemberPregnancyCell *)cell
{
    cell.cellDelegate = self;
    cell.btnTrue.selected = NO;
    cell.btnFalse.selected = NO;
    if ([self.memberDetail.pregnancy isEqualToString:@"U"]) {
        cell.btnFalse.selected = YES;
    } else if ([self.memberDetail.pregnancy isEqualToString:@"Y"]) {
        cell.btnTrue.selected = YES;
    } else {
        cell.btnFalse.selected = YES;
    }
}

// 创建慢病按钮
- (UIButton *)createTagButtonWithTitle:(NSString *)title WithIndex:(NSUInteger)index withOffset:(CGFloat)offset withHeight:(CGFloat)floatHeight
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:RGBHex(qwColor8) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:Kfont];
    UIImage *resizeImage = nil;

    resizeImage = [UIImage imageNamed:@"btn_bg_tag"];
    resizeImage = [resizeImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10,10, 10) resizingMode:UIImageResizingModeStretch];
    CGSize size = [title sizeWithFont:button.titleLabel.font constrainedToSize:CGSizeMake(300, 20)];
    button.frame = CGRectMake(offset, floatHeight, Kfont * (title.length + 1), 20.0f);
    [button setBackgroundImage:resizeImage forState:UIControlStateNormal];
    return button;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            MemberNameCell *cellName = [tableView dequeueReusableCellWithIdentifier:@"cellName"];
            cellName.separatorLine.hidden = YES;
            cellName.tfName.text = self.memberDetail.name;
            cellName.tfName.delegate = self;
            cellName.tfName.tag = 233;
            return cellName;
        }
        case 1:
        {
            // 性别cell
            MemberGenderCell *cellGender = [tableView dequeueReusableCellWithIdentifier:@"cellGender"];
            cellGender.btnMan.selected = NO;
            cellGender.btnWoman.selected = NO;
            cellGender.cellDelegate = self;
            if ([self.memberDetail.sex isEqualToString:@"U"]) {
                self.memberDetail.sex = @"M";
                cellGender.btnMan.selected = YES;
            } else if ([self.memberDetail.sex isEqualToString:@"M"]) {
                cellGender.btnMan.selected = YES;
            } else if ([self.memberDetail.sex isEqualToString:@"F"]){
                cellGender.btnWoman.selected = YES;
            } else {
                self.memberDetail.sex = @"M";
                cellGender.btnMan.selected = YES;
            }
            return cellGender;
        }
        case 2:
        {
            // 设置时间
            MemberAgeCell *cellAge = [tableView dequeueReusableCellWithIdentifier:@"cellBirth"];
            if (self.memberDetail.birthday.length > 0) {
                NSArray *arrDate = [self.memberDetail.birthday componentsSeparatedByString:@"-"];
                if (arrDate.count == 3) {       // 容错处理
                    NSDate *datePic = [self convertStringToDate:self.memberDetail.birthday withFormatStr:@"yyyy-MM-dd"];
                    [self.pickerBirth setPickerDate:datePic];
                } else {
                    NSDate *datePic = [self convertStringToDate:self.memberDetail.birthday withFormatStr:@"yyyy-MM"];
                    [self.pickerBirth setPickerDate:datePic];
                }
            }
            cellAge.tfAgeSelect.inputView = self.pickerBirth;
            cellAge.tfAgeSelect.text = self.memberDetail.birthday;
            return cellAge;
        }
        case 3:
        {
            // 拓展信息cell
            UITableViewCell *cellName = [tableView dequeueReusableCellWithIdentifier:@"cellExpandInfo"];
            return cellName;
        }
        case 4:
        {
            // 已添加的慢病cell
            UITableViewCell *cellName = [tableView dequeueReusableCellWithIdentifier:@"cellAddDisease"];
            return cellName;
        }
        case 5:
        {
            if (self.isShowDisease) {   // 如果没有慢病，要减少一行
                // 已订阅的慢病cell
                MemberDiseaseListCell *cellList = [tableView dequeueReusableCellWithIdentifier:@"cellDiseaseList"];
                float FrameOfY = 12;
                float btnX = 10.0f;
                for (UIView *subView in cellList.viewDiseaseList.subviews) {
                    [subView removeFromSuperview];
                }
                for(NSString *str in self.arrDisNames){
                    if(APP_W - btnX < Kfont * (str.length + 1)){
                        FrameOfY += 30.0f;
                        btnX = 10.0f;
                    }
                    UIButton *btn = [self createTagButtonWithTitle:str WithIndex:indexPath.row withOffset:btnX withHeight:FrameOfY];
                    btnX += Kfont * (str.length + 2);
                    [cellList.viewDiseaseList addSubview:btn];
                }
                CGRect ret = cellList.viewDiseaseList.frame;
                ret.size.height = FrameOfY + 32.0f;
                cellList.viewDiseaseList.frame = ret;
                return cellList;
            } else {
                // 是否传染病的cell
                MemberAllergyCell *cellAllergy = [tableView dequeueReusableCellWithIdentifier:@"cellAllergy"];
                [self setAllergyCellData:cellAllergy];
                return cellAllergy;
            }
        }
        case 6:
        {
            if (self.isShowDisease) {
                // 是否传染病的cell
                MemberAllergyCell *cellAllergy = [tableView dequeueReusableCellWithIdentifier:@"cellAllergy"];
                [self setAllergyCellData:cellAllergy];
                return cellAllergy;
            } else {
                // 是否怀孕的cell
                MemberPregnancyCell *cellPregnancy = [tableView dequeueReusableCellWithIdentifier:@"cellPregnancy"];
                [self setPregnancyCellData:cellPregnancy];
                return cellPregnancy;
            }
        }
        case 7:
        {   // 是否怀孕的cell
            MemberPregnancyCell *cellPregnancy = [tableView dequeueReusableCellWithIdentifier:@"cellPregnancy"];
            [self setPregnancyCellData:cellPregnancy];
            return cellPregnancy;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isShowDisease) {
        if ([self judgeNeedShowPregnancy]) {
            // 有慢病并且可以选择怀孕
            return 8;
        } else {
            // 有慢病并且不能选择怀孕
            return 7;
        }
    } else {
        if ([self judgeNeedShowPregnancy]) {
            // 没有慢病并且可以选择怀孕
            return 7;
        } else {
            // 没有慢病并且不能选择怀孕
            return 6;
        }
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isShowDisease) {
        if (indexPath.row == 5) {
            float FrameOfY = 12;
            float btnX = 10.0f;
            for(NSString *str in self.arrDisNames){
                if(APP_W - btnX < Kfont * (str.length + 1)){
                    FrameOfY += 30.0f;
                    btnX = 10.0f;
                }
                btnX += Kfont * (str.length + 2);
            }
            CGRect ret = CGRectZero;
            ret.size.height = FrameOfY + 32.0f;
            return ret.size.height;
        }
    }
    if (indexPath.row == 3) {
        return 38.0f;
    }
    return 56.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
        [self performSegueWithIdentifier:@"pushToDisease" sender:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.isFromConsultDoctor) {
        return 80.0f;
    }
    return 0.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.isFromConsultDoctor) {
        return self.tbViewFooter;
    }
    return nil;
}

#pragma mark - UITextField delegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 233) {
        self.memberDetail.name = textField.text;
    }
}

#pragma mark - 慢病订阅
// 保存选择的慢病信息
- (void)savedMemberDiseaseList:(NSArray *)arrDisease
{
    self.hasEnteredEditDisease = YES;
    [self.arrDisNames removeAllObjects];
    if (arrDisease.count > 0) {
        self.isShowDisease = YES;
        self.arrDiseases = arrDisease;
        for (SlowDiseaseVo *modelVo in arrDisease) {
            [self.arrDisNames addObject:modelVo.name];
        }
        self.memberDetail.slowDiseases = arrDisease;
    } else {
        self.isShowDisease = NO;
        self.arrDiseases = @[];
        self.memberDetail.slowDiseases = @[];
    }
    [self.tbViewContent reloadData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"pushToDisease"]) {
        self.hasEnterTheDisease = YES;
        MemberDiseaseListViewController *vcDiseaseList = (MemberDiseaseListViewController *)segue.destinationViewController;
        vcDiseaseList.diseaseDelegate = self;
        vcDiseaseList.modelMember = self.memberDetail;
        if (self.hasEnteredEditDisease) {   // 如果不是第一次进入选择慢病的列表页面，则将已经选择的慢病列表传入，用于编辑
            vcDiseaseList.isEditMode = YES;
            vcDiseaseList.arrSelected = [self.arrDiseases mutableCopy];
        }
    }
}


- (IBAction)actionSubmitInfo:(UIButton *)sender {
    [self saveMemberInfo];
}
@end
