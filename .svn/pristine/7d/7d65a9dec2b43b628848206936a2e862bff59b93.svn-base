//
//  MyPharmacyViewController.h
//  wenyao
//
//  Created by Pan@QW on 14-9-22.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseVC.h"
#import "FamilyMedicineModel.h"

typedef enum TagType {
    DrugTag = 1,
    UseNameTag = 2,
    EffectTag = 3,
    AddTag,
} TagType;

@interface MyPharmacyViewController : QWBaseVC

@property (nonatomic, strong) NSMutableArray            *myMedicineList;

//YES的话 不需要显示searchBar以及添加标签字段
@property (weak, nonatomic) IBOutlet UILabel *memberDetail;
@property (strong, nonatomic)IBOutlet  UITableView *tableView;
@property (strong ,nonatomic)FamilyMembersVo *familyMembersVo;
- (IBAction)addMedcine:(id)sender;
@property (nonatomic, assign) BOOL                      subType;
@property (nonatomic, assign) BOOL                      shouldScrollToUncomplete;
@property (weak, nonatomic) IBOutlet UIView *subHeadView;
- (IBAction)editMemberInfo:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIView *myHeaderView;
@property (nonatomic,strong)NSString *memberId;
@end
