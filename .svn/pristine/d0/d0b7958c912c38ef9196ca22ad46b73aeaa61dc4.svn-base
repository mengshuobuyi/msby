//
//  CircleDetailCell.h
//  wenYao-store
//
//  Created by Yang Yuexia on 15/12/31.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "QWBaseTableCell.h"
#import "MGSwipeTableCell.h"
#import "QWImageView.h"
#import "QWLabel.h"


@protocol CircleDetailCellDelegate <NSObject>

- (void)tapHeadericon:(NSIndexPath *)indexpath;

@end

@interface CircleDetailCell : MGSwipeTableCell

@property (assign, nonatomic) id <CircleDetailCellDelegate> circleDetailCellDelegate;
@property (weak, nonatomic) IBOutlet UIView *contentBgView;

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet QWImageView *headerIcon; //头像
@property (weak, nonatomic) IBOutlet QWLabel *name; //姓名

@property (weak, nonatomic) IBOutlet UILabel *expertLogoLabel;

@property (weak, nonatomic) IBOutlet UILabel *expertBrandLabel;

@property (weak, nonatomic) IBOutlet UILabel *time; //时间

@property (weak, nonatomic) IBOutlet UIView *lvlBgView;
@property (weak, nonatomic) IBOutlet UILabel *lvlLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *name_layout_width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *expertBrand_layout_width;

@property (weak, nonatomic) IBOutlet UILabel *readNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentNumLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *readNum_layout_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentNum_layout_width;


@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UILabel *title; //标题
@property (weak, nonatomic) IBOutlet UILabel *content; //内容
@property (weak, nonatomic) IBOutlet UIView *imageBgView; //图片背景
@property (weak, nonatomic) IBOutlet UIImageView *imageOne;
@property (weak, nonatomic) IBOutlet UIImageView *imageTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imageThree;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_layout_height; //标题高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageBgView_layout_height; //图片背景高度约束

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageOne_layout_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageOne_layout_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTwo_layout_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTwo_layout_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageThree_layout_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageThree_layout_width;

//我的发帖列表
- (void)myPostTopic:(id)data;

- (void)myCollectionTopic:(id)data;

@end
