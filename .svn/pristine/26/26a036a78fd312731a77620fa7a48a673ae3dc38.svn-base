//
//  FootChatBubbleView.m
//  APP
//
//  Created by caojing on 15/6/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "FootChatBubbleView.h"

@implementation FootChatBubbleView
NSString *const kRouterEventFootChat = @"kRouterEventFootChat";
- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.bgView.layer.cornerRadius = 5.0;
    self.bgView.layer.masksToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bubbleViewPressed:)];
    [self addGestureRecognizer:tap];
    self.backgroundColor = [UIColor clearColor];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

#pragma mark - setter
-(void)setMessageModel:(MessageModel *)messageModel
{
    [super setMessageModel:messageModel];
    self.contentLable.text = @"该药房药师可能正忙，您是否需要将该问题转发给其他药房药师为您解答？";
    
}

#pragma mark - public
+ (CGSize)sizeForBubbleWithObject:(MessageModel *)model
{
    CGSize bubbleSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width,50);
    return bubbleSize;
}

- (void)bubbleViewPressed:(id)sender
{
    [self routerEventWithName:kRouterEventFootChat userInfo:@{KMESSAGEKEY:self.messageModel}];
}

@end
