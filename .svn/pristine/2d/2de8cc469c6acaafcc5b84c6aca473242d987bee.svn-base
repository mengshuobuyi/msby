//
//  ExpertCommentCell.m
//  wenYao-store
//
//  Created by Yang Yuexia on 16/1/12.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "ExpertCommentCell.h"
#import "CircleModel.h"
#import "NSString+WPAttributedMarkup.h"

@implementation ExpertCommentCell

+ (CGFloat)getCellHeight:(id)data
{
    TeamMessageModel *model = (TeamMessageModel *)data;
    
    NSString *title = model.sourceTitle;
    CGSize titleSize = [QWGLOBALMANAGER sizeText:title font:fontSystem(14) limitWidth:APP_W-86];
    if (titleSize.height > 35) {
        titleSize.height = 35;
    }
    
    int width;
    width = APP_W-30;
    CGSize contentSize = [MLEmojiLabel expertInfoCommentNeedSizeWithText:model.msgContent WithConstrainSize:CGSizeMake(width, MAXFLOAT)];
    
    
    if (model.msgType == 1 || model.msgType == 3) { //新评论
        return 112-10+titleSize.height+contentSize.height-20;
    }else if (model.msgType == 2){ //新回复
        CGSize commentSize = [QWGLOBALMANAGER sizeText:[NSString stringWithFormat:@"%@",model.sourceContent] font:fontSystem(14) limitWidth:APP_W-30];
        if (commentSize.height > 35) {
            commentSize.height = 35;
        }
        return 112-10+titleSize.height+contentSize.height+43-14+commentSize.height-20;
    }else{
        return 0;
    }
}

- (void)UIGlobal
{
    [super UIGlobal];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.separatorLine.hidden = YES;
    self.applyLabel.layer.cornerRadius = 4.0;
    self.applyLabel.layer.masksToBounds = YES;
    
    self.commentContent.numberOfLines = 0;
    self.commentContent.customEmojiRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    self.commentContent.customEmojiPlistName = @"expressionImage_custom_backup.plist";
    self.commentContent.disableThreeCommon = YES;
}

- (void)setCell:(id)data
{
    [super setCell:data];
    
    TeamMessageModel *model = (TeamMessageModel *)data;
    
    //如果是专家，隐藏回复按钮
    if (model.sourceOwnerType == 3 || model.sourceOwnerType == 4) {
        self.applyLabel.hidden = YES;
        self.applyButton.hidden = YES;
        self.applyButton.enabled = NO;
    }else{
        self.applyLabel.hidden = NO;
        self.applyButton.hidden = NO;
        self.applyButton.enabled = YES;
    }
    
    //您的评论
    if (model.msgType == 1 || model.msgType == 3)
    {
        self.typeTitle.text = @"新评论";
        self.yourCommentBg_layout_height.constant = 0.1;
        self.yourComment.hidden = YES;
        
    }else if (model.msgType == 2)
    {
        self.typeTitle.text = @"新回复";
        CGSize commentSize = [QWGLOBALMANAGER sizeText:[NSString stringWithFormat:@"%@",model.sourceContent] font:fontSystem(14) limitWidth:APP_W-30];
        
        if (commentSize.height > 35) {
            commentSize.height = 35;
        }
        
        self.yourCommentBg_layout_height.constant = 43-14+commentSize.height;
        self.yourComment.hidden = NO;
        self.yourComment.text = [NSString stringWithFormat:@"%@",model.sourceContent];
    }
    
    //时间
    self.time.text = model.createDate;
    
    [self.commentContent setEmojiText:model.msgContent];
    
    //帖子标题
    self.topicTitle.text = model.sourceTitle;
    NSString *title = model.sourceTitle;
    CGSize titleSize = [QWGLOBALMANAGER sizeText:title font:fontSystem(14) limitWidth:APP_W-86];
    if (titleSize.height > 35) {
        titleSize.height = 35;
    }
    self.topicBg_layout_height.constant = 43-14+titleSize.height;
    
}


@end
