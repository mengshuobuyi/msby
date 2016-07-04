//
//  HotCircleCell.h
//  wenYao-store
//
//  Created by Yang Yuexia on 15/12/17.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "QWBaseTableCell.h"
#import "QWView.h"

@protocol HotCircleCellDelegate <NSObject>

- (void)tapHeader:(NSIndexPath *)indexPath;

@end

@interface HotCircleCell : QWBaseTableCell

@property (assign, nonatomic) id <HotCircleCellDelegate> hotCircleCellDelegate;
@property (weak, nonatomic) IBOutlet UIView *contentBgView;

//top
@property (weak, nonatomic) IBOutlet QWView *topView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topView_layout_height;

@property (weak, nonatomic) IBOutlet UIImageView *headerIcon;                   //头像
@property (weak, nonatomic) IBOutlet UILabel *name;                             //名字
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *name_layout_width;     //姓名宽约束

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *name_layout_left;

@property (weak, nonatomic) IBOutlet UIView *lvlBgview;                         //普通用户等级
@property (weak, nonatomic) IBOutlet UILabel *lvlLabel;

@property (weak, nonatomic) IBOutlet UILabel *expertLogoLabel;                  //专家logo
@property (weak, nonatomic) IBOutlet UILabel *expertBrandName;                  //所属商家

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *expertBrand_layout_width;


//center
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UILabel *title;                            //标题
@property (weak, nonatomic) IBOutlet UILabel *content;                          //内容
@property (weak, nonatomic) IBOutlet UIView *imageBgView;                       //图片背景
@property (weak, nonatomic) IBOutlet UIImageView *imageOne;                     //图片one
@property (weak, nonatomic) IBOutlet UIImageView *imageTwo;                     //图片two
@property (weak, nonatomic) IBOutlet UIImageView *imageThree;                   //图片three

//bottom
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *time;                             //时间
@property (weak, nonatomic) IBOutlet UILabel *readNumLabel;                     //阅读数
@property (weak, nonatomic) IBOutlet UILabel *commentNumLabel;                  //评论数
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *readNum_layout_width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentNum_layout_width;


//约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_layout_height;   //标题高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageBg_layout_height; //图片高度约束

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageOne_layout_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageOne_layout_width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTwo_layout_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTwo_layout_width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageThree_layout_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageThree_layout_width;

//圈子详情帖子列表
- (void)circleDetailList:(id)data type:(int)type flagGroup:(BOOL)flagGroup;

//我的发帖列表
- (void)myPostTopic:(id)data;

@end
