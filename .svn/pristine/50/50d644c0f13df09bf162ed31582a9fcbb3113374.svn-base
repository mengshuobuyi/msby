//
//  TeleAllChatBubbleView.m
//  APP
//
//  Created by YYX on 15/7/1.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "TeleAllChatBubbleView.h"
NSString *const kRouterEventTeleAllChat = @"kRouterEventTeleAllChat";
@implementation TeleAllChatBubbleView

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
    self.contentLable.text = @"您也可以直接拨打药房电话咨询";
    
}

#pragma mark - public
+ (CGSize)sizeForBubbleWithObject:(MessageModel *)model
{
    CGSize bubbleSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width,50);
    return bubbleSize;
}

- (void)bubbleViewPressed:(id)sender
{
    [self routerEventWithName:kRouterEventTeleAllChat userInfo:@{KMESSAGEKEY:self.messageModel}];
}

@end