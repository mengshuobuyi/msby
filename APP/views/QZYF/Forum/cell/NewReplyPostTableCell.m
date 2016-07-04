//
//  NewReplyPostTableCell.m
//  APP
//
//  Created by Martin.Liu on 16/6/22.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "NewReplyPostTableCell.h"
#import "cssex.h"
#import "Forum.h"
@interface NewReplyPostTableCell()
@property (strong, nonatomic) IBOutlet UIView *myContainerView;

@property (strong, nonatomic) IBOutlet UILabel *postTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *replyContentLabel;
@property (strong, nonatomic) IBOutlet UILabel *replyTimeLabel;

@end

@implementation NewReplyPostTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.myContainerView.backgroundColor = RGBHex(qwColor11);
    QWCSS(self.postTitleLabel, 1, 6);
    QWCSS(self.replyContentLabel, 1, 7);
    QWCSS(self.replyTimeLabel, 5, 8);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCell:(id)obj
{
    if ([obj isKindOfClass:[QWPostReply class]]) {
        QWPostReply* reply = obj;
        self.postTitleLabel.text = [NSString stringWithFormat:@"原贴 : %@", reply.postTitle];
        self.replyContentLabel.text = [NSString stringWithFormat:@"回帖 : %@", reply.content];
        self.replyTimeLabel.text = reply.createDate;
    }
}

@end
