//
//  MySendPostTableCel.m
//  APP
//
//  Created by Martin.Liu on 16/6/23.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "MySendPostTableCel.h"
#import "UIImageView+WebCache.h"
#import "UILabel+MAAttributeString.h"
#import "Forum.h"
@interface MySendPostTableCel()

@property (strong, nonatomic) IBOutlet UIView *myContainerView;
@property (strong, nonatomic) IBOutlet UIImageView *anonImageView;
@property (strong, nonatomic) IBOutlet UILabel *postTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *postTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *postContentLabel;
@property (strong, nonatomic) IBOutlet UIView *imagesContianerView;
@property (strong, nonatomic) IBOutlet UIImageView *firstImageView;
@property (strong, nonatomic) IBOutlet UIImageView *secondImageView;
@property (strong, nonatomic) IBOutlet UIImageView *thirdImageView;
@property (strong, nonatomic) IBOutlet UILabel *viewCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *sendPostTimeLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_imagesContainerViewTop; // 15


@end

@implementation MySendPostTableCel

- (void)awakeFromNib {
    [super awakeFromNib];
    self.myContainerView.backgroundColor = RGBHex(qwColor11);
    self.anonImageView.hidden = YES;
    // 置顶 、 专栏 、 热议
    self.postTypeLabel.layer.masksToBounds = YES;
    self.postTypeLabel.layer.cornerRadius = 3;
    self.postTypeLabel.layer.borderColor = RGBHex(qwColor8).CGColor;
    self.postTypeLabel.layer.borderWidth = 1.0f/[UIScreen mainScreen].scale;
    self.postTypeLabel.font = [UIFont systemFontOfSize:kFontS5];
    self.postTypeLabel.textColor = RGBHex(qwColor7);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCell:(id)obj
{
    if ([obj isKindOfClass:[QWPostModel class]])
    {
        QWPostModel* postModel = obj;
        if (postModel.flagAnon) {
            self.anonImageView.hidden = NO;
        }
        else
        {
            self.anonImageView.hidden = YES;
        }
        [self.postTitleLabel ma_setAttributeText:postModel.postTitle];
        self.viewCountLabel.text = [NSString stringWithFormat:@"%ld", (long)postModel.readCount];
        self.commentCountLabel.text = [NSString stringWithFormat:@"%ld", (long)postModel.replyCount];
        [self.postContentLabel ma_setAttributeText:postModel.postContent];
        self.sendPostTimeLabel.text = StrDFString(postModel.postStrDate, @"");
        
        // 优先级  置顶 > 专栏 > 热门
        // 有置顶的页面  ： 热议 、 专栏（发帖），圈子详情的看帖
        NSString* whiteSpaceString = @"       ";
        if (postModel.flagTopHot && (self.postCellType == PostCellType_HotDiscuss || self.postCellType == PostCellType_SpecailColumn || self.postCellType == PostCellType_LookPost)) {
            self.postTypeLabel.hidden = NO;
            //            self.postTypeLabel.backgroundColor = RGBHex(qwColor2);
            self.postTypeLabel.text = @"置顶";
            [self.postTitleLabel ma_setAttributeText:[whiteSpaceString stringByAppendingString:postModel.postTitle]];
        }
        // 有专栏的页面  :  热议 、 圈子详情的看帖 、 收藏的帖子
        else if ((postModel.posterType == 3 || postModel.posterType == 4) && (self.postCellType == PostCellType_HotDiscuss || self.postCellType == PostCellType_LookPost || self.postCellType == PostCellType_CollectionPost))
        {
            self.postTypeLabel.hidden = NO;
            //            self.postTypeLabel.backgroundColor = RGBHex(qwColor13);
            self.postTypeLabel.text = @"专栏";
            [self.postTitleLabel ma_setAttributeText:[whiteSpaceString stringByAppendingString:postModel.postTitle]];
        }
        // 有热门的页面 ： 专栏（发帖） 、 圈子详情的看帖 、 圈子详情的专家 、 Ta的发帖 、 我的发帖 、 收藏的帖子
        else if (postModel.isHot && (self.postCellType == PostCellType_SpecailColumn || self.postCellType == PostCellType_LookPost || self.postCellType == PostCellType_Expert || self.postCellType == PostCellType_HisSendPost || self.postCellType == PostCellType_MineSendPost || self.postCellType == PostCellType_CollectionPost))
        {
            self.postTypeLabel.hidden = NO;
            //            self.postTypeLabel.backgroundColor = RGBHex(qwColor3);
            self.postTypeLabel.text = @"热门";
            [self.postTitleLabel ma_setAttributeText:[whiteSpaceString stringByAppendingString:postModel.postTitle]];
        }
        else
        {
            self.postTypeLabel.hidden = YES;
            [self.postTitleLabel ma_setAttributeText:postModel.postTitle];
        }
        
        if ([postModel.postImgList isKindOfClass:[NSArray class]] && postModel.postImgList.count > 0) {
            self.constraint_imagesContainerViewTop.constant = 15;
            switch (MIN(postModel.postImgList.count, 3)) {
                case 1:
                    self.firstImageView.hidden = NO;
                    self.secondImageView.hidden = YES;
                    self.thirdImageView.hidden = YES;
                    [self.firstImageView setImageWithURL:[NSURL URLWithString:postModel.postImgList[0]] placeholderImage:ForumDefaultImage];
                    break;
                case 2:
                    self.firstImageView.hidden = NO;
                    self.secondImageView.hidden = NO;
                    self.thirdImageView.hidden = YES;
                    [self.firstImageView setImageWithURL:[NSURL URLWithString:postModel.postImgList[0]] placeholderImage:ForumDefaultImage];
                    [self.secondImageView setImageWithURL:[NSURL URLWithString:postModel.postImgList[1]] placeholderImage:ForumDefaultImage];
                    break;
                case 3:
                    self.firstImageView.hidden = NO;
                    self.secondImageView.hidden = NO;
                    self.thirdImageView.hidden = NO;
                    [self.firstImageView setImageWithURL:[NSURL URLWithString:postModel.postImgList[0]] placeholderImage:ForumDefaultImage];
                    [self.secondImageView setImageWithURL:[NSURL URLWithString:postModel.postImgList[1]] placeholderImage:ForumDefaultImage];
                    [self.thirdImageView setImageWithURL:[NSURL URLWithString:postModel.postImgList[2]] placeholderImage:ForumDefaultImage];
                    break;
            }
        }
        else
        {
            self.constraint_imagesContainerViewTop.constant = -1000;
        }
        
    }
}

@end
