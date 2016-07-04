//
//  FootAllChatBubbleView.m
//  APP
//
//  Created by YYX on 15/7/1.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "FootConsultAgainView.h"
NSString *const kRouterEventFootConsultAgainChat = @"kRouterEventFootConsultAgainChat";
@implementation FootConsultAgainView

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
    self.translatesAutoresizingMaskIntoConstraints = NO;
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
    [self routerEventWithName:kRouterEventFootConsultAgainChat userInfo:@{KMESSAGEKEY:self.messageModel}];
}


@end
