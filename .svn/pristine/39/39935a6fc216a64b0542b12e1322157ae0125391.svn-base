//
//  FamilyMedicineCell.m
//  APP
//
//  Created by carret on 15/8/18.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "FamilyMedicineCell.h"
#import "FamilyMedicineModel.h"
@implementation FamilyMedicineCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)creat{
    if (m_checkImageView == nil)
    {
        m_checkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Unselected.png"]];
        m_checkImageView.frame = CGRectMake(10, 10, 29, 29);
        [self addSubview:m_checkImageView];
    }
}
-(void)setCell:(id)data
{
    FamilyMembersVo *familyMembersVo = (FamilyMembersVo *)data;
    self.isSelf = familyMembersVo.isSelf;
//    if ([familyMembersVo.isSelf isEqualToString:@"Y"]) {
//        self.title.text = [NSString stringWithFormat:@"我"];
//    }else
//    {
        self.title.text = [NSString stringWithFormat:@"%@",familyMembersVo.name];
//    }
    if ([familyMembersVo.isComplete isEqualToString:@"Y"] ) {
        NSMutableString *slowDiseasesStr = [NSMutableString string];
        if (familyMembersVo.slowDiseases.count >0) {
//            for (NSString *modelVo in familyMembersVo.slowDiseases) {
//             
//                
//            }
            for (int i = 0; i<familyMembersVo.slowDiseases.count; i++) {
                NSString *modelVo =familyMembersVo.slowDiseases[i];
                if (i ==0) {
                       [slowDiseasesStr appendFormat:@"，%@",modelVo];
                }else
                {
                       [slowDiseasesStr appendFormat:@"、%@",modelVo];
                }
            }
        }else
        {
          [slowDiseasesStr appendString:@""];
        }
        NSString *allergy = @"";
        if ([familyMembersVo.allergy isEqualToString:@"Y"]) {
            allergy = [NSString stringWithFormat:@"，有药物过敏史"];
        }else if ([familyMembersVo.allergy isEqualToString:@"N"])
        {
            
        }else
        {
            
        }
        NSString *pregnant = @"";
        if ([familyMembersVo.pregnant isEqualToString:@"Y"]) {
            pregnant = [NSString stringWithFormat:@"，孕妇"];
        }else if ([familyMembersVo.pregnant isEqualToString:@"N"])
        {
            
        }else
        {
            
        }
        if ([familyMembersVo.sex isEqualToString:@"F"]) {
            self.descripte.text =[NSString stringWithFormat:@"(女，%@%@%@%@%@)",familyMembersVo.age,familyMembersVo.unit,slowDiseasesStr,pregnant,allergy];
            self.headImg.image = [UIImage imageNamed:@"ic_portrait_woman"];
        }else if ([familyMembersVo.sex isEqualToString:@"M"])
        {
             self.headImg.image = [UIImage imageNamed:@"ic_portrait_man"];
            self.descripte.text =[NSString stringWithFormat:@"(男，%@%@%@%@%@)",familyMembersVo.age,familyMembersVo.unit,slowDiseasesStr,pregnant,allergy];
        }else
        {
            self.descripte.text =[NSString stringWithFormat:@"(%@%@%@%@%@)",familyMembersVo.age,familyMembersVo.unit,slowDiseasesStr,pregnant,allergy];
        }
    }else
    {
        self.descripte.text =[NSString stringWithFormat:@"(请完善资料)"];
    }
   
    self.drugCount.text = [NSString stringWithFormat:@"%@种药品",familyMembersVo.drugCount];
}


- (void)setChecked:(BOOL)checked{
    if (checked)
    {
        self.leftHeadImg.constant = 52;
        self.deleteBtn.hidden = NO;
        self.editBtn.hidden = NO;
//        m_checkImageView.image = [UIImage imageNamed:@"Selected.png"];
//        self.backgroundView.backgroundColor = [UIColor colorWithRed:223.0/255.0 green:230.0/255.0 blue:250.0/255.0 alpha:1.0];
    }
    else
    {
        self.leftHeadImg.constant = 15;
        self.editBtn.hidden = YES;
        self.deleteBtn.hidden = YES;
//        m_checkImageView.image = [UIImage imageNamed:@"Unselected.png"];
//        self.backgroundView.backgroundColor = [UIColor whiteColor];
    }
    if ([self.isSelf isEqualToString:@"Y"]) {
        self.deleteBtn.hidden = YES;
    }
    m_checked = checked;
    
    
}


- (void)awakeFromNib
{
       [self creat];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 70, APP_W, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [self addSubview:line];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
