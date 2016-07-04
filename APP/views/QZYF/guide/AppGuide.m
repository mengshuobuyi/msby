//
//  AppGuide.m
//  quanzhi
//
//  Created by ZhongYun on 14-1-28.
//  Copyright (c) 2014年 ZhongYun. All rights reserved.
//

#import "AppGuide.h"
#import "PageControl.h"
#import "Constant.h"
#import "QWGlobalManager.h"
#import "css.h"
#import "AppDelegate.h"
#define TAG_BASE            100000
//#define OFFSET_H    (APP_H==460?0:46)
#define COMMON_DOT  COLOR(216, 168, 254)
#define ACTIVE_DOT  COLOR(118, 52, 176)
#define TAG(v)              (v>=TAG_BASE?v-TAG_BASE:v+TAG_BASE)

//立即体验按钮Frame:
#define  btnWidth       192.0f  //按钮宽度
#define  btnHeight      39.0f   //按钮高度

#define  PCHeight       18.0f   //pageControl高度
#define  PCConstant     17.5f   //pageControl距离立即体验按钮像素


#define  ScreenHeight   APP_H + 20

@interface AppGuide()<UIScrollViewDelegate>
{
    CGFloat btnConstant;
    PageControl* m_pageControl;
    UIButton* btnOPClose;
    UIScrollView *m_scrollView;
    
}

@end

@implementation AppGuide

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self commonInitEmbedded];
    }
    return self;
}


- (id)init
{
    CGRect frame = [UIScreen mainScreen].bounds;
    self = [super initWithFrame:frame];
    if (self) {

        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    [self setBackgroundColor:[UIColor whiteColor]];
    //引导页的滚动view
    m_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, APP_W, ScreenHeight)];
    m_scrollView.pagingEnabled = YES;
    m_scrollView.showsHorizontalScrollIndicator = NO;
    m_scrollView.userInteractionEnabled = YES;
    m_scrollView.delegate = self;
    [self addSubview:m_scrollView];
    
    // page点点点
    m_pageControl = [[PageControl alloc] init];
    m_pageControl.userInteractionEnabled = NO;
    
    if (IS_IPHONE_4_OR_LESS)
    {
        btnConstant = 25.0f;
        m_pageControl.frame = CGRectMake((self.bounds.size.width-60)/2, self.frame.size.height - btnHeight - PCConstant - btnConstant  - PCHeight, 60, PCHeight);
    }else if (IS_IPHONE_5)
    {
        btnConstant = 35.0f;
        m_pageControl.frame = CGRectMake((self.bounds.size.width-60)/2, self.frame.size.height - btnHeight -PCConstant- btnConstant  - PCHeight, 60, PCHeight);
    }else if (IS_IPHONE_6)
    {
        btnConstant = 35.0f;
        m_pageControl.frame = CGRectMake((self.bounds.size.width-60)/2, self.frame.size.height - btnHeight -PCConstant- btnConstant  - PCHeight, 60, PCHeight);
    }else if (IS_IPHONE_6P)
    {
        btnConstant = 52.0f;
        m_pageControl.frame = CGRectMake((self.bounds.size.width-60)/2, self.frame.size.height - btnHeight -PCConstant- btnConstant  - PCHeight, 60, PCHeight);
    }

    m_pageControl.commonColor = RGBHex(0xf4efd2);
    m_pageControl.activeColor = RGBHex(0xf3e055);
    m_pageControl.commonImage = [UIImage imageNamed:@"btn_guide_normal"];
    m_pageControl.activeImage = [UIImage imageNamed:@"btn_guide_selected"];
    m_pageControl.backgroundColor = [UIColor clearColor];
    [self addSubview:m_pageControl];
}


- (void)commonInitEmbedded
{
    [self setBackgroundColor:[UIColor whiteColor]];
    //引导页的滚动view
    m_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, APP_W, ScreenHeight)];
    m_scrollView.pagingEnabled = YES;
    m_scrollView.showsHorizontalScrollIndicator = NO;
    m_scrollView.userInteractionEnabled = YES;
    m_scrollView.delegate = self;
    [self addSubview:m_scrollView];
    
    // page点点点
    m_pageControl = [[PageControl alloc] init];
    m_pageControl.userInteractionEnabled = NO;
    
    if (IS_IPHONE_4_OR_LESS)
    {
        btnConstant = 25.0f;
        m_pageControl.frame = CGRectMake((self.bounds.size.width-60)/2, self.frame.size.height - btnHeight  - btnConstant  - PCHeight, 60, PCHeight);
    }else if (IS_IPHONE_5)
    {
        btnConstant = 35.0f;
        m_pageControl.frame = CGRectMake((self.bounds.size.width-60)/2, self.frame.size.height - btnHeight - btnConstant  - PCHeight, 60, PCHeight);
    }else if (IS_IPHONE_6)
    {
        btnConstant = 35.0f;
        m_pageControl.frame = CGRectMake((self.bounds.size.width-60)/2, self.frame.size.height - btnHeight - btnConstant  - PCHeight, 60, PCHeight);
    }else if (IS_IPHONE_6P)
    {
        btnConstant = 52.0f;
        m_pageControl.frame = CGRectMake((self.bounds.size.width-60)/2, self.frame.size.height - btnHeight - btnConstant  - PCHeight, 60, PCHeight);
    }
    
    m_pageControl.commonColor = RGBHex(0xf4efd2);
    m_pageControl.activeColor = RGBHex(0xf3e055);
    m_pageControl.commonImage = [UIImage imageNamed:@"btn_guide_normal"];
    m_pageControl.activeImage = [UIImage imageNamed:@"btn_guide_selected"];
    m_pageControl.backgroundColor = [UIColor clearColor];
    [self addSubview:m_pageControl];
}

- (void)dealloc
{
    [m_scrollView release];
    [super dealloc];
}

// 设置scrollView上的图片

- (void)setImgNames:(NSArray *)imgNames
{
    [self clearImages];
    if (!imgNames || imgNames.count==0)
        return;
    _imgNames = [imgNames copy];
    [self buildScrollViewPics:imgNames];
    m_pageControl.numberOfPages = imgNames.count;
    m_pageControl.currentPage = 0;
    m_pageControl.alpha = 1.0f;
    m_scrollView.contentOffset = CGPointMake(0, 0);
}

- (void)setImage:(UIImage *)image
{
    [self clearImages];
    if (!image)
        return;
    [self buildScrollViewPic:image];
    m_pageControl.alpha = 0.0f;
    m_scrollView.contentOffset = CGPointMake(0, 0);
}


- (void)buildScrollViewPic:(UIImage *)image
{
    CGRect rect = CGRectMake(0, 0, APP_W, self.bounds.size.height);
    UIImageView* imgbg = [[UIImageView alloc] initWithFrame:rect];
    imgbg.userInteractionEnabled = YES;
    imgbg.image = image;
    [m_scrollView addSubview:imgbg];
    [imgbg release];
    
    UIImageView *imgPage = [[UIImageView alloc] initWithImage:image];
    imgPage.frame = rect;
    imgPage.contentMode = UIViewContentModeScaleAspectFit;
    imgPage.tag = TAG(0+0);
    imgPage.clipsToBounds = YES;
    [m_scrollView addSubview:imgPage];
    
    [imgPage release];
    
    //跳过 按钮
    btnOPClose = [[UIButton alloc] init];
    [btnOPClose addTarget:self action:@selector(onBtnCloseOP) forControlEvents:UIControlEventTouchUpInside];
    [btnOPClose setTitle:@"0秒跳过" forState:UIControlStateNormal];
    [btnOPClose setBackgroundColor:[UIColor clearColor]];
    btnOPClose.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    btnOPClose.alpha = 1.0;
    
    if (IS_IPHONE_4_OR_LESS)
    {
        btnOPClose.frame = CGRectMake(60+4, 404, APP_W-120, 40);
    }else if (IS_IPHONE_5)
    {
        btnOPClose.frame = CGRectMake(60, 581, APP_W-120, 40);
    }else if (IS_IPHONE_6)
    {
        btnOPClose.frame = CGRectMake(60, 568, APP_W-120, 40);
    }else if (IS_IPHONE_6P)
    {
        btnOPClose.frame = CGRectMake(60, 629, APP_W-120, 40);
    }else{
        
    }
    
    [m_scrollView addSubview:btnOPClose];
    [btnOPClose release];
    
    m_scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    m_scrollView.contentOffset = CGPointMake(0, 0);
    
    self.count = 0;
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(dismissTimer) userInfo:nil repeats:YES];
}

- (void)dismissTimer
{
    self.count++;
    [btnOPClose setTitle:[NSString stringWithFormat:@"%d秒跳过",self.count] forState:UIControlStateNormal];
    
    if (self.count == 5) {
        [self onBtnCloseOP];
    }
}

- (void)onBtnCloseOP
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        // 显示OP
//        [APPDelegate showOPSplash];
        //MARK: 别删，未来可能使用 comment by perry
       
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        if([[userDefault objectForKey:@"showGuide"] boolValue] == NO) {
            [userDefault setObject:[NSNumber numberWithBool:YES] forKey:@"showGuide"];
            [userDefault synchronize];
            [QWGLOBALMANAGER postNotif:NotifAppCheckVersion data:nil object:self];
        }
    }];
}


// 设置scrollView上的图片

- (void)buildScrollViewPics:(NSArray*)imgNames
{

    for (int i = 0; i < imgNames.count; i++)
    {
        CGRect rect = CGRectMake(i*APP_W, 0, APP_W, self.bounds.size.height);
        UIImageView* imgbg = [[UIImageView alloc] initWithFrame:rect];
        imgbg.userInteractionEnabled = YES;
        imgbg.image = [UIImage imageNamed:imgNames[i]];
        [m_scrollView addSubview:imgbg];
        [imgbg release];
        
//        UIImageView *imgPage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[imgNames objectAtIndex:i]]];
//        imgPage.frame = rect;
//        imgPage.contentMode = UIViewContentModeScaleAspectFit;
//        imgPage.tag = TAG(i*2+0);
//        imgPage.clipsToBounds = YES;
//        [m_scrollView addSubview:imgPage];
//
//        [imgPage release];
    }
    
//    for (int i = 0; i < imgNames.count; i++) {
//        CGRect rect = CGRectMake(i*APP_W+(APP_W-80), 0, 80, 80);
//        
//        UIView * jumpButton = [[UIView alloc] init];
//        jumpButton.frame = rect;
//        jumpButton.backgroundColor = [UIColor colorWithRed:237.0f/255.0f green:239.0f/255.0f blue:241.0f/255.0f alpha:1.0f];
//        jumpButton.userInteractionEnabled = NO;
//        [m_scrollView addSubview:jumpButton];
//    }
//    
    

    UIButton* btnClose = [[UIButton alloc] init];
    [btnClose addTarget:self action:@selector(onBtnCloseTouched:) forControlEvents:UIControlEventTouchUpInside];
    [btnClose setTitle:@"立即体验" forState:UIControlStateNormal];
    [btnClose setTitleColor:RGBHex(qwColor4) forState:UIControlStateNormal];
    [btnClose setBackgroundColor:[UIColor clearColor]];
    btnClose.layer.masksToBounds = YES;
    btnClose.layer.cornerRadius = btnHeight/2.0f;
    btnClose.layer.borderColor = RGBHex(qwColor4).CGColor;
    btnClose.layer.borderWidth = 1.0f;
    btnClose.titleLabel.font = fontSystem(kFontS2);
    btnClose.alpha = 1.0;
        
    
    CGFloat btnX = (imgNames.count - 1) * APP_W + btnWidth/2.0f;
    
    if (IS_IPHONE_4_OR_LESS)
    {
        btnClose.frame = CGRectMake(btnX, ScreenHeight - btnConstant - btnHeight, self.bounds.size.width - btnWidth, btnHeight);
    }
    else if (IS_IPHONE_5)
    {
        btnClose.frame = CGRectMake(btnX, ScreenHeight - btnConstant - btnHeight, self.bounds.size.width - btnWidth, btnHeight);
    }
    else if (IS_IPHONE_6)
    {
        btnClose.frame = CGRectMake(btnX, ScreenHeight - btnConstant - btnHeight, self.bounds.size.width - btnWidth, btnHeight);
    }
    else if (IS_IPHONE_6P)
    {
        btnClose.frame = CGRectMake(btnX, ScreenHeight - btnConstant - btnHeight, self.bounds.size.width - btnWidth, btnHeight);
    }

    [m_scrollView addSubview:btnClose];
    [btnClose release];
    
    m_scrollView.contentSize = CGSizeMake(imgNames.count*self.frame.size.width, self.frame.size.height);
    m_scrollView.contentOffset = CGPointMake(0, 0);
}

- (void)onBtnCloseTouched:(UIButton*)sender
{
    [QWGLOBALMANAGER statisticsEventId:@"引导页_立即体验" withLable:@"引导页_立即体验" withParams:nil];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        
        // 显示OP
//        [APPDelegate showOPSplash];
        //MARK: 别删，未来可能使用 comment by perry
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        if([[userDefault objectForKey:@"showGuide"] boolValue] == NO) {
            [userDefault setObject:[NSNumber numberWithBool:YES] forKey:@"showGuide"];
            [userDefault synchronize];
            [QWGLOBALMANAGER postNotif:NotifAppCheckVersion data:nil object:self];
        }
        [QWGLOBALMANAGER postNotif:NotiMessageOPLaunchingScreenDisappear data:nil object:nil];
    }];
    
    //添加透明层
//    m_viOne = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    m_viOne.alpha = 0;
//    
//    UIImageView *imageOne = [[UIImageView alloc] init];
//    if(HIGH_RESOLUTION) {
//        imageOne.frame = CGRectMake(0, 20, m_viOne.frame.size.width, m_viOne.frame.size.height);
//        imageOne.image  = [UIImage imageNamed:@"img_mask_1568"];
//    }else{
//        imageOne.frame = CGRectMake(0, 20, m_viOne.frame.size.width, m_viOne.frame.size.height-10);
//        imageOne.image  = [UIImage imageNamed:@"img_mask_1480"];
//    }
//    
//    [m_viOne addSubview:imageOne];
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissFirstBgView)];
//    [m_viOne addGestureRecognizer:tap];
//    
//    [[UIApplication sharedApplication].keyWindow addSubview:m_viOne];
//    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
//        m_viOne.alpha = 0.8;
//        self.alpha = 0;
//    } completion:^(BOOL finished) {
//        
//        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//        [userDefault setObject:[NSNumber numberWithBool:YES] forKey:@"showGuide"];
//        [userDefault synchronize];
//
//        [QWGLOBALMANAGER postNotif:NotifAppCheckVersion data:nil object:self];
//    }];
}

- (void)dismissFirstBgView
{
    //添加透明层
//    m_viTwo = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    m_viTwo.alpha = 0;
//    
//    UIImageView *imageTwo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, m_viTwo.frame.size.width, m_viTwo.frame.size.height)];
//    if(HIGH_RESOLUTION) {
//        imageTwo.frame = CGRectMake(0, 20, m_viTwo.frame.size.width, m_viTwo.frame.size.height);
//        imageTwo.image  = [UIImage imageNamed:@"img_mask_2568"];
//    }else{
//        imageTwo.frame = CGRectMake(0, 20, m_viTwo.frame.size.width, m_viTwo.frame.size.height-10);
//        imageTwo.image  = [UIImage imageNamed:@"img_mask_2480"];
//    }
//    
//    imageTwo.alpha = 1;
//    [m_viTwo addSubview:imageTwo];
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSecondBgView)];
//    [m_viTwo addGestureRecognizer:tap];
//    
//    [[UIApplication sharedApplication].keyWindow addSubview:m_viTwo];
//    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
//        m_viOne.alpha = 0;
//        m_viTwo.alpha = 0.8;
//    } completion:^(BOOL finished) {
//        [m_viOne removeFromSuperview];
//    }];
}

- (void)dismissSecondBgView
{
//    [UIView animateWithDuration:0.5 animations:^{
//        m_viTwo.alpha = 0;
//    } completion:^(BOOL finished) {
//        [m_viTwo removeFromSuperview];
//        [self removeFromSuperview];
//    }];
}


- (void)clearImages
{
    for (int i = 0; i < m_scrollView.subviews.count; i++) {
        UIView* subview = [m_scrollView.subviews objectAtIndex:i];
        if (subview.tag >= TAG_BASE) {
            [subview removeFromSuperview];
        }
    }
    m_pageControl.numberOfPages = 0;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int w = 0, i = 0;
    for (i = 0; i < m_pageControl.numberOfPages; i++)
    {
        if (scrollView.contentOffset.x <= w)
            break;
        w += self.bounds.size.width;
    }
    m_pageControl.currentPage = i;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if(scrollView.contentOffset.x < 0){
        scrollView.scrollEnabled = NO;
        return;
    }
    if(scrollView.contentOffset.x > self.frame.size.width * (self.imgNames.count - 1)){
        scrollView.scrollEnabled = NO;
        return;
    }
    scrollView.scrollEnabled = YES;

    
//    if(scrollView.contentOffset.x >= ((_imgNames.count - 1) * APP_W + 50))
//    {
//        [self onBtnCloseTouched:nil];
//    }

}

@end

void showAppGuide(NSArray* images)
{
    //已经显示过引导页的话 检查app最新版本
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if([[userDefault objectForKey:@"showGuide"] boolValue]){
        [QWGLOBALMANAGER postNotif:NotifAppCheckVersion data:nil object:nil];
        return;
    }
    [QWGLOBALMANAGER statisticsEventId:@"引导页" withLable:@"引导页" withParams:nil];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    AppGuide* guide = [[AppGuide alloc] init];
    guide.imgNames = images;
    guide.tag = 1008;
    [[UIApplication sharedApplication].keyWindow addSubview:guide];
    [guide release];
}

void showAppOPGuide(UIImage* image)
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    AppGuide* guide = [[AppGuide alloc] init];
    guide.image = image;
    [[UIApplication sharedApplication].keyWindow addSubview:guide];
    [guide release];
}

