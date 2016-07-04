//
//  FamilyMedicineListViewController.m
//  APP
//
//  Created by carret on 15/8/17.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "FamilyMedicineListViewController.h"
#import "FamilyMedicine.h"
#import "FamilyMedicineCell.h"
#import "FamilyMedicineModel.h"
#import "AddNewFam.h"
#import "AddFamMemViewController.h"
#import "MyPharmacyViewController.h"
#import "FamilyMemberInfoViewController.h"
#import "WebDirectViewController.h"
@interface FamilyMedicineListViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
 
    NSMutableArray *contacts;
    NSMutableArray *familyList;
    NSInteger deleteTag;
    BOOL    memberEdit;
}
@end

@implementation FamilyMedicineListViewController
- (void)UIGlobal{
    //    [super UIGlobal];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"家人用药";

    familyList = [NSMutableArray array];
}
-(void)viewWillAppear:(BOOL)animated
{
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(allSelect:)];
    contacts = [NSMutableArray array];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [super viewWillAppear:animated];
    self.footerView.hidden = YES;
    QueryFamilyMembersR *queryFamilyMembersR = [QueryFamilyMembersR new];
    queryFamilyMembersR.token = QWGLOBALMANAGER.configure.userToken;
    [FamilyMedicine queryFamilyMembers:queryFamilyMembersR success:^(QueryFamilyMembersModel *modle ) {
        familyList = [[NSMutableArray alloc]initWithArray:modle.list];
        for (int i = 0; i <familyList.count; i++) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:@"NO" forKey:@"checked"];
            [contacts addObject:dic];
        }
            memberEdit = NO;
        self.footerView.hidden = NO;
        [self.familyListView reloadData];
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } failure:^(HttpException *e) {
        
    }];
    ((QWBaseNavigationController *)self.navigationController).canDragBack = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    ((QWBaseNavigationController *)self.navigationController).canDragBack = YES;
}

-(void)deleteCell:(UIButton *)sender
{
       UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"是否删除" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.delegate = self;
    UIButton *btn = (UIButton *)sender;
    [alertView show];
    deleteTag = btn.tag;

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        if (buttonIndex == 1) {
            

            FamilyMembersVo *familyMembersVo = [familyList objectAtIndex:deleteTag];
            DeleteFamilyMemberR *deleteFamilyMemberR = [DeleteFamilyMemberR new];
            deleteFamilyMemberR.memberId = familyMembersVo.memberId;
            [FamilyMedicine deleteFamilyMember:deleteFamilyMemberR success:^(id obj ) {
                
            } failure:^(HttpException *e) {
                
            }];

            [familyList removeObjectAtIndex:deleteTag];
            [self.familyListView reloadData];
        }
   
}
-(void)editCell:(UIButton *)sender
{
     UIButton *btn = (UIButton *)sender;
    FamilyMemberInfoViewController *addFamMemViewController = [[UIStoryboard storyboardWithName:@"ConsultForFree" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"FamilyMemberInfoViewController"];
    
    FamilyMembersVo *modelVo =  familyList[btn.tag];
    if ([modelVo.isComplete isEqualToString:@"Y"]) {
        addFamMemViewController.enumTypeEdit = MemberViewTypeEdit;
    } else {
        addFamMemViewController.enumTypeEdit = MemberViewTypeComplete;
    }
    addFamMemViewController.strMemID = modelVo.memberId;
    
    [self.navigationController pushViewController:addFamMemViewController animated:YES];
}
- (void)allSelect:(UINavigationItem*)sender{
    if (contacts.count ==0 ) {
        return;
    }
    NSArray *anArrayOfIndexPath = [NSArray arrayWithArray:[self.familyListView indexPathsForVisibleRows]];
    for (int i = 0; i < [anArrayOfIndexPath count]; i++) {
        NSIndexPath *indexPath= [anArrayOfIndexPath objectAtIndex:i];
        FamilyMedicineCell *cell = (FamilyMedicineCell*)[self.familyListView cellForRowAtIndexPath:indexPath];
        NSUInteger row = [indexPath row];
   
        NSMutableDictionary *dic = [contacts objectAtIndex:row];
        if ([[(UINavigationItem*)sender title] isEqualToString:@"编辑"]) {
            [dic setObject:@"YES" forKey:@"checked"];
            [cell setChecked:YES];
        
        }else {
            [dic setObject:@"NO" forKey:@"checked"];
            [cell setChecked:NO];
        }
    }
    if ([[(UINavigationItem*)sender title]  isEqualToString:@"编辑"]){
        
        memberEdit = YES;
        self.footerView.hidden = YES;
        for (NSDictionary *dic in contacts) {
            [dic setValue:@"YES" forKey:@"checked"];
        }
        [(UINavigationItem*)sender setTitle:@"完成"];
    }else{
        memberEdit = NO;
         self.footerView.hidden = NO;
        for (NSDictionary *dic in contacts) {
            [dic setValue:@"NO" forKey:@"checked"];
        }
        [(UINavigationItem*)sender setTitle:@"编辑" ];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return familyList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FamilyMembersVo *familyMembersVo = [familyList objectAtIndex:indexPath.row];
    FamilyMedicineCell   *cell = [tableView dequeueReusableCellWithIdentifier:@"FamilyMedicineCell"];

    [cell setCell:familyMembersVo];
    [cell.deleteBtn addTarget:self action:@selector(deleteCell:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteBtn.tag = indexPath.row;
    [cell.editBtn addTarget:self action:@selector(editCell:) forControlEvents:UIControlEventTouchUpInside];
    cell.editBtn.tag = indexPath.row;
    NSUInteger row = [indexPath row];
    if (contacts.count>0) {
        NSMutableDictionary *dic = [contacts objectAtIndex:row];
        if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
            [dic setObject:@"NO" forKey:@"checked"];
            [cell setChecked:NO];
            
        }else {
            [dic setObject:@"YES" forKey:@"checked"];
            [cell setChecked:YES];
        }
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] <= 8.0) {
        [cell layoutSubviews];
    }
  
    
    return cell;
}

-(void)addMember:(id)sender
{
    
}

- (void)popVCAction:(id)sender
{
    if (self.fromSlowGuide) {
        QWBaseVC *vcLast = (QWBaseVC *)self.navigationController.viewControllers[self.navigationController.viewControllers.count - 2];
        if ([vcLast isKindOfClass:[WebDirectViewController class]]) {
            QWBaseVC *vcJump = (QWBaseVC *)self.navigationController.viewControllers[self.navigationController.viewControllers.count - 3];
            [self.navigationController popToViewController:vcJump animated:YES];
        }
    } else {
        [super popVCAction:sender];
    }
    if (self.extCallback != nil) {
        self.extCallback(YES);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!memberEdit) {
        FamilyMembersVo *familyMembersVo = [familyList objectAtIndex:indexPath.row];
        MyPharmacyViewController *myPharmacyViewController = [[UIStoryboard storyboardWithName:@"FamilyMedicineListViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MyPharmacyViewController"];
        myPharmacyViewController.hidesBottomBarWhenPushed = YES;
        myPharmacyViewController.familyMembersVo  = familyMembersVo;
        [self.navigationController pushViewController:myPharmacyViewController animated:YES];
    }
}
-(void)edit
{
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    if ([segue.identifier isEqualToString:@"segueToInfo"]) {
//        UIButton *btn = (UIButton *)sender;
//        FamilyMemberInfoViewController *vcInfo = (FamilyMemberInfoViewController *)segue.destinationViewController;
//        //        vcInfo.modelMember = self.arrFamilyList[btn.tag];
//        FamilyMembersVo *modelVo =  familyList[btn.tag];
//        vcInfo.strMemID = modelVo.memberId;
//        vcInfo.enumTypeEdit = MemberViewTypeEdit;
//    } else if ([segue.identifier isEqualToString:@"segueAddMember"]) {
//        FamilyMemberInfoViewController *vcInfo = (FamilyMemberInfoViewController *)segue.destinationViewController;
//        //        vcInfo.modelMember = self.arrFamilyList[btn.tag];
//       
//    }
//}


- (IBAction)pushTo:(id)sender {
    FamilyMemberInfoViewController *addFamMemViewController = [[UIStoryboard storyboardWithName:@"ConsultForFree" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"FamilyMemberInfoViewController"];
     addFamMemViewController.enumTypeEdit = MemberViewTypeAdd;
    [self.navigationController pushViewController:addFamMemViewController animated:YES];
}
@end
