//
//  AddNewMedicineViewController.h
//  wenyao
//
//  Created by Pan@QW on 14-9-22.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseVC.h"
#import "secondCustomAlertView.h"
#import "Box.h"
#import "ZHPickView.h"

@class FamilyMembersVo;
typedef void (^PushToMyMedicineList)();

@interface AddNewMedicineViewController : QWBaseVC<UIPickerViewDelegate,UIPickerViewDataSource>

//0为新增模式    1为编辑模式需要填充数据
@property (nonatomic, assign) NSUInteger        editMode;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIPickerView *timesPicker;
@property (weak, nonatomic) IBOutlet UIImageView *irrowRightImg;

@property (nonatomic, strong) IBOutlet  UIView  *footerView;
 @property (nonatomic, strong) IBOutlet  UILabel   *usageDetailLabel;
 @property (strong, nonatomic)  ZHPickView *yongfaPicker;
- (IBAction)bgBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *bgBtn;

@property (strong, nonatomic)  ZHPickView *yongliangPicker;
@property (nonatomic, strong) PushToMyMedicineList blockPush;
@property (nonatomic, copy) QueryMyBoxModel *queryMyBoxModel;
@property (nonatomic, copy) void(^InsertNewPharmacy)(QueryMyBoxModel *myboxModel);
@property (nonatomic, copy) void (^boxModelDidChange)(QueryMyBoxModel *myboxModel);
@property (weak, nonatomic) IBOutlet UIView *medcineView;

@property (weak, nonatomic) IBOutlet UIView *userViw;
 @property (weak, nonatomic) IBOutlet UILabel *timesLable;
@property (weak, nonatomic) IBOutlet UILabel *yongliangLable;
 
- (IBAction)chooseMedcine:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkMedcine;
- (IBAction)timesBtn:(id)sender;
- (IBAction)yongliangBtn:(id)sender;
- (IBAction)chooseUser:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *chooseUser;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
 @property (strong ,nonatomic)NSMutableArray *userArr;
@property (nonatomic ,strong) secondCustomAlertView *customAlertView;
@property (strong ,nonatomic)FamilyMembersVo *familyMembersVo;
@property (weak, nonatomic) IBOutlet UITextField *medicinelabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineO;
 @property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineT;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *medcineTextLeadingR;
 
- (IBAction)useMeather:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *koufu;
@property (weak, nonatomic) IBOutlet UIButton *qita;
@property (weak, nonatomic) IBOutlet UIButton *waiyong;

@property (nonatomic,copy)NSString *memberId;

@property (nonatomic,assign)BOOL   toAddMember;
//- (IBAction)pushIntoScanReaderView:(id)sender;
-(void)queryMemberInfo;
- (void)setPushToMyMedicineBlock:(PushToMyMedicineList)block;
-(void)removeUserInfo;
@end
