//
//  PharmacySotreSearchTableViewCell.h
//  APP
//
//  Created by 李坚 on 16/1/5.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultStoreModel.h"

@interface PharmacySotreSearchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mainAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailAddressLabel;

+ (CGFloat)getCellHeight:(id)data;
- (void)setCell:(MicroMallBranchVo *)model;

@end
