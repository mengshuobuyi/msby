//
//  FamliyMedcineViewController.m
//  APP
//
//  Created by carret on 15/8/18.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "FamliyMedcineViewController.h"
#import "FamilyMedicineListViewController.h"
#import "AddNewMedicineViewController.h"
#import "PerfectCell.h"
#import "FamilyMedicine.h"
#import "FamilyMedicineR.h"
#import "FamilyMedicineModel.h"
#import "MyPharmacyViewController.h"
#import "MGSwipeButton.h"
#import "SVProgressHUD.h"
#import "WebDirectViewController.h"
#import "AnalyzeMedicineViewController.h"

@interface FamliyMedcineViewController ()<UITableViewDataSource,UITableViewDelegate,MGSwipeTableCellDelegate,UIAlertViewDelegate>
{
    NSMutableArray *noCompleteList;
}
@end

@implementation FamliyMedcineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"家庭药箱";
    noCompleteList = [NSMutableArray array];
          self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed: @"ic_btn_explain"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(help:)];
    self.descripView.hidden = YES;

    // Do any additional setup after loading the view.
}
- (void)UIGlobal{
//    [super UIGlobal];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    QueryNoCompleteMedicineR *queryNoCompleteMedicineR = [QueryNoCompleteMedicineR new];
    queryNoCompleteMedicineR.token = QWGLOBALMANAGER.configure.userToken;
    [FamilyMedicine queryNoCompleteMedicine:queryNoCompleteMedicineR success:^(id ojj) {
        QueryNoCompleteMedicineModel *model = (QueryNoCompleteMedicineModel *)ojj;
        if ([model.apiStatus integerValue]== 0) {
            
            noCompleteList =  [[NSMutableArray alloc]initWithArray:model.list];
            [self.noCompleteTable reloadData];
      
        }
        else if ([model.apiStatus integerValue] ==1)
        {
                self.descripImgView.image = [UIImage imageNamed:@"ic_img_fail"];
                self.descripLabel.text = model.apiMessage;
                self.descripView.hidden = NO;
            self.noCompleteTable.hidden = YES;
        }
        else
        {
                self.descripImgView.image = [UIImage imageNamed:@"ic_img_yes"];
                self.descripView.hidden = NO;
                self.descripLabel.text = model.apiMessage;
              self.noCompleteTable.hidden = YES;
        }
    } failure:^(HttpException *e) {
        
    }];
}
-(void)help:(id)sender
{
    WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
    modelLocal.typeLocalWeb = WebLocalTypeMedicineHelp;
    [vcWebDirect setWVWithLocalModel:modelLocal];
    
    vcWebDirect.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vcWebDirect animated:YES];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return noCompleteList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MemberMedicine *memberMedicine = [noCompleteList objectAtIndex:indexPath.row];
    PerfectCell   *cell = [tableView dequeueReusableCellWithIdentifier:@"PerfectCell"];
    cell.perfBtn.tag = indexPath.row;
//     cell.imgUrl.image = [UIImage imageNamed:@"img_medical-notice-brand_nomal"];
    cell.imgUrl.placeholderName = @"img_medical-notice-brand_nomal";
    [cell setCell:memberMedicine];
    cell.swipeDelegate = self;
        [self layoutTableView:tableView withTableViewCell:cell WithTag:memberMedicine];
        //    if (cell.editing == YES) {
        //        cell.deleteBtn.hidden = NO;
        //    }
//        [cell.deleteBtn addTarget:self action:@selector(deleteCell:) forControlEvents:UIControlEventTouchUpInside];
//        cell.deleteBtn.tag = indexPath.row;
//        [cell.editBtn addTarget:self action:@selector(editCell:) forControlEvents:UIControlEventTouchUpInside];
//        cell.editBtn.tag = indexPath.row;
 
   
        return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MemberMedicine *memberMedicine = [noCompleteList objectAtIndex:indexPath.row];
    
    AddNewMedicineViewController *addFamMemViewController = [[UIStoryboard storyboardWithName:@"FamilyMedicineListViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"AddNewMedicineViewController"];
    addFamMemViewController.editMode = 1;
    addFamMemViewController.queryMyBoxModel = [QueryMyBoxModel new];
    addFamMemViewController.queryMyBoxModel.boxId = memberMedicine.boId;
    addFamMemViewController.queryMyBoxModel.proId = memberMedicine.proId;
    addFamMemViewController.queryMyBoxModel.productName = memberMedicine.name;
    addFamMemViewController.queryMyBoxModel.drugTag = memberMedicine.medicineTag;
    if (memberMedicine.perCount ==nil) {
        
    }
    if (memberMedicine.intervalDays ==nil) {
        
    }
    if (memberMedicine.drugTime ==nil) {
        
    }
    if (memberMedicine.perCount ==nil) {
        
    }
    addFamMemViewController.queryMyBoxModel.useMethod = memberMedicine.useMethod;
    addFamMemViewController.queryMyBoxModel.perCount = memberMedicine.perCount;
    addFamMemViewController.queryMyBoxModel.intervalDay = memberMedicine.intervalDays;
    addFamMemViewController.queryMyBoxModel.drugTime = memberMedicine.drugTime;
    addFamMemViewController.queryMyBoxModel.effect = memberMedicine.effect;
    addFamMemViewController.queryMyBoxModel.unit = memberMedicine.unit;
    //    addFamMemViewController.queryMyBoxModel.boxId = memberMedicine.imgUrl;
    //    addFamMemViewController.fromPerfect = NO;
    //    addFamMemViewController.boId = memberMedicine.boId;
//    [addFamMemViewController queryMemberInfo];
    [self.navigationController pushViewController:addFamMemViewController animated:YES];
}
- (IBAction)pushToFm:(id)sender {
    FamilyMedicineListViewController *famliyMedcineViewController = [[UIStoryboard storyboardWithName:@"FamilyMedicineListViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"FamilyMedicineListViewController"];
    [self.navigationController pushViewController:famliyMedcineViewController animated:YES];
}

- (IBAction)PerfectMedcine:(id)sender {
       UIButton *btn = (UIButton *)sender;
    MemberMedicine *memberMedicine = [noCompleteList objectAtIndex:btn.tag];
    
    AddNewMedicineViewController *addFamMemViewController = [[UIStoryboard storyboardWithName:@"FamilyMedicineListViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"AddNewMedicineViewController"];
    addFamMemViewController.editMode = 1;
    addFamMemViewController.queryMyBoxModel = [QueryMyBoxModel new];
    addFamMemViewController.queryMyBoxModel.boxId = memberMedicine.boId;
    addFamMemViewController.queryMyBoxModel.proId = memberMedicine.proId;
    addFamMemViewController.queryMyBoxModel.productName = memberMedicine.name;
    addFamMemViewController.queryMyBoxModel.drugTag = memberMedicine.medicineTag;
    if (memberMedicine.perCount ==nil) {
        
    }
    if (memberMedicine.intervalDays ==nil) {
        
    }
    if (memberMedicine.drugTime ==nil) {
        
    }
    if (memberMedicine.perCount ==nil) {
        
    }
    addFamMemViewController.queryMyBoxModel.useMethod = memberMedicine.useMethod;
    addFamMemViewController.queryMyBoxModel.perCount = memberMedicine.perCount;
    addFamMemViewController.queryMyBoxModel.intervalDay = memberMedicine.intervalDays;
    addFamMemViewController.queryMyBoxModel.drugTime = memberMedicine.drugTime;
    addFamMemViewController.queryMyBoxModel.effect = memberMedicine.effect;
    addFamMemViewController.queryMyBoxModel.unit = memberMedicine.unit;
    //    addFamMemViewController.queryMyBoxModel.boxId = memberMedicine.imgUrl;
    //    addFamMemViewController.fromPerfect = NO;
    //    addFamMemViewController.boId = memberMedicine.boId;
    [self.navigationController pushViewController:addFamMemViewController animated:YES];
}


- (void)layoutTableView:(UITableView *)atableView withTableViewCell:(UITableViewCell *)cell WithTag:(MemberMedicine *)tagsDict
{
    for(UIView *button in cell.contentView.subviews) {
        if(button.frame.origin.y == 67.0)
            [button removeFromSuperview];
    }
    CGFloat offset = 84;
    UIButton *button = nil;
    NSUInteger index = 0;
    
    index = [noCompleteList indexOfObject:tagsDict];
    
   // if(tagsDict.medicineTag && ![tagsDict.medicineTag isEqualToString:@""])
    if (!StrIsEmpty(tagsDict.medicineTag))
    {
        NSString *strDrugTag = tagsDict.medicineTag;
        DDLogVerbose(@"the drug tag is %@",strDrugTag);
        if (strDrugTag.length > 6) {
            strDrugTag = [strDrugTag substringToIndex:6];
        }
        
        button = [self createTagButtonWithTitle:strDrugTag WithIndex:index tagType:DrugTag withOffset:offset];
        [cell.contentView addSubview:button];
        offset += button.frame.size.width + 5;
        if(![atableView isEqual:self.noCompleteTable]) {
            button.tag *= -1;
        }
    }
 
   // if(tagsDict.effect && ![tagsDict.effect isEqualToString:@""])
    if(!StrIsEmpty(tagsDict.effect))
    {
        NSString *strEffect = tagsDict.effect;
        if (strEffect.length > 4) {
            strEffect = [strEffect substringToIndex:4];
        }
        button = [self createTagButtonWithTitle:strEffect WithIndex:index tagType:EffectTag withOffset:offset];
        [cell.contentView addSubview:button];
        if(![atableView isEqual:self.noCompleteTable]) {
            button.tag *= -1;
        }
        offset += button.frame.size.width + 5;
    }
 
    //    button = [self createTagButtonWithTitle:@"添加标签" WithIndex:index tagType:AddTag withOffset:offset];
    if(![atableView isEqual:self.noCompleteTable])
    {
        button.tag *= -1;
    }
//    [button addTarget:self action:@selector(showTagDetail:) forControlEvents:UIControlEventTouchDown];
   
    [cell.contentView addSubview:button];
}


- (UIButton *)createTagButtonWithTitle:(NSString *)title WithIndex:(NSUInteger)index tagType:(TagType)tagType withOffset:(CGFloat)offset
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:RGBHex(qwColor7) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:11.0];
    UIImage *resizeImage = nil;
    if([title isEqualToString:self.title]) {
        resizeImage = [UIImage imageNamed:@"btn_bg_tag"];
        [button setTitleColor:RGBHex(qwColor1) forState:UIControlStateNormal];
        resizeImage = [resizeImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    }else{
        resizeImage = [UIImage imageNamed:@"btn_bg_tag"];

        resizeImage = [resizeImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10,10, 10) resizingMode:UIImageResizingModeStretch];
    }
    CGSize size = [title sizeWithFont:button.titleLabel.font constrainedToSize:CGSizeMake(300, 20)];
    button.frame = CGRectMake(offset, 67, size.width + 2 * 10, 20);
    button.tag = index * 1000 + tagType;
    [button setBackgroundImage:resizeImage forState:UIControlStateNormal];
        button.enabled = NO;
    return button;
}

-(NSArray *) createRightButtons: (int) number
{
    NSMutableArray * result = [NSMutableArray array];
    NSString* titles[2] = {@"删除"};
    UIColor * colors[2] = {[UIColor redColor]};
    for (int i = 0; i < number; ++i)
    {
        MGSwipeButton * button = [MGSwipeButton buttonWithTitle:titles[i] backgroundColor:colors[i] callback:^BOOL(MGSwipeTableCell * sender){
            return YES;
        }];
        if(i == 1) {
            [button setTitleColor:RGBHex(qwColor5) forState:UIControlStateNormal];
        }
        [result addObject:button];
    }
    return result;
}



#pragma mark -
#pragma mark MGSwipeTableCellDelegate
-(NSArray*) swipeTableCell:(MGSwipeTableCell*)cell
  swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*)swipeSettings
         expansionSettings:(MGSwipeExpansionSettings*)expansionSettings;
{
    
    if (direction == MGSwipeDirectionRightToLeft)
    {

            return [self createRightButtons:1];
    
    }
    return nil;
}

-(BOOL) swipeTableCell:(MGSwipeTableCell*)cell tappedButtonAtIndex:(NSInteger)index direction:(MGSwipeDirection)direction fromExpansion:(BOOL)fromExpansion
{
    
    NSIndexPath *  indexPath = [self.noCompleteTable indexPathForCell:cell];
  
    //删除事件
    if (QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        
        [SVProgressHUD showErrorWithStatus:@"网络未连接，请重试" duration:0.8f];
        
        return NO;
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确定要删除该用药吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.delegate = self;
    alertView.tag = indexPath.row;
    [alertView show];
    
    
   
    return YES;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
 
        MemberMedicine *boxModel = nil;
 
        boxModel = noCompleteList[alertView.tag];
     
        
        [noCompleteList removeObject:boxModel];
        [self.noCompleteTable reloadData];
        DeleteMemberMedicineR *deleteMemberMedicineR = [DeleteMemberMedicineR new];
        deleteMemberMedicineR.boId =boxModel.boId;
        [FamilyMedicine deleteMemberMedicine:deleteMemberMedicineR success:^(id obj) {
            DDLogVerbose(@"success ---delete");
        } failure:^(HttpException *e) {
            
        }];
        if (noCompleteList.count == 0) {
            self.descripImgView.image = [UIImage imageNamed:@"ic_img_yes"];
            self.descripView.hidden = NO;
            self.descripLabel.text = @"药品都已成功归类~";
            self.noCompleteTable.hidden = YES;
        }
    }
}

- (IBAction)alasysMedcine:(id)sender {
    AnalyzeMedicineViewController *analyzeMedicineViewController = [[AnalyzeMedicineViewController alloc] initWithNibName:@"AnalyzeMedicineViewController" bundle:nil];
    
//    WebDirectViewController *vcWebDirect = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
//    WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
//    modelLocal.typeLocalWeb = WebLocalTypeAnalyzeMember;
//    [vcWebDirect setWVWithLocalModel:modelLocal];
//    vcWebDirect.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:analyzeMedicineViewController animated:YES];
}
@end
