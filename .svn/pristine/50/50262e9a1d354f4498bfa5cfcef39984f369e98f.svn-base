//
//  XHMessageTableViewCell.m
//  MessageDisplayExample
//
//  Created by qtone-1 on 14-4-24.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHMessageTableViewCell.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

#import "css.h"
#import "QWGlobalManager.h"
#import "QWMessage.h"

static const CGFloat kXHLabelPadding = 5.0f;
static const CGFloat kXHTimeStampLabelHeight = 20.0f;

static const CGFloat kXHAvatorPaddingX = 8.0;
static const CGFloat kXHAvatorPaddingY = 15;

static const CGFloat kXHBubbleMessageViewPadding = 8;


@interface XHMessageTableViewCell ()<MLEmojiLabelDelegate>
{
    
}

@property (nonatomic, weak, readwrite) XHMessageBubbleView *messageBubbleView;

@property (nonatomic, weak, readwrite) UIButton *avatorButton;

@property (nonatomic, weak, readwrite) LKBadgeView *timestampLabel;

@property (nonatomic, strong) UITapGestureRecognizer    *tapGestureRecognizer;

/**
 *  是否显示时间轴Label
 */
@property (nonatomic, assign) BOOL displayTimestamp;

/**
 *  1、是否显示Time Line的label
 *
 *  @param message 需要配置的目标消息Model
 */
- (void)configureTimestamp:(BOOL)displayTimestamp atMessage:(id <XHMessageModel>)message;

/**
 *  2、配置头像
 *
 *  @param message 需要配置的目标消息Model
 */
- (void)configAvatorWithMessage:(id <XHMessageModel>)message;

/**
 *  3、配置需要显示什么消息内容，比如语音、文字、视频、图片
 *
 *  @param message 需要配置的目标消息Model
 */
- (void)configureMessageBubbleViewWithMessage:(id <XHMessageModel>)message;

/**
 *  头像按钮，点击事件
 *
 *  @param sender 头像按钮对象
 */
- (void)avatorButtonClicked:(UIButton *)sender;

/**
 *  统一一个方法隐藏MenuController，多处需要调用
 */
- (void)setupNormalMenuController;

/**
 *  点击Cell的手势处理方法，用于隐藏MenuController的
 *
 *  @param tapGestureRecognizer 点击手势对象
 */
- (void)tapGestureRecognizerHandle:(UITapGestureRecognizer *)tapGestureRecognizer;

/**
 *  长按Cell的手势处理方法，用于显示MenuController的
 *
 *  @param longPressGestureRecognizer 长按手势对象
 */
- (void)longPressGestureRecognizerHandle:(UILongPressGestureRecognizer *)longPressGestureRecognizer;

/**
 *  单击手势处理方法，用于点击多媒体消息触发方法，比如点击语音需要播放的回调、点击图片需要查看大图的回调
 *
 *  @param tapGestureRecognizer 点击手势对象
 */
- (void)sigleTapGestureRecognizerHandle:(UITapGestureRecognizer *)tapGestureRecognizer;

/**
 *  双击手势处理方法，用于双击文本消息，进行放大文本的回调
 *
 *  @param tapGestureRecognizer 双击手势对象
 */
- (void)doubleTapGestureRecognizerHandle:(UITapGestureRecognizer *)tapGestureRecognizer;

@end

@implementation XHMessageTableViewCell

- (void)avatorButtonClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectedAvatorOnMessage:atIndexPath:)]) {
        [self.delegate didSelectedAvatorOnMessage:self.messageBubbleView.message atIndexPath:self.indexPath];
    }
}

#pragma mark - Copying Method

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)becomeFirstResponder {
    return [super becomeFirstResponder];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if(![self.messageBubbleView.message officialType])
    {
        if([self.messageBubbleView.message messageMediaType] == XHBubbleMessageMediaTypeMedicineShowOnce || [self.messageBubbleView.message messageMediaType] == XHBubbleMessageMediaTypeMedicineSpecialOffersShowOnce) {
            return NO;
        }
        if([self.messageBubbleView.message messageMediaType] == XHBubbleMessageMediaTypeStarStore || [self.messageBubbleView.message messageMediaType] == XHBubbleMessageMediaTypeStarClient || [self.messageBubbleView.message messageMediaType] == XHBubbleMessageMediaTypeActivity || [self.messageBubbleView.message messageMediaType] == XHBubbleMessageMediaTypeMedicine || [self.messageBubbleView.message messageMediaType] == XHBubbleMessageMediaTypeMedicineSpecialOffers || [self.messageBubbleView.message messageMediaType] == XHBubbleMessageMediaTypeLocation || [self.messageBubbleView.message messageMediaType] == XHBubbleMessageMediaTypeMedicineShowOnce || [self.messageBubbleView.message messageMediaType] == XHBubbleMessageMediaTypeMedicineSpecialOffersShowOnce || [self.messageBubbleView.message messageMediaType] == XHBubbleMessageMediaTypeHeader || [self.messageBubbleView.message messageMediaType] == XHBubbleMessageMediaTypeLine || [self.messageBubbleView.message messageMediaType] == XHBubbleMessageMediaTypeFooter || [self.messageBubbleView.message messageMediaType] == XHBubbleMessageMediaTypePhone) {
            return action == @selector(deleted:);
        }else {
            return (action == @selector(copyed:) || action == @selector(deleted:));
        }
    }
    else
        return NO;
}

#pragma mark - Menu Actions

- (void)copyed:(id)sender {
    // change  by  shen 不能复制表情
        [[UIPasteboard generalPasteboard] setString:self.messageBubbleView.message.text];
//       [[UIPasteboard generalPasteboard] setString:self.messageBubbleView.displayTextView.text];
    //  change  end
 
    [self resignFirstResponder];
    DLog(@"Cell was copy");
}

- (void)deleted:(id)sender
{
    if([self.delegate respondsToSelector:@selector(deleteOneMessageAtIndexPath:)]){
        [self.delegate deleteOneMessageAtIndexPath:self.indexPath];
    }
}

- (void)favorites:(id)sender
{
    DLog(@"Cell was favorites");
}

- (void)more:(id)sender
{
    DLog(@"Cell was more");
}

#pragma mark - Setters
- (void)setSended:(SendType)sended
{
    _sended = sended;
    [_messageBubbleView setSendType:sended];
}


- (void)configureCellWithMessage:(id <XHMessageModel>)message
               displaysTimestamp:(BOOL)displayTimestamp {
    // 1、是否显示Time Line的label
    [self configureTimestamp:displayTimestamp atMessage:message];
    
    // 2、配置头像
    [self configAvatorWithMessage:message];
    
    // 3、配置需要显示什么消息内容，比如语音、文字、视频、图片
    [self configureMessageBubbleViewWithMessage:message];
}

- (void)configureTimestamp:(BOOL)displayTimestamp atMessage:(id <XHMessageModel>)message {
    self.displayTimestamp = displayTimestamp;
    self.timestampLabel.hidden = !self.displayTimestamp;
    if (displayTimestamp) {
        self.timestampLabel.text = [QWGLOBALMANAGER updateDisplayTime:[message timestamp]];
    }
}

- (void)configAvatorWithMessage:(id <XHMessageModel>)message
{
    self.avatorButton.backgroundColor = [UIColor clearColor];
    if (message.avatorUrl) {

        self.avatorButton.messageAvatorType = XHMessageAvatorTypeSquare;
        UIImage *placeholder = nil;
        if([message bubbleMessageType] == XHBubbleMessageTypeSending) {
            placeholder = [UIImage imageNamed:@"ic_img_notlogin"];
        }else{
            placeholder = [UIImage imageNamed:@"药店默认头像.png"];
        }
        
        [self.avatorButton setImageWithURL:[NSURL URLWithString:message.avatorUrl] forState:UIControlStateNormal placeholderImage:placeholder];

    } else {
        self.avatorButton.messageAvatorType = XHMessageAvatorTypeSquare;
        [self.avatorButton setImage:[message avator] forState:UIControlStateNormal];
    }
}

- (void)configureMessageBubbleViewWithMessage:(id <XHMessageModel>)message {
    XHBubbleMessageMediaType currentMediaType = message.messageMediaType;
    for (UIGestureRecognizer *gesTureRecognizer in self.messageBubbleView.bubbleImageView.gestureRecognizers) {
        [self.messageBubbleView.bubbleImageView removeGestureRecognizer:gesTureRecognizer];
    }
    for (UIGestureRecognizer *gesTureRecognizer in self.messageBubbleView.bubblePhotoImageView.gestureRecognizers) {
        [self.messageBubbleView.bubblePhotoImageView removeGestureRecognizer:gesTureRecognizer];
    }
         self.avatorButton.hidden = NO;
    switch (currentMediaType) {
        case XHBubbleMessageMediaTypeAutoSubscription:
        case XHBubbleMessageMediaTypeDrugGuide:
        {
            if([message officialType]){
                self.avatorButton.hidden = YES;
            }else{
                self.avatorButton.hidden = NO;
            }
            break;
        }
        case XHBubbleMessageMediaTypeMedicine:
        case XHBubbleMessageMediaTypeMedicineSpecialOffers:
        {
            self.avatorButton.hidden = NO;
        }
        case XHBubbleMessageMediaTypeText:
        case XHBubbleMessageMediaTypePurchaseMedicine:
        case XHBubbleMessageMediaTypeActivity:
        case XHBubbleMessageMediaTypeStarStore:
        case XHBubbleMessageMediaTypeStarClient: {
            if([message officialType]){
                self.avatorButton.hidden = YES;
            }else{
                self.avatorButton.hidden = NO;
            }
            self.messageBubbleView.voiceDurationLabel.text = [NSString stringWithFormat:@"%@\'\'", message.voiceDuration];
            break;
        }
        case XHBubbleMessageMediaTypeMedicineShowOnce:
        case XHBubbleMessageMediaTypeMedicineSpecialOffersShowOnce:
        {
            self.avatorButton.hidden = YES;
            break;
        }
            
        case XHBubbleMessageMediaTypeHeader:
     
            self.avatorButton.hidden = YES;
            break;
        case XHBubbleMessageMediaTypeFooter:
          self.avatorButton.hidden = YES;
            break;
        case XHBubbleMessageMediaTypeLine:
      self.avatorButton.hidden = YES;
            break;
        case XHBubbleMessageMediaTypePhone:
       self.avatorButton.hidden = YES;
            break;
        default:
            break;
    }
    [self.messageBubbleView configureCellWithMessage:message];
}

#pragma mark - Gestures

- (void)setupNormalMenuController {
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
        UIView *superView = ((UIViewController *)self.delegate).view;
        //[superView removeGestureRecognizer:self.tapGestureRecognizer];
    }
}

- (void)tapGestureRecognizerHandle:(UITapGestureRecognizer *)tapGestureRecognizer {
    [self updateMenuControllerVisiable];
}

- (void)updateMenuControllerVisiable {
    [self setupNormalMenuController];
}

- (void)longPressGestureRecognizerHandle:(UILongPressGestureRecognizer *)longPressGestureRecognizer {
    if (self.messageBubbleView.message.messageMediaType == XHBubbleMessageMediaTypeLine ||self.messageBubbleView.message.messageMediaType == XHBubbleMessageMediaTypeFooter ||self.messageBubbleView.message.messageMediaType == XHBubbleMessageMediaTypeHeader ||self.messageBubbleView.message.messageMediaType == XHBubbleMessageMediaTypePhone  ) {
        return;
    }
    if (longPressGestureRecognizer.state != UIGestureRecognizerStateBegan || ![self becomeFirstResponder])
        return;
    
    UIMenuItem *copy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyed:)];
    UIMenuItem *transpond = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleted:)];
    //    UIMenuItem *favorites = [[UIMenuItem alloc] initWithTitle:NSLocalizedStringFromTable(@"favorites", @"MessageDisplayKitString", @"收藏") action:@selector(favorites:)];
    //    UIMenuItem *more = [[UIMenuItem alloc] initWithTitle:NSLocalizedStringFromTable(@"more", @"MessageDisplayKitString", @"更多") action:@selector(more:)];
    
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    
    if ( self.messageBubbleView.message.messageMediaType == XHBubbleMessageMediaTypePhoto) {
        [menu setMenuItems:[NSArray arrayWithObjects: transpond, nil]];
    }else
    {
        [menu setMenuItems:[NSArray arrayWithObjects:copy, transpond, nil]];
    }
    CGRect targetRect = [self convertRect:[self.messageBubbleView bubbleFrame]
                                 fromView:self.messageBubbleView];
    
    [menu setTargetRect:CGRectInset(targetRect, 0.0f, 4.0f) inView:self];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleMenuWillShowNotification:)
                                                 name:UIMenuControllerWillShowMenuNotification
                                               object:nil];
    [menu setMenuVisible:YES animated:YES];
//    UIView *superView = ((UIViewController *)self.delegate).view;
//    [superView addGestureRecognizer:self.tapGestureRecognizer];
}

- (void)sigleTapGestureRecognizerHandle:(UITapGestureRecognizer *)tapGestureRecognizer {
    if (tapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self setupNormalMenuController];
        if ([self.delegate respondsToSelector:@selector(multiMediaMessageDidSelectedOnMessage:atIndexPath:onMessageTableViewCell:)]) {
            [self.delegate multiMediaMessageDidSelectedOnMessage:self.messageBubbleView.message atIndexPath:self.indexPath onMessageTableViewCell:self];
        }
    }
}

- (void)doubleTapGestureRecognizerHandle:(UITapGestureRecognizer *)tapGestureRecognizer {
    if (tapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if ([self.delegate respondsToSelector:@selector(didDoubleSelectedOnTextMessage:atIndexPath:)]) {
            [self.delegate didDoubleSelectedOnTextMessage:self.messageBubbleView.message atIndexPath:self.indexPath];
        }
    }
}

#pragma mark - Notifications

- (void)handleMenuWillHideNotification:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIMenuControllerWillHideMenuNotification
                                                  object:nil];
}

- (void)handleMenuWillShowNotification:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIMenuControllerWillShowMenuNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleMenuWillHideNotification:)
                                                 name:UIMenuControllerWillHideMenuNotification
                                               object:nil];
}

#pragma mark - Getters

- (XHBubbleMessageType)bubbleMessageType {
    return self.messageBubbleView.message.bubbleMessageType;
}

+ (CGFloat)calculateCellHeightWithMessage:(id <XHMessageModel>)message
                        displaysTimestamp:(BOOL)displayTimestamp {
    
    CGFloat timestampHeight = displayTimestamp ? (kXHTimeStampLabelHeight + kXHLabelPadding * 2) : kXHLabelPadding;
    if([message messageMediaType] == XHBubbleMessageMediaTypeMedicineShowOnce || [message messageMediaType] == XHBubbleMessageMediaTypeMedicineSpecialOffersShowOnce) {
        if(displayTimestamp)
            timestampHeight += 10;
    }
    CGFloat avatarHeight = kXHAvatarImageSize;

    CGFloat subviewHeights = timestampHeight + kXHBubbleMessageViewPadding * 2;
    CGFloat bubbleHeight = [XHMessageBubbleView calculateCellHeightWithMessage:message];
    
    return subviewHeights + MAX(avatarHeight, bubbleHeight);
}

#pragma mark - Life cycle

- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryNone;
    self.accessoryView = nil;
    
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognizerHandle:)];
    [recognizer setMinimumPressDuration:0.4f];
    [self addGestureRecognizer:recognizer];
    
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self.delegate action:@selector(tapGestureRecognizerHandle:)];
}

- (instancetype)initWithMessage:(id <XHMessageModel>)message
              displaysTimestamp:(BOOL)displayTimestamp
                reuseIdentifier:(NSString *)cellIdentifier {
    self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    if (self) {
        // 如果初始化成功，那就根据Message类型进行初始化控件，比如配置头像，配置发送和接收的样式
        
        // 1、是否显示Time Line的label
        if (!_timestampLabel) {
            LKBadgeView *timestampLabel = [[LKBadgeView alloc] initWithFrame:CGRectMake(0, kXHLabelPadding, 160, kXHTimeStampLabelHeight)];
            timestampLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
            timestampLabel.badgeColor = RGBHex(qwColor10);
            timestampLabel.textColor = [UIColor whiteColor];
            timestampLabel.font = [UIFont systemFontOfSize:13.0f];
            timestampLabel.center = CGPointMake(CGRectGetWidth([[UIScreen mainScreen] bounds]) / 2.0, timestampLabel.center.y);
            [self.contentView addSubview:timestampLabel];
            [self.contentView bringSubviewToFront:timestampLabel];
            _timestampLabel = timestampLabel;
        }
        
        // 2、配置头像
        // avator
        CGRect avatorButtonFrame;
        switch (message.bubbleMessageType) {
            case XHBubbleMessageTypeReceiving:
                avatorButtonFrame = CGRectMake(kXHAvatorPaddingX, kXHAvatorPaddingY + (self.displayTimestamp ? kXHTimeStampLabelHeight : 0), kXHAvatarImageSize, kXHAvatarImageSize);
                break;
            case XHBubbleMessageTypeSending:
                avatorButtonFrame = CGRectMake(CGRectGetWidth(self.bounds) - kXHAvatarImageSize - kXHAvatorPaddingX, kXHAvatorPaddingY + (self.displayTimestamp ? kXHTimeStampLabelHeight : 0), kXHAvatarImageSize, kXHAvatarImageSize);
                break;
            default:
                break;
        }
        
        UIButton *avatorButton = [[UIButton alloc] initWithFrame:avatorButtonFrame];
//        [avatorButton setImage:[XHMessageAvatorFactory avatarImageNamed:[UIImage imageNamed:@"avator"] messageAvatorType:XHMessageAvatorTypeCircle] forState:UIControlStateNormal];
        [avatorButton addTarget:self action:@selector(avatorButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:avatorButton];
        avatorButton.layer.cornerRadius = 5.0;
        avatorButton.layer.masksToBounds = YES;
        avatorButton.backgroundColor = [UIColor clearColor];
        self.avatorButton = avatorButton;
        
        // 3、配置需要显示什么消息内容，比如语音、文字、视频、图片
        if (!_messageBubbleView) {
            CGFloat bubbleX = 0.0f;
            
            CGFloat offsetX = 0.0f;
            
            if (message.bubbleMessageType == XHBubbleMessageTypeReceiving)
                bubbleX = kXHAvatarImageSize + kXHAvatorPaddingX + kXHAvatorPaddingX;
            else
                offsetX = kXHAvatarImageSize + kXHAvatorPaddingX + kXHAvatorPaddingX;
            
            CGRect frame = CGRectMake(bubbleX,
                                      kXHBubbleMessageViewPadding + (self.displayTimestamp ? (kXHTimeStampLabelHeight + kXHLabelPadding) : kXHLabelPadding),
                                      self.contentView.frame.size.width - bubbleX - offsetX,
                                      self.contentView.frame.size.height - (kXHBubbleMessageViewPadding + (self.displayTimestamp ? (kXHTimeStampLabelHeight + kXHLabelPadding) : kXHLabelPadding)));
            

            // bubble container
            XHMessageBubbleView *messageBubbleView = [[XHMessageBubbleView alloc] initWithFrame:frame message:message];
            messageBubbleView.autoresizingMask = UIViewAutoresizingNone;
            [self.contentView addSubview:messageBubbleView];
            [self.contentView sendSubviewToBack:messageBubbleView];
            self.messageBubbleView = messageBubbleView;
            self.messageBubbleView.displayTextView.emojiDelegate = self;
            self.messageBubbleView.footGuide.emojiDelegate = self;

            [self.messageBubbleView.checkButton addTarget:self action:@selector(checkDrugGuide:) forControlEvents:UIControlEventTouchDown];
            [messageBubbleView.resendButton addTarget:self action:@selector(resendMessage:) forControlEvents:UIControlEventTouchDown];
            [messageBubbleView.askOtherDoc addTarget:self action:@selector(askOtherDoc:) forControlEvents:UIControlEventTouchDown];
            
            [messageBubbleView.sendMedicineLink addTarget:self action:@selector(sendMedicineLink:) forControlEvents:UIControlEventTouchDown];
            [messageBubbleView.sendActivity addTarget:self action:@selector(sendPTMLink:) forControlEvents:UIControlEventTouchDown];
            [messageBubbleView.advisory addTarget:self action:@selector(advisory:) forControlEvents:UIControlEventTouchDown];
            [messageBubbleView.phoneBtn addTarget:self action:@selector(phone:) forControlEvents:UIControlEventTouchDown];
            
        }
    }
    return self;
}

- (void)touchDownTitle:(id)sender
{
//    if([self.delegate respondsToSelector:@selector(didSelectActivityTitle:)])
//    {
//        [self.delegate didSelectActivityTitle:self.indexPath];
//    }
}
-(void)advisory:(id)sender
{
    
    if ([self.delegate respondsToSelector:@selector(sendToOther:)] ) {
        [self.delegate sendToOther:self.indexPath.row];
    }
}
-(void)phone:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(makeCall)]) {
        [self.delegate makeCall];
    }
}
- (void)checkDrugGuide:(id)sender
{
    TagWithMessage* tag = [self.messageBubbleView.message tagList][0];
    [self mlEmojiLabel:nil didSelectLink:tag.tagId withType:MLEmojiLabelLinkTypeDrugGuide];
}

- (void)mlEmojiLabel:(MLEmojiLabel*)emojiLabel didSelectLink:(NSString*)link withType:(MLEmojiLabelLinkType)type
{
    if([self.delegate respondsToSelector:@selector(didSelectLinkOnMeseage:atIndexPath:LinkSting:LinkType:)])
    {
        [self.delegate didSelectLinkOnMeseage:self.messageBubbleView.message atIndexPath:self.indexPath LinkSting:link LinkType:type];
    }
}


- (void)resendMessage:(id)sender
{
    if([self.delegate respondsToSelector:@selector(resendMessageWithIndexPath:)])
    {
        [self.delegate resendMessageWithIndexPath:self.indexPath];
    }
}

- (void)sendMedicineLink:(id)sender
{
    if([self.delegate respondsToSelector:@selector(sendMedicineLink:)])
    {
        [self.delegate sendMedicineLink:self.indexPath];
    }
}

- (void)sendPTMLink:(id)sender
{
    if([self.delegate respondsToSelector:@selector(sendPTMLink:)])
    {
        [self.delegate sendPTMLink:self.indexPath];
    }
}

-(void)askOtherDoc:(id)sender
{
    if([self.delegate respondsToSelector:@selector(askOtherStore)])
    {
        [self.delegate askOtherStore];
    }
}

- (void)setDelegate:(id<XHMessageTableViewCellDelegate>)delegate
{
    _delegate = delegate;
    self.messageBubbleView.superParentViewController = delegate;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    [self setup];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat layoutOriginY = kXHAvatorPaddingY + (self.displayTimestamp ? kXHTimeStampLabelHeight : 0);
    CGRect avatorButtonFrame = self.avatorButton.frame;
    avatorButtonFrame.origin.y = layoutOriginY;
    avatorButtonFrame.origin.x = ([self bubbleMessageType] == XHBubbleMessageTypeReceiving) ? kXHAvatorPaddingX : ((CGRectGetWidth(self.bounds) - kXHAvatorPaddingX - kXHAvatarImageSize));
    
    layoutOriginY = kXHBubbleMessageViewPadding + (self.displayTimestamp ? kXHTimeStampLabelHeight : 0);
    CGRect bubbleMessageViewFrame = self.messageBubbleView.frame;
    bubbleMessageViewFrame.origin.y = layoutOriginY;
    
    CGFloat bubbleX = 0.0f;
    if ([self bubbleMessageType] == XHBubbleMessageTypeReceiving)
        bubbleX = kXHAvatarImageSize + kXHAvatorPaddingX + kXHAvatorPaddingX;
    bubbleMessageViewFrame.origin.x = bubbleX;
    
    self.avatorButton.frame = avatorButtonFrame;
    if([self.messageBubbleView.message messageMediaType] == XHBubbleMessageMediaTypeMedicineShowOnce || [self.messageBubbleView.message messageMediaType] == XHBubbleMessageMediaTypeMedicineSpecialOffersShowOnce) {
        bubbleMessageViewFrame.size.width = APP_W;
        CGFloat height = self.contentView.frame.size.height - (kXHBubbleMessageViewPadding + (self.displayTimestamp ? (kXHTimeStampLabelHeight + kXHLabelPadding) : kXHLabelPadding));
        if(self.displayTimestamp) {
            bubbleMessageViewFrame.origin.y = layoutOriginY + 5;
            bubbleMessageViewFrame.size.height = height - 10;
        }else{
            bubbleMessageViewFrame.size.height = height + 5;
        }
    }else{
        CGFloat bubbleX = 0.0f;
        
        CGFloat offsetX = 0.0f;
        
        if (self.messageBubbleView.message.bubbleMessageType == XHBubbleMessageTypeReceiving)
            bubbleX = kXHAvatarImageSize + kXHAvatorPaddingX + kXHAvatorPaddingX;
        else
            offsetX = kXHAvatarImageSize + kXHAvatorPaddingX + kXHAvatorPaddingX;

        bubbleMessageViewFrame.size.width = self.contentView.frame.size.width - bubbleX - offsetX;
    }
    self.messageBubbleView.frame = bubbleMessageViewFrame;
}

- (void)dealloc
{
    _avatorButton = nil;
    _timestampLabel = nil;
    _messageBubbleView = nil;
    _indexPath = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - TableViewCell

- (void)prepareForReuse
{
    // 这里做清除工作
    [super prepareForReuse];
    self.messageBubbleView.displayTextView.text = @"";
    //self.messageBubbleView.displayTextView.attributedText = nil;
    self.messageBubbleView.bubblePhotoImageView.messagePhoto = nil;
    self.timestampLabel.text = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
