//
//  EditPatientListViewController.m
//  APP
//
//  Created by PerryChen on 8/24/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "EditPatientListViewController.h"
#import "FamilyMedicine.h"
#import "FamilyMedicineR.h"
#import "FamilyMedicineModel.h"
#import "PatientListCell.h"
#import "FamilyMemberInfoViewController.h"
@interface EditPatientListViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tbContentView;

@property (weak, nonatomic) IBOutlet UIView *viewTBFoot;

@property (nonatomic, assign) NSInteger intSelectedMemberIndex;

@property (weak, nonatomic) IBOutlet UIButton *btnAddMember;

- (IBAction)action_addMember:(UIButton *)sender;

@end

@implementation EditPatientListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)setRightNaviBtn
{
    self.navigationItem.rightBarButtonItems = nil;
//    [self naviRightBotton:@"保存" action:@selector(saveFamilyList)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveFamilyList)];
}

//- (void)popVCAction:(id)sender
//{
//    if (self.isEditMode) {
//        self.isEditMode = NO;
//        [self setRightNaviBtn];
//        [self.tbContentView reloadData];
//        return;
//    } else {
//        [super popVCAction:sender];
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)editFamilyList
{
    [self setRightNaviBtn];
    [self.tbContentView reloadData];
}

- (void)saveFamilyList
{
    [self setRightNaviBtn];
    [self.tbContentView reloadData];
}

#pragma mark - Data source

#pragma mark - UITableView methods
- (void)actionMemberSelected:(UIButton *)btnSelected
{
    NSInteger intPreviousIndex = self.intSelectedMemberIndex;
    self.intSelectedMemberIndex = btnSelected.tag;
    [self.tbContentView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:btnSelected.tag inSection:0],[NSIndexPath indexPathForRow:intPreviousIndex inSection:0], nil] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)actionMemberEdit:(UIButton *)btnEdit
{
    [self performSegueWithIdentifier:@"segueToDetail" sender:btnEdit];
}

- (void)actionMemberDelete:(UIButton *)btnDel
{

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FamilyMembersVo *modelVo = self.arrFamilyList[indexPath.row];
    PatientListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PatientListCell"];

    cell.btnDelete.hidden = NO;
    cell.btnEdit.hidden = NO;
    cell.btnSelect.hidden = YES;

    cell.btnSelect.selected = NO;
    if (indexPath.row == self.intSelectedMemberIndex) {
        cell.btnSelect.selected = YES;
    }
    cell.btnDelete.tag = cell.btnSelect.tag = cell.btnEdit.tag = cell.btnDelete.tag = indexPath.row;
    
    // bind the button action
    [cell.btnSelect addTarget:self action:@selector(actionMemberSelected:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnDelete addTarget:self
                       action:@selector(actionMemberDelete:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnEdit addTarget:self
                     action:@selector(actionMemberEdit:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.lblUserName.text = modelVo.name;
    cell.lblDetailInfo.text = @"完善资料";
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrFamilyList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return self.viewTBFoot;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30.0f;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"segueToDetail"]) {
        UIButton *btn = (UIButton *)sender;
        FamilyMemberInfoViewController *vcInfo = (FamilyMemberInfoViewController *)segue.destinationViewController;
        //        vcInfo.modelMember = self.arrFamilyList[btn.tag];
        FamilyMembersVo *modelVo = self.arrFamilyList[btn.tag];
        vcInfo.strMemID = modelVo.memberId;
        vcInfo.enumTypeEdit = MemberViewTypeEdit;
    } else if ([segue.identifier isEqualToString:@"segueAddMember"]) {
        FamilyMemberInfoViewController *vcInfo = (FamilyMemberInfoViewController *)segue.destinationViewController;
        //        vcInfo.modelMember = self.arrFamilyList[btn.tag];
        vcInfo.enumTypeEdit = MemberViewTypeAdd;
    }
}


- (IBAction)action_addMember:(UIButton *)sender {
    [self performSegueWithIdentifier:@"segueAddMember" sender:sender];
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
