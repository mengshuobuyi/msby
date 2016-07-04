//
//  XHMessageBubbleView.h
//  MessageDisplayExample
//
//  Created by qtone-1 on 14-4-24.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import <UIKit/UIKit.h>

// Views
#import "XHMessageTextView.h"
#import "XHMessageInputView.h"
#import "XHMessageDisplayTextView.h"
#import "XHBubblePhotoImageView.h"

// Macro
#import "XHMacro.h"

// Model
#import "XHMessage.h"

// Factorys
#import "XHMessageAvatorFactory.h"
#import "XHMessageVoiceFactory.h"

// Categorys
#import "UIImage+XHAnimatedFaceGif.h"

//RichText
#import "Constant.h"
#import "TQRichTextView.h"
#import "MLEmojiLabel.h"
#import "RatingView.h"

#import "progressView.h"
#define kXHMessageBubbleDisplayMaxLine 200

#define kXHTextLineSpacing 3.0
@class XHMessageTableViewController;
@interface XHMessageBubbleView : UIView <TQRichTextViewDelegate>

@property (nonatomic, weak) XHMessageTableViewController *superParentViewController;

@property (nonatomic, strong) UILabel           *activityTitle;
@property (nonatomic ,strong) UIView            *uiGrayBgView;
@property (nonatomic, strong) UILabel           *subTitle;
@property (nonatomic, strong) UILabel           *remarkLabel;
@property (nonatomic, strong) UILabel           *activityContent;
@property (nonatomic, strong) UIImageView       *activityImage;

@property (nonatomic ,strong) UIView            *topSeparateLine;
@property (nonatomic ,strong) UIView            *bottomSeparateLine;


@property (nonatomic, strong) MLEmojiLabel      *footGuide;
/**
 *  目标消息Model对象
 */
@property (nonatomic, strong, readonly)  id <XHMessageModel> message;
@property (nonatomic,assign) SendType                        sendType;
/**
 *  发送失败的重发按钮
 */
@property (nonatomic, strong) UIButton                    *resendButton;

/**
 *  发送等待的显示器
 */
@property (nonatomic, strong) UIActivityIndicatorView     *activityView;

/**
 *  自定义显示文本消息控件，子类化的原因有两个，第一个是屏蔽Menu的显示。第二是传递手势到下一层，因为文本需要双击的手势
 */
@property (nonatomic, weak, readonly) MLEmojiLabel *displayTextView;

/**
 *  用于显示评价星级
 */
@property (nonatomic, strong) RatingView           *ratingView;

@property (nonatomic, strong) UILabel              *serviceLabel;
@property (nonatomic, strong) UIButton             *checkButton;
@property (nonatomic, strong) UIButton             *askOtherDoc;
@property (nonatomic, strong) UIButton             *checkImmediately;
@property (nonatomic, strong) UIButton             *sendMedicineLink;
@property (nonatomic, strong) UIButton             *sendActivity;

@property (nonatomic, strong) UIButton             *phoneBtn;
@property (nonatomic, strong) UIButton             *advisory;
@property (nonatomic ,strong)UIView                *lineView;
/**
 *  用于显示气泡的ImageView控件
 */
@property (nonatomic, weak, readonly) UIImageView *bubbleImageView;

/**
 *  用于显示语音的控件，并且支持播放动画
 */
@property (nonatomic, weak, readonly) UIImageView *animationVoiceImageView;

/**
 *  用于显示语音时长的label
 */
@property (nonatomic, weak) UILabel *voiceDurationLabel;

/**
 *  用于显示仿微信发送图片的控件
 */
@property (nonatomic, weak, readonly) XHBubblePhotoImageView *bubblePhotoImageView;

/**
 *  显示语音播放的图片控件
 */
@property (nonatomic, weak, readonly) UIImageView *videoPlayImageView;

/**
 *  显示地理位置的文本控件
 */
@property (nonatomic, weak, readonly) UILabel *geolocationsLabel;

/**
 *  设置文本消息的字体
 */
@property (nonatomic, strong) UIFont *font UI_APPEARANCE_SELECTOR;


@property (nonatomic , strong)progressView *dpMeterView ;

/**
 *  初始化消息内容显示控件的方法
 *
 *  @param frame   目标Frame
 *  @param message 目标消息Model对象
 *
 *  @return 返回XHMessageBubbleView类型的对象
 */
- (instancetype)initWithFrame:(CGRect)frame
                      message:(id <XHMessageModel>)message;

/**
 *  获取气泡相对于父试图的位置
 *
 *  @return 返回气泡的位置
 */
- (CGRect)bubbleFrame;

/**
 *  根据消息Model对象配置消息显示内容
 *
 *  @param message 目标消息Model对象
 */
- (void)configureCellWithMessage:(id <XHMessageModel>)message;

/**
 *  根据消息Model对象计算消息内容的高度
 *
 *  @param message 目标消息Model对象
 *
 *  @return 返回所需高度
 */
+ (CGFloat)calculateCellHeightWithMessage:(id <XHMessageModel>)message;

@end