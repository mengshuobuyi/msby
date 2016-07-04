//
//  QWTopNotice.m
//  APP
//
//  Created by Martin.Liu on 15/11/9.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "QWTopNotice.h"
#import "ConstraintsUtility.h"
#import "AppDelegate.h"
// 5秒后自动隐藏通知
#define AutoHiddenSeconds 5
// 左边“问药通知”图片
#define DefaultLeftImageName @"img_notice"
// 右边关闭图片
#define DefaultRightImageName @"img_close"
// 背景颜色（透明）
#define NoticeViewBackGroundColor RGBAHex(qwColor6, 0.7)
// 内容文字颜色
#define ContentLabelTextColor RGBHex(qwColor4)
// 内容文字大小
#define ContentLabelFont [UIFont systemFontOfSize:AutoValue(kFontS5)]
// 倒计时文字颜色
#define TipLabelTextColor RGBHex(qwColor4)
// 倒计时文字大小
#define TipLabelFont [UIFont systemFontOfSize:kFontS6]

@class QWNoticeContentView;

@protocol QWNoticeContentViewDelegate <NSObject>

- (void)contentTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event contentView:(QWNoticeContentView *)contentView;

@optional
- (void)contentTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event contentView:(QWNoticeContentView *)contentView;
- (void)contentTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event contentView:(QWNoticeContentView *)contentView;
- (void)contentTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event contentView:(QWNoticeContentView *)contentView;

@end

@interface QWNoticeContentView : UIView;

@property (nonatomic, assign) id<QWNoticeContentViewDelegate> delegate;

@end

@implementation QWNoticeContentView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_delegate && [_delegate respondsToSelector:@selector(contentTouchesBegan:withEvent:contentView:)]) {
        [_delegate contentTouchesBegan:touches withEvent:event contentView:self];
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_delegate && [_delegate respondsToSelector:@selector(contentTouchesMoved:withEvent:contentView:)]) {
        [_delegate contentTouchesMoved:touches withEvent:event contentView:self];
    }
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_delegate && [_delegate respondsToSelector:@selector(contentTouchesEnded:withEvent:contentView:)]) {
        [_delegate contentTouchesEnded:touches withEvent:event contentView:self];
    }
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_delegate && [_delegate respondsToSelector:@selector(contentTouchesCancelled:withEvent:contentView:)]) {
        [_delegate contentTouchesCancelled:touches withEvent:event contentView:self];
    }
    [super touchesCancelled:touches withEvent:event];
}

@end



static QWTopNotice *_notice = nil;

@interface QWTopNotice ()<QWNoticeContentViewDelegate>

@property (nonatomic, strong) UIView *noticeView;           // 最外层的View, 显示隐藏操作此视图
@property (nonatomic, strong) QWNoticeContentView *contentView;          //
@property (nonatomic, strong) UIImageView *leftImageView;   // “全维通知”图片
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *rightImageView;  // 关闭图片
@property (nonatomic, strong) UILabel *tipLabel;            // 关闭图片旁边的提示文字 倒计时用的
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSInteger countDown;          // 倒计时数字
@property (nonatomic, strong) NSDictionary *attributeStringDic; // 文字内容使用AttributeString，可以更好地控制样式间距。

@property (nonatomic, strong) UIView *inView;               // 所在的页面 暂时不用

@property (nonatomic, copy) ClickNoticeBlock clickBlock;    // 点击通知返回的块

@end

@implementation QWTopNotice
{
    CGPoint _startPoint;    // 点击时间开始时候的位置
    BOOL draging;           // 是否滑动视图的标志
}

+ (instancetype) sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _notice = [self new];
    });
    return _notice;
}


// 展示通知 , 当点击左边的时候调用clickBlock块
+ (void)showNoticeWithText:(NSString *)contentText
{
    [self showNoticeWithText:contentText clickBlock:nil];
}

// 展示通知 , 当点击左边的时候调用clickBlock块
+(void)showNoticeWithText:(NSString *)contentText clickBlock:(ClickNoticeBlock)clickBlock
{
    QWTopNotice *notice = [QWTopNotice sharedInstance];
    [QWTopNotice cancelPreviousPerformRequestsWithTarget:notice];
    [notice setupUIS];
//    notice.contentLabel.text = contentText;
    notice.contentLabel.attributedText = [[NSAttributedString alloc] initWithString:contentText attributes:notice.attributeStringDic];
    notice.clickBlock = clickBlock;
    [notice performSelector:@selector(showAnimation) withObject:nil afterDelay:0.1];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    CGRect frame = [change[@"new"] CGRectValue];
    DebugLog(@"frame : %@", NSStringFromCGRect(frame));
}



//  隐藏通知
+ (void)hiddenNotice
{
    [[QWTopNotice sharedInstance] hideAnimation];
    
//    [[QWTopNotice sharedInstance] hiddenNoticeView];
//    [[QWTopNotice sharedInstance] removeNotice];
}

//+ (void) showNoticeWithText:(NSString *)contentText inView:(UIView *)inView;
//{
//    QWTopNotice *notice = [QWTopNotice sharedInstance];
//    notice.inView = inView;
//    [notice setupUIS];
//    notice.contentLabel.text = contentText;
//    [notice performSelector:@selector(showAnimation) withObject:nil afterDelay:0.01];
//}

- (void) showAnimation
{
    draging = NO;
    if (AutoHiddenSeconds > 0) {
        [self setCountDown:AutoHiddenSeconds];
        [self timer];
    }
    [self.class cancelPreviousPerformRequestsWithTarget:self];
    CGRect frame = self.noticeView.frame;
    frame.origin.y = -frame.size.height;
    self.noticeView.frame = frame;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.noticeView.frame;
        frame.origin.y = 0;
        self.noticeView.frame = frame;
        _noticeView.hidden = NO;
        [self.noticeView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:AutoHiddenSeconds];
    }];
}

- (void) hideAnimation
{
    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
    if(self.contentLabel.text && self.contentLabel.text.length > 0) {
        setting[@"通告内容"] = self.contentLabel.text;
    }else{
        setting[@"通告内容"] = @"";
    }
    if(_timer) {
        [QWGLOBALMANAGER statisticsEventId:@"x_sy_tggb" withLable:@"通告关闭" withParams:setting];
    }else{
        return;
    }
    [_timer invalidate];
    _timer = nil;
    NSLayoutConstraint* top = [_contentView constraintNamed:@"noticeView_align_top"];
    [UIView animateWithDuration:0.3 animations:^{
        
        if (top) {
            top.constant = -self.noticeView.frame.size.height;
            [self.noticeView layoutIfNeeded];
        }
        else
        {
            [self hiddenNoticeView];
        }
    } completion:^(BOOL finished) {
        [self removeNotice];
    }];
}

- (void) hiddenNoticeView
{
    [_timer invalidate];
    CGRect frame = self.noticeView.frame;
    frame.origin.y = -frame.size.height;
    self.noticeView.frame = frame;
}

- (void)removeNotice
{
    self.noticeView.hidden = YES;
    [self.noticeView removeFromSuperview];
}

// 懒加载初始化视图，并增加加约束
- (void) setupUIS
{
    if (!_noticeView) {
        [[QWTopNotice sharedInstance] addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
        [self.noticeView addSubview:self.contentView];
        [self.contentView addSubview:self.leftImageView];
        [self.contentView addSubview:self.rightImageView];
        [self.contentView addSubview:self.contentLabel];
        [self.rightImageView addSubview:self.tipLabel];
        [((AppDelegate *)[UIApplication sharedApplication].delegate).window addSubview:_noticeView];
        
        PREPCONSTRAINTS(_noticeView);
        PREPCONSTRAINTS(self.contentView);
        PREPCONSTRAINTS(self.leftImageView);
        PREPCONSTRAINTS(self.rightImageView);
        PREPCONSTRAINTS(self.contentLabel);
        PREPCONSTRAINTS(self.tipLabel);
        
        // 约束距离父视图顶部距离为0
//        ALIGN_TOP(_noticeView, 0);
        // 设置约束的nameTag，为了找到此约束进行编辑
        INSTALL_CONSTRAINTS(DEFAULT_LAYOUT_PRIORITY, @"noticeView_align_top", CONSTRAINT_ALIGNING_TOP(_noticeView, 0));
        // 约束距离父视图左边距离为0
        ALIGN_LEADING(_noticeView, 0);
        // 约束距离父视图右边距离为0
        ALIGN_TRAILING(_noticeView, 0);
        // 约束该视图的最大高度和最小高度
        CONSTRAIN_MIN_HEIGHT(_noticeView, 64, UILayoutPriorityDefaultHigh);
        CONSTRAIN_MAX_HEIGHT(_noticeView, SCREEN_H/2, UILayoutPriorityDefaultHigh);
        
        // 约束与父视图位置与大小一样
        ALIGN_TOP(self.contentView, STATUS_BAR_HEIGHT);
        ALIGN_LEADING(self.contentView, 0);
        ALIGN_BOTTOMRIGHT(self.contentView, 0);
        
        // 约束距离父视图的顶部距离与左距离为“8”
        ALIGN_TOP(self.leftImageView, 12);
        ALIGN_LEADING(self.leftImageView, 15);
        
        // 约束距离父视图顶部距离为“8”
        ALIGN_TOP(self.contentLabel, 12);
        [[NSLayoutConstraint constraintWithItem:self.contentView attribute: NSLayoutAttributeBottom relatedBy: NSLayoutRelationGreaterThanOrEqual toItem:self.contentLabel attribute: NSLayoutAttributeBottom multiplier: 1.0f constant: 12] install:999];
        // 约束距离兄弟视图左边距离为“8”
        LAYOUT_H_WITHOUTCENTER(self.leftImageView, 9, self.contentLabel);
        
        // 约束距离父视图顶部距离与右边距离为“8”
        ALIGN_TOPRIGHT(self.rightImageView, AutoValue(0));
        [[NSLayoutConstraint constraintWithItem:self.rightImageView attribute: NSLayoutAttributeBottom relatedBy: NSLayoutRelationLessThanOrEqual toItem: [self.rightImageView superview] attribute: NSLayoutAttributeBottom multiplier: 1.0f constant: (0)] install:998];
        // 倒计时标签约束
        ALIGN_CENTER_V(self.tipLabel);
        ALIGN_TRAILING(self.tipLabel, 5);
        
        
        LAYOUT_H_WITHOUTCENTER(self.contentLabel, AutoValue(8), self.rightImageView);
        // 降低视图压缩阻力和内容吸附的优先级
        HUG_H(_contentLabel, 220);
        RESIST_H(_contentLabel, 720);
    }
    if (!_noticeView.superview) {
        [((AppDelegate *)[UIApplication sharedApplication].delegate).window addSubview:_noticeView];
        PREPCONSTRAINTS(_noticeView);
//        ALIGN_TOP(_noticeView, 0);
        // 设置约束的nameTag，为了找到此约束进行编辑
        INSTALL_CONSTRAINTS(DEFAULT_LAYOUT_PRIORITY, @"noticeView_align_top", CONSTRAINT_ALIGNING_TOP(_noticeView, 0));
        ALIGN_LEADING(_noticeView, 0);
        ALIGN_TRAILING(_noticeView, 0);
        // removeFromSuperView 方法不会把下面的约束给去掉，不必再次添加。
//        CONSTRAIN_MIN_HEIGHT(_noticeView, 35, UILayoutPriorityDefaultHigh);
//        CONSTRAIN_MAX_HEIGHT(_noticeView, SCREEN_H/2, UILayoutPriorityDefaultHigh);
    }
}

- (UIView *)noticeView
{
    if (!_noticeView) {
        _noticeView = [[UIView alloc] init];
        _noticeView.hidden = YES;
        _noticeView.backgroundColor = [UIColor clearColor];
    }
    return _noticeView;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[QWNoticeContentView alloc] init];
        _contentView.delegate = self;
        _contentView.backgroundColor = NoticeViewBackGroundColor;
    }
    return _contentView;
}

- (UIImageView *)leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.image = [UIImage imageNamed:DefaultLeftImageName];
    }
    return _leftImageView;
}

- (UIImageView *)rightImageView
{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:DefaultRightImageName];
    }
    return _rightImageView;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLabel.textColor = ContentLabelTextColor;
        _contentLabel.font = ContentLabelFont;
    }
    return _contentLabel;
}

- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textColor = TipLabelTextColor;
        _tipLabel.font = TipLabelFont;
        _tipLabel.text = @"5s";
    }
    return _tipLabel;
}

- (NSTimer *)timer
{
    if (!_timer || ![_timer isValid]) {
        _timer = nil;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownFun) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (void)countDownFun
{
    self.countDown --;
    if (_countDown < 0) {
        [_timer invalidate];
    }
}

- (void)setCountDown:(NSInteger)countDown
{
    _countDown = countDown;
    if (!draging) {
        // 如果是滑动状态则不更新倒计时label， 避免视图出现跳动现象
        self.tipLabel.text = [NSString stringWithFormat:@"%lds", MAX(0, (long)_countDown)];
    }
}

- (NSDictionary *)attributeStringDic
{
    if (!_attributeStringDic) {
        NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 3;
        style.lineBreakMode = NSLineBreakByWordWrapping;
        _attributeStringDic = [NSDictionary dictionaryWithObjectsAndKeys:TipLabelFont, NSFontAttributeName, TipLabelTextColor, NSForegroundColorAttributeName, style, NSParagraphStyleAttributeName, nil];
    }
    return _attributeStringDic;
}

- (UIView *)inView
{
    if (!_inView) {
        _inView = ((AppDelegate *)[UIApplication sharedApplication].delegate).window;
    }
    return _inView;
}

#pragma mark - QWNoticeContentViewDelegate

- (void)contentTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event contentView:(QWNoticeContentView *)contentView {
    CGPoint endPoint = [[touches anyObject] locationInView:contentView];
    // 开始点击和结束点击的手指需要在关闭图片外,
    if (!draging && !CGRectContainsPoint(self.rightImageView.frame, _startPoint) && !CGRectContainsPoint(self.rightImageView.frame, endPoint)) {
        if (self.clickBlock) {
            self.clickBlock();
        }
    }
    [self hideAnimation];
}

- (void)contentTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event contentView:(QWNoticeContentView *)contentView {
    [self.class cancelPreviousPerformRequestsWithTarget:self];
    draging = NO;
    _startPoint = [[touches anyObject] locationInView:contentView];
}

- (void)contentTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event contentView:(QWNoticeContentView *)contentView {
    CGPoint point = [[touches anyObject] locationInView:contentView];
    CGFloat moveValue = _startPoint.y - point.y;
    
    if (fabs(moveValue) > 5) {
        draging = YES;
    }

    if (_noticeView.frame.origin.y - moveValue <= 0 && _noticeView.frame.origin.y >= -_noticeView.frame.size.height && draging) {
        CGRect noticeViewFrame = _noticeView.frame;
        noticeViewFrame.origin.y -= moveValue;
        _noticeView.frame = noticeViewFrame;
    }
}

- (void)contentTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event contentView:(QWNoticeContentView *)contentView {
    [self hideAnimation];
}

@end
