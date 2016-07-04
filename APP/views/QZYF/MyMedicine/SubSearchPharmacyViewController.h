//
//  SubSearchPharmacyViewController.h
//  wenyao
//
//  Created by xiezhenghong on 14-10-24.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPharmacyViewController.h"

@interface SubSearchPharmacyViewController : QWBaseVC

@property (nonatomic, strong) NSMutableArray            *myMedicineList;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *navVIew;
@property (strong ,nonatomic)FamilyMembersVo *familyMembersVo;

@property (nonatomic,strong)NSString *memberId;
@end
