//
//  FamilyMedicineCell.h
//  APP
//
//  Created by carret on 15/8/18.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QWBaseCell.h"

@interface FamilyMedicineCell : QWBaseCell{
    BOOL			m_checked;
    UIImageView*	m_checkImageView;
}
- (void)setChecked:(BOOL)checked;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftHeadImg;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *drugCount;
@property (weak, nonatomic) IBOutlet UILabel *descripte;
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (copy ,nonatomic)NSString * isSelf;
@end
