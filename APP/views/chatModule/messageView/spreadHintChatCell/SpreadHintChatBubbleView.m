//
//  PurchaseChatBubbleView
//  APP
//
//  Created by caojing on 15/5/22.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "SpreadHintChatBubbleView.h"

NSString *const kRouterEventOfficeSpreadHint = @"kRouterEventOfficeSpreadHint";

@implementation SpreadHintChatBubbleView

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentLable.customEmojiRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    self.contentLable.disableThreeCommon = YES;
    self.contentLable.customEmojiPlistName = @"expressionImage_custom.plist";
    self.contentLable.emojiDelegate = self;
    self.contentLable.lineBreakMode = NSLineBreakByCharWrapping;
    self.contentLable.isNeedAtAndPoundSign = YES;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - setter
-(void)setMessageModel:(MessageModel *)messageModel
{
    [super setMessageModel:messageModel];
    self.contentLable.emojiText=_messageModel.text;
    if(_messageModel.tagList){
        [self.contentLable addLinkTags:_messageModel.tagList];
    }
}


#pragma mark - public

+ (CGSize)sizeForBubbleWithObject:(MessageModel *)model
{
    CGFloat maxWidth=APP_W-MARGIN_W;
    CGSize contentTextSize = [MLEmojiLabel needSizeWithText:model.text WithConstrainSize:CGSizeMake(maxWidth, MAXFLOAT) FontSize:15.0f];
    return CGSizeMake(maxWidth,contentTextSize.height+30);
}


- (void)bubbleViewPressed:(id)sender
{
    [self routerEventWithName:kRouterEventOfficeSpreadHint userInfo:@{KMESSAGEKEY:self.messageModel}];
}

- (void)progress:(CGFloat)progress
{
}

@end
