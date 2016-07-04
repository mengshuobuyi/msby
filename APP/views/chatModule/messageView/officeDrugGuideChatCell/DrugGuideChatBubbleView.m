//
//  DrugGuideChatBubbleView
//  APP
//
//  Created by caojing on 15/5/22.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "DrugGuideChatBubbleView.h"

NSString *const kRouterEventOfficeDrugGuideChat = @"kRouterEventOfficeDrugGuideChat";

@implementation DrugGuideChatBubbleView


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

- (void)mlEmojiLabel:(MLEmojiLabel*)emojiLabel didSelectLink:(NSString*)link withType:(MLEmojiLabelLinkType)type
{
    [self routerEventWithName:kRouterEventOfficeDrugGuideChat userInfo:@{KMESSAGEKEY:self.messageModel,@"link":link,@"type":[NSNumber numberWithInt:type]}];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - setter
-(void)setMessageModel:(MessageModel *)messageModel
{
    [super setMessageModel:messageModel];
    self.titleLable.text=_messageModel.title?_messageModel.title:@"测试药房";
    self.subTitleLable.text=_messageModel.subTitle?_messageModel.subTitle:@"测试二级目录";
    self.contentLable.emojiText=_messageModel.text;
    if(_messageModel.tagList){
            [self.contentLable addLinkTags:_messageModel.tagList];
    }

    
    
}

#pragma mark - public

+ (CGSize)sizeForBubbleWithObject:(MessageModel *)model
{
    CGFloat maxWidth=APP_W-MARGIN_W*2;
    CGSize titleTextSize = [MLEmojiLabel needSizeWithText:model.title WithConstrainSize:CGSizeMake(maxWidth, MAXFLOAT) FontSize:17.0f];
    CGSize subTitleTextSize = [MLEmojiLabel needSizeWithText:model.subTitle WithConstrainSize:CGSizeMake(maxWidth, MAXFLOAT) FontSize:15.0f];
    CGSize contentTextSize = [MLEmojiLabel needSizeWithText:model.text WithConstrainSize:CGSizeMake(maxWidth, MAXFLOAT) FontSize:14.0f];
    return CGSizeMake(maxWidth, titleTextSize.height+subTitleTextSize.height+contentTextSize.height+82);
}


- (void)bubbleViewPressed:(id)sender
{
    [self routerEventWithName:kRouterEventOfficeDrugGuideChat userInfo:@{KMESSAGEKEY:self.messageModel}];
}

- (void)progress:(CGFloat)progress
{
    //    [_progressView setProgress:progress animated:YES];
}

@end
