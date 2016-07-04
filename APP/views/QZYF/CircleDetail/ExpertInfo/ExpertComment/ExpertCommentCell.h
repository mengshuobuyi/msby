//
//  ExpertCommentCell.h
//  wenYao-store
//
//  Created by Yang Yuexia on 16/1/12.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "QWBaseTableCell.h"
#import "MGSwipeTableCell.h"
#import "QWView.h"
#import "QWButton.h"
#import "MLEmojiLabel.h"

@interface ExpertCommentCell : MGSwipeTableCell

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *typeTitle;
@property (weak, nonatomic) IBOutlet MLEmojiLabel *commentContent;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *applyLabel;
@property (weak, nonatomic) IBOutlet QWButton *applyButton;
@property (weak, nonatomic) IBOutlet UILabel *yourComment;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yourCommentBg_layout_height;
@property (weak, nonatomic) IBOutlet UILabel *topicTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topicBg_layout_height;
@property (weak, nonatomic) IBOutlet QWView *topicBgView;

@end
