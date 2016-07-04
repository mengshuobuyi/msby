
//
//  XHMessageBubbleView.m
//  MessageDisplayExample
//
//  Created by qtone-1 on 14-4-24.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHMessageBubbleView.h"
#import "TQRichTextURLRun.h"
#import "XHMessageBubbleHelper.h"
#import "XHMessageTableViewController.h"
#import "TQRichTextEmojiRun.h"
#import "MLEmojiLabel.h"
#import "UIImageView+WebCache.h"
#define kMarginTop 8.0f
#define kMarginBottom 5.0f
#define kPaddingTop 4.0f
#define kBubblePaddingRight 10.0f

#define kVoiceMargin 20.0f

#define kXHArrowMarginWidth 5
#define KTitleTop 9
#define KdesTop 41
#define KtextFrame 70
#define KpandingLeft 29
#define Kpandingright 43
@interface XHMessageBubbleView ()<UIActionSheetDelegate,MLEmojiLabelDelegate>

@property (nonatomic, weak, readwrite) MLEmojiLabel *displayTextView;

@property (nonatomic, weak, readwrite) UIImageView *bubbleImageView;

@property (nonatomic, weak, readwrite) UIImageView *animationVoiceImageView;

@property (nonatomic, weak, readwrite) XHBubblePhotoImageView *bubblePhotoImageView;

@property (nonatomic, weak, readwrite) UIImageView *videoPlayImageView;

@property (nonatomic, weak, readwrite) UILabel *geolocationsLabel;

@property (nonatomic, strong, readwrite) id <XHMessageModel> message;

@end

@implementation XHMessageBubbleView

#pragma mark - Bubble view

+ (CGFloat)neededWidthForText:(NSString *)text {
    CGSize stringSize;
    stringSize = [text sizeWithFont:[[XHMessageBubbleView appearance] font]
                  constrainedToSize:CGSizeMake(MAXFLOAT, 19)];
    return roundf(stringSize.width);
}

+ (CGSize)neededSizeForText:(NSString *)text
{
    CGFloat maxWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) * (kIsiPad ? 0.8 : 0.6);
    //    CGFloat dyWidth = [XHMessageBubbleView neededWidthForText:text];
    CGSize textSize = [MLEmojiLabel needSizeWithText:text WithConstrainSize:CGSizeMake(maxWidth, MAXFLOAT)];
    if(textSize.height == 25)
        textSize.height -= 2;
    return CGSizeMake(textSize.width + kBubblePaddingRight * 2 + kXHArrowMarginWidth, textSize.height);
}

+ (CGSize)neededSizeForText:(NSString *)text withDelta:(CGFloat)delta
{
    CGFloat maxWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) * delta;
    //    CGFloat dyWidth = [XHMessageBubbleView neededWidthForText:text];
    CGSize textSize = [MLEmojiLabel needSizeWithText:text WithConstrainSize:CGSizeMake(maxWidth, MAXFLOAT)];
    if(textSize.height == 25)
        textSize.height -= 2;
    return CGSizeMake(textSize.width + kBubblePaddingRight * 2 + kXHArrowMarginWidth, textSize.height);
}


+ (CGSize)neededSizeForPhoto:(UIImage *)photo {
    // 这里需要缩放后的size
    CGSize photoSize = CGSizeMake(MAX_SIZE,MAX_SIZE);
    return photoSize;
}

+ (CGSize)neededSizeForVoicePath:(NSString *)voicePath voiceDuration:(NSString *)voiceDuration {
    // 这里的100只是暂时固定，到时候会根据一个函数来计算
    float gapDuration = (!voiceDuration || voiceDuration.length == 0 ? -1 : [voiceDuration floatValue] - 1.0f);
    CGSize voiceSize = CGSizeMake(100 + (gapDuration > 0 ? (120.0 / (60 - 1) * gapDuration) : 0),30);
    return voiceSize;
}

+ (CGFloat)calculateCellHeightWithMessage:(id <XHMessageModel>)message {
    CGSize size = [XHMessageBubbleView getBubbleFrameWithMessage:message];
    return size.height + kMarginTop + kMarginBottom;
}

+ (CGSize)getBubbleFrameWithMessage:(id <XHMessageModel>)message {
    CGSize bubbleSize;
    switch (message.messageMediaType) {
        case XHBubbleMessageMediaTypeText:
        {
            if([message officialType]) {
                bubbleSize = [self neededSizeForText:message.text withDelta:0.85];
            }else {
                bubbleSize = [XHMessageBubbleView neededSizeForText:message.text];
            }
          
            break;
        }
        case XHBubbleMessageMediaTypeDrugGuide:
        {
            if([message officialType]){
                bubbleSize = [self neededSizeForText:message.text withDelta:0.85];
            }else{
                bubbleSize = [self neededSizeForText:message.text];
            }
            DDLogVerbose(@"DrugGuide------->%f",bubbleSize.height);
            if (message.fromTag ==2) {
                bubbleSize.height += 85;
            }else
            {
                bubbleSize.height += 48;
            }
            break;
        }
        case XHBubbleMessageMediaTypePurchaseMedicine://9
        {
            if([message officialType]) {
                bubbleSize = [self neededSizeForText:message.text withDelta:0.85];
            }else {
                bubbleSize = [XHMessageBubbleView neededSizeForText:message.text];
            }
            if (message.fromTag ==2) {
                bubbleSize.height += 50;
            }
           
            break;
        }
        case XHBubbleMessageMediaTypeStarStore:{
            bubbleSize = [XHMessageBubbleView neededSizeForText:message.text ];
            break;
        }
        case XHBubbleMessageMediaTypeStarClient:
        {
            bubbleSize = [XHMessageBubbleView neededSizeForText:message.text ];
            if(bubbleSize.height == 25)
                bubbleSize.height -= 5;
            bubbleSize.height += 25.0f;
            CGFloat maxWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) * (kIsiPad ? 0.8 : 0.6);
            bubbleSize.width = maxWidth + kBubblePaddingRight * 2 + kXHArrowMarginWidth;
            break;
        }
        case XHBubbleMessageMediaTypeLocation:
        {
            bubbleSize = CGSizeMake(APP_W * 0.6, 25);
            //CGSize size = [[message text] sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake(190, 45)];
            bubbleSize.height += 40;
            CGFloat maxWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) * (kIsiPad ? 0.8 : 0.6);
            bubbleSize.width = maxWidth + kBubblePaddingRight * 2 + kXHArrowMarginWidth;
            break;
        }
        case XHBubbleMessageMediaTypeActivity:
        {
            CGSize constrainedSize = CGSizeZero;
            if([message messageMediaType] == XHBubbleMessageMediaTypeDrugGuide) {
                constrainedSize = CGSizeMake(260, 45);
            }else{
                constrainedSize = CGSizeMake(190, 45);
            }
           // if(message.activityUrl == nil || [message.activityUrl isEqualToString:@""])
            if(StrIsEmpty(message.activityUrl))
            {
                NSString *content = message.text;
                
                CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:13.0f] constrainedToSize:CGSizeMake(0.6 * APP_W, 65)];
                
                CGFloat maxWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) * (kIsiPad ? 0.8 : 0.6);
                bubbleSize.width = maxWidth + kBubblePaddingRight * 2 + kXHArrowMarginWidth;
                CGSize titleSize = [[message title] sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:constrainedSize];
                bubbleSize.height += titleSize.height + 8 + size.height;
                
            }else{
                bubbleSize = CGSizeMake(APP_W * 0.6, 65);
                CGSize size = [[message title] sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:constrainedSize];
                bubbleSize.height += size.height;
                CGFloat maxWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) * (kIsiPad ? 0.8 : 0.6);
                bubbleSize.width = maxWidth + kBubblePaddingRight * 2 + kXHArrowMarginWidth;
            }
            break;
        }
        case XHBubbleMessageMediaTypeMedicineSpecialOffersShowOnce:
        {
            bubbleSize = CGSizeMake(APP_W, 120);
            break;
        }
        case XHBubbleMessageMediaTypeMedicineShowOnce:
        {
            bubbleSize = CGSizeMake(APP_W, 100);
            break;
        }
        case XHBubbleMessageMediaTypeMedicineSpecialOffers:
        {
            CGSize constrainedSize = CGSizeZero;
            constrainedSize = CGSizeMake(190, 45);
           // if(message.activityUrl == nil || [message.activityUrl isEqualToString:@""])
            if(StrIsEmpty(message.activityUrl))
            {
                NSString *content = message.text;
                
                CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:13.0f] constrainedToSize:CGSizeMake(0.6 * APP_W, 65)];
                
                CGFloat maxWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) * (kIsiPad ? 0.8 : 0.6);
                bubbleSize.width = maxWidth + kBubblePaddingRight * 2 + kXHArrowMarginWidth;
                CGSize titleSize = [[message title] sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:constrainedSize];
                bubbleSize.height += titleSize.height + 8 + size.height;
                
            }else{
                bubbleSize = CGSizeMake(APP_W * 0.6, 65);
                CGSize size = [[message title] sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:constrainedSize];
                bubbleSize.height += size.height;
                CGFloat maxWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) * (kIsiPad ? 0.8 : 0.6);
                bubbleSize.width = maxWidth + kBubblePaddingRight * 2 + kXHArrowMarginWidth;
            }
            break;
        }
        case XHBubbleMessageMediaTypeMedicine:
        {
            bubbleSize = CGSizeMake(APP_W * 0.6, 25);
            bubbleSize.height += 55;
            CGFloat maxWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) * (kIsiPad ? 0.8 : 0.6);
            bubbleSize.width = maxWidth + kBubblePaddingRight * 2 + kXHArrowMarginWidth;
            break;
        }
        case XHBubbleMessageMediaTypePhoto: {
            
            SDImageCache *imageCache = [SDImageCache sharedImageCache];
            if ([imageCache diskImageExistsWithKey:message.UUID]) {
                
                UIImage *img2 =[[SDImageCache sharedImageCache] imageFromDiskCacheForKey: message.UUID];
                bubbleSize = img2.size;
                if (bubbleSize.width == 0 || bubbleSize.height == 0) {
                    bubbleSize.width = MAX_SIZE;
                    bubbleSize.height = MAX_SIZE;
                }
                else if (bubbleSize.width > bubbleSize.height) {
                    CGFloat height =  MAX_SIZE / bubbleSize.width  *  bubbleSize.height;
                    bubbleSize.height = height;
                    bubbleSize.width = MAX_SIZE;
                }
                else{
                    CGFloat width = MAX_SIZE / bubbleSize.height * bubbleSize.width;
                    bubbleSize.width = width;
                    bubbleSize.height = MAX_SIZE;
                }
            }
            else{

                if (message.photo) {
                    bubbleSize = message.photo.size;
                    if (bubbleSize.width == 0 || bubbleSize.height == 0) {
                        bubbleSize.width = MAX_SIZE;
                        bubbleSize.height = MAX_SIZE;
                    }
                    else if (bubbleSize.width > bubbleSize.height) {
                        
                        CGFloat height =  MAX_SIZE / bubbleSize.width  *  bubbleSize.height;
                        bubbleSize.height = height;
                        bubbleSize.width = MAX_SIZE;
                    }
                    else{
                        CGFloat width = MAX_SIZE / bubbleSize.height * bubbleSize.width;
                        bubbleSize.width = width;
                        bubbleSize.height = MAX_SIZE;
                    }
                }else
                {
                    bubbleSize = [XHMessageBubbleView neededSizeForPhoto:message.photo];
                }
            }
            //
            break;
        }
        case XHBubbleMessageMediaTypeAutoSubscription:
        {
            if([message officialType]){
                bubbleSize = [self neededSizeForText:message.text withDelta:0.85];
            }else{
                bubbleSize = [self neededSizeForText:message.text];
            }
            bubbleSize.height += 25;
            break;
        }
      
        case XHBubbleMessageMediaTypeEmotion:
            // 是否固定大小呢？
            bubbleSize = CGSizeMake(100, 100);
            break;
        case XHBubbleMessageMediaTypeLocalPosition:
            // 固定大小，必须的
            bubbleSize = CGSizeMake(119, 119);
            break;
        case XHBubbleMessageMediaTypeQuitout:
        {
            if([message officialType]) {
                bubbleSize = [self neededSizeForText:message.text withDelta:0.8];
            }else {
                bubbleSize = [XHMessageBubbleView neededSizeForText:message.text];
            }
            bubbleSize.height += 50;
            break;
        }
        case XHBubbleMessageMediaTypeSpreadHint:
        {
            bubbleSize = [self neededSizeForText:message.text withDelta:0.85];
//            bubbleSize.height += 25;
            break;
        }
        case XHBubbleMessageMediaTypeHeader:
        {
             bubbleSize = [self neededSizeForText:message.text withDelta:0.95];
               bubbleSize = CGSizeMake(297, 24);
//            bubbleSize.height += 25;
            break;
        }
        case XHBubbleMessageMediaTypeFooter:
        {
            bubbleSize = [self neededSizeForText:message.text withDelta:0.7];
                 bubbleSize = CGSizeMake(297, 42);
//            bubbleSize.height += 25;
            break;
        }
        case XHBubbleMessageMediaTypeLine:
        {
            bubbleSize = [self neededSizeForText:message.text withDelta:0.85];
//            bubbleSize.height += 25;
            break;
        }
        case XHBubbleMessageMediaTypePhone:
        {
//            bubbleSize = [self neededSizeForText:message.text withDelta:0.85];
//            bubbleSize.height += 25;
              bubbleSize = CGSizeMake(273, 34);
            break;
        }
        default:
            break;
    }
    return bubbleSize;
}

#pragma mark - UIAppearance Getters

- (UIFont *)font {
    if (_font == nil) {
        _font = [[[self class] appearance] font];
    }
    
    if (_font != nil) {
        return _font;
    }
    
    return [UIFont systemFontOfSize:15.0f];
}

#pragma mark - Getters


- (CGRect)bubbleFrame
{
    CGSize bubbleSize = [XHMessageBubbleView getBubbleFrameWithMessage:self.message];
    return CGRectIntegral(CGRectMake((self.message.bubbleMessageType == XHBubbleMessageTypeSending ? CGRectGetWidth(self.bounds) - bubbleSize.width : 0.0f),
                                     kMarginTop,
                                     bubbleSize.width,
                                     bubbleSize.height + kMarginTop + kMarginBottom));
}

#pragma mark -
#pragma mark TQRichTextViewDelegate

#pragma mark -
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.superParentViewController.shouldPreventAutoScrolling = YES;
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    self.superParentViewController.shouldPreventAutoScrolling = NO;
}
#pragma mark - Life cycle

- (void)configureCellWithMessage:(id <XHMessageModel>)message {
    _message = message;
    
    [self configureBubbleImageView:message];
    
    [self configureMessageDisplayMediaWithMessage:message];
    
}

- (void)configureBubbleImageView:(id <XHMessageModel>)message {
    XHBubbleMessageMediaType currentType = [message messageMediaType];
    _voiceDurationLabel.hidden = YES;
    _advisory.hidden = YES;
    _phoneBtn.hidden = YES;
    [self setBackgroundColor:[UIColor clearColor]];
    _lineView.hidden = YES;
 
    _checkImmediately.hidden = YES;
    _sendActivity.hidden = YES;
    _sendMedicineLink.hidden = YES;
    _activityContent.hidden = YES;
    _activityTitle.hidden = YES;
    _activityImage.hidden = YES;
    _checkButton.hidden = YES;
 _displayTextView.textColor = [UIColor blackColor];
    _displayTextView.font = [UIFont systemFontOfSize:14.0];
    switch (currentType) {
        case XHBubbleMessageMediaTypeVoice:
        {
            [self setBackgroundColor:[UIColor clearColor]];
            self.sendMedicineLink.hidden = YES;
            self.dpMeterView.hidden = YES;
            _voiceDurationLabel.hidden = NO;
            self.askOtherDoc.hidden = YES;
            _checkImmediately.hidden = YES;
            self.sendActivity.hidden = YES;
            self.topSeparateLine.hidden = YES;
            self.bottomSeparateLine.hidden = YES;
            break;
        }
        case XHBubbleMessageMediaTypeText:
        {
            [self setBackgroundColor:[UIColor clearColor]];
            self.sendMedicineLink.hidden = YES;
            self.subTitle.hidden = YES;
            self.uiGrayBgView.hidden = YES;
            self.askOtherDoc.hidden = YES;
            _checkImmediately.hidden = YES;
            self.sendActivity.hidden = YES;
            self.topSeparateLine.hidden = YES;
            self.bottomSeparateLine.hidden = YES;
        }
        case XHBubbleMessageMediaTypePurchaseMedicine:
        {
            [self setBackgroundColor:[UIColor clearColor]];
            self.sendMedicineLink.hidden = YES;
            if (message.fromTag == 0) {
                self.activityTitle.hidden = YES;
                self.subTitle.hidden = YES;
                self.uiGrayBgView.hidden = YES;
            }else if(message.fromTag == 2)
            {
                self.activityTitle.hidden = NO;
                self.subTitle.hidden = YES;
                self.uiGrayBgView.hidden = NO;
            }
            self.dpMeterView.hidden = YES;
            if( currentType == XHBubbleMessageMediaTypeStarStore)
            {
                if([message isMarked])
                {
                    self.remarkLabel.hidden = YES;
                }else{
                    self.remarkLabel.hidden = NO;
                }
            }else{
                self.remarkLabel.hidden = YES;
            }
            if([message officialType]){
                _bubbleImageView.image = [XHMessageBubbleFactory bubbleImageViewForOfficialType:message.bubbleMessageType];
            }else{
                _bubbleImageView.image = [XHMessageBubbleFactory bubbleImageViewForType:message.bubbleMessageType style:XHBubbleImageViewStyleWeChat meidaType:message.messageMediaType];
            }
            // 只要是文本、语音、第三方表情，背景的气泡都不能隐藏
            _bubbleImageView.hidden = NO;
            _checkButton.hidden = YES;
            // 只要是文本、语音、第三方表情，都需要把显示尖嘴图片的控件隐藏了
            _bubblePhotoImageView.hidden = YES;
            self.activityContent.hidden = YES;
            self.activityImage.hidden = YES;
            self.activityTitle.hidden = YES;
            _footGuide.hidden = YES;
            if (currentType == XHBubbleMessageMediaTypeText || currentType == XHBubbleMessageMediaTypeStarStore || currentType == XHBubbleMessageMediaTypeStarClient || currentType == XHBubbleMessageMediaTypePurchaseMedicine) {
                // 如果是文本消息，那文本消息的控件需要显示
                _displayTextView.hidden = NO;
                // 那语言的gif动画imageView就需要隐藏了
                _animationVoiceImageView.hidden = YES;
                
            } else {
                // 那如果不文本消息，必须把文本消息的控件隐藏了啊
                _displayTextView.hidden = YES;
                
                // 对语音消息的进行特殊处理，第三方表情可以直接利用背景气泡的ImageView控件
                if (currentType == XHBubbleMessageMediaTypeVoice) {
                    [_animationVoiceImageView removeFromSuperview];
                    _animationVoiceImageView = nil;
                    
                    UIImageView *animationVoiceImageView = [XHMessageVoiceFactory messageVoiceAnimationImageViewWithBubbleMessageType:message.bubbleMessageType];
                    [self addSubview:animationVoiceImageView];
                    _animationVoiceImageView = animationVoiceImageView;
                    _animationVoiceImageView.hidden = NO;
                } else {
                    _animationVoiceImageView.hidden = YES;
                }
            }
            self.askOtherDoc.hidden = YES;
            _checkImmediately.hidden = YES;
            self.sendActivity.hidden = YES;
            self.topSeparateLine.hidden = YES;
            self.bottomSeparateLine.hidden = YES;
            break;
        }
        case XHBubbleMessageMediaTypeStarStore:
        case XHBubbleMessageMediaTypeStarClient:
        case XHBubbleMessageMediaTypeEmotion: {
            [self setBackgroundColor:[UIColor clearColor]];
            self.sendMedicineLink.hidden = YES;
            if (message.fromTag == 0) {
                DDLogVerbose(@"XHBubbleMessageMediaTypeEmotion---fromtag--0");
            }else if(message.fromTag == 2)
            {
                DDLogVerbose(@"XHBubbleMessageMediaTypeEmotion---fromtag--2");
            }
            self.dpMeterView.hidden = YES;
            if( currentType == XHBubbleMessageMediaTypeStarStore)
            {
                if([message isMarked])
                {
                    self.remarkLabel.hidden = YES;
                }else{
                    self.remarkLabel.hidden = NO;
                }
            }else{
                self.remarkLabel.hidden = YES;
            }
            if([message officialType]){
                _bubbleImageView.image = [XHMessageBubbleFactory bubbleImageViewForOfficialType:message.bubbleMessageType];
            }else{
                _bubbleImageView.image = [XHMessageBubbleFactory bubbleImageViewForType:message.bubbleMessageType style:XHBubbleImageViewStyleWeChat meidaType:message.messageMediaType];
            }
            // 只要是文本、语音、第三方表情，背景的气泡都不能隐藏
            _bubbleImageView.hidden = NO;
            _checkButton.hidden = YES;
            // 只要是文本、语音、第三方表情，都需要把显示尖嘴图片的控件隐藏了
            _bubblePhotoImageView.hidden = YES;
            self.activityContent.hidden = YES;
            self.activityImage.hidden = YES;
            self.activityTitle.hidden = YES;
            _footGuide.hidden = YES;
            if (currentType == XHBubbleMessageMediaTypeText || currentType == XHBubbleMessageMediaTypeStarStore || currentType == XHBubbleMessageMediaTypeStarClient || currentType == XHBubbleMessageMediaTypePurchaseMedicine) {
                // 如果是文本消息，那文本消息的控件需要显示
                _displayTextView.hidden = NO;
                // 那语言的gif动画imageView就需要隐藏了
                _animationVoiceImageView.hidden = YES;
                
            } else {
                // 那如果不文本消息，必须把文本消息的控件隐藏了啊
                _displayTextView.hidden = YES;
                
                // 对语音消息的进行特殊处理，第三方表情可以直接利用背景气泡的ImageView控件
                if (currentType == XHBubbleMessageMediaTypeVoice) {
                    [_animationVoiceImageView removeFromSuperview];
                    _animationVoiceImageView = nil;
                    
                    UIImageView *animationVoiceImageView = [XHMessageVoiceFactory messageVoiceAnimationImageViewWithBubbleMessageType:message.bubbleMessageType];
                    [self addSubview:animationVoiceImageView];
                    _animationVoiceImageView = animationVoiceImageView;
                    _animationVoiceImageView.hidden = NO;
                } else {
                    _animationVoiceImageView.hidden = YES;
                }
            }
            self.askOtherDoc.hidden = YES;
            _checkImmediately.hidden = YES;
            self.sendActivity.hidden = YES;
            self.topSeparateLine.hidden = YES;
            self.bottomSeparateLine.hidden = YES;
            break;
        }
        case XHBubbleMessageMediaTypeAutoSubscription:
        case XHBubbleMessageMediaTypeDrugGuide:
        {
            [self setBackgroundColor:[UIColor clearColor]];
            self.sendMedicineLink.hidden = YES;
            self.dpMeterView.hidden = YES;
            // 只要是文本、语音、第三方表情，背景的气泡都不能隐藏
            _bubbleImageView.hidden = NO;
            self.remarkLabel.hidden = YES;
            if (message.fromTag == 0) {
            }else if(message.fromTag == 2)
            {
            }
            // 只要是文本、语音、第三方表情，都需要把显示尖嘴图片的控件隐藏了
            _bubblePhotoImageView.hidden = YES;
            self.activityContent.hidden = YES;
            self.activityImage.hidden = YES;
            self.activityTitle.hidden = YES;
            self.ratingView.hidden = YES;
            self.serviceLabel.hidden = YES;
            if([message officialType]){
                _bubbleImageView.image = [XHMessageBubbleFactory bubbleImageViewForOfficialType:message.bubbleMessageType];
            }else{
                _bubbleImageView.image = [XHMessageBubbleFactory bubbleImageViewForType:message.bubbleMessageType style:XHBubbleImageViewStyleWeChat meidaType:message.messageMediaType];
            }
            if(currentType == XHBubbleMessageMediaTypeDrugGuide) {
                self.activityTitle.hidden = NO;
                _checkButton.hidden = YES;
                _footGuide.hidden = NO;
            }else{
                self.activityTitle.hidden = YES;
                _checkButton.hidden = NO;
                _footGuide.hidden = YES;
            }
            _checkImmediately.hidden = YES;
            self.askOtherDoc.hidden = YES;
            self.sendActivity.hidden = YES;
            self.topSeparateLine.hidden = YES;
            self.bottomSeparateLine.hidden = YES;
            break;
        }
        case XHBubbleMessageMediaTypeLocation:
        {
            [self setBackgroundColor:[UIColor clearColor]];
            self.sendMedicineLink.hidden = YES;
            _checkButton.hidden = YES;
            _footGuide.hidden = YES;
            _bubbleImageView.image = [XHMessageBubbleFactory bubbleImageViewForType:message.bubbleMessageType style:XHBubbleImageViewStyleWeChat meidaType:message.messageMediaType];
            // 只要是文本、语音、第三方表情，背景的气泡都不能隐藏
            _bubbleImageView.hidden = NO;
            _bubblePhotoImageView.hidden = YES;
            _displayTextView.hidden = YES;
            
            self.activityContent.hidden = NO;
            self.activityImage.hidden = NO;
            self.activityTitle.hidden = YES;
            self.dpMeterView.hidden = YES;
            self.ratingView.hidden = YES;
            self.serviceLabel.hidden = YES;
            self.subTitle.hidden = YES;
            self.uiGrayBgView.hidden = YES;
               self.askOtherDoc.hidden = YES;
            _checkImmediately.hidden = YES;
            self.sendActivity.hidden = YES;
            self.topSeparateLine.hidden = YES;
            self.bottomSeparateLine.hidden = YES;
            break;
        }
        case XHBubbleMessageMediaTypePhoto:
        {
            [self setBackgroundColor:[UIColor clearColor]];
            self.sendMedicineLink.hidden = YES;
            _bubbleImageView.image = [XHMessageBubbleFactory bubbleImageViewForType:message.bubbleMessageType style:XHBubbleImageViewStyleWeChat meidaType:message.messageMediaType];
            _checkButton.hidden = YES;
            _videoPlayImageView .hidden = YES;
            _bubblePhotoImageView.hidden = NO;
            self.activityContent.hidden = YES;
            self.activityImage.hidden = YES;
            self.activityTitle.hidden = YES;
            _displayTextView.hidden = YES;
            _checkButton.hidden = YES;
            _footGuide.hidden = YES;
            //            [self.activityView stopAnimating];
            //            self.activityView.hidden = YES;
            _checkButton.hidden = YES;
            if (message.sended ==Sending) {
                self.dpMeterView.hidden = NO;
                self.resendButton.hidden = YES;
                self.activityView.hidden = NO;
            }else
            {
                self.dpMeterView.hidden = YES;
            }
            self.remarkLabel.hidden = YES;
            _bubbleImageView.hidden = NO;
            self.activityTitle.hidden = YES;
            self.ratingView.hidden = YES;
            self.serviceLabel.hidden = YES;
            
            _checkButton.hidden = YES;
            // 只要是文本、语音、第三方表情，都需要把显示尖嘴图片的控件隐藏了
            //            _bubblePhotoImageView.hidden = YES;
            self.activityContent.hidden = YES;
            self.activityImage.hidden = YES;
            self.activityTitle.hidden = YES;
            self.subTitle.hidden = YES;
            self.uiGrayBgView.hidden = YES;
               self.askOtherDoc.hidden = YES;
            _checkImmediately.hidden = YES;
            self.sendActivity.hidden = YES;
            self.topSeparateLine.hidden = YES;
            self.bottomSeparateLine.hidden = YES;
            break;
        }
        case XHBubbleMessageMediaTypeMedicineSpecialOffers:
        {
            [self setBackgroundColor:[UIColor clearColor]];
            self.sendMedicineLink.hidden = YES;
            self.remarkLabel.hidden = YES;
            _footGuide.hidden = YES;
            _checkButton.hidden = YES;
            _bubbleImageView.image = [XHMessageBubbleFactory bubbleImageViewForType:message.bubbleMessageType style:XHBubbleImageViewStyleWeChat meidaType:message.messageMediaType];
            // 只要是文本、语音、第三方表情，背景的气泡都不能隐藏
            _bubbleImageView.hidden = NO;
            _bubblePhotoImageView.hidden = YES;
            _displayTextView.hidden = YES;
            self.activityContent.hidden = NO;
            self.activityImage.hidden = NO;
            self.activityTitle.hidden = NO;
            self.ratingView.hidden = YES;
            self.serviceLabel.hidden = YES;
            self.dpMeterView.hidden = YES;
            self.subTitle.hidden = YES;
            self.uiGrayBgView.hidden = YES;
            self.askOtherDoc.hidden = YES;
            _checkImmediately.hidden = YES;
            self.sendActivity.hidden = YES;
            self.topSeparateLine.hidden = YES;
            self.bottomSeparateLine.hidden = YES;
            break;
        }
        case XHBubbleMessageMediaTypeMedicine:
        {
            [self setBackgroundColor:[UIColor clearColor]];
            self.remarkLabel.hidden = YES;
            self.sendMedicineLink.hidden = YES;
            _footGuide.hidden = YES;
            _checkButton.hidden = YES;
            _checkImmediately.hidden = NO;
            _bubbleImageView.image = [XHMessageBubbleFactory bubbleImageViewForType:message.bubbleMessageType style:XHBubbleImageViewStyleWeChat meidaType:message.messageMediaType];
            
            // 只要是文本、语音、第三方表情，背景的气泡都不能隐藏
            _bubbleImageView.hidden = NO;
            _bubblePhotoImageView.hidden = YES;
            _displayTextView.hidden = YES;
            self.activityContent.hidden = NO;
            self.activityImage.hidden = NO;
            self.activityTitle.hidden = YES;
            self.ratingView.hidden = YES;
            self.serviceLabel.hidden = YES;
            self.dpMeterView.hidden = YES;
            self.subTitle.hidden = YES;
            self.uiGrayBgView.hidden = YES;
            self.askOtherDoc.hidden = YES;
            self.sendActivity.hidden = YES;
            self.topSeparateLine.hidden = YES;
            self.bottomSeparateLine.hidden = YES;
            break;
        }
        case XHBubbleMessageMediaTypeMedicineShowOnce:
        {
            [self setBackgroundColor:[UIColor whiteColor]];
            self.sendMedicineLink.hidden = NO;
            self.remarkLabel.hidden = YES;
            _footGuide.hidden = YES;
            _checkButton.hidden = YES;
            _checkImmediately.hidden = YES;
            _bubbleImageView.image = [XHMessageBubbleFactory bubbleImageViewForType:message.bubbleMessageType style:XHBubbleImageViewStyleWeChat meidaType:message.messageMediaType];
            
            // 只要是文本、语音、第三方表情，背景的气泡都不能隐藏
            _bubbleImageView.hidden = NO;
            _bubblePhotoImageView.hidden = YES;
            _displayTextView.hidden = YES;
            self.activityContent.hidden = NO;
            self.activityImage.hidden = NO;
            self.activityTitle.hidden = YES;
            self.ratingView.hidden = YES;
            self.serviceLabel.hidden = YES;
            self.dpMeterView.hidden = YES;
            self.subTitle.hidden = YES;
            self.uiGrayBgView.hidden = YES;
            self.askOtherDoc.hidden = YES;
            self.sendActivity.hidden = YES;
            self.topSeparateLine.hidden = NO;
            self.bottomSeparateLine.hidden = NO;
            break;
        }
        case XHBubbleMessageMediaTypeMedicineSpecialOffersShowOnce:
        {
            [self setBackgroundColor:[UIColor whiteColor]];
            self.sendActivity.hidden = NO;
            self.sendMedicineLink.hidden = YES;
            self.remarkLabel.hidden = YES;
            _footGuide.hidden = YES;
            _checkButton.hidden = YES;
            _bubbleImageView.image = [XHMessageBubbleFactory bubbleImageViewForType:message.bubbleMessageType style:XHBubbleImageViewStyleWeChat meidaType:message.messageMediaType];
            // 只要是文本、语音、第三方表情，背景的气泡都不能隐藏
            _bubbleImageView.hidden = NO;
            _bubblePhotoImageView.hidden = YES;
            _displayTextView.hidden = YES;
            self.activityContent.hidden = NO;
            self.activityImage.hidden = NO;
            self.activityTitle.hidden = NO;
            self.ratingView.hidden = YES;
            self.serviceLabel.hidden = YES;
            self.dpMeterView.hidden = YES;
            self.subTitle.hidden = YES;
            self.uiGrayBgView.hidden = YES;
            self.askOtherDoc.hidden = YES;
            _checkImmediately.hidden = YES;
            self.topSeparateLine.hidden = NO;
            self.bottomSeparateLine.hidden = NO;
            break;
        }
        case XHBubbleMessageMediaTypeActivity:
        {
            [self setBackgroundColor:[UIColor clearColor]];
            self.sendMedicineLink.hidden = YES;
            self.remarkLabel.hidden = YES;
            _footGuide.hidden = YES;
            _checkButton.hidden = YES;
            if([message officialType]){
                _bubbleImageView.image = [XHMessageBubbleFactory bubbleImageViewForOfficialType:message.bubbleMessageType];
            }else{
                _bubbleImageView.image = [XHMessageBubbleFactory bubbleImageViewForType:message.bubbleMessageType style:XHBubbleImageViewStyleWeChat meidaType:message.messageMediaType];
            }
            // 只要是文本、语音、第三方表情，背景的气泡都不能隐藏
            _bubbleImageView.hidden = NO;
            _bubblePhotoImageView.hidden = YES;
            _displayTextView.hidden = YES;
            self.activityContent.hidden = NO;
            self.activityImage.hidden = NO;
            self.activityTitle.hidden = NO;
            self.ratingView.hidden = YES;
            self.serviceLabel.hidden = YES;
            self.dpMeterView.hidden = YES;
            self.subTitle.hidden = YES;
            self.uiGrayBgView.hidden = YES;
            self.askOtherDoc.hidden = YES;
            _checkImmediately.hidden = YES;
            self.sendActivity.hidden = YES;
            self.topSeparateLine.hidden = YES;
            self.bottomSeparateLine.hidden = YES;
            break;
        }
        case XHBubbleMessageMediaTypeQuitout:
        {
            [self setBackgroundColor:[UIColor clearColor]];
            self.sendMedicineLink.hidden = YES;
            _checkButton.hidden = YES;
            _videoPlayImageView .hidden = YES;
            _bubblePhotoImageView.hidden = NO;
            self.activityContent.hidden = YES;
            self.activityImage.hidden = YES;
            self.activityTitle.hidden = YES;
            _displayTextView.hidden = YES;
            _checkButton.hidden = YES;
            _footGuide.hidden = YES;
            //            [self.activityView stopAnimating];
            //            self.activityView.hidden = YES;
            _checkButton.hidden = YES;
       
                self.dpMeterView.hidden = YES;
           
            self.remarkLabel.hidden = YES;
            _bubbleImageView.hidden = YES;
            self.activityTitle.hidden = YES;
            self.ratingView.hidden = YES;
            self.serviceLabel.hidden = YES;
         
            _checkButton.hidden = YES;
            // 只要是文本、语音、第三方表情，都需要把显示尖嘴图片的控件隐藏了
            //            _bubblePhotoImageView.hidden = YES;
            self.activityContent.hidden = YES;
            self.activityImage.hidden = YES;
            self.activityTitle.hidden = YES;
            self.subTitle.hidden = YES;
            self.uiGrayBgView.hidden = YES;
            self.askOtherDoc.hidden = NO;
            _checkImmediately.hidden = YES;
            self.sendActivity.hidden = YES;
            break;

        }
        case XHBubbleMessageMediaTypeSpreadHint:
        {
            [self setBackgroundColor:[UIColor clearColor]];
            self.sendMedicineLink.hidden = YES;
            self.askOtherDoc.hidden = NO;
            _checkButton.hidden = YES;
            _videoPlayImageView .hidden = YES;
            _bubblePhotoImageView.hidden = NO;
            self.activityContent.hidden = YES;
            self.activityImage.hidden = YES;
            self.activityTitle.hidden = YES;
            _displayTextView.hidden = NO;
            _checkButton.hidden = YES;
            _footGuide.hidden = YES;
            //            [self.activityView stopAnimating];
            //            self.activityView.hidden = YES;
            _checkButton.hidden = YES;
            
            self.dpMeterView.hidden = YES;
            
            self.remarkLabel.hidden = YES;
            _bubbleImageView.hidden = NO;
            self.activityTitle.hidden = YES;
            self.ratingView.hidden = YES;
            self.serviceLabel.hidden = YES;
        _bubbleImageView.image = [XHMessageBubbleFactory bubbleImageViewForOfficialType:message.bubbleMessageType];
            _checkButton.hidden = YES;
            // 只要是文本、语音、第三方表情，都需要把显示尖嘴图片的控件隐藏了
            //            _bubblePhotoImageView.hidden = YES;
            self.activityContent.hidden = YES;
            self.activityImage.hidden = YES;
            self.activityTitle.hidden = YES;
            self.subTitle.hidden = YES;
            self.uiGrayBgView.hidden = YES;
            self.askOtherDoc.hidden = NO;
            _checkImmediately.hidden = YES;
            self.sendActivity.hidden = YES;
            self.topSeparateLine.hidden = YES;
            self.bottomSeparateLine.hidden = YES;
            break;
            
        }
        case XHBubbleMessageMediaTypeHeader:
            self.sendActivity.hidden = YES;
            self.sendMedicineLink.hidden = YES;
            self.remarkLabel.hidden = YES;
            _footGuide.hidden = YES;
            _checkButton.hidden = YES;
            
            _bubbleImageView.hidden = NO;
            _bubblePhotoImageView.hidden = YES;
            _displayTextView.hidden = YES;
            self.activityContent.hidden = YES;
            self.activityImage.hidden = YES;
            self.activityTitle.hidden = YES;
            self.ratingView.hidden = YES;
            self.serviceLabel.hidden = YES;
            self.dpMeterView.hidden = YES;
            self.subTitle.hidden = YES;
            self.uiGrayBgView.hidden = YES;
            self.askOtherDoc.hidden = YES;
            _checkImmediately.hidden = YES;
            self.topSeparateLine.hidden = YES;
            self.bottomSeparateLine.hidden = YES;
            _bubbleImageView.image = [XHMessageBubbleFactory bubbleImageVIewforPTP:message.messageMediaType];
            _checkButton.hidden = YES;
            _displayTextView.hidden = NO;
            self.displayTextView.textColor = RGBHex(qwColor7);
            self.displayTextView.font = [UIFont systemFontOfSize:13.0];
            break;
        case XHBubbleMessageMediaTypeFooter:
            self.sendActivity.hidden = YES;
            self.sendMedicineLink.hidden = YES;
            self.remarkLabel.hidden = YES;
            _footGuide.hidden = YES;
            _checkButton.hidden = YES;
            
            _bubbleImageView.hidden = NO;
            _bubblePhotoImageView.hidden = YES;
            _displayTextView.hidden = YES;
            self.activityContent.hidden = YES;
            self.activityImage.hidden = YES;
            self.activityTitle.hidden = YES;
            self.ratingView.hidden = YES;
            self.serviceLabel.hidden = YES;
            self.dpMeterView.hidden = YES;
            self.subTitle.hidden = YES;
            self.uiGrayBgView.hidden = YES;
            self.askOtherDoc.hidden = YES;
            _checkImmediately.hidden = YES;
            self.topSeparateLine.hidden = YES;
            self.bottomSeparateLine.hidden = YES;
            _bubbleImageView.image = [XHMessageBubbleFactory bubbleImageVIewforPTP:message.messageMediaType];
            _checkButton.hidden = YES;
            _advisory.hidden = NO;
            _displayTextView.hidden = NO;
            self.displayTextView.textColor = RGBHex(qwColor7);
            self.displayTextView.font = [UIFont systemFontOfSize:13.0];
            break;
        case XHBubbleMessageMediaTypeLine:
            self.sendActivity.hidden = YES;
            self.sendMedicineLink.hidden = YES;
            self.remarkLabel.hidden = YES;
            _footGuide.hidden = YES;
            _checkButton.hidden = YES;
            
            _bubbleImageView.hidden = NO;
            _bubblePhotoImageView.hidden = YES;
            _displayTextView.hidden = YES;
            self.activityContent.hidden = YES;
            self.activityImage.hidden = YES;
            self.activityTitle.hidden = YES;
            self.ratingView.hidden = YES;
            self.serviceLabel.hidden = YES;
            self.dpMeterView.hidden = YES;
            self.subTitle.hidden = YES;
            self.uiGrayBgView.hidden = YES;
            self.askOtherDoc.hidden = YES;
            _checkImmediately.hidden = YES;
            self.topSeparateLine.hidden = YES;
            self.bottomSeparateLine.hidden = YES;
            _bubbleImageView.image = [XHMessageBubbleFactory bubbleImageVIewforPTP:message.messageMediaType];
            _checkButton.hidden = YES;
            _displayTextView.hidden = NO;
            _lineView.hidden = NO;
            self.displayTextView.textColor = RGBHex(qwColor7);
            self.displayTextView.font = [UIFont systemFontOfSize:13.0];
            break;
        case XHBubbleMessageMediaTypePhone:
            self.sendActivity.hidden = YES;
            self.sendMedicineLink.hidden = YES;
            self.remarkLabel.hidden = YES;
            _footGuide.hidden = YES;
            _checkButton.hidden = YES;
 
            _bubbleImageView.hidden = NO;
            _bubblePhotoImageView.hidden = YES;
            _displayTextView.hidden = YES;
            self.activityContent.hidden = YES;
            self.activityImage.hidden = YES;
            self.activityTitle.hidden = YES;
            self.ratingView.hidden = YES;
            self.serviceLabel.hidden = YES;
            self.dpMeterView.hidden = YES;
            self.subTitle.hidden = YES;
            self.uiGrayBgView.hidden = YES;
            self.askOtherDoc.hidden = YES;
            _checkImmediately.hidden = YES;
            self.topSeparateLine.hidden = YES;
            self.bottomSeparateLine.hidden = YES;
            _bubbleImageView.image = [XHMessageBubbleFactory bubbleImageVIewforPTP:message.messageMediaType];
            _checkButton.hidden = YES;
            _phoneBtn.hidden = NO;
            _displayTextView.hidden = NO;
            self.displayTextView.textColor = RGBHex(qwColor7);
            self.displayTextView.font = [UIFont systemFontOfSize:13.0];
            break;
        default:
            break;
    }
}

- (void)configureMessageDisplayMediaWithMessage:(id <XHMessageModel>)message {
    switch (message.messageMediaType) {
        case XHBubbleMessageMediaTypeText:
        case XHBubbleMessageMediaTypeStarStore:
        case XHBubbleMessageMediaTypeStarClient:
        case XHBubbleMessageMediaTypePurchaseMedicine://9
        {
            self.activityTitle.text = message.title;
            [_displayTextView setEmojiText:[message text]];
            NSArray *tagList = [message tagList];
            if(tagList)
                [_displayTextView addLinkTags:tagList];
            DDLogVerbose(@"%@---fafasdfa-------%@",_displayTextView.text,[message text]);
            break;
        }
        case XHBubbleMessageMediaTypeAutoSubscription:
        case XHBubbleMessageMediaTypeDrugGuide://8
        {
//            self.activityTitle.textColor = RGB(69, 192, 26);
            self.activityTitle.userInteractionEnabled = YES;
            
            [_displayTextView setEmojiText:[message text]];
            
            NSArray *tagList = [message tagList];
            [_displayTextView addLinkTags:tagList];
            self.activityTitle.text = [message title]?[message title]:@"测试药房";
//            DDLogVerbose(@"---->%@",[message title]?[message title]:@"测试药房");
            self.subTitle.text = message.subTitle?message.subTitle:@"测试二级目录";

            if(tagList)
                [_displayTextView addLinkTags:tagList];
            self.footGuide.emojiText = [NSString stringWithFormat:@"根据您的用药为您推送"];
            
            break;
        }
        case XHBubbleMessageMediaTypePhoto:
            [_bubblePhotoImageView configureMessagePhoto:message.photo thumbnailUrl:message.thumbnailUrl originPhotoUrl:message.originPhotoUrl onBubbleMessageType:self.message.bubbleMessageType uuid: message.UUID];
            break;
        case XHBubbleMessageMediaTypeEmotion:
            // 直接设置GIF
            if (message.emotionPath) {
                _bubbleImageView.image = [UIImage animatedImageWithAnimatedGIFURL:[NSURL fileURLWithPath:message.emotionPath]];
            }
            break;
        case XHBubbleMessageMediaTypeLocalPosition:
            //            [_bubblePhotoImageView configureMessagePhoto:message.localPositionPhoto thumbnailUrl:nil originPhotoUrl:nil onBubbleMessageType:self.message.bubbleMessageType];
            //
            _geolocationsLabel.text = message.geolocations;
            break;
        case XHBubbleMessageMediaTypeActivity:
        case XHBubbleMessageMediaTypeMedicineSpecialOffers:
        case XHBubbleMessageMediaTypeMedicineSpecialOffersShowOnce:
        case XHBubbleMessageMediaTypeMedicine:
        case XHBubbleMessageMediaTypeMedicineShowOnce:
        case XHBubbleMessageMediaTypeLocation:
        {
            self.activityTitle.textColor = [UIColor blackColor];
            self.activityTitle.userInteractionEnabled = NO;
            self.activityTitle.text = message.title;
            self.activityContent.text = message.text;
            
            self.activityImage.image = nil;
            if(message.messageMediaType == XHBubbleMessageMediaTypeActivity || message.messageMediaType == XHBubbleMessageMediaTypeMedicineSpecialOffers || message.messageMediaType == XHBubbleMessageMediaTypeMedicineSpecialOffersShowOnce) {
                self.activityContent.numberOfLines = 4;
                //if(message.activityUrl == nil || [message.activityUrl isEqualToString:@""]){
                if(StrIsEmpty(message.activityUrl)){
                    self.activityImage.hidden = YES;
                }else{
                    self.activityImage.hidden = NO;
                    [self.activityImage setImageWithURL:[NSURL URLWithString:message.activityUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片.png"]];
                    
                }
            }else if(message.messageMediaType == XHBubbleMessageMediaTypeLocation){
                self.activityContent.numberOfLines = 2;
                self.activityImage.hidden = NO;
                [self.activityImage setImage:[UIImage imageNamed:@"mapIcon.png"]];
            }else if (message.messageMediaType == XHBubbleMessageMediaTypeMedicine || message.messageMediaType == XHBubbleMessageMediaTypeMedicineShowOnce) {
                self.activityContent.numberOfLines = 2;
                self.activityImage.hidden = NO;
                [self.activityImage setImageWithURL:[NSURL URLWithString:message.activityUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片.png"]];
            }
            break;
        }
        case XHBubbleMessageMediaTypeQuitout:
        {
            [_displayTextView setEmojiText:[message text]];
      
            break;
        }
        case XHBubbleMessageMediaTypeSpreadHint:
        {
            [_displayTextView setEmojiText:[message text]];
            
            break;
        }
        case XHBubbleMessageMediaTypeHeader:
              [_displayTextView setEmojiText:[message text]];
            break;
        case XHBubbleMessageMediaTypeFooter:
              [_displayTextView setEmojiText:[message text]];
            break;
        case XHBubbleMessageMediaTypeLine:
              [_displayTextView setEmojiText:[message text]];
            break;
        case XHBubbleMessageMediaTypePhone:
              [_displayTextView setEmojiText:[message text]];
            break;
        default:
            break;
    }
    
    [self setNeedsLayout];
}

- (void)setSendType:(SendType)sendType
{
    _sendType = sendType;
    CGRect rect = self.bubbleImageView.frame;
    
    switch (sendType) {
        case Sending:
        {
            if([[self message] bubbleMessageType] == XHBubbleMessageTypeReceiving){
                rect.origin.x += rect.size.width + 10;
            }else{
                rect.origin.x -= 25;
            }
            rect.origin.y += rect.size.height / 2 - 7.5;
            rect.size.width = 15;
            rect.size.height = 15;

            [self.activityView startAnimating];
            self.resendButton.hidden = YES;
            [self bringSubviewToFront:self.activityView];
            self.activityView.frame = rect;
            break;
        }
        case SendFailure:
        {
            rect.origin.x -= 40;
            rect.origin.y += rect.size.height / 2 - 20;
            rect.size.width = 40;
            rect.size.height = 40;
            
            [self.activityView stopAnimating];
            self.resendButton.hidden = NO;
            [self bringSubviewToFront:self.resendButton];
            self.resendButton.frame = rect;
            break;
        }
        case Sended:
        default:{
            [self.activityView stopAnimating];
            self.resendButton.hidden = YES;
            break;
        }
    }
}

- (instancetype)initWithFrame:(CGRect)frame
                      message:(id <XHMessageModel>)message {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _message = message;
        
        // 1、初始化气泡的背景
        if (!_bubbleImageView) {
            //bubble image
            UIImageView *bubbleImageView = [[UIImageView alloc] init];
            bubbleImageView.frame = self.bounds;
            bubbleImageView.userInteractionEnabled = YES;
            [self addSubview:bubbleImageView];
            _bubbleImageView = bubbleImageView;
        }
        
        // 2、初始化显示文本消息的TextView
        if (!_displayTextView) {
            MLEmojiLabel *displayTextView = [[MLEmojiLabel alloc] init];
            displayTextView.numberOfLines = 0;
            //displayTextView.customEmojiRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
            displayTextView.customEmojiRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
            displayTextView.disableThreeCommon = YES;
            displayTextView.customEmojiPlistName = @"expressionImage_custom.plist";
            displayTextView.font = [UIFont systemFontOfSize:14.0f];
            displayTextView.emojiDelegate = self;
            displayTextView.backgroundColor = [UIColor clearColor];
            displayTextView.lineBreakMode = NSLineBreakByWordWrapping;
         
            displayTextView.isNeedAtAndPoundSign = YES;
            [self addSubview:displayTextView];
            _displayTextView = displayTextView;
        }
        
        // 3、初始化显示图片的控件
        if (!_bubblePhotoImageView) {
            XHBubblePhotoImageView *bubblePhotoImageView = [[XHBubblePhotoImageView alloc] initWithFrame:CGRectZero];
            [self addSubview:bubblePhotoImageView];
            bubblePhotoImageView.messagePhoto = [UIImage imageNamed:@"image_waiting"];
            _bubblePhotoImageView = bubblePhotoImageView;
            
            if (!_videoPlayImageView) {
                UIImageView *videoPlayImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MessageVideoPlay"]];
                [bubblePhotoImageView addSubview:videoPlayImageView];
                _videoPlayImageView = videoPlayImageView;
            }
            
            if (!_geolocationsLabel) {
                UILabel *geolocationsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
                geolocationsLabel.numberOfLines = 0;
                geolocationsLabel.lineBreakMode = NSLineBreakByTruncatingTail;
                geolocationsLabel.textColor = [UIColor whiteColor];
                geolocationsLabel.backgroundColor = [UIColor clearColor];
                geolocationsLabel.font = [UIFont systemFontOfSize:12];
                [bubblePhotoImageView addSubview:geolocationsLabel];
                _geolocationsLabel = geolocationsLabel;
            }
            if (!_dpMeterView) {
                //                progressView *dpMeterView =[[progressView alloc]initWithFrame:CGRectZero];
                NSBundle * bundle = [NSBundle mainBundle];
                NSArray * progressViews = [bundle loadNibNamed:@"progressView" owner:self options:nil];
                
                progressView *dpMeterViews =[progressViews objectAtIndex:0];
                dpMeterViews.progressLabel.text = @"0%";
                //                [dpMeterView setMeterType:DPMeterTypeLinearHorizontal];
                //                [dpMeterView add:0.6];
                [self addSubview:_dpMeterView];
                _dpMeterView =dpMeterViews;
            }
        }
        
        //4、初始化显示语音时长的label
        if (!_voiceDurationLabel) {
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 30, 30)];
            lbl.textColor = [UIColor lightGrayColor];
            lbl.backgroundColor = [UIColor clearColor];
            lbl.font = [UIFont systemFontOfSize:13.f];
            lbl.textAlignment = NSTextAlignmentRight;
            lbl.hidden = YES;
            [self addSubview:lbl];
            self.voiceDurationLabel = lbl;
        }
        
        if(!_ratingView) {
            self.ratingView = [[RatingView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
            [self.ratingView setImagesDeselected:@"star_none_medium.png" partlySelected:@"star_half_medium.png" fullSelected:@"star_full_medium.png" andDelegate:nil];
            [self.ratingView setBackgroundColor:[UIColor clearColor]];
            self.ratingView.userInteractionEnabled = NO;
        }
        
        self.ratingView.hidden = YES;
        self.resendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.resendButton.frame = CGRectMake(0, 0, 40, 40);
        [self.resendButton setImage:[UIImage imageNamed:@"发送失败图标"] forState:UIControlStateNormal];
        self.resendButton.hidden = YES;
        [self addSubview:self.resendButton];
        self.activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        self.activityView.color = [UIColor grayColor];
        self.activityView.hidesWhenStopped = YES;
        
        self.serviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 25)];
        self.serviceLabel.font = [UIFont systemFontOfSize:15.0];
        self.serviceLabel.text = @"服务打分:";
        self.serviceLabel.backgroundColor = [UIColor clearColor];
        self.serviceLabel.hidden = YES;
        
        [self addSubview:self.serviceLabel];
        [self addSubview:self.activityView];
        [self addSubview:self.ratingView];
        
        self.activityTitle = [[UILabel alloc] init];
        if([self.message messageMediaType] == XHBubbleMessageMediaTypeDrugGuide) {
            self.activityTitle.frame = CGRectMake(0, 0, 190, 45);
        }else{
            self.activityTitle.frame = CGRectMake(0, 0, 190, 45);
        }
//        self.activityTitle.textAlignment =
        self.activityTitle.font = [UIFont systemFontOfSize:16.0];
        self.activityTitle.numberOfLines = 2;
        self.activityTitle.textColor = RGBHex(qwColor6);
        self.activityTitle.backgroundColor = [UIColor clearColor];
        [self addSubview:self.activityTitle];
        self.activityTitle.hidden = YES;
        
        self.subTitle = [[UILabel alloc] init];
        if([self.message messageMediaType] == XHBubbleMessageMediaTypeDrugGuide) {
            self.subTitle.frame = CGRectMake(-KpandingLeft, 44, 250, 45);
        }else{
            self.subTitle.frame = CGRectMake(-KpandingLeft,44, 250, 45);
        }
//        self.subTitle.textAlignment =
        self.subTitle.font = [UIFont systemFontOfSize:14.0];
        self.subTitle.numberOfLines = 2;
        self.subTitle.textColor = RGBHex(qwColor8);
        self.subTitle.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.subTitle];
        self.subTitle.hidden = YES;
        
        self.uiGrayBgView = [[UIView alloc]initWithFrame:CGRectMake(-KpandingLeft, 49, 265, 1)];
        self.uiGrayBgView.backgroundColor = RGBHex(qwColor10);
        [self addSubview:self.uiGrayBgView];
        self.uiGrayBgView.hidden = YES;
        
        self.remarkLabel = [[UILabel alloc] init];
        self.remarkLabel.frame = CGRectMake(148,22.5, 190, 45);
        self.remarkLabel.text = @"立即评价";
        self.remarkLabel.font = [UIFont systemFontOfSize:14.0];
        self.remarkLabel.textColor = [UIColor blueColor];
        self.remarkLabel.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.remarkLabel];
        self.remarkLabel.hidden = YES;
        
        
        self.activityContent = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 125, 65)];
        self.activityContent.font = [UIFont systemFontOfSize:13.0];
        self.activityContent.numberOfLines = 4;
        self.activityContent.textAlignment = NSTextAlignmentLeft;
        
        self.activityContent.backgroundColor = [UIColor clearColor];
        [self addSubview:self.activityContent];
        self.activityContent.hidden = YES;
        
        self.activityImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
        [self addSubview:self.activityImage];
        self.activityImage.hidden = YES;
        
        //慢病订阅立即查看按钮
        self.checkButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.checkButton setTitle:@"立即去查看" forState:UIControlStateNormal];
        self.checkButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        self.checkButton.titleLabel.textColor = [UIColor blueColor];
        self.checkButton.backgroundColor = [UIColor clearColor];
        self.checkButton.frame = CGRectMake(160, 0, 80, 20);
        [self addSubview:self.checkButton];
        
        self.askOtherDoc = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.askOtherDoc setTitle:@"咨询其他药店" forState:UIControlStateNormal];
        self.askOtherDoc.titleLabel.font = [UIFont systemFontOfSize:15.0];
        self.askOtherDoc.titleLabel.textColor = [UIColor blueColor];
        self.askOtherDoc.backgroundColor = [UIColor clearColor];
        self.askOtherDoc.frame = CGRectMake(160, 0, 100, 20);
        [self addSubview:self.askOtherDoc];
        self.askOtherDoc.hidden = YES;
        
        self.checkImmediately = [UIButton buttonWithType:UIButtonTypeSystem];
        self.checkImmediately.userInteractionEnabled = NO;
        [self.checkImmediately setTitle:@"查看详情>" forState:UIControlStateNormal];
        self.checkImmediately.titleLabel.font = [UIFont systemFontOfSize:15.0];
        self.checkImmediately.titleLabel.textColor = [UIColor blueColor];
        self.checkImmediately.backgroundColor = [UIColor clearColor];
        self.checkImmediately.frame = CGRectMake(160, 0, 100, 20);
        [self addSubview:self.checkImmediately];
        self.checkImmediately.hidden = YES;
        
        //发送药品链接
        self.sendMedicineLink = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.sendMedicineLink setTitle:@"发送链接" forState:UIControlStateNormal];
        UIImage *resizeImage = [UIImage imageNamed:@"ic_btn_send.png"];
        resizeImage = [resizeImage resizableImageWithCapInsets:UIEdgeInsetsMake(20, 30, 20, 30) resizingMode:UIImageResizingModeStretch];
        [self.sendMedicineLink setBackgroundImage:resizeImage forState:UIControlStateNormal];
        self.sendMedicineLink.titleLabel.font = [UIFont systemFontOfSize:15.0];
        self.sendMedicineLink.titleLabel.textColor = [UIColor blueColor];
        self.sendMedicineLink.frame = CGRectMake(160, 0, 85, 36);
        [self addSubview:self.sendMedicineLink];
        self.sendMedicineLink.hidden = YES;
        
        //发送优惠活动链接
        self.sendActivity = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.sendActivity setTitle:@"发送" forState:UIControlStateNormal];
        self.sendActivity.titleLabel.font = [UIFont systemFontOfSize:15.0];
        self.sendActivity.titleLabel.textColor = [UIColor blueColor];
        [self.sendActivity setBackgroundImage:[UIImage imageNamed:@"ic_btn_send.png"] forState:UIControlStateNormal];
        self.sendActivity.frame = CGRectMake(160, 0, 86, 36);
        [self addSubview:self.sendActivity];
        self.sendActivity.hidden = YES;
        
        self.topSeparateLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 0.5)];
        self.topSeparateLine.backgroundColor = RGBHex(qwColor10);
        [self addSubview:self.topSeparateLine];
        self.topSeparateLine.hidden = YES;
        
        self.bottomSeparateLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, APP_W, 0.5)];
        self.bottomSeparateLine.backgroundColor = RGBHex(qwColor10);
        [self addSubview:self.bottomSeparateLine];
        self.bottomSeparateLine.hidden = YES;
        
        //用药指导注标
        if([_message officialType]){
            self.footGuide = [[MLEmojiLabel alloc] initWithFrame:CGRectMake(-22, 0, APP_W * 0.8, 20)];
        }else{
            self.footGuide = [[MLEmojiLabel alloc] initWithFrame:CGRectMake(-22, 0, APP_W * 0.6, 20)];
        }
        self.footGuide.emojiDelegate = self;
        
        self.footGuide.textColor = RGB(153, 153, 153);
        self.footGuide.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:self.footGuide];
        
        if (!_advisory) {
            _advisory = [UIButton buttonWithType:UIButtonTypeCustom];
            _advisory.frame = CGRectMake(240, 0, 44, 44);
            [_advisory setImage:[UIImage imageNamed:@"ic_btn_advisory"] forState:UIControlStateNormal];
            _advisory.hidden = YES;
            [self addSubview:_advisory];
        }
        if (!_phoneBtn) {
            _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _phoneBtn.frame = CGRectMake(260, 0, 44, 44);
            [_phoneBtn setImage:[UIImage imageNamed:@"ic_btn_phone"] forState:UIControlStateNormal];
            [self addSubview:_phoneBtn];
        }
        if (!_lineView) {
            _lineView = [[UIView alloc]initWithFrame:CGRectMake(150, 30, 320, 1)];
            _lineView.backgroundColor = [UIColor redColor];
            [self addSubview:_lineView];
        }
    }
    return self;
}


- (void)dealloc {
    _message = nil;
    
    _displayTextView = nil;
    
    _bubbleImageView = nil;
    
    _bubblePhotoImageView = nil;
    
    _animationVoiceImageView = nil;
    
    _voiceDurationLabel = nil;
    
    _videoPlayImageView = nil;
    
    _geolocationsLabel = nil;
    
    _font = nil;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.activityContent.textColor = RGBHex(qwColor8);
    self.activityTitle.textColor = RGBHex(qwColor6);
    _displayTextView.textColor = [UIColor blackColor];
    _displayTextView.font = [UIFont systemFontOfSize:14.0];
    XHBubbleMessageMediaType currentType = self.message.messageMediaType;
    CGRect bubbleFrame = [self bubbleFrame];
    switch (currentType) {
        case XHBubbleMessageMediaTypeText:
        {
            CGRect bubbleFrameCopy = bubbleFrame;
            CGFloat textX = CGRectGetMinX(bubbleFrame) + kBubblePaddingRight;
            if([self.message officialType]) {
                bubbleFrameCopy.origin.x = -35;
//                 textX += kXHArrowMarginWidth  ;
            }
            if (self.message.bubbleMessageType == XHBubbleMessageTypeReceiving) {
                textX += kXHArrowMarginWidth  - 5;
                   bubbleFrameCopy.origin.x =  bubbleFrameCopy.origin.x -8;
            }
            bubbleFrameCopy.size.height = MAX(35, bubbleFrameCopy.size.height);
            self.bubbleImageView.frame = bubbleFrameCopy;
       
            
           
            CGRect textFrame = CGRectMake(textX,
                                          CGRectGetMinY(bubbleFrame) + kPaddingTop + 2,
                                          CGRectGetWidth(bubbleFrame) - kBubblePaddingRight * 2 - kXHArrowMarginWidth,
                                          bubbleFrame.size.height - kMarginTop - kMarginBottom);
            if(textFrame.size.height <= 30) {
                textFrame.origin.y += 3;
            }
            if([self.message officialType]) {
                textFrame.origin.x = -28;
            }
            self.displayTextView.frame = CGRectIntegral(textFrame);
            
            [self.displayTextView sizeToFit];
            
            CGRect animationVoiceImageViewFrame = self.animationVoiceImageView.frame;
            animationVoiceImageViewFrame.origin = CGPointMake((self.message.bubbleMessageType == XHBubbleMessageTypeReceiving ? (bubbleFrame.origin.x + kVoiceMargin) : (bubbleFrame.origin.x + CGRectGetWidth(bubbleFrame) - kVoiceMargin - CGRectGetWidth(animationVoiceImageViewFrame))), 17);
            self.animationVoiceImageView.frame = animationVoiceImageViewFrame;
            [self resetVoiceDurationLabelFrameWithBubbleFrame:bubbleFrame];
            if (currentType == XHBubbleMessageMediaTypeStarStore)
            {
                self.ratingView.hidden = NO;
                self.serviceLabel.hidden = YES;
                CGRect rect = self.ratingView.frame;
                if (self.message.bubbleMessageType == XHBubbleMessageTypeReceiving) {
                    rect.origin.x = 50;
                }else{
                    rect.origin.x = 70;
                }
                rect.origin.y = 36.5;
                
                self.ratingView.frame = rect;
                [self.ratingView displayRating:0.0];
                
            }else if (currentType == XHBubbleMessageMediaTypeStarClient) {
                self.ratingView.hidden = NO;
                
                self.serviceLabel.hidden = NO;
                CGRect rect = self.serviceLabel.frame;
                rect.origin.x = 21;
                rect.origin.y = 12;
                self.serviceLabel.frame = rect;
                
                rect = self.ratingView.frame;
                rect.origin.x = 105;
                rect.origin.y  = 16;
                self.ratingView.frame = rect;
                [self.ratingView displayRating:self.message.starMark];
                rect = self.displayTextView.frame;
                rect.origin.x = 21;
                rect.origin.y = 40;
                self.displayTextView.frame = rect;
                
            }else{
                self.serviceLabel.hidden = YES;
                self.ratingView.hidden = YES;
            }
            break;
        }
        case XHBubbleMessageMediaTypeStarStore:
        case XHBubbleMessageMediaTypeStarClient:
        case XHBubbleMessageMediaTypeDrugGuide://8
        {
            
            if([_message officialType]) {
                self.activityTitle.numberOfLines =1;
                self.subTitle.numberOfLines = 1;
                bubbleFrame.origin.x = -Kpandingright;
                //                bubbleFrame.size.height =+42;
            }
            self.uiGrayBgView .hidden = NO;
            self.subTitle.hidden = NO;
            CGRect bubbleFrameCopy = bubbleFrame;
    
            CGFloat textX = CGRectGetMinX(bubbleFrame) + kBubblePaddingRight;
            
            if (self.message.bubbleMessageType == XHBubbleMessageTypeReceiving) {
                textX += kXHArrowMarginWidth  - 2;
            }
        CGSize textSize =    [XHMessageBubbleView getBubbleFrameWithMessage:self.message];
             textSize = [XHMessageBubbleView neededSizeForText:self.displayTextView.text withDelta:0.85];
            CGFloat maxWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) * .85;
            CGRect textFrame = CGRectMake(textX ,
                                          CGRectGetMinY(bubbleFrame) + kPaddingTop + 60,
                                          textSize.width- kBubblePaddingRight * 2 - kXHArrowMarginWidth,
                                          textSize.height);
            if(textFrame.size.height <= 30) {
                textFrame.origin.y += 3;
            }
            textFrame.origin.y += 10;
            CGRect subTitleRect = self.subTitle.frame;
            if (self.message.fromTag == 0) {
                subTitleRect.origin.y =bubbleFrame.origin.y +5;
                self.subTitle.frame = subTitleRect;
                textFrame.origin.y =bubbleFrame.origin.y +39;

            }else if(self.message.fromTag == 2)
            {

                subTitleRect.origin.y =bubbleFrame.origin.y +35;
                self.subTitle.frame = subTitleRect;
                textFrame.origin.y =bubbleFrame.origin.y+KtextFrame;
            }
            DDLogVerbose(@"-textFrame-----%f",CGRectGetWidth(bubbleFrame) - kBubblePaddingRight * 2 - kXHArrowMarginWidth);
                self.displayTextView.contentMode = UIViewContentModeTopLeft;
            self.displayTextView.frame = CGRectIntegral(textFrame);
               DDLogVerbose(@"-textFrame-----%f", maxWidth);
       [self.displayTextView sizeToFit];
            if (self.message.fromTag == 0) {
                
                self.activityTitle.hidden = YES;
                self.uiGrayBgView.hidden = YES;
            }else if(self.message.fromTag == 2)
            {
                self.activityTitle.hidden = NO;
                self.uiGrayBgView.hidden = NO;
                
            }
            
            if([_message officialType]) {
                CGRect titleFrame = self.activityTitle.frame;
                titleFrame.origin.x = -KpandingLeft;
                titleFrame.origin.y = 8;
        
                    titleFrame.size = CGSizeMake(260, 45);
   
                self.activityTitle.frame = titleFrame;
                CGRect footFrame = self.footGuide.frame;
                footFrame.origin.y = bubbleFrameCopy.origin.y + bubbleFrameCopy.size.height - 30.5;
                 footFrame.origin.x = -KpandingLeft;
                self.footGuide.frame = footFrame;
            }else{
                CGRect titleFrame = self.activityTitle.frame;
  
                    titleFrame.size = CGSizeMake(260, 45);
           
                titleFrame.origin.x = 13;
                titleFrame.origin.y = 8;
                self.activityTitle.frame = titleFrame;
                
                CGRect footFrame = self.footGuide.frame;
                footFrame.origin.y = bubbleFrameCopy.origin.y + bubbleFrameCopy.size.height - 30.5;
                footFrame.origin.x = 13;
                self.footGuide.frame = footFrame;
                
            }
            
            bubbleFrameCopy.size.height = MAX(35, bubbleFrameCopy.size.height);
            self.bubbleImageView.frame = bubbleFrameCopy;
            DDLogVerbose(@"-bubfram-----%@-----%@",NSStringFromCGRect(bubbleFrame),NSStringFromCGRect(self.displayTextView.frame));
                         DDLogVerbose(@"-textFrame-----%f", self.displayTextView.frame.size.height);
            DDLogVerbose(@"-jianxi-----%f",   bubbleFrame.origin.y +bubbleFrame.size.height - self.displayTextView.frame.origin.y-self.displayTextView.frame.size.height-self.subTitle.frame.origin.y-self.subTitle.frame.size.height);
            break;
        }
        case XHBubbleMessageMediaTypePurchaseMedicine://9
        {
            
            if (self.message.fromTag == 0) {
 
                self.activityTitle.hidden = YES;
                self.uiGrayBgView.hidden = YES;
            }else if(self.message.fromTag == 2)
            {
                self.activityTitle.hidden = NO;
                self.uiGrayBgView.hidden = NO;
             
            }
            CGRect bubbleFrameCopy = bubbleFrame;
            if([self.message officialType]) {
                self.activityTitle.numberOfLines =1;
                self.subTitle.numberOfLines = 1;
                bubbleFrameCopy.origin.x = -Kpandingright;
            
            }
            bubbleFrameCopy.size.height = MAX(35, bubbleFrameCopy.size.height);
            self.bubbleImageView.frame = bubbleFrameCopy;
            CGFloat textX = CGRectGetMinX(bubbleFrame) + kBubblePaddingRight;
            
            if (self.message.bubbleMessageType == XHBubbleMessageTypeReceiving) {
                textX += kXHArrowMarginWidth  - 5;
            }
            CGRect textFrame = CGRectMake(textX,
                                          CGRectGetMinY(bubbleFrame) + kPaddingTop + 2,
                                          CGRectGetWidth(bubbleFrame) - kBubblePaddingRight * 2 - kXHArrowMarginWidth,
                                          bubbleFrame.size.height - kMarginTop - kMarginBottom);
            if (self.message.fromTag == 0) {
//                textFrame.size.height= -KtextFrame;
//                bubbleFrameCopy.size.height = -KtextFrame;
//                bubbleFrameCopy.size.height = MAX(35, bubbleFrameCopy.size.height);
//                self.bubbleImageView.frame = bubbleFrameCopy;
            }else if(self.message.fromTag == 2)
            {
//                bubbleFrameCopy.size.height = MAX(35, bubbleFrameCopy.size.height);
//                self.bubbleImageView.frame = bubbleFrameCopy;
                textFrame.origin.y =bubbleFrame.origin.y+KtextFrame-23;
            }
            if([_message officialType]) {
                CGRect titleFrame = self.activityTitle.frame;
               titleFrame.origin.x = -27;
                titleFrame.origin.y = KTitleTop;

                    titleFrame.size = CGSizeMake(260, 45);

                self.activityTitle.frame = titleFrame;

            }else{
                CGRect titleFrame = self.activityTitle.frame;

                    titleFrame.size = CGSizeMake(260, 45);

                titleFrame.origin.x = 13;
                titleFrame.origin.y = 8;
                self.activityTitle.frame = titleFrame;

                
            }
            if(textFrame.size.height <= 30) {
                textFrame.origin.y += 3;
            }
            if([self.message officialType]) {
                textFrame.origin.x = -27;
            }
            self.displayTextView.frame = CGRectIntegral(textFrame);
            
            [self.displayTextView sizeToFit];
            
            CGRect animationVoiceImageViewFrame = self.animationVoiceImageView.frame;
            animationVoiceImageViewFrame.origin = CGPointMake((self.message.bubbleMessageType == XHBubbleMessageTypeReceiving ? (bubbleFrame.origin.x + kVoiceMargin) : (bubbleFrame.origin.x + CGRectGetWidth(bubbleFrame) - kVoiceMargin - CGRectGetWidth(animationVoiceImageViewFrame))), 17);
            self.animationVoiceImageView.frame = animationVoiceImageViewFrame;
            [self resetVoiceDurationLabelFrameWithBubbleFrame:bubbleFrame];
            if (currentType == XHBubbleMessageMediaTypeStarStore)
            {
                self.ratingView.hidden = NO;
                self.serviceLabel.hidden = YES;
                CGRect rect = self.ratingView.frame;
                [self.ratingView displayRating:5.0f];
                if (self.message.bubbleMessageType == XHBubbleMessageTypeReceiving) {
                    if(HIGH_RESOLUTION){
                        rect.origin.x = 35;
                    }
                    else{
                        rect.origin.x = 50;
                    }
                }else{
                    rect.origin.x = 45;
                }
                rect.origin.y = 36.5;
                self.ratingView.frame = rect;
                [self.ratingView displayRating:0.0];
                
            }else if (currentType == XHBubbleMessageMediaTypeStarClient) {
                self.ratingView.hidden = NO;
                
                self.serviceLabel.hidden = NO;
                CGRect rect = self.serviceLabel.frame;
                rect.origin.x = 51;
                rect.origin.y = 12;
                self.serviceLabel.frame = rect;
                
                rect = self.ratingView.frame;
                rect.origin.x = 135;
                rect.origin.y  = 16;
                self.ratingView.frame = rect;
                [self.ratingView displayRating:self.message.starMark];
                rect = self.displayTextView.frame;
                rect.origin.x = 51;
                rect.origin.y = 40;
                self.displayTextView.frame = rect;
                
            }else{
                self.serviceLabel.hidden = YES;
                self.ratingView.hidden = YES;
            }
            break;
        }
        case XHBubbleMessageMediaTypeEmotion:
        {
            CGRect bubbleFrameCopy = bubbleFrame;
            if([self.message officialType]) {
                bubbleFrameCopy.origin.x = -40;
            }
            bubbleFrameCopy.size.height = MAX(35, bubbleFrameCopy.size.height);
            self.bubbleImageView.frame = bubbleFrameCopy;
            CGFloat textX = CGRectGetMinX(bubbleFrame) + kBubblePaddingRight;
            
            if (self.message.bubbleMessageType == XHBubbleMessageTypeReceiving) {
                textX += kXHArrowMarginWidth  - 5;
            }
            CGRect textFrame = CGRectMake(textX,
                                          CGRectGetMinY(bubbleFrame) + kPaddingTop + 2,
                                          CGRectGetWidth(bubbleFrame) - kBubblePaddingRight * 2 - kXHArrowMarginWidth,
                                          bubbleFrame.size.height - kMarginTop - kMarginBottom);
            if(textFrame.size.height <= 30) {
                textFrame.origin.y += 3;
            }
            if([self.message officialType]) {
                textFrame.origin.x = -20;
            }
            self.displayTextView.frame = CGRectIntegral(textFrame);
            
            [self.displayTextView sizeToFit];
            
            CGRect animationVoiceImageViewFrame = self.animationVoiceImageView.frame;
            animationVoiceImageViewFrame.origin = CGPointMake((self.message.bubbleMessageType == XHBubbleMessageTypeReceiving ? (bubbleFrame.origin.x + kVoiceMargin) : (bubbleFrame.origin.x + CGRectGetWidth(bubbleFrame) - kVoiceMargin - CGRectGetWidth(animationVoiceImageViewFrame))), 17);
            self.animationVoiceImageView.frame = animationVoiceImageViewFrame;
            [self resetVoiceDurationLabelFrameWithBubbleFrame:bubbleFrame];
            if (currentType == XHBubbleMessageMediaTypeStarStore)
            {
                self.ratingView.hidden = NO;
                self.serviceLabel.hidden = YES;
                CGRect rect = self.ratingView.frame;
                [self.ratingView displayRating:5.0f];
                if (self.message.bubbleMessageType == XHBubbleMessageTypeReceiving) {
                    if(HIGH_RESOLUTION){
                        rect.origin.x = 35;
                    }
                    else{
                        rect.origin.x = 50;
                    }
                }else{
                    rect.origin.x = 45;
                }
                rect.origin.y = 36.5;
                self.ratingView.frame = rect;
                [self.ratingView displayRating:0.0];
                
            }else if (currentType == XHBubbleMessageMediaTypeStarClient) {
                self.ratingView.hidden = NO;
                
                self.serviceLabel.hidden = NO;
                CGRect rect = self.serviceLabel.frame;
                rect.origin.x = 51;
                rect.origin.y = 12;
                self.serviceLabel.frame = rect;
                
                rect = self.ratingView.frame;
                rect.origin.x = 135;
                rect.origin.y  = 16;
                self.ratingView.frame = rect;
                [self.ratingView displayRating:self.message.starMark];
                rect = self.displayTextView.frame;
                rect.origin.x = 51;
                rect.origin.y = 40;
                self.displayTextView.frame = rect;
                
            }else{
                self.serviceLabel.hidden = YES;
                self.ratingView.hidden = YES;
            }
            break;
        }
        case XHBubbleMessageMediaTypeLocation:
        {
            CGRect bubbleFrameCopy = bubbleFrame;
            bubbleFrameCopy.size.height = MAX(35, bubbleFrameCopy.size.height);
            self.bubbleImageView.frame = bubbleFrameCopy;
            CGFloat textX = CGRectGetMinX(bubbleFrame) + kBubblePaddingRight;
            
            if (self.message.bubbleMessageType == XHBubbleMessageTypeReceiving) {
                textX += kXHArrowMarginWidth  - 5;
            }
            CGRect textFrame = CGRectMake(textX,
                                          CGRectGetMinY(bubbleFrame) + kPaddingTop + 2,
                                          CGRectGetWidth(bubbleFrame) - kBubblePaddingRight * 2 - kXHArrowMarginWidth,
                                          bubbleFrame.size.height - kMarginTop - kMarginBottom);
            if(textFrame.size.height <= 30) {
                textFrame.origin.y += 3;
            }
            
            CGRect rect = CGRectZero;
            CGSize constrainedSize = CGSizeZero;
            if([self.message messageMediaType] == XHBubbleMessageMediaTypeDrugGuide) {
                constrainedSize = CGSizeMake(260, 45);
            }else{
                constrainedSize = CGSizeMake(190, 45);
            }
            
            rect = self.activityImage.frame;
            rect.origin.x = 21;
            rect.origin.y = 19.5;
            self.activityImage.frame = rect;
            
            rect = self.activityContent.frame;
            rect.origin.x = 86;
            rect.origin.y = 12.5;
            rect.size.width = 120;
            rect.size.height = 65;
            self.activityContent.frame = rect;
            
            break;
        }
        case XHBubbleMessageMediaTypeMedicineSpecialOffers:
        {
            CGRect bubbleFrameCopy = bubbleFrame;
            bubbleFrameCopy.size.height = MAX(35, bubbleFrameCopy.size.height);
            self.bubbleImageView.frame = bubbleFrameCopy;
            CGFloat textX = CGRectGetMinX(bubbleFrame) + kBubblePaddingRight;
            
            if (self.message.bubbleMessageType == XHBubbleMessageTypeReceiving) {
                textX += kXHArrowMarginWidth  - 5;
            }
            CGRect textFrame = CGRectMake(textX,
                                          CGRectGetMinY(bubbleFrame) + kPaddingTop + 2,
                                          CGRectGetWidth(bubbleFrame) - kBubblePaddingRight * 2 - kXHArrowMarginWidth,
                                          bubbleFrame.size.height - kMarginTop - kMarginBottom);
            if(textFrame.size.height <= 30) {
                textFrame.origin.y += 3;
            }
            if(self.message.bubbleMessageType == XHBubbleMessageTypeReceiving) {
                CGRect rect = CGRectZero;
                CGSize constrainedSize = CGSizeZero;
                if([self.message messageMediaType] == XHBubbleMessageMediaTypeDrugGuide) {
                    constrainedSize = CGSizeMake(260, 45);
                }else{
                    constrainedSize = CGSizeMake(190, 45);
                }
                
                CGSize size = [[_message title] sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:constrainedSize];
                rect = self.activityTitle.frame;
                rect.origin.x = 20;
                rect.origin.y = 14;
                rect.size.height = ceilf(size.height);
                rect.size.width = 180;
                self.activityTitle.frame = rect;
                rect = self.activityImage.frame;
                rect.origin.x = 25 ;
                rect.origin.y = self.activityTitle.frame.origin.y + size.height + 8;
                self.activityImage.frame = rect;
                
                rect = self.activityContent.frame;
                rect.origin.x = 85;
                rect.origin.y = self.activityTitle.frame.origin.y + size.height + 4;
                rect.size.width = 115;
                self.activityContent.frame = rect;
            }else{
                CGRect rect = self.activityTitle.frame;
                rect.origin.x = 16;
                rect.origin.y = 14;
                self.activityTitle.frame = rect;
                
                CGSize constrainedSize = CGSizeZero;
                if([self.message messageMediaType] == XHBubbleMessageMediaTypeDrugGuide) {
                    constrainedSize = CGSizeMake(260, 45);
                }else{
                    constrainedSize = CGSizeMake(190, 45);
                }
                
                CGSize size = [[_message title] sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:constrainedSize];
                rect = self.activityTitle.frame;
                rect.origin.x = 61.5;
                rect.size.width = 180;
                rect.size.height = ceilf(size.height);
                self.activityTitle.frame = rect;
                rect = self.activityImage.frame;
                rect.origin.x = 16 + 50 ;
                rect.origin.y = self.activityTitle.frame.origin.y + size.height + 8;
                
                self.activityImage.frame = rect;
                rect = self.activityContent.frame;
                rect.origin.x = 125;
                rect.origin.y = self.activityTitle.frame.origin.y + size.height + 4;
                rect.size.width = 115;
                self.activityContent.frame = rect;
            }
            break;
        }
        case XHBubbleMessageMediaTypeMedicineSpecialOffersShowOnce:
        {
            CGRect bubbleFrameCopy = bubbleFrame;
            bubbleFrameCopy.size.height = MAX(35, bubbleFrameCopy.size.height);
            self.bubbleImageView.frame = bubbleFrameCopy;
            CGFloat textX = CGRectGetMinX(bubbleFrame) + kBubblePaddingRight;
            
            if (self.message.bubbleMessageType == XHBubbleMessageTypeReceiving) {
                textX += kXHArrowMarginWidth  - 5;
            }
            CGRect textFrame = CGRectMake(textX,
                                          CGRectGetMinY(bubbleFrame) + kPaddingTop + 2,
                                          CGRectGetWidth(bubbleFrame) - kBubblePaddingRight * 2 - kXHArrowMarginWidth,
                                          bubbleFrame.size.height - kMarginTop - kMarginBottom);
            if(textFrame.size.height <= 30) {
                textFrame.origin.y += 3;
            }
            
            CGRect rect = self.activityTitle.frame;

            rect = self.activityTitle.frame;
            rect.origin.x = 10;
            rect.origin.y = 10;
            rect.size.width = 300;
            rect.size.height = 40;
            self.activityTitle.frame = rect;

            
            rect = self.activityImage.frame;
            rect.origin.x = 10 ;
            rect.origin.y = 55;
            self.activityImage.frame = rect;

            
            rect = self.activityContent.frame;
            rect.origin.x = 80;
            rect.origin.y = 60;
            rect.size.width = 225;
            rect.size.height = 35;
            self.activityContent.frame = rect;

            rect = self.sendActivity.frame;
            rect.origin.x = 76;
            rect.origin.y = 100;
            self.sendActivity.frame = rect;
            
            self.topSeparateLine.frame =CGRectMake(0, 0, APP_W, 0.5);
            self.bottomSeparateLine.frame = CGRectMake(0, self.frame.size.height - 0.5, APP_W, 0.5);
            break;
        }
        case XHBubbleMessageMediaTypeActivity:
        {
            CGRect bubbleFrameCopy = bubbleFrame;
            bubbleFrameCopy.size.height = MAX(35, bubbleFrameCopy.size.height);
            self.bubbleImageView.frame = bubbleFrameCopy;
            CGFloat textX = CGRectGetMinX(bubbleFrame) + kBubblePaddingRight;
            
            if (self.message.bubbleMessageType == XHBubbleMessageTypeReceiving) {
                textX += kXHArrowMarginWidth  - 5;
            }
            CGRect textFrame = CGRectMake(textX,
                                          CGRectGetMinY(bubbleFrame) + kPaddingTop + 2,
                                          CGRectGetWidth(bubbleFrame) - kBubblePaddingRight * 2 - kXHArrowMarginWidth,
                                          bubbleFrame.size.height - kMarginTop - kMarginBottom);
            if(textFrame.size.height <= 30) {
                textFrame.origin.y += 3;
            }
            
            CGRect rect = self.activityTitle.frame;
            rect.origin.x = 21;
            rect.origin.y = 14;
            self.activityTitle.frame = rect;
            
           // if(self.message.activityUrl == nil || [self.message.activityUrl isEqualToString:@""])
            if(StrIsEmpty(self.message.activityUrl))
            {
                CGSize constrainedSize = CGSizeZero;
                if([self.message messageMediaType] == XHBubbleMessageMediaTypeDrugGuide) {
                    constrainedSize = CGSizeMake(260, 45);
                }else{
                    constrainedSize = CGSizeMake(190, 45);
                }
                
                CGSize size = [[_message title] sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:constrainedSize];
                CGRect rect = self.activityTitle.frame;
                rect.size.height = ceilf(size.height);
                rect.size.width = 180;
                self.activityTitle.frame = rect;
                rect = self.activityContent.frame;
                
                rect.origin.x = 21;
                rect.size.width = 115;
                rect.origin.y = self.activityTitle.frame.origin.y + size.height + 4;
                CGSize textSize = [[self.message text] sizeWithFont:[UIFont systemFontOfSize:13.0f] constrainedToSize:CGSizeMake(0.6 * APP_W, 65)];
                rect.size = textSize;
                self.activityContent.frame = rect;
                
            }else{
                CGSize constrainedSize = CGSizeZero;
                if([self.message messageMediaType] == XHBubbleMessageMediaTypeDrugGuide) {
                    constrainedSize = CGSizeMake(260, 45);
                }else{
                    constrainedSize = CGSizeMake(190, 45);
                }
                
                CGSize size = [[_message title] sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:constrainedSize];
                CGRect rect = self.activityTitle.frame;
                rect.size.width = 180;
                rect.size.height = ceilf(size.height);
                self.activityTitle.frame = rect;
                rect = self.activityImage.frame;
                rect.origin.x = 21;
                rect.origin.y = self.activityTitle.frame.origin.y + size.height + 8;
                self.activityImage.frame = rect;
                
                rect = self.activityContent.frame;
                rect.origin.x = 90;
                rect.origin.y = self.activityTitle.frame.origin.y + size.height + 4;
                rect.size.width = 115;
                rect.size.height = 65;
                self.activityContent.frame = rect;
            }
            break;
        }
        case XHBubbleMessageMediaTypeMedicineShowOnce:
        {
            CGRect bubbleFrameCopy = bubbleFrame;
            bubbleFrameCopy.size.height = MAX(35, bubbleFrameCopy.size.height);
            self.bubbleImageView.frame = bubbleFrameCopy;
            CGFloat textX = CGRectGetMinX(bubbleFrame) + kBubblePaddingRight + 30;
            
            CGRect textFrame = CGRectMake(textX,
                                          CGRectGetMinY(bubbleFrame) + kPaddingTop + 2,
                                          CGRectGetWidth(bubbleFrame) - kBubblePaddingRight * 2 - kXHArrowMarginWidth,
                                          bubbleFrame.size.height - kMarginTop - kMarginBottom);
            if(textFrame.size.height <= 30) {
                textFrame.origin.y += 3;
            }
            
            CGRect rect = CGRectZero;
            rect = self.activityImage.frame;
            rect.origin.x = 10;
            rect.origin.y = 25;
            self.activityImage.frame = rect;
            
            rect = self.activityContent.frame;
            rect.origin.x = 90 ;
            rect.origin.y = 30;
            rect.size.width = 225;
            rect.size.height = 40;
            self.activityContent.frame = rect;
            
            rect = self.sendMedicineLink.frame;
            rect.origin.x = 85;
            rect.origin.y = 77;
            self.sendMedicineLink.frame = rect;
            self.topSeparateLine.frame =CGRectMake(0, 0, APP_W, 0.5);
            self.bottomSeparateLine.frame = CGRectMake(0, self.frame.size.height - 0.5, APP_W, 0.5);
            break;
        }
        case XHBubbleMessageMediaTypeMedicine:
        {
            CGRect bubbleFrameCopy = bubbleFrame;
            bubbleFrameCopy.size.height = MAX(35, bubbleFrameCopy.size.height);
            self.bubbleImageView.frame = bubbleFrameCopy;
            CGFloat textX = CGRectGetMinX(bubbleFrame) + kBubblePaddingRight + 30;
 
            CGRect textFrame = CGRectMake(textX,
                                          CGRectGetMinY(bubbleFrame) + kPaddingTop + 2,
                                          CGRectGetWidth(bubbleFrame) - kBubblePaddingRight * 2 - kXHArrowMarginWidth,
                                          bubbleFrame.size.height - kMarginTop - kMarginBottom);
            if(textFrame.size.height <= 30) {
                textFrame.origin.y += 3;
            }
            
            CGRect rect = CGRectZero;

            if([self.message bubbleMessageType] == XHBubbleMessageTypeSending) {
                rect = self.activityImage.frame;
                rect.origin.x = 21 + 40;
                rect.origin.y = 20;
                self.activityImage.frame = rect;
                
                rect = self.activityContent.frame;
                rect.origin.x = 90 + 35;
                rect.origin.y = 12.5;
                rect.size.width = 115;
                rect.size.height = 65;
                self.activityContent.frame = rect;
                
                rect = self.checkImmediately.frame;
                rect.origin.x = 152;
                rect.origin.y = 70;
                self.checkImmediately.frame = rect;
            }else{
                rect = self.activityImage.frame;
                rect.origin.x = 21 ;
                rect.origin.y = 20;
                self.activityImage.frame = rect;
                
                rect = self.activityContent.frame;
                rect.origin.x = 90;
                rect.origin.y = 12.5;
                rect.size.width = 115;
                rect.size.height = 65;
                self.activityContent.frame = rect;
                
                rect = self.checkImmediately.frame;
                rect.origin.x = 115;
                rect.origin.y = 70;
                self.checkImmediately.frame = rect;
            }
            self.activityContent.textColor = RGBHex(qwColor6);
            break;
        }
        case XHBubbleMessageMediaTypeAutoSubscription:
        {
            self.subTitle.hidden = YES;
            self.uiGrayBgView.hidden = YES;
            bubbleFrame.origin.x = -Kpandingright;
            CGRect bubbleFrameCopy = bubbleFrame;
            
            bubbleFrameCopy.size.height = MAX(35, bubbleFrameCopy.size.height);
            self.bubbleImageView.frame = bubbleFrameCopy;
            CGFloat textX = CGRectGetMinX(bubbleFrame) + kBubblePaddingRight;
            
            if (self.message.bubbleMessageType == XHBubbleMessageTypeReceiving) {
                textX += kXHArrowMarginWidth  - 1;
            }
            CGRect textFrame = CGRectMake(textX,
                                          CGRectGetMinY(bubbleFrame) + kPaddingTop + 7,
                                          CGRectGetWidth(bubbleFrame) - kBubblePaddingRight * 2 - kXHArrowMarginWidth,
                                          bubbleFrame.size.height - kMarginTop - kMarginBottom);
            if(textFrame.size.height <= 30) {
                textFrame.origin.y += 3;
            }
            self.displayTextView.frame = CGRectIntegral(textFrame);
            [self.displayTextView sizeToFit];
            CGRect buttonFrame = self.checkButton.frame;
            buttonFrame.origin.y = bubbleFrameCopy.origin.y + bubbleFrameCopy.size.height - 25;
            self.checkButton.frame = buttonFrame;
            
            break;
        }
        case XHBubbleMessageMediaTypePhoto:
        {
            CGSize  bubbleSize = CGSizeZero;
            SDImageCache *imageCache = [SDImageCache sharedImageCache];
            if ([imageCache diskImageExistsWithKey:self.message.UUID]) {
                
                UIImage *img2 =[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:self.message.UUID];
                bubbleSize = img2.size;
                if (bubbleSize.width == 0 || bubbleSize.height == 0) {
                    bubbleSize.width = MAX_SIZE;
                    bubbleSize.height = MAX_SIZE;
                }
                else if (bubbleSize.width > bubbleSize.height) {
                    CGFloat height =  MAX_SIZE / bubbleSize.width  *  bubbleSize.height;
                    bubbleSize.height = height;
                    bubbleSize.width = MAX_SIZE;
                }
                else{
                    CGFloat width = MAX_SIZE / bubbleSize.height * bubbleSize.width;
                    bubbleSize.width = width;
                    bubbleSize.height = MAX_SIZE;
                }
            }
            else{
                if (self.message.photo) {
                    bubbleSize = self.message.photo.size;
                    if (bubbleSize.width == 0 || bubbleSize.height == 0) {
                        bubbleSize.width = MAX_SIZE;
                        bubbleSize.height = MAX_SIZE;
                    }
                    else if (bubbleSize.width > bubbleSize.height) {
                        
                        CGFloat height =  MAX_SIZE / bubbleSize.width  *  bubbleSize.height;
                        bubbleSize.height = height;
                        bubbleSize.width = MAX_SIZE;
                    }
                    else{
                        CGFloat width = MAX_SIZE / bubbleSize.height * bubbleSize.width;
                        bubbleSize.width = width;
                        bubbleSize.height = MAX_SIZE;
                    }
                }else
                {
                    bubbleSize = [XHMessageBubbleView neededSizeForPhoto:self.message.photo];
                }
            }
            CGRect photoImageViewFrame = CGRectMake(bubbleFrame.origin.x , 0, bubbleSize.width, bubbleSize.height);
            _bubblePhotoImageView.frame = photoImageViewFrame;
            _bubblePhotoImageView.contentMode = UIViewContentModeScaleAspectFit;
            
            self.bubbleImageView.frame = CGRectMake(_bubblePhotoImageView.frame.origin.x+2 , _bubblePhotoImageView.frame.origin.y +5, _bubblePhotoImageView.frame.size.width+4 , _bubblePhotoImageView.frame.size.height -9);
            if (self.message.bubbleMessageType == XHBubbleMessageTypeReceiving) {
                self.bubbleImageView.frame = CGRectMake(_bubblePhotoImageView.frame.origin.x-4 , _bubblePhotoImageView.frame.origin.y +5, _bubblePhotoImageView.frame.size.width+4 , _bubblePhotoImageView.frame.size.height -9);
            }else{
                self.bubbleImageView.frame = CGRectMake(_bubblePhotoImageView.frame.origin.x+2 , _bubblePhotoImageView.frame.origin.y +5, _bubblePhotoImageView.frame.size.width+4 , _bubblePhotoImageView.frame.size.height -9);
            }
            if (self.message.sended == Sending) {
                self.dpMeterView.hidden = NO;
            }else
            {
                self.dpMeterView.hidden = YES;
            }
            [self.dpMeterView setFrame:self.bubblePhotoImageView.frame];
            [self.dpMeterView setNeedsDisplay];
            [self addSubview:self.dpMeterView];
            self.videoPlayImageView.hidden = YES;
            self.ratingView.hidden = YES;
            break;
        }
        case XHBubbleMessageMediaTypeLocalPosition: {
            self.ratingView.hidden = YES;
            CGRect photoImageViewFrame = CGRectMake(bubbleFrame.origin.x - 2, 0, bubbleFrame.size.width, bubbleFrame.size.height);
            self.bubblePhotoImageView.frame = photoImageViewFrame;
            
            self.videoPlayImageView.center = CGPointMake(CGRectGetWidth(photoImageViewFrame) / 2.0, CGRectGetHeight(photoImageViewFrame) / 2.0);
            
            CGRect geolocationsLabelFrame = CGRectMake(11, CGRectGetHeight(photoImageViewFrame) - 47, CGRectGetWidth(photoImageViewFrame) - 20, 40);
            self.geolocationsLabel.frame = geolocationsLabelFrame;
            
            break;
        }
            case XHBubbleMessageMediaTypeSpreadHint:
        {
            self.subTitle.hidden = YES;
            self.uiGrayBgView.hidden = YES;
            bubbleFrame.origin.x = -Kpandingright;
            CGRect bubbleFrameCopy = bubbleFrame;
            
            bubbleFrameCopy.size.height = MAX(35, bubbleFrameCopy.size.height);
            self.bubbleImageView.frame = bubbleFrameCopy;
            CGFloat textX = CGRectGetMinX(bubbleFrame) + kBubblePaddingRight;
            
            if (self.message.bubbleMessageType == XHBubbleMessageTypeReceiving) {
                textX += kXHArrowMarginWidth  - 1;
            }
            CGRect textFrame = CGRectMake(textX,
                                          CGRectGetMinY(bubbleFrame) + kPaddingTop + 7,
                                          CGRectGetWidth(bubbleFrame) - kBubblePaddingRight * 2 - kXHArrowMarginWidth,
                                          bubbleFrame.size.height - kMarginTop - kMarginBottom);
            if(textFrame.size.height <= 30) {
                textFrame.origin.y += 3;
            }
            self.displayTextView.frame = CGRectIntegral(textFrame);
            [self.displayTextView sizeToFit];
            CGRect buttonAskBtnFrame = self.askOtherDoc.frame;
            buttonAskBtnFrame.origin.x = bubbleFrameCopy.origin.x+bubbleFrameCopy.size.width-self.askOtherDoc.frame.size.width-5;
            buttonAskBtnFrame.origin.y = bubbleFrameCopy.origin.y + bubbleFrameCopy.size.height - 25;
            self.askOtherDoc.frame = buttonAskBtnFrame;
            
            break;
        }
        case XHBubbleMessageMediaTypeHeader:
        {
            CGRect bubbleFrameCopy = bubbleFrame;
            CGFloat textX = CGRectGetMinX(bubbleFrame) + kBubblePaddingRight+34;
           
//            bubbleFrameCopy.size.width = 260;
            bubbleFrameCopy.origin.x =textX;
            bubbleFrameCopy.size.height = MAX(35, bubbleFrameCopy.size.height);
            self.bubbleImageView.frame = bubbleFrameCopy;
            
            
            
            CGRect textFrame = CGRectMake(textX+12,
                                          CGRectGetMinY(bubbleFrame) + kPaddingTop + 5,
                                          CGRectGetWidth(bubbleFrame) ,
                                          bubbleFrame.size.height - kMarginTop - kMarginBottom);
            if(textFrame.size.height <= 30) {
                textFrame.origin.y += 3;
            }
         
            self.displayTextView.frame = CGRectIntegral(textFrame);
            self.displayTextView.textColor = RGBHex(qwColor7);
            self.displayTextView.font = [UIFont systemFontOfSize:13.0];
            [self.displayTextView sizeToFit];
          
        }
             break;
        case XHBubbleMessageMediaTypeFooter:
        {
            CGRect bubbleFrameCopy = bubbleFrame;
            CGFloat textX = CGRectGetMinX(bubbleFrame) + kBubblePaddingRight+34;
            
//            bubbleFrameCopy.size.width = 260;
            bubbleFrameCopy.origin.x = textX;
            bubbleFrameCopy.size.height = MAX(35, bubbleFrameCopy.size.height);
            self.bubbleImageView.frame = bubbleFrameCopy;
            
            
            
            CGRect textFrame = CGRectMake(textX+12,
                                          CGRectGetMinY(bubbleFrame) + kPaddingTop + 2,
                                          CGRectGetWidth(bubbleFrame)-60,
                                          bubbleFrame.size.height - kMarginTop - kMarginBottom);
            if(textFrame.size.height <= 30) {
                textFrame.origin.y += 3;
            }
            CGRect advisoryFrame = _advisory.frame;
            advisoryFrame.origin.x =bubbleFrameCopy.origin.x +bubbleFrameCopy.size.width -5-44;
            advisoryFrame.origin.y =bubbleFrameCopy.origin.y +4;
            _advisory.frame = advisoryFrame;
            self.displayTextView.frame = CGRectIntegral(textFrame);
            self.displayTextView.textColor = RGBHex(qwColor7);
            self.displayTextView.font = [UIFont systemFontOfSize:13.0];
            [self.displayTextView sizeToFit];
            
        }
            break;
        case XHBubbleMessageMediaTypeLine:
        {
            CGRect bubbleFrameCopy = bubbleFrame;
            CGFloat textX =  kBubblePaddingRight;
            bubbleFrameCopy.size.width = 260;
            bubbleFrameCopy.origin.x  =30;
            
            bubbleFrameCopy.size.height = 10;
            self.bubbleImageView.frame = bubbleFrameCopy;
            
            
            
            CGRect textFrame = CGRectMake(textX,
                                          CGRectGetMinY(bubbleFrame) + kPaddingTop + 2,
                                          CGRectGetWidth(bubbleFrame) - kBubblePaddingRight * 2 - kXHArrowMarginWidth,
                                          20);
            if(textFrame.size.height <= 30) {
                textFrame.origin.y += 3;
            }
            
          
            self.displayTextView.frame = CGRectIntegral(textFrame);
            self.displayTextView.textColor = RGBHex(qwColor6);
            self.displayTextView.font = [UIFont systemFontOfSize:13.0];
            [self.displayTextView sizeToFit];
            CGRect lineFrame = _lineView.frame;
            lineFrame.origin.x =textX +self.displayTextView.frame.size.width +15;
            lineFrame.origin.y =bubbleFrameCopy.origin.y +18;
            _lineView.frame = lineFrame;
            _lineView.backgroundColor =RGBHex(qwColor10);
        }
        break;
        case XHBubbleMessageMediaTypePhone:
        {
            CGRect bubbleFrameCopy = bubbleFrame;
            CGFloat textX = CGRectGetMinX(bubbleFrame) + kBubblePaddingRight+30;
            
//            bubbleFrameCopy.size.width = 260;
            bubbleFrameCopy.origin.x +=30;
            bubbleFrameCopy.size.height = MAX(35, bubbleFrameCopy.size.height);
            self.bubbleImageView.frame = bubbleFrameCopy;
            
            
            
            CGRect textFrame = CGRectMake(textX,
                                          CGRectGetMinY(bubbleFrame) + kPaddingTop + 11,
                                          CGRectGetWidth(bubbleFrame) - kBubblePaddingRight * 2 - kXHArrowMarginWidth,
                                          bubbleFrame.size.height - kMarginTop - kMarginBottom);
            if(textFrame.size.height <= 30) {
                textFrame.origin.y += 3;
            }
            CGRect phoneFrame = _phoneBtn.frame;
            phoneFrame.origin.x =bubbleFrameCopy.origin.x +bubbleFrameCopy.size.width -10-44;
             phoneFrame.origin.y =bubbleFrameCopy.origin.y +2;
            _phoneBtn.frame = phoneFrame;
            self.displayTextView.frame = CGRectIntegral(textFrame);
            self.displayTextView.textColor = RGBHex(qwColor7);
            self.displayTextView.font = [UIFont systemFontOfSize:13.0];
            [self.displayTextView sizeToFit];
            
        }
            break;
        default:
            break;
    }
    
    
    [self setSendType:self.sendType];
}

- (void)resetVoiceDurationLabelFrameWithBubbleFrame:(CGRect)bubbleFrame {
    CGRect voiceFrame = _voiceDurationLabel.frame;
    voiceFrame.origin.x = (self.message.bubbleMessageType == XHBubbleMessageTypeSending ? bubbleFrame.origin.x - _voiceDurationLabel.frame.size.width : bubbleFrame.origin.x + bubbleFrame.size.width);
    _voiceDurationLabel.frame = voiceFrame;
    
    _voiceDurationLabel.textAlignment = (self.message.bubbleMessageType == XHBubbleMessageTypeSending ? NSTextAlignmentRight : NSTextAlignmentLeft);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if([self.message messageMediaType] == XHBubbleMessageMediaTypeMedicineShowOnce || [self.message messageMediaType] == XHBubbleMessageMediaTypeMedicineSpecialOffersShowOnce)
        return YES;
    BOOL result = CGRectContainsPoint(self.bubbleImageView.frame,point);
    if (!result) {
        result = CGRectContainsPoint(self.resendButton.frame, point);
    }
    if(!result) {
        [self.superParentViewController layoutOtherMenuViewHide:YES fromInputView:NO];
    }
    return result;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.superParentViewController.messages indexOfObject:self.message] inSection:0];
    XHMessageTableViewCell *cell = (XHMessageTableViewCell *)[self.superParentViewController.messageTableView cellForRowAtIndexPath:indexPath];
    [self.superParentViewController multiMediaMessageDidSelectedOnMessage:self.message atIndexPath:indexPath onMessageTableViewCell:cell];
}

@end
