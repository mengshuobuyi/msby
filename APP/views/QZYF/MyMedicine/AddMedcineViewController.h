//
//  AddMedcineViewController.h
//  APP
//
//  Created by carret on 15/8/18.
//  Copyright (c) 2015年 carret. All rights reserved.
//
#import "secondCustomAlertView.h"
#import "QWBaseVC.h"
#import "Box.h"
#import "FamilyMedicineModel.h"
@interface AddMedcineViewController : QWBaseVC
- (IBAction)chooseL:(id)sender;
- (IBAction)koufu:(id)sender;
- (IBAction)waiyong:(id)sender;
- (IBAction)other:(id)sender;
- (IBAction)times:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *PerfectBtn;
@property (nonatomic,assign)BOOL fromPerfect;
@property (nonatomic,strong) NSString *boId;
- (IBAction)yongliang:(id)sender;
- (IBAction)addMember:(id)sender;
@property (nonatomic, copy) void(^InsertNewPharmacy)(QueryMyBoxModel *myboxModel);
@property (nonatomic, copy) void (^boxModelDidChange)(QueryMyBoxModel *myboxModel);
@property (nonatomic ,strong) secondCustomAlertView *customAlertView;
@property (nonatomic, strong) NSMutableDictionary *infoDict;
@property (weak, nonatomic) IBOutlet UILabel *memebers;
@property (weak, nonatomic) IBOutlet UIPickerView *yongliangPicker;
@end
