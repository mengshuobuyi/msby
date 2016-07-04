//
//  TopTipChatBubbleView.m
//  APP
//
//  Created by YYX on 15/6/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "TopTipChatBubbleView.h"

NSString *const kRouterEventTopTipBubbleTapEventName = @"kRouterEventTopTipBubbleTapEventName";

@implementation TopTipChatBubbleView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.bgView.layer.cornerRadius = 4.0;
    self.bgView.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bubbleViewPressed:)];
    [self addGestureRecognizer:tap];
    self.backgroundColor = [UIColor clearColor];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - setter
-(void)setMessageModel:(MessageModel *)messageModel
{
    [super setMessageModel:messageModel];
}


#pragma mark - public

-(void)bubbleViewPressed:(id)sender
{
    [self routerEventWithName:kRouterEventTopTipBubbleTapEventName userInfo:@{KMESSAGEKEY:self.messageModel}];
}

+(CGSize)sizeForBubbleWithObject:(MessageModel *)model
{
    CGSize bubbleSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 28);
    return bubbleSize;
}


@end
