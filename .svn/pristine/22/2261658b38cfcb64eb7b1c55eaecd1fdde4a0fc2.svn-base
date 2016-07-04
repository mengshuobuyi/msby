//
//  AddFamMemViewController.m
//  APP
//
//  Created by carret on 15/8/18.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "AddFamMemViewController.h"
#import "FamilyMedicineModel.h"
#import "FamilyMedicineR.h"
#import "FamilyMedicine.h"
@interface AddFamMemViewController ()
{
    AddFamilyMemberR *addFamilyMemberR;
}

@end

@implementation AddFamMemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加成员";
    addFamilyMemberR = [AddFamilyMemberR new];
    addFamilyMemberR.allergy = @"U";
    addFamilyMemberR.pregnancy = @"U";
      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(sameMember:)];
    // Do any additional setup after loading the view.
}
-(void)sameMember:(id)sender
{
 
    addFamilyMemberR.token = QWGLOBALMANAGER.configure.userToken;
    
   [ FamilyMedicine addFamilyMember:addFamilyMemberR  success:^(id obj) {
        
    } failure:^(HttpException *e) {
        
    }];
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)male:(id)sender {
    addFamilyMemberR.sex = @"M";
}

- (IBAction)famale:(id)sender {
    addFamilyMemberR.sex = @"F";
}

- (IBAction)year:(id)sender {
    addFamilyMemberR.sex = self.year.text;
}

- (IBAction)have:(id)sender {
    addFamilyMemberR.allergy = @"N";
}

- (IBAction)haveNo:(id)sender {
    addFamilyMemberR.allergy = @"Y";
}

- (IBAction)chooseYes:(id)sender {
    addFamilyMemberR.pregnancy = @"Y";
}

- (IBAction)chooseNo:(id)sender {
    addFamilyMemberR.pregnancy = @"N";
}
@end
