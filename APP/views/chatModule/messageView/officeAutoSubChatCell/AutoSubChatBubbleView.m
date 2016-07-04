//
//  AutoSubChatBubbleView
//  APP
//
//  Created by caojing on 15/5/22.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "AutoSubChatBubbleView.h"
#import "QWMessage.h"

NSString *const kRouterEventOfficeAutoSubChat = @"kRouterEventOfficeAutoSubChat";

@implementation AutoSubChatBubbleView


- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.autoMessage.customEmojiRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    self.autoMessage.disableThreeCommon = YES;
    self.autoMessage.customEmojiPlistName = @"expressionImage_custom.plist";
    self.autoMessage.emojiDelegate = self;
    self.autoMessage.lineBreakMode = NSLineBreakByCharWrapping;
    self.autoMessage.isNeedAtAndPoundSign = YES;
}

- (void)mlEmojiLabel:(MLEmojiLabel*)emojiLabel didSelectLink:(NSString*)link withType:(MLEmojiLabelLinkType)type
{
    [self routerEventWithName:kRouterEventOfficeAutoSubChat userInfo:@{KMESSAGEKEY:self.messageModel,@"link":link,@"type":[NSNumber numberWithInt:type]}];
}
- (IBAction)checkQuick:(id)sender {
    
    TagWithMessage* tag = [self.messageModel tagList][0];
    [self mlEmojiLabel:nil didSelectLink:tag.tagId withType:MLEmojiLabelLinkTypeDrugGuide];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - setter
-(void)setMessageModel:(MessageModel *)messageModel
{
    [super setMessageModel:messageModel];
    self.autoMessage.emojiText=_messageModel.text;
    if(_messageModel.tagList){
        [self.autoMessage addLinkTags:_messageModel.tagList];
    }
}

#pragma mark - public

+ (CGSize)sizeForBubbleWithObject:(MessageModel *)model
{
    CGFloat maxWidth=APP_W-MARGIN_W*2;
    CGSize textSize = [MLEmojiLabel needSizeWithText:model.text WithConstrainSize:CGSizeMake(maxWidth, MAXFLOAT) FontSize:17.0f];
    return CGSizeMake(maxWidth, textSize.height+49);
}

- (void)bubbleViewPressed:(id)sender
{
    [self routerEventWithName:kRouterEventOfficeAutoSubChat userInfo:@{KMESSAGEKEY:self.messageModel}];
}

- (void)progress:(CGFloat)progress
{
    //    [_progressView setProgress:progress animated:YES];
}

@end
