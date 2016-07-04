//
//  AddMedcineViewController.m
//  APP
//
//  Created by carret on 15/8/18.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "AddMedcineViewController.h"
#import "FamilyMedicineModel.h"
#import "FamilyMedicineR.h"
#import "FamilyMedicine.h"
#import "LeveyPopListViewNew.h"
@interface AddMedcineViewController ()<LeveyPopListViewDelegate>
@property (nonatomic, strong) NSArray           *usageList;
@property (nonatomic, strong) NSArray           *unitList;
@property (nonatomic, strong) NSArray           *periodList;
@property (nonatomic, strong) NSMutableArray    *useNameList;
@property (nonatomic, strong) NSArray           *frequencyList;
@end

@implementation AddMedcineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.usageList = @[@"口服",@"外用",@"其他"];
    self.unitList = @[@"粒",@"袋",@"包",@"瓶",@"克",@"毫克",@"毫升",@"片",@"支",@"滴",@"枚",@"块",@"盒",@"喷"];
 
    
    NSString *homePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat: @"Documents/%@",QWGLOBALMANAGER.configure.userName]];
    homePath = [NSString stringWithFormat:@"%@/UserNameList.plist",homePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:homePath])
    {
        self.useNameList = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"UserNameList" ofType:@"plist"]];
        [self.useNameList writeToFile:homePath atomically:YES];
    }else{
        self.useNameList = [NSMutableArray arrayWithContentsOfFile:homePath];
    }
    self.periodList = @[@"每日",@"每2日",@"每3日",@"每4日",@"每5日",@"每6日",@"每7日",@"即需即用"];
    self.frequencyList = @[@"1次",@"2次",@"3次",@"4次",@"5次"];

    if (self.fromPerfect) {
        self.PerfectBtn.hidden = YES;
         MedicineDetailR *medicine = [MedicineDetailR new];
        medicine.boId = self.boId;
        [FamilyMedicine medicineDetail:medicine success:^(id obj) {
            MedicineDetailModel *modle = (MedicineDetailModel *)obj;
        } failure:^(HttpException *e) {
            
        }];
    }else
    {
        self.PerfectBtn.hidden = NO;
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)UIGlobal{
    //    [super UIGlobal];
}
/*
#pragma mark - Navigation

 In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     Get the new view controller using [segue destinationViewController].
     Pass the selected object to the new view controller.
}
*/


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}


// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 2;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
     [pickerView selectedRowInComponent:component];
    return view;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}
- (IBAction)chooseL:(id)sender {
}

- (IBAction)koufu:(id)sender {
}

- (IBAction)waiyong:(id)sender {
}

- (IBAction)other:(id)sender {
}

- (IBAction)times:(id)sender {
}

- (IBAction)yongliang:(id)sender {
}

- (IBAction)addMember:(id)sender {
    LeveyPopListViewNew *popListView = [[LeveyPopListViewNew alloc] initWithTitle:@"请选择用法" options:self.useNameList];
    popListView.delegate = self;
    popListView.tag = 5;
    if(self.infoDict[@"useName"])
        popListView.selectedIndex = [self compareAdapter:self.infoDict[@"useName"] WithFilterArray:self.useNameList];
    [popListView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.6]];
    [popListView showInView:self.view animated:YES];
}
- (NSInteger)compareAdapter:(NSString *)adapter WithFilterArray:(NSArray *)array
{
    for(NSString *filter in array)
    {
        if([filter isEqualToString:adapter]) {
            return [array indexOfObject:filter];
        }
    }
    return -1;
}
#pragma mark - UIAlertViewDelegate
- (void)leveyPopListView:(LeveyPopListViewNew *)popListView didSelectedIndex:(NSInteger)anIndex
{
    
    switch (popListView.tag)
    {
        case 1:{
            NSString *title = self.usageList[anIndex];
            self.infoDict[@"useMethod"] = title;
//            [self.usageButton setTitle:title forState:UIControlStateNormal];
//            [self.usageButton setTitleColor:RGBHex(kColor5) forState:UIControlStateNormal];
            break;
        }
        case 2:{
            NSString *title = self.unitList[anIndex];
            self.infoDict[@"unit"] = title;
//            [self.unitButton setTitleColor:RGBHex(kColor5) forState:UIControlStateNormal];
//            [self.unitButton setTitle:title forState:UIControlStateNormal];
            
            break;
        }
        case 3:{
//            NSString *title = self.periodList[anIndex];
//            NSString *intervalDay = [title substringWithRange:NSMakeRange(1, 1)];
//            if([intervalDay isEqualToString:@"日"]) {
//                intervalDay = @"1";
//            }
//            if([title isEqualToString:@"即需即用"]){
//                intervalDay = @"0";
//                self.frequencyButton.userInteractionEnabled = NO;
//                NSString *title = self.frequencyList[0];
//                NSString *drugTime = [title substringWithRange:NSMakeRange(0, 1)];
//                self.infoDict[@"drugTime"] = [NSNumber numberWithInt:[drugTime integerValue]];
//                [self.frequencyButton setTitleColor:RGBHex(kColor5) forState:UIControlStateNormal];
//                [self.frequencyButton setTitle:@"次数" forState:UIControlStateNormal];
//            }else{
//                self.frequencyButton.userInteractionEnabled = YES;
//            }
//            
//            self.infoDict[@"intervalDay"] = [NSNumber numberWithInt:[intervalDay integerValue]];
//            [self.periodButton setTitleColor:RGBHex(kColor5) forState:UIControlStateNormal];
//            [self.periodButton setTitle:title forState:UIControlStateNormal];
            break;
        }
        case 4:{
            NSString *title = self.frequencyList[anIndex];
            NSString *drugTime = [title substringWithRange:NSMakeRange(0, 1)];
            self.infoDict[@"drugTime"] = [NSNumber numberWithInt:[drugTime integerValue]];
//            [self.frequencyButton setTitleColor:RGBHex(kColor5) forState:UIControlStateNormal];
//            [self.frequencyButton setTitle:title forState:UIControlStateNormal];
            break;
        }
        case 5:
        {
            if(anIndex == (self.useNameList.count - 1)) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alertView.tag = 999;
                NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"secondCustomAlertView" owner:self options:nil];
                self.customAlertView = [nibViews objectAtIndex: 0];
                self.customAlertView.textField.frame = CGRectMake(self.customAlertView.textField.frame.origin.x, self.customAlertView.textField.frame.origin.y, self.customAlertView.textField.frame.size.width, 48);
                self.customAlertView.textField.placeholder = @"";
                self.customAlertView.textField.font = fontSystem(15.0f);
                self.customAlertView.textField.textColor = RGBHex(kColor5);
                
                self.customAlertView.textField.layer.masksToBounds = YES;
                self.customAlertView.textField.layer.borderWidth = 0.5;
                self.customAlertView.textField.layer.borderColor = RGBHex(kColor8).CGColor;
                self.customAlertView.textField.layer.cornerRadius = 3.0f;
                UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 0)];
                self.customAlertView.textField.leftView = paddingView;
                self.customAlertView.textField.leftViewMode = UITextFieldViewModeAlways;
                if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
                    [alertView setValue:self.customAlertView forKey:@"accessoryView"];
                }else{
                    [alertView addSubview:self.customAlertView];
                }
                [alertView show];
                
            }
            else{
                self.infoDict[@"useName"] = self.useNameList[anIndex];
            }
//            [self.tableView reloadData];
            break;
        }
        default:
            break;
    }
//    [self adjustUseageDetailLabel];
}

- (void)leveyPopListViewDidCancel
{
    
}

@end
