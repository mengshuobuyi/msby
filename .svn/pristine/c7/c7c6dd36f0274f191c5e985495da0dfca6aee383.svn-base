//
//  TeleChatBubbleView.m
//  APP
//
//  Created by caojing on 15/6/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "TeleChatBubbleView.h"
#import "Constant.h"
NSString *const kRouterEventTeleChat = @"kRouterEventTeleChat";
@implementation TeleChatBubbleView


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
    [self routerEventWithName:kRouterEventTeleChat userInfo:@{KMESSAGEKEY:self.messageModel}];
}

@end