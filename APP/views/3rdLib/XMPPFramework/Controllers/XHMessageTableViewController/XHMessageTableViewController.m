//
//  XHMessageTableViewController.m
//  MessageDisplayExample
//
//  Created by qtone-1 on 14-4-24.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHMessageTableViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "TQRichTextURLRun.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"
#import "DFMultiPhotoSelectorViewController.h"
#import "XMPPStream.h"
#import "UIImage+Ex.h"
#import "QWMessage.h"
#import "HttpClient.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import "Coupon.h"
#import "QYImage.h"
#import "QYPhotoAlbum.h"
#import "PhotoAlbum.h"
#import "PopupMarketActivityView.h"
#import "QuickSearchDrugViewController.h"
#import "FavoriteModelR.h"
#import "Favorite.h"

@interface XHMessageTableViewController ()<DFMultiPhotoSelectorViewControllerDelegate,MarketActivityViewDelegate>
{
    
    UIImage * willsendimg;
 
}
/**
 *  记录旧的textView contentSize Heigth
 */
@property (nonatomic, assign) CGFloat previousTextViewContentHeight;
@property (nonatomic, strong) PopupMarketActivityView *popupMarketActivityView;
/**
 *  记录键盘的高度，为了适配iPad和iPhone
 */
@property (nonatomic, assign) CGFloat keyboardViewHeight;
@property (nonatomic, strong) UIImageView      *alarmLogo;
@property (nonatomic, assign) XHInputViewType textViewInputViewType;

@property (nonatomic, weak, readwrite) XHMessageInputView *messageInputView;
@property (nonatomic, weak, readwrite) XHShareMenuView *shareMenuView;
@property (nonatomic, weak, readwrite) XHEmotionManagerView *emotionManagerView;

@property (nonatomic, strong) UIActivityIndicatorView *loadMoreActivityIndicatorView;


#pragma mark - DataSource Change
/**
 *  改变数据源需要的子线程
 *
 *  @param queue 子线程执行完成的回调block
 */
- (void)exChangeMessageDataSourceQueue:(void (^)())queue;

/**
 *  执行块代码在主线程
 *
 *  @param queue 主线程执行完成回调block
 */
- (void)exMainQueue:(void (^)())queue;

#pragma mark - Previte Method
/**
 *  判断是否允许滚动
 *
 *  @return 返回判断结果
 */
- (BOOL)shouldAllowScroll;

#pragma mark - Life Cycle
/**
 *  配置默认参数
 */
- (void)setup;

/**
 *  初始化显示控件
 */
- (void)initilzer;

#pragma mark - UITextView Helper Method
/**
 *  获取某个UITextView对象的content高度
 *
 *  @param textView 被获取的textView对象
 *
 *  @return 返回高度
 */
- (CGFloat)getTextViewContentH:(UITextView *)textView;

#pragma mark - Layout Message Input View Helper Method
/**
 *  动态改变TextView的高度
 *
 *  @param textView 被改变的textView对象
 */
- (void)layoutAndAnimateMessageInputTextView:(UITextView *)textView;

#pragma mark - Scroll Message TableView Helper Method
/**
 *  根据bottom的数值配置消息列表的内部布局变化
 *
 *  @param bottom 底部的空缺高度
 */
- (void)setTableViewInsetsWithBottomValue:(CGFloat)bottom;

/**
 *  根据底部高度获取UIEdgeInsets常量
 *
 *  @param bottom 底部高度
 *
 *  @return 返回UIEdgeInsets常量
 */
- (UIEdgeInsets)tableViewInsetsWithBottomValue:(CGFloat)bottom;

#pragma mark - Message Calculate Cell Height
/**
 *  统一计算Cell的高度方法
 *
 *  @param message   被计算目标消息对象
 *  @param indexPath 被计算目标消息所在的位置
 *
 *  @return 返回计算的高度
 */
- (CGFloat)calculateCellHeightWithMessage:(id <XHMessageModel>)message atIndexPath:(NSIndexPath *)indexPath;

#pragma mark - Message Send helper Method
/**
 *  根据文本开始发送文本消息
 *
 *  @param text 目标文本
 */
- (void)didSendMessageWithText:(NSString *)text;
/**
 *  根据图片开始发送图片消息
 *
 *  @param photo 目标图片
 */
- (void)didSendMessageWithPhoto:(UIImage *)photo;
/**
 *  根据视频的封面和视频的路径开始发送视频消息
 *
 *  @param videoConverPhoto 目标视频的封面图
 *  @param videoPath        目标视频的路径
 */
- (void)didSendMessageWithVideoConverPhoto:(UIImage *)videoConverPhoto videoPath:(NSString *)videoPath;

#pragma mark - Other Menu View Frame Helper Mehtod
/**
 *  根据显示或隐藏的需求对所有第三方Menu进行管理
 *
 *  @param hide 需求条件
 */
- (void)layoutOtherMenuViewHiden:(BOOL)hide;

@end

@implementation XHMessageTableViewController

#pragma mark - DataSource Change

- (void)exChangeMessageDataSourceQueue:(void (^)())queue {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), queue);
}

- (void)exMainQueue:(void (^)())queue {
    dispatch_async(dispatch_get_main_queue(), queue);
}

- (void)addCacheMessage:(NSMutableArray *)messageList
{
    NSMutableArray *messages = [NSMutableArray arrayWithArray:self.messages];
    
    
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:10];
    for(NSUInteger index = 0; index < messageList.count ; ++index)
    {
        [indexPaths addObject:[NSIndexPath indexPathForRow:messages.count + index inSection:0]];
    }
    [messages addObjectsFromArray:messageList];
    self.messages = messages;
    [self.messageTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    [self scrollToBottomAnimated:NO];
}

- (void)addMessages:(NSArray *)addedMessages
{
    XHMessage *tryTypeMessage = nil;
    if(self.messages.count > 0) {
        tryTypeMessage = [self.messages lastObject];
    }
    NSMutableArray *messages = [NSMutableArray arrayWithArray:self.messages];;
    if(tryTypeMessage && (tryTypeMessage.messageMediaType == XHBubbleMessageMediaTypeSpreadHint)) {
        [messages insertObjects:addedMessages atIndexes:[NSIndexSet indexSetWithIndex:messages.count - 1]];
        XHMessage *lastMessage = [addedMessages lastObject];
        tryTypeMessage.timestamp = lastMessage.timestamp;
    }else{
        [messages addObjectsFromArray:addedMessages];
    }
    self.messages = messages;
    [self.messageTableView reloadData];
    [self scrollToBottomAnimated:NO];
}

- (void)addMessage:(XHMessage *)addedMessage {
    XHMessage *tryTypeMessage = nil;
    if(self.messages.count > 0) {
        tryTypeMessage = [self.messages lastObject];
    }
    NSMutableArray *messages = [NSMutableArray arrayWithArray:self.messages];;
    if(tryTypeMessage && (tryTypeMessage.messageMediaType == XHBubbleMessageMediaTypeSpreadHint)) {
        [messages insertObject:addedMessage atIndex:messages.count - 1];
        tryTypeMessage.timestamp = addedMessage.timestamp;
    }else{
        [messages addObject:addedMessage];
    }
    self.messages = messages;
    [self.messageTableView reloadData];
    [self scrollToBottomAnimated:NO];
}

- (void)removeMessageAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.messages.count)
        return;
    [self.messages removeObjectAtIndex:indexPath.row];
    
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:1];
    [indexPaths addObject:indexPath];
    
    [self.messageTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
}

static CGPoint  delayOffset = {0.0};
#pragma mark - Propertys

- (NSMutableArray *)messages {
    if (!_messages) {
        _messages = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _messages;
}

- (void)setLoadingMoreMessage:(BOOL)loadingMoreMessage {
    _loadingMoreMessage = loadingMoreMessage;
    if (loadingMoreMessage) {
        [self.loadMoreActivityIndicatorView startAnimating];
    } else {
        [self.loadMoreActivityIndicatorView stopAnimating];
    }
}

- (XHShareMenuView *)shareMenuView {
    if (!_shareMenuView) {
        XHShareMenuView *shareMenuView = [[XHShareMenuView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds), 95)];
        shareMenuView.delegate = self;
        shareMenuView.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
        shareMenuView.alpha = 0.0;
        shareMenuView.shareMenuItems = self.shareMenuItems;
        [self.view addSubview:shareMenuView];
        _shareMenuView = shareMenuView;
    }
    [self.view bringSubviewToFront:_shareMenuView];
    return _shareMenuView;
}

- (XHEmotionManagerView *)emotionManagerView {
    if (!_emotionManagerView) {
        XHEmotionManagerView *emotionManagerView = [[XHEmotionManagerView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds), self.keyboardViewHeight)];
        emotionManagerView.delegate = self;
        emotionManagerView.dataSource = self;
        emotionManagerView.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
        emotionManagerView.alpha = 0.0;
        [self.view addSubview:emotionManagerView];
        [emotionManagerView.emotionSectionBar.storeManagerItemButton addTarget:self action:@selector(didSendTextMessage:) forControlEvents:UIControlEventTouchDown];
        
        _emotionManagerView = emotionManagerView;
        
    }
    [self.view bringSubviewToFront:_emotionManagerView];
    return _emotionManagerView;
}

#pragma mark - Messages View Controller

- (void)finishSendMessageWithBubbleMessageType:(XHBubbleMessageMediaType)mediaType {
    switch (mediaType) {
        case XHBubbleMessageMediaTypeText: {
            [self.messageInputView.inputTextView setText:nil];
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
                self.messageInputView.inputTextView.enablesReturnKeyAutomatically = NO;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.messageInputView.inputTextView.enablesReturnKeyAutomatically = YES;
                    [self.messageInputView.inputTextView reloadInputViews];
                    self.popupMarketActivityView.replyTextField.text = @"";
                });
            }
            break;
        }
        case XHBubbleMessageMediaTypePhoto: {
            break;
        }
        default:
            break;
    }
}

- (void)setBackgroundColor:(UIColor *)color {
    self.view.backgroundColor = color;
    _messageTableView.backgroundColor = color;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    self.messageTableView.backgroundView = nil;
    self.messageTableView.backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
}

- (void)scrollToBottomAnimated:(BOOL)animated {
	if (![self shouldAllowScroll] || self.shouldPreventAutoScrolling)
        return;
	
    if(self.messageTableView.tableFooterView == nil) {
        NSInteger rows = [self.messageTableView numberOfRowsInSection:0];
        
        if (rows > 0) {
            [self.messageTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rows - 1 inSection:0]
                                  atScrollPosition:UITableViewScrollPositionBottom
                                          animated:animated];
        }
    }else{
        [self.messageTableView scrollRectToVisible:self.messageTableView.tableFooterView.frame animated:YES];
    }

}


- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath
			  atScrollPosition:(UITableViewScrollPosition)position
					  animated:(BOOL)animated {
	if (![self shouldAllowScroll])
        return;
	
	[self.messageTableView scrollToRowAtIndexPath:indexPath
						  atScrollPosition:position
								  animated:animated];
}

#pragma mark - Previte Method

- (BOOL)shouldAllowScroll {
    if (self.isUserScrolling) {
        if ([self.delegate respondsToSelector:@selector(shouldPreventScrollToBottomWhileUserScrolling)]
            && [self.delegate shouldPreventScrollToBottomWhileUserScrolling]) {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - Life Cycle
- (void)setup {
    // iPhone or iPad keyboard view height set here.
    self.keyboardViewHeight = (kIsiPad ? 264 : 216);
    _allowsPanToDismissKeyboard = YES;
    _allowsSendVoice = NO;
    _allowsSendMultiMedia = YES;
    _allowsSendFace = YES;
    _inputViewStyle = XHMessageInputViewStyleFlat;
    
    self.delegate = self;
    self.dataSource = self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [self setup];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
}

- (void)initilzer {
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    // 默认设置用户滚动为NO
    _isUserScrolling = NO;
    
    // 初始化message tableView
    CGRect rect = self.view.bounds;
    rect.size.height -= 45;
	XHMessageTableView *messageTableView = [[XHMessageTableView alloc] initWithFrame:rect style:UITableViewStylePlain];
	messageTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth ;
	messageTableView.dataSource = self;
	messageTableView.delegate = self;
    messageTableView.separatorColor = [UIColor clearColor];
    messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [messageTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
//    messageTableView.headerPullToRefreshText = @"下拉可以刷新";
//    messageTableView.headerReleaseToRefreshText = @"松开刷新了";
//    messageTableView.headerRefreshingText = @"正在刷新中";

    [self enableSimpleRefresh:messageTableView block:^(SRRefreshView *sender) {
        [self headerRereshing];
    }];
    
    [self.view addSubview:messageTableView];
    [self.view sendSubviewToBack:messageTableView];
	_messageTableView = messageTableView;

    // 设置整体背景颜色
//    [self setBackgroundColor:RGBHex(kColor21)];

    // 初始化输入工具条
    
    [self layoutDifferentMessageType];
    
    // 设置手势滑动，默认添加一个bar的高度值
    self.messageTableView.messageInputBarHeight = CGRectGetHeight(_messageInputView.bounds);
}

- (void)layoutDifferentMessageType
{
    CGFloat inputViewHeight = (self.inputViewStyle == XHMessageInputViewStyleFlat) ? 45.0f : 40.0f;
    [self setTableViewInsetsWithBottomValue:inputViewHeight - 45];
    CGRect inputFrame = CGRectMake(0.0f,
                                   self.view.frame.size.height - inputViewHeight,
                                   self.view.frame.size.width,
                                   inputViewHeight);
    if(!_messageInputView)
        _messageInputView = [self setupMessageInputView:inputFrame];
    
    switch (self.showType) {
        case MessageShowTypeNewCreate:
        {
            _bottomView = _messageInputView;
            CGRect rect = self.messageTableView.frame;
            rect.origin.y = 0;
            rect.size.height = self.view.frame.size.height - 45 - 64;
            self.messageTableView.frame = rect;
            break;
        }
        case MessageShowTypeAnswering:
        {
            self.headerHintView = [self setupCountDownHeaderView];
            [self.view addSubview:self.headerHintView];
            CGRect rect = self.messageTableView.frame;
            rect.origin.y = 0;
            rect.size.height = self.view.frame.size.height  - 64;
            self.messageTableView.frame = rect;
            
            [self performSelector:@selector(delayDismissHeaderHint) withObject:nil afterDelay:5.0];
            _bottomView = _messageInputView;
            break;
        }
        case MessageShowTypeClosed:
        {
            _bottomView = [self setupClosedBottomView:inputFrame];
            _messageInputView.hidden = YES;
            [self.view addSubview:_messageInputView];
            CGRect rect = self.messageTableView.frame;
            rect.origin.y = 0;
            rect.size.height = self.view.frame.size.height - 80 - 64;
            self.messageTableView.frame = rect;
            break;
        }
        case MessageShowTypeTimeout:
        {
            _bottomView = [self setupTimeoutBottomView:inputFrame];
            _messageInputView.hidden = YES;
            [self.view addSubview:_messageInputView];
            CGRect rect = self.messageTableView.frame;
            rect.origin.y = 0;
            rect.size.height = self.view.frame.size.height - 80 - 64;
            self.messageTableView.frame = rect;
            break;
        }
        case MessageShowTypeDiffusion:
        {
            CGRect rect = self.messageTableView.frame;
            rect.origin.y = 0;
            rect.size.height = self.view.frame.size.height - 55 - 64;
            self.messageTableView.frame = rect;
            _messageInputView.hidden = YES;
            [self.view addSubview:_messageInputView];
            break;
        }
        default:
            break;
    }
    if(_bottomView) {
        [self.view addSubview:_bottomView];
        [self.view bringSubviewToFront:_bottomView];
    }
}

- (void)delayDismissHeaderHint
{
    [UIView animateWithDuration:0.35 animations:^{
        self.headerHintView.alpha = 0.0;
        CGRect rect = self.messageTableView.frame;
        rect.origin.y = 0;
        rect.size.height = self.view.frame.size.height - 64;
        self.messageTableView.frame = rect;
    } completion:^(BOOL finished) {
        [self.headerHintView removeFromSuperview];
    }];
}

- (UIView *)setupCountDownHeaderView
{
    UIView *headerView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 45)];
    UIColor *backGroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_header_answer"]];
    backGroundColor = [backGroundColor colorWithAlphaComponent:0.8];
    [headerView setBackgroundColor:backGroundColor];
    self.countDownLabel = [[UILabel alloc] init];
    [_countDownLabel setText:@"该问题24小时后过期"];
    _countDownLabel.font = [UIFont systemFontOfSize:14.0f];
    _countDownLabel.textColor = RGBHex(qwColor3);
    _countDownLabel.alpha = 0.6f;
    _countDownLabel.frame = CGRectMake(65, 4.5, 190, 36);
    _countDownLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:_countDownLabel];
    
    _alarmLogo = [[UIImageView alloc] initWithFrame:CGRectMake(0, (45.0 - 18 ) / 2.0f, 18, 18)];
    _alarmLogo.image = [UIImage imageNamed:@"icon_clock.png"];
    [headerView addSubview:_alarmLogo];
    [self setCountDownLabelText:_countDownLabel.text];
    return headerView;
}

- (void)setCountDownLabelText:(NSString *)text
{
    _countDownLabel.text = text;

    CGFloat width = [text sizeWithFont:[UIFont systemFontOfSize:14.0f]].width;
    CGRect rect = _countDownLabel.frame;
    rect.size.width = width;
    rect.origin.x = (APP_W - width ) / 2.0 + 13.5f;
    _countDownLabel.frame = rect;
    
    rect = _alarmLogo.frame;
    rect.origin.x = (APP_W - width ) / 2.0 - 13.5;
    _alarmLogo.frame = rect;
}

- (UIView *)setupClosedBottomView:(CGRect)inputFrame
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_H - 80 - 64, APP_W, 80)];
    [bottomView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *closeLabel = [[UILabel alloc] init];
    if(self.historyMsg && self.historyMsg.consultMessage)
        [closeLabel setText:self.historyMsg.consultMessage];
    closeLabel.font = [UIFont systemFontOfSize:14.0f];
    closeLabel.numberOfLines = 3;
    closeLabel.textColor = RGBHex(qwColor6);
    closeLabel.tag = 888;
    closeLabel.frame = CGRectMake(10, 10, 200, 60);
    closeLabel.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:closeLabel];
    
    UIButton *reopenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [reopenButton setTitle:@"进店咨询" forState:UIControlStateNormal];
    [reopenButton addTarget:self action:@selector(pushIntoDetailConsult:) forControlEvents:UIControlEventTouchDown];
    reopenButton.frame = CGRectMake(220, 22, 86, 36);
    [reopenButton setBackgroundImage:[UIImage imageNamed:@"ic_btn_zixun1.png"] forState:UIControlStateNormal];
    [reopenButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];

    UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 0.5)];
    [separatorLine setBackgroundColor:RGBHex(qwColor10)];
    [bottomView addSubview:separatorLine];
    [bottomView addSubview:reopenButton];
    return bottomView;
}

- (UIView *)setupTimeoutBottomView:(CGRect)inputFrame
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_H - 80 - 64, APP_W, 80)];
    [bottomView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *closeLabel = [[UILabel alloc] init];
    if(self.historyMsg && self.historyMsg.consultMessage)
        [closeLabel setText:self.historyMsg.consultMessage];
    closeLabel.font = [UIFont systemFontOfSize:14.0f];
    closeLabel.numberOfLines = 3;
    closeLabel.tag = 888;
    closeLabel.textColor = RGBHex(qwColor6);
    closeLabel.frame = CGRectMake(10, 10, 200, 60);
    closeLabel.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:closeLabel];
    
    UIButton *reopenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [reopenButton setTitle:@"     咨询" forState:UIControlStateNormal];
    [reopenButton addTarget:self action:@selector(reopenConsultQuestion:) forControlEvents:UIControlEventTouchDown];
    reopenButton.frame = CGRectMake(220, 22, 86, 36);
    [reopenButton setBackgroundImage:[UIImage imageNamed:@"ic_btn_zixun2.png"] forState:UIControlStateNormal];
    [reopenButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [bottomView addSubview:reopenButton];
    
    UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 0.5)];
    [separatorLine setBackgroundColor:RGBHex(qwColor10)];
    [bottomView addSubview:separatorLine];
    
    return bottomView;
}

- (void)pushIntoDetailConsult:(id)sender
{
    
}

- (void)reopenConsultQuestion:(id)sender
{
    
}

- (XHMessageInputView *)setupMessageInputView:(CGRect)inputFrame
{
    XHMessageInputView *inputView = [[XHMessageInputView alloc] initWithFrame:inputFrame];
    inputView.allowsSendFace = self.allowsSendFace;
    inputView.allowsSendVoice = self.allowsSendVoice;
    inputView.allowsSendMultiMedia = self.allowsSendMultiMedia;
    inputView.delegate = self;
    return inputView;
}



- (void)unLoadKeyboardBlock
{
    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardDidHideNotification object:nil];
    self.messageTableView.keyboardDidScrollToPoint = NULL;
    self.messageTableView.keyboardWillSnapBackToPoint = NULL;
    self.messageTableView.keyboardWillBeDismissed = NULL;
    self.messageTableView.keyboardWillChange = NULL;
    self.messageTableView.keyboardDidChange = NULL;
    self.messageTableView.keyboardDidHide = NULL;
}

- (void)initKeyboardBlock
{
    WEAKSELF
    if (self.allowsPanToDismissKeyboard) {
        // 控制输入工具条的位置块
        void (^AnimationForMessageInputViewAtPoint)(CGPoint point) = ^(CGPoint point) {
            CGRect inputViewFrame = weakSelf.messageInputView.frame;
            CGPoint keyboardOrigin = [weakSelf.view convertPoint:point fromView:nil];
            inputViewFrame.origin.y = keyboardOrigin.y - inputViewFrame.size.height;
            weakSelf.messageInputView.frame = inputViewFrame;
        };
        
        self.messageTableView.keyboardDidScrollToPoint = ^(CGPoint point) {
            if (weakSelf.textViewInputViewType == XHInputViewTypeText)
                AnimationForMessageInputViewAtPoint(point);
        };
        
        self.messageTableView.keyboardWillSnapBackToPoint = ^(CGPoint point) {
            if (weakSelf.textViewInputViewType == XHInputViewTypeText)
                AnimationForMessageInputViewAtPoint(point);
        };
        
        self.messageTableView.keyboardWillBeDismissed = ^() {
            CGRect inputViewFrame = weakSelf.messageInputView.frame;
            inputViewFrame.origin.y = weakSelf.view.bounds.size.height - inputViewFrame.size.height;
            weakSelf.messageInputView.frame = inputViewFrame;
        };
    }
    
    // block回调键盘通知
    self.messageTableView.keyboardWillChange = ^(CGRect keyboardRect, UIViewAnimationOptions options, double duration, BOOL showKeyborad) {
        if(self.shouldPreventAutoScrolling)
            return;
        if (weakSelf.textViewInputViewType == XHInputViewTypeText) {
            [UIView animateWithDuration:duration
                                  delay:0.0
                                options:options
                             animations:^{
                                 CGFloat keyboardY = [weakSelf.view convertRect:keyboardRect fromView:nil].origin.y;
                                 
                                 CGRect inputViewFrame = weakSelf.messageInputView.frame;
                                 CGFloat inputViewFrameY = keyboardY - inputViewFrame.size.height;
                                 
                                 // for ipad modal form presentations
                                 CGFloat messageViewFrameBottom = weakSelf.view.frame.size.height - inputViewFrame.size.height;
                                 if (inputViewFrameY > messageViewFrameBottom)
                                     inputViewFrameY = messageViewFrameBottom;
                                 
                                 weakSelf.messageInputView.frame = CGRectMake(inputViewFrame.origin.x,
                                                                              inputViewFrameY,
                                                                              inputViewFrame.size.width,
                                                                              inputViewFrame.size.height);
                                 
                                 [weakSelf setTableViewInsetsWithBottomValue:weakSelf.view.frame.size.height
                                  - weakSelf.messageInputView.frame.origin.y - 45];
                                 if (showKeyborad)
                                     [weakSelf scrollToBottomAnimated:NO];
                             }
                             completion:nil];
        }
    };
    
    self.messageTableView.keyboardDidChange = ^(BOOL didShowed) {
        if ([weakSelf.messageInputView.inputTextView isFirstResponder]) {
            if (didShowed) {
                if (weakSelf.textViewInputViewType == XHInputViewTypeText) {
                    weakSelf.shareMenuView.alpha = 0.0;
                    weakSelf.emotionManagerView.alpha = 0.0;
                }
            }
        }
    };
    
    self.messageTableView.keyboardDidHide = ^() {
        [weakSelf.messageInputView.inputTextView resignFirstResponder];
    };
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 设置键盘通知或者手势控制键盘消失
    [self.messageTableView setupPanGestureControlKeyboardHide:self.allowsPanToDismissKeyboard];
    // KVO 检查contentSize
    [self.messageInputView.inputTextView addObserver:self
                                     forKeyPath:@"contentSize"
                                        options:NSKeyValueObservingOptionNew
                                        context:nil];
    [self initKeyboardBlock];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 取消输入框
    [self unLoadKeyboardBlock];
    [self.messageInputView.inputTextView resignFirstResponder];
    [self setEditing:NO animated:YES];
    
    // remove键盘通知或者手势
    [self.messageTableView disSetupPanGestureControlKeyboardHide:self.allowsPanToDismissKeyboard];

    // remove KVO
    [self.messageInputView.inputTextView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化消息页面布局
    
    self.popupMarketActivityView = [[[NSBundle mainBundle] loadNibNamed:@"PopupMarketActivityView" owner:self options:nil] objectAtIndex:0];

    self.popupMarketActivityView.delegate = self;
    
    [self initilzer];
      self.photoDic = [NSMutableDictionary dictionary];
    self.uploaderPhoto = [NSMutableArray array];

    [[XHMessageBubbleView appearance] setFont:[UIFont systemFontOfSize:16.0f]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    _messages = nil;
    self.delegate = nil;
    _dataSource = nil;
    _messageTableView.delegate = nil;
    _messageTableView.dataSource = nil;
    _messageTableView = nil;
    _messageInputView = nil;

}

#pragma mark - View Rotation

- (BOOL)shouldAutorotate {
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

#pragma mark - UITextView Helper Method

- (CGFloat)getTextViewContentH:(UITextView *)textView {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        return ceilf([textView sizeThatFits:textView.frame.size].height);
    } else {
        return textView.contentSize.height;
    }
}

#pragma mark - Layout Message Input View Helper Method

- (void)layoutAndAnimateMessageInputTextView:(UITextView *)textView {
    CGFloat maxHeight = [XHMessageInputView maxHeight];
    
    CGFloat contentH = [self getTextViewContentH:textView];
    
    BOOL isShrinking = contentH < self.previousTextViewContentHeight;
    CGFloat changeInHeight = contentH - _previousTextViewContentHeight;
    
    if (!isShrinking && (self.previousTextViewContentHeight == maxHeight || textView.text.length == 0)) {
        changeInHeight = 0;
    }
    else {
        changeInHeight = MIN(changeInHeight, maxHeight - self.previousTextViewContentHeight);
    }
    
    if (changeInHeight != 0.0f) {
        [UIView animateWithDuration:0.0f
                         animations:^{
                             [self setTableViewInsetsWithBottomValue:self.messageTableView.contentInset.bottom + changeInHeight];
    
                             [self scrollToBottomAnimated:NO];
        
                             if (isShrinking) {
                                 if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
                                     self.previousTextViewContentHeight = MIN(contentH, maxHeight);
                                 }
                                 // if shrinking the view, animate text view frame BEFORE input view frame
                                 [self.messageInputView adjustTextViewHeightBy:changeInHeight];
                             }
                             
                             CGRect inputViewFrame = self.messageInputView.frame;
                             self.messageInputView.frame = CGRectMake(0.0f,
                                                                      inputViewFrame.origin.y - changeInHeight,
                                                                      inputViewFrame.size.width,
                                                                      inputViewFrame.size.height + changeInHeight);
                             if (!isShrinking) {
                                 if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
                                     self.previousTextViewContentHeight = MIN(contentH, maxHeight);
                                 }
                                 // growing the view, animate the text view frame AFTER input view frame
                                 [self.messageInputView adjustTextViewHeightBy:changeInHeight];
                             }
                         }
                         completion:^(BOOL finished) {
                         }];
        
        self.previousTextViewContentHeight = MIN(contentH, maxHeight);
    }
    if (self.previousTextViewContentHeight == maxHeight) {
        double delayInSeconds = 0.01;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime,
                       dispatch_get_main_queue(),
                       ^(void) {
                           CGPoint bottomOffset = CGPointMake(0.0f, contentH - textView.bounds.size.height);
                           [textView setContentOffset:bottomOffset animated:YES];
                       });
    }
}

#pragma mark - Scroll Message TableView Helper Method

- (void)setTableViewInsetsWithBottomValue:(CGFloat)bottom
{
    UIEdgeInsets insets = [self tableViewInsetsWithBottomValue:bottom];
    self.messageTableView.contentInset = insets;
    self.messageTableView.scrollIndicatorInsets = insets;
    self.messageTableView.header.scrollViewOriginalInset = insets;
    self.messageTableView.footer.scrollViewOriginalInset = insets;
}

- (UIEdgeInsets)tableViewInsetsWithBottomValue:(CGFloat)bottom {
    UIEdgeInsets insets = UIEdgeInsetsZero;
    insets.bottom = bottom;
    return insets;
}

#pragma mark - Message Calculate Cell Height

- (CGFloat)calculateCellHeightWithMessage:(id <XHMessageModel>)message atIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellHeight = 0;
    
    BOOL displayTimestamp = YES;
    if ([self.delegate respondsToSelector:@selector(shouldDisplayTimestampForRowAtIndexPath:)]) {
        displayTimestamp = [self.delegate shouldDisplayTimestampForRowAtIndexPath:indexPath];
    }
    
    cellHeight = [XHMessageTableViewCell calculateCellHeightWithMessage:message displaysTimestamp:displayTimestamp];
    DDLogVerbose(@"%f",cellHeight);
    return cellHeight;
}

#pragma mark - Message Send helper Method

- (void)didSendMessageWithText:(NSString *)text
{
    DLog(@"send text : %@", text);
    if ([self.delegate respondsToSelector:@selector(didSendText:fromSender:onDate:)]) {
        [self.delegate didSendText:text fromSender:self.messageSender onDate:[NSDate date]];
    }
}

- (void)didSendMedicineName:(NSString *)drugName imageUrl:(NSString *)imageUrl productId:(NSString *)productId
{
    if ([self.delegate respondsToSelector:@selector(didSendMedicine:productId:imageUrl:fromSender:onDate:)]) {
        [self.delegate didSendMedicine:drugName productId:productId imageUrl:imageUrl fromSender:self.messageSender onDate:[NSDate date]];
    }
}

- (void)didSendActivity:(NSString *)title
                content:(NSString *)content
                comment:(NSString *)comment
            activityUrl:(NSString *)activityUrl
             activityId:(NSString *)activityId
{
    if ([self.delegate respondsToSelector:@selector(didSendActivity:content:comment:activityUrl:activityId:fromSender:onDate:)]) {
        [self.delegate didSendActivity:title content:content comment:comment activityUrl:activityUrl activityId:activityId fromSender:self.messageSender onDate:[NSDate date]];
    }
}

- (void)didSendMessageWithPhoto:(UIImage *)photo {
    if ([self.delegate respondsToSelector:@selector(didSendPhoto:fromSender:onDate:image:uuid:)]) {
        [self.delegate didSendPhoto:photo fromSender:self.messageSender onDate:[NSDate date] image:nil uuid:@""];
    }
}


//选中表情集,添加占位符到文本框中
- (void)didSendEmotionMessageWithEmotionPath:(XHEmotion *)emotionPath
{
    DLog(@"send emotionPath : %@", emotionPath);
    NSString *text = self.messageInputView.inputTextView.text;
    if([emotionPath.emotionPath isEqualToString:@"删除"])
    {
        NSString *scanString = [NSString stringWithString:text];
        NSUInteger count = 0;
        while (scanString.length > 0)
        {
            NSString *lastString = [scanString substringWithRange:NSMakeRange(scanString.length - 1, 1)];
            if([lastString isEqualToString:@"["] && scanString.length >= 1)
            {
                text = [scanString substringToIndex:scanString.length - 1];
                self.messageInputView.inputTextView.text = text;
                return;
            }
            count++;
            if(count >= 4)
                break;
            scanString = [scanString substringToIndex:scanString.length - 1];
        }
        if(text.length > 0){
            text = [text substringToIndex:text.length - 1];
            self.messageInputView.inputTextView.text = text;
        }
        return;
    }
    
    text = [text stringByAppendingString:emotionPath.emotionPath];
    self.messageInputView.inputTextView.text = text;
}

- (void)didSendGeolocationsMessageWithGeolocaltions:(NSString *)geolcations location:(CLLocation *)location
{
    DLog(@"send geolcations : %@", geolcations);
    if ([self.delegate respondsToSelector:@selector(didSendGeoLocationsPhoto:geolocations:location:fromSender:onDate:)]) {
        [self.delegate didSendGeoLocationsPhoto:[UIImage imageNamed:@"Fav_Cell_Loc"] geolocations:geolcations location:location fromSender:self.messageSender onDate:[NSDate date]];
    }
}

#pragma mark - Other Menu View Frame Helper Mehtod
- (void)layoutOtherMenuViewHide:(BOOL)hide fromInputView:(BOOL)from
{
    [self.messageInputView.inputTextView resignFirstResponder];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        __block CGRect inputViewFrame = self.messageInputView.frame;
        __block CGRect otherMenuViewFrame;
        
        void (^InputViewAnimation)(BOOL hide) = ^(BOOL hide) {
            inputViewFrame.origin.y = (hide ? (CGRectGetHeight(self.view.bounds) - CGRectGetHeight(inputViewFrame)) : (CGRectGetMinY(otherMenuViewFrame) - CGRectGetHeight(inputViewFrame)));
            self.messageInputView.frame = inputViewFrame;
        };
        
        void (^EmotionManagerViewAnimation)(BOOL hide) = ^(BOOL hide) {
            otherMenuViewFrame = self.emotionManagerView.frame;
            otherMenuViewFrame.origin.y = (hide ? CGRectGetHeight(self.view.frame) : (CGRectGetHeight(self.view.frame) - CGRectGetHeight(otherMenuViewFrame)));
            self.emotionManagerView.alpha = !hide;
            self.emotionManagerView.frame = otherMenuViewFrame;
        };
        
        void (^ShareMenuViewAnimation)(BOOL hide) = ^(BOOL hide) {
            otherMenuViewFrame = self.shareMenuView.frame;
            otherMenuViewFrame.origin.y = (hide ? CGRectGetHeight(self.view.frame) : (CGRectGetHeight(self.view.frame) - CGRectGetHeight(otherMenuViewFrame)));
            if(self.shareMenuView.alpha == 1.0f && from) {
                otherMenuViewFrame.origin.y -= 121;
                [self.messageInputView.inputTextView becomeFirstResponder];
                InputViewAnimation(NO);
            }else{
                InputViewAnimation(hide);
            }
            self.shareMenuView.alpha = !hide;
            self.shareMenuView.frame = otherMenuViewFrame;
            
        };
        
        if (hide) {
            switch (self.textViewInputViewType) {
                case XHInputViewTypeEmotion: {
                    EmotionManagerViewAnimation(hide);
                    break;
                }
                case XHInputViewTypeShareMenu: {
                    ShareMenuViewAnimation(hide);
                    break;
                }
                default:
                    break;
            }
            InputViewAnimation(hide);
        } else {
            
            // 这里需要注意block的执行顺序，因为otherMenuViewFrame是公用的对象，所以对于被隐藏的Menu的frame的origin的y会是最大值
            switch (self.textViewInputViewType) {
                case XHInputViewTypeEmotion: {
                    // 1、先隐藏和自己无关的View
                    ShareMenuViewAnimation(!hide);
                    // 2、再显示和自己相关的View
                    EmotionManagerViewAnimation(hide);
                    InputViewAnimation(hide);
                    break;
                }
                case XHInputViewTypeShareMenu: {
                    // 1、先隐藏和自己无关的View
                    EmotionManagerViewAnimation(!hide);
                    // 2、再显示和自己相关的View
                    ShareMenuViewAnimation(hide);
                    break;
                }
                default:
                    break;
            }
        }
        [self setTableViewInsetsWithBottomValue:self.view.frame.size.height
         - self.messageInputView.frame.origin.y - 45];
        
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)layoutOtherMenuViewHiden:(BOOL)hide {
    [self layoutOtherMenuViewHide:hide fromInputView:YES];
    [self scrollToBottomAnimated:YES];
}

- (void)showPopMarkActivityDetail:(CouponNewListModel *)model
{
    [self.popupMarketActivityView setContent:model.desc avatarUrl:model.imgUrl];
    self.popupMarketActivityView.infoDict = [NSMutableDictionary dictionaryWithDictionary:[model dictionaryModel]];
    [self.popupMarketActivityView showInView:self.view animated:YES];
    [self.view addSubview:self.popupMarketActivityView];
}

- (void)didSendMarketActivityWithDict:(NSDictionary *)dict
{
    CouponNewListModel *model = [CouponNewListModel parse:dict];
    [self didSendActivity:model.title content:model.desc comment:model.replyText activityUrl:model.imgUrl activityId:model.id];
    
}
#pragma mark - XHMessageInputView Delegate
- (void)inputTextViewWillBeginEditing:(XHMessageTextView *)messageInputTextView
{
    self.textViewInputViewType = XHInputViewTypeText;
}

- (void)inputTextViewDidBeginEditing:(XHMessageTextView *)messageInputTextView
{
    if (!self.previousTextViewContentHeight)
		self.previousTextViewContentHeight = [self getTextViewContentH:messageInputTextView];
}

- (void)didChangeSendVoiceAction:(BOOL)changed
{
    if (changed) {
        if (self.textViewInputViewType == XHInputViewTypeText)
            return;
        // 在这之前，textViewInputViewType已经不是XHTextViewTextInputType
        [self layoutOtherMenuViewHiden:YES];
    }
}

- (void)didSendTextMessage:(id)sender
{
    if(self.messageInputView.inputTextView.text.length == 0)
        return;
    if ([self.delegate respondsToSelector:@selector(didSendText:fromSender:onDate:)]) {
        [self.delegate didSendText:self.messageInputView.inputTextView.text fromSender:self.messageSender onDate:[NSDate date]];
    }
}

- (void)didSendTextAction:(NSString *)text {
    DLog(@"text : %@", text);
    if ([self.delegate respondsToSelector:@selector(didSendText:fromSender:onDate:)]) {
        [self.delegate didSendText:text fromSender:self.messageSender onDate:[NSDate date]];
    }
}

- (void)didSelectedMultipleMediaAction
{
    self.textViewInputViewType = XHInputViewTypeShareMenu;
    if(self.shareMenuView.alpha == 1.0) {
        [self.messageInputView.inputTextView becomeFirstResponder];
    }else{
        [self layoutOtherMenuViewHiden:NO];
    }
}

- (void)didSendFaceAction:(BOOL)sendFace {
    [self scrollToBottomAnimated:YES];
    if (sendFace) {
        self.textViewInputViewType = XHInputViewTypeEmotion;
        [self layoutOtherMenuViewHide:NO fromInputView:NO];
        [self scrollToBottomAnimated:YES];
    } else {
        [self.messageInputView.inputTextView becomeFirstResponder];
    }
}

#pragma mark - XHShareMenuView Delegate

- (void)didSelecteShareMenuItem:(XHShareMenuItem *)shareMenuItem atIndex:(NSInteger)index {
    DLog(@"title : %@   index:%ld", shareMenuItem.title, (long)index);
    
    WEAKSELF
    switch (index) {
        case 0: {
            ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
            if(author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied) {
                [SVProgressHUD showErrorWithStatus:@"当前程序未开启相册使用权限" duration:0.8];
                return;
            }
            [self LocalPhoto];
            break;
        }
        case 1: {
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if(authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied){
                [SVProgressHUD showErrorWithStatus:@"当前程序未开启相机使用权限" duration:0.8];
                return;
            }
            [self takePhoto];
            break;
        }
        case 2: {
            //发送药品
//            [self didSendMedicineName:@"仁和,枸橼酸铋钾片123123123123" imageUrl:@"www.baidu.com" productId:@"603257"];
            QuickSearchDrugViewController *quickSearchDrugViewController = [QuickSearchDrugViewController new];
            quickSearchDrugViewController.returnValueBlock = ^(productclassBykwId *model){
//                [self didSendMedicineName:model.proName imageUrl:PORID_IMAGE(model.proId) productId:model.proId];
                [self didSendMedicineName:model.proName imageUrl:model.imgUrl productId:model.proId];
            };
            [self.navigationController pushViewController:quickSearchDrugViewController animated:NO];
            
            break;
        }
        
        default:
            break;
    }
}

#pragma mark - XHEmotionManagerView Delegate

- (void)didSelecteEmotion:(XHEmotion *)emotion atIndexPath:(NSIndexPath *)indexPath {
    if (emotion.emotionPath) {
        [self didSendEmotionMessageWithEmotionPath:emotion];
    }
}

#pragma mark - XHEmotionManagerView DataSource

- (NSInteger)numberOfEmotionManagers {
    return 0;
}

- (XHEmotionManager *)emotionManagerForColumn:(NSInteger)column {
    return nil;
}

- (NSArray *)emotionManagersAtManager {
    return nil;
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
 
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
	self.isUserScrolling = YES;
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    }
    
    if (self.textViewInputViewType != XHInputViewTypeNormal && self.textViewInputViewType != XHInputViewTypeText) {
        [self layoutOtherMenuViewHiden:YES];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.isUserScrolling = NO;
}

#pragma mark - XHMessageTableViewController Delegate

- (BOOL)shouldPreventScrollToBottomWhileUserScrolling {
    return YES;
}

#pragma mark - XHMessageTableViewController DataSource

- (id <XHMessageModel>)messageForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.messages[indexPath.row];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    id <XHMessageModel> message = [self.dataSource messageForRowAtIndexPath:indexPath];
    
    BOOL displayTimestamp = YES;
    if ([self.delegate respondsToSelector:@selector(shouldDisplayTimestampForRowAtIndexPath:)]) {
        displayTimestamp = [self.delegate shouldDisplayTimestampForRowAtIndexPath:indexPath];
    }
    static NSString *cellIdentifier = @"XHMessageTableViewCell";
    
    XHMessageTableViewCell *messageTableViewCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!messageTableViewCell) {
        messageTableViewCell = [[XHMessageTableViewCell alloc] initWithMessage:message displaysTimestamp:displayTimestamp reuseIdentifier:cellIdentifier];
        messageTableViewCell.delegate = self;
    }
    messageTableViewCell.userInteractionEnabled = YES;
    messageTableViewCell.indexPath = indexPath;
    [messageTableViewCell configureCellWithMessage:message displaysTimestamp:displayTimestamp];

    [messageTableViewCell setSended:message.sended];
    if ([self.delegate respondsToSelector:@selector(configureCell:atIndexPath:)]) {
        [self.delegate configureCell:messageTableViewCell atIndexPath:indexPath];
    }
    
    return messageTableViewCell;
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id <XHMessageModel> message = [self.dataSource messageForRowAtIndexPath:indexPath];
    return [self calculateCellHeightWithMessage:message atIndexPath:indexPath];
}

#pragma mark - Key-value Observing

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (object == self.messageInputView.inputTextView && [keyPath isEqualToString:@"contentSize"]) {
        [self layoutAndAnimateMessageInputTextView:object];
    }
}
#pragma mark - send Photo
-(void)takePhoto
{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        [self performSelector:@selector(showcamera) withObject:nil afterDelay:0.3];

    }else
    {
        DDLogVerbose(@"模拟其中无法打开照相机,请在真机中使用");
    }
}
-(void)showcamera
{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {

    }

    picker.sourceType = UIImagePickerControllerSourceTypeCamera;

    [self presentViewController:picker animated:YES completion:^{
        
    }];

}
-(void)LocalPhoto
{
    
//    DFMultiPhotoSelectorViewController *vc = [[DFMultiPhotoSelectorViewController alloc]init];
//    vc.delegate = self;
//    [self.navigationController pushViewController:vc animated: NO];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PhotoAlbum" bundle:nil];
    PhotoAlbum* vc = [sb instantiateViewControllerWithIdentifier:@"PhotoAlbum"];
    [vc selectPhotos:4 selected:nil block:^(NSMutableArray *list) {
        for (PhotoModel *mode in list) {
            if (mode.fullImage) {
                UIImage *image=mode.fullImage;
                [self didChoosePhoto:image];
            }
        }
        /*
        dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(aQueue, ^(void) {
            NSMutableArray *tmp=[[NSMutableArray alloc]initWithCapacity:list.count];
            NSMutableArray *tmp2=[[NSMutableArray alloc]initWithCapacity:list.count];
            for (PhotoModel *mode in list) {
                [tmp addObject:mode.asset];
            }
            [PhotosAlbum getImagesByAssetList:tmp photosBlock:^(NSArray *listPhotos) {
                dispatch_async(dispatch_get_main_queue(),
                               ^{
                                   for (UIImage *image in listPhotos) {
                                       [self didChoosePhoto:image];
                                   }
                               });
            } failure:nil];
            /*
            [PhotosAlbum getFullImageByAssetList:tmp photoBlock:^(UIImage *fullResolutionImage) {
                UIImage *imgTmp;
                imgTmp=fullResolutionImage;
                imgTmp = [imgTmp imageByScalingToMinSize];
                imgTmp = [UIImage scaleAndRotateImage:imgTmp];
                [tmp2 addObject:imgTmp];
                if (tmp2.count==list.count) {
                    dispatch_async(dispatch_get_main_queue(),
                                   ^{
                                       for (UIImage *image in tmp2) {
                                           [self didChoosePhoto:image];
                                       }
                                   });
                }
                
            } failure:nil];
         

        });
        */

    } failure:^(NSError *error) {
        DebugLog(@"%@",error);
        [vc closeAction:nil];
    }];
    
    UINavigationController *nav = [[QWBaseNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:^{
    }];
}

- (void)multiPhotoSelectorDidCanceled:(DFMultiPhotoSelectorViewController *)selector
{
    
}

- (void)multiPhotoSelector:(DFMultiPhotoSelectorViewController *)selector didSelectedPhotos:(NSArray *)photos
{
    
}

-(void)didChoosePhoto:(UIImage *)img
{
    WEAKSELF
    NSString *str =[XMPPStream generateUUID];
    willsendimg = img;
    [[SDImageCache sharedImageCache] storeImage:img forKey:str];
    [self performSelectorOnMainThread:@selector(doSendPhoto:) withObject:str  waitUntilDone:NO];
}

#pragma mark UIImagePickerControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([navigationController isKindOfClass:[UIImagePickerController class]] &&
        ((UIImagePickerController *)navigationController).sourceType ==     UIImagePickerControllerSourceTypePhotoLibrary) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    image = [image imageByScalingToMinSize];
    image = [UIImage scaleAndRotateImage:image];
    
    [self didChoosePhoto:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void)doSendPhoto:(NSString*)str
{
    WEAKSELF
    UIImage *imagedata =  [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:str] ;
    [weakSelf didSendPhoto:imagedata fromSender:self.messageSender onDate:[NSDate date] image:@"" uuid:str];
}

-(void)resendPhotoWihtUuid:(NSString *)red
{
    
    
}

-(void)progressUpdate:(NSString *)uuid progress:(float)newProgress
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        XHMessage *message = [self getMessageWithUUID:uuid];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.messages indexOfObject:message] inSection:0];
        XHMessageTableViewCell *cell = (XHMessageTableViewCell *)[self.messageTableView cellForRowAtIndexPath:indexPath];
        if (cell) {
            cell.messageBubbleView.dpMeterView.hidden = NO;
            cell.messageBubbleView.resendButton.hidden = YES;
            [cell.messageBubbleView.dpMeterView setProgress:newProgress];
        }
        
    });
    
}
- (void)addPhotoMessage:(XHMessage *)addedMessage {
     if (![self.messages containsObject:addedMessage]) {
          [self.messages addObject:addedMessage];
        
        NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:1];
        [indexPaths addObject:[NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0]];
               [self.messageTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    [self.messageTableView reloadData];
           [self scrollToBottomAnimated:YES];
    }
//    else
//    {
//        return;
//    }

    WEAKSELF
    [weakSelf exMainQueue:^{
        UIImage *imagedata =  [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:addedMessage.UUID] ;
        NSData * imageData = UIImageJPEGRepresentation(imagedata, 1.0f);
      
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.messages indexOfObject:addedMessage] inSection:0];
        XHMessageTableViewCell *cell = (XHMessageTableViewCell *)[self.messageTableView cellForRowAtIndexPath:indexPath];

         [self progressUpdate:addedMessage.UUID progress:0];

        [self sendToSe:addedMessage.UUID imagData:imageData success:^(id responseObj) {
            cell.messageBubbleView.dpMeterView.activeShow.hidden = YES;
            cell.messageBubbleView.dpMeterView.hidden = YES;
              cell.messageBubbleView.dpMeterView.progressLabel.text = [NSString stringWithFormat:@"%d%@",0,@"%"];
            [self requestDidSuccessed:addedMessage.UUID obj:responseObj];
        } failure:^(HttpException *e) {
            cell.messageBubbleView.dpMeterView.activeShow.hidden = YES;
            cell.messageBubbleView.dpMeterView.hidden = YES;
               cell.messageBubbleView.dpMeterView.progressLabel.text = [NSString stringWithFormat:@"%d%@",0,@"%"];
            [self requestDidFaileded:addedMessage.UUID obj:e];
        } uploadProgressBlock:^(NSString *str, float progress) {
            [self progressUpdate:str progress:progress];
        }];
    }];
}

- (void)requestDidSuccessed:(NSString *)uuid obj:(id)responseObj
{
    [self.photoDic removeObjectForKey:uuid];
    NSDictionary * dict = responseObj;
    WEAKSELF
    
    //    HistoryMessages * hmsg = [[HistoryMessages alloc] init];
    //
    //    hmsg.issend =[NSString stringWithFormat:@"%d", Sended];
    //
    //    [HistoryMessages updateObjToDB:hmsg WithKey:self.messageSender];
    QWMessage * msg =  [QWMessage getObjFromDBWithKey:uuid];
    DDLogVerbose(@"success image ==  %@",uuid);
//    msg.recvname = self.messageSender;
    msg.issend = [NSString stringWithFormat:@"%d",Sending];
    msg.richbody =[dict objectForKey:@"url"];
        DDLogVerbose(@"success image ==  %@", msg.richbody);
    [QWMessage updateObjToDB:msg WithKey:uuid];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"UUID == %@",uuid];
    NSArray *array = [self.messages filteredArrayUsingPredicate:predicate];
    if([array count] > 0) {
        XHMessage *filterMessage =  array[0];
        filterMessage.sended = Sended;
        filterMessage.richBody = [dict objectForKey:@"url"];
        //filterMessage.UUID =
        [weakSelf sendXmppPhototimestamp:filterMessage.timestamp richBody:[dict objectForKey:@"url"] UUID:uuid];
    }
    [self.messageTableView reloadData];
    
    if ([dict[@"result"] isEqualToString:@"FAIL"]) {
        [SVProgressHUD showErrorWithStatus:dict[@"msg"] duration:DURATION_SHORT];
        return;
    }
}

- (void)requestDidFaileded:(NSString *)uuid obj:(id)responseObj
{
      DDLogVerbose(@"failed image ==  %@",uuid);
    //    [app.dataBase updateMessageRichBody:@"" With:request.asiFormDataUUID Status:[NSNumber numberWithInt:SendFailure]];
    QWMessage * msg =  [QWMessage getObjFromDBWithKey:uuid];
    
//    msg.recvname = self.messageSender;
    msg.issend = [NSString stringWithFormat:@"%d",SendFailure];
    msg.richbody = @"";
    
    [QWMessage updateObjToDB:msg WithKey:uuid];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"UUID == %@",uuid];
    NSArray *array = [self.messages filteredArrayUsingPredicate:predicate];
    
    if([array count] > 0) {
        XHMessage *filterMessage =  array[0];
        filterMessage.sended = SendFailure;
        [self scrollToBottomAnimated:NO];
    }
    [self.messageTableView reloadData];
    DDLogVerbose(@"send  photo   faile");
//    [[NSNotificationCenter defaultCenter] postNotificationName:UPDATEBOX object:nil];
    [GLOBALMANAGER
     postNotif:NotimessageBoxUpdate data:nil object:nil];
}
-(void)sendToSe:(NSString *)str imagData:(NSData *)imageData success:(void(^)(id responseObj))success failure:(void(^)(HttpException * e))failure  uploadProgressBlock:(void (^)(NSString* str, float progress ))uploadProgressBlock
{
    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
    setting[@"type"] = @(4);
    setting[@"token"] = QWGLOBALMANAGER.configure.userToken;
    if (!imageData ) {
        return;
    }
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:imageData];
    
    HttpClient *httpClent = [HttpClient new];
    //cj----cj
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *apiUrl = [def objectForKey:@"APIDOMAIN"];
    NSString *h5Url = [def objectForKey:@"H5DOMAIN"];
    if(!StrIsEmpty(apiUrl)){
        [httpClent setBaseUrl:apiUrl];
    }else{
        [httpClent setBaseUrl:BASE_URL_V2];
    }
    httpClent.progressEnabled = NO;
    [httpClent uploaderImg:array params:setting withUrl:NW_uploadFile success:^(id responseObj) {
//        self.activeShow.hidden = YES;
//        self.hidden = YES;
        if (success) {
            success(responseObj);
        }
    } failure:^(HttpException *e) {
//        self.activeShow.hidden = YES;
//        self.hidden = YES;
        if (failure) {
            failure(e);
        }
    } uploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
        if (uploadProgressBlock) {
            uploadProgressBlock(str, ( (double)totalBytesWritten/(double)totalBytesExpectedToWrite ));
        }
        
    }];
    
}



@end
