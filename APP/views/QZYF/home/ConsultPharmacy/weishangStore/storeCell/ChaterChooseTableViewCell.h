//
//  ChaterChooseTableViewCell.h
//  APP
//
//  Created by 李坚 on 16/5/9.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultStoreModel.h"

@interface ChaterChooseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageUrl;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *branchLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodLabel;
@property (weak, nonatomic) IBOutlet UIButton *chatBtn;
@property (weak, nonatomic) IBOutlet UILabel *onlineLabel;

@property (nonatomic, strong) UIView *line;

- (void)setCell:(id)data;
+ (CGFloat)getCellHeight:(MbrInfoVo *)data;

@end
