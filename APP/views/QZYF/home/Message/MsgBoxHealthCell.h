//
//  MsgBoxHealthCell.h
//  APP
//
//  Created by  ChenTaiyu on 16/6/23.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIResponder+Router.h"
#import "MLEmojiLabel.h"

extern NSString *const kRouterEventMsgBoxHealthCellLink;
extern NSString *const kRouterEventMsgBoxHealthCellActionBtn;

@class MsgBoxHealthItemModel;

@interface MsgBoxHealthBaseCell : UITableViewCell
//<<< abstract
+ (CGFloat)getCellHeightWithModel:(MsgBoxHealthItemModel *)model;
+ (instancetype)cell;
//- (void)setCell:(id)obj;
- (void)setCell:(id)obj tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
//>>>
+ (CGFloat)getCachedCellHeightWithModel:(MsgBoxHealthItemModel *)model tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end

@interface MsgBoxHealthDietTipsCell : MsgBoxHealthBaseCell
@end

@interface MsgBoxHealthCell : MsgBoxHealthBaseCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *midSeperator;
@end

@interface MsgBoxHealthCell2 : MsgBoxHealthBaseCell
@property (weak, nonatomic) IBOutlet UILabel *contentTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomSeperator;
@end

@interface MsgBoxHealthCell3 : MsgBoxHealthBaseCell
@end

@interface MsgBoxHealthCell4 : MsgBoxHealthBaseCell
@end

@interface MsgBoxHealthCell5 : MsgBoxHealthBaseCell
@end