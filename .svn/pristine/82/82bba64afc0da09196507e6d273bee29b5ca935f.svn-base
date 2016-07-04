//
//  ChatOutgoingTableViewCell.m
//  APP
//
//  Created by PerryChen on 5/28/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "OfficeChatTableViewCell.h"

@interface OfficeChatTableViewCell ()

@property (nonatomic, strong) NSLayoutConstraint *leftBubbleConstraint;
@property (nonatomic, strong) NSLayoutConstraint *topBubbleConstraint;

@property (nonatomic, strong) NSLayoutConstraint *widthBubbleConstraint;
@property (nonatomic, strong) NSLayoutConstraint *heightBubbleConstraint;

@end


@implementation OfficeChatTableViewCell

 -(void)awakeFromNib
{
    [super awakeFromNib];
}

- (id)initWithMessageModel:(MessageModel *)model reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithMessageModel:model reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}


- (void)setupSubviewsForMessageModel:(MessageModel *)messageModel
{
    [super setupSubviewsForMessageModel:messageModel];

}

- (void)updateBubbleViewConsTraint:(MessageModel *)model
{
    [super updateBubbleViewConsTraint:model];
    CGSize bubbleSize = [ChatTableViewCell bubbleViewHeightForMessagModel:model];
    if (_bubbleView) {
        CGFloat floatHeight = 0.0;
        if (IS_IPHONE_6P) {
            floatHeight = 15.0f;
        } else {
            floatHeight = 12.0f;
        }
        self.leftBubbleConstraint = [NSLayoutConstraint constraintWithItem:_bubbleView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:10.0f];
        [self.contentView addConstraint:self.leftBubbleConstraint];
        
        self.topBubbleConstraint = [NSLayoutConstraint constraintWithItem:_bubbleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.constraintTimeHeight.constant + floatHeight];
        [self.contentView addConstraint:self.topBubbleConstraint];
        
        self.widthBubbleConstraint = [NSLayoutConstraint constraintWithItem:_bubbleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:bubbleSize.width+MARGIN_W];
        [_bubbleView addConstraint:self.widthBubbleConstraint];
        
        self.heightBubbleConstraint = [NSLayoutConstraint constraintWithItem:_bubbleView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:bubbleSize.height-5];
        [_bubbleView addConstraint:self.heightBubbleConstraint];
        [self.contentView layoutIfNeeded];
        [self.contentView setNeedsLayout];
    }
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [_bubbleView removeConstraints:@[self.widthBubbleConstraint, self.heightBubbleConstraint]];
    [self.contentView removeConstraints:@[self.leftBubbleConstraint,self.topBubbleConstraint]];
}




@end
