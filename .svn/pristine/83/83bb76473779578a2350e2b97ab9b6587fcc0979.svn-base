//
//  LinePharmacistChatBubbleView.m
//  APP
//
//  Created by YYX on 15/6/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "LinePharmacistChatBubbleView.h"

NSString *const kRouterEventLinePharmacistBubbleTapEventName = @"kRouterEventLinePharmacistBubbleTapEventName";

@implementation LinePharmacistChatBubbleView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
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
    self.linePharmacistText.text = [NSString stringWithFormat:@"%@",messageModel.text];
}


#pragma mark - public

-(void)bubbleViewPressed:(id)sender
{
    [self routerEventWithName:kRouterEventLinePharmacistBubbleTapEventName userInfo:@{KMESSAGEKEY:self.messageModel}];
}

+(CGSize)sizeForBubbleWithObject:(MessageModel *)model
{
    CGSize bubbleSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 40);
    return bubbleSize;
}

@end
