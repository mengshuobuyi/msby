//
//  ServiceStyleTableViewCell.h
//  APP
//
//  Created by 李坚 on 16/1/4.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultStoreModel.h"

@interface ServiceStyleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *serviceLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *styleLabel;
@property (weak, nonatomic) IBOutlet UILabel *styleMoneyLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *serviceLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *styleLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineWidthConstant;

+ (CGFloat)getCellHeight:(PostTipVo *)data;
- (void)setCell:(id)data;
- (void)addSpeatorLine;

@end
