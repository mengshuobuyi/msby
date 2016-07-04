//
//  NewCircleTableCell.m
//  APP
//
//  Created by Martin.Liu on 16/6/28.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "NewCircleTableCell.h"
#import "cssex.h"
#import "Forum.h"
#import "UIImageView+WebCache.h"
@interface NewCircleTableCell()
@property (strong, nonatomic) IBOutlet UIView *myContainerView;

@property (strong, nonatomic) IBOutlet UIImageView *circleImageView;
@property (strong, nonatomic) IBOutlet UILabel *circleNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *careCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *postCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *masterFlagLabel;

@end

@implementation NewCircleTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    QWCSS(self.circleNameLabel, 1, 6);
    QWCSS(self.careCountLabel, 5, 8);
    QWCSS(self.postCountLabel, 5, 8);
    QWCSS(self.masterFlagLabel, 1, 7);
    
    self.circleImageView.layer.masksToBounds = YES;
    self.circleImageView.layer.cornerRadius = 2;
    self.circleImageView.layer.borderColor = RGBHex(qwColor20).CGColor;
    self.circleImageView.layer.borderWidth = 1.0/[UIScreen mainScreen].scale;
    
    self.myContainerView.backgroundColor= RGBHex(qwColor11);
    self.masterFlagLabel.hidden = YES;
    self.circleImageView.image = ForumCircleImage;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCell:(id)obj
{
    if ([obj isKindOfClass:[QWCircleModel class]]) {
        QWCircleModel* circleModel = obj;
        [self.circleImageView setImageWithURL:[NSURL URLWithString:circleModel.teamLogo] placeholderImage:ForumCircleImage];
        self.circleNameLabel.text = circleModel.teamName;
        
        self.careCountLabel.text = [NSString stringWithFormat:@"关注 %ld", (long)circleModel.attnCount];
        self.postCountLabel.text = [NSString stringWithFormat:@"帖子 %ld", (long)circleModel.postCount];
        
        if (circleModel.flagMaster) {
            self.masterFlagLabel.hidden = NO;
        }
        else
        {
            self.masterFlagLabel.hidden = YES;
        }
        
    }
}

@end
