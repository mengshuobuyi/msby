//
//  UserCenterViewCell.h
//  wenyao
//
//  Created by Meng on 15/1/27.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseTableCell.h"

@interface UserCenterViewCell : QWBaseTableCell
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *TagImage;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

/**
 *  图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;

/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/**
 *  我关注的药房 数字
 */
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end
