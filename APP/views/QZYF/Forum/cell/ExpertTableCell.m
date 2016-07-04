//
//  ExpertTableCell.m
//  APP
//
//  Created by Martin.Liu on 16/1/14.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "ExpertTableCell.h"
#import "Forum.h"
#import "UIImageView+WebCache.h"
#import "MAUILabel.h"
@interface ExpertTableCell()

@property (strong, nonatomic) IBOutlet UIImageView *expertImageView;
@property (strong, nonatomic) IBOutlet UILabel *expertNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *expertPositionImageView;
@property (strong, nonatomic) IBOutlet UILabel *expertPositionLabel;
@property (strong, nonatomic) IBOutlet MAUILabel *expertRemarkLabel;
@property (strong, nonatomic) IBOutlet UILabel *postCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *replyCountLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_infoViewTrailing; // default is 15 ,  aother is 60;

@end

@implementation ExpertTableCell

- (void)awakeFromNib {
    self.expertPositionLabel.textColor = RGBHex(qwColor3);
    self.chooseBtn.userInteractionEnabled = NO;
    self.expertImageView.layer.masksToBounds = YES;
    self.expertImageView.layer.cornerRadius = CGRectGetHeight(self.expertImageView.frame)/2;
    [self showChooseBtn:NO];
    
    // 专家所属药房
    self.expertRemarkLabel.font = [UIFont systemFontOfSize:kFontS5];
    self.expertRemarkLabel.textColor = RGBHex(qwColor4);
    self.expertRemarkLabel.layer.masksToBounds = YES;
    self.expertRemarkLabel.layer.cornerRadius = 4;
    self.expertRemarkLabel.backgroundColor = RGBAHex(qwColor3, 0.6);
    self.expertRemarkLabel.edgeInsets = UIEdgeInsetsZero;
}

- (void)showChooseBtn:(BOOL)show
{
    if (show) {
        self.chooseBtn.hidden = NO;
        self.constraint_infoViewTrailing.constant = 60;
    }
    else
    {
        self.chooseBtn.hidden = YES;
        self.constraint_infoViewTrailing.constant = 15;
    }
}

- (void)setCell:(id)obj
{
    if ([obj isKindOfClass:[QWExpertInfoModel class]]) {
        QWExpertInfoModel* expert = obj;
        self.expertPositionLabel.text = nil;
        [self setExpertRemarkLabelText:nil];
        [self.expertImageView setImageWithURL:[NSURL URLWithString:expert.headImageUrl] placeholderImage:ForumDefaultImage];
        self.expertNameLabel.text = expert.nickName;
        if (expert.userType == PosterType_YingYangShi) {
            self.expertPositionImageView.image = [UIImage imageNamed:@"ic_expert"];
            self.expertPositionLabel.text = @"营养师";
//            self.expertRemarkLabel.text = @"营养师";
            [self setExpertRemarkLabelText:nil];
        }
        else
        {
//            self.expertRemarkLabel.text = expert.groupName;
            [self setExpertRemarkLabelText:expert.groupName];
            self.expertPositionImageView.image = [UIImage imageNamed:@"pharmacist"];
            self.expertPositionLabel.text = @"药师";
            
        }
        self.postCountLabel.text = [NSString stringWithFormat:@"%ld", expert.postCount];
        self.replyCountLabel.text = [NSString stringWithFormat:@"%ld", expert.replyCount];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setExpertRemarkLabelText:(NSString*)userRemarkText
{
    self.expertRemarkLabel.text = userRemarkText;
    self.expertRemarkLabel.edgeInsets = StrIsEmpty(userRemarkText) ? UIEdgeInsetsZero : UIEdgeInsetsMake(3, 3, 3, 3);
}

@end
