//
//  MedicineUseTypeTableViewCell.h
//  APP
//
//  Created by 李坚 on 16/2/18.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultStoreModel.h"

@interface MedicineUseTypeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UILabel *useLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sepatorLineHeightConstant;
@property (weak, nonatomic) IBOutlet UIButton *useButton;

+ (CGFloat)getCellHeight:(ProductInstructionsVo *)VO;
- (void)setCell:(ProductInstructionsVo *)VO;
@end
