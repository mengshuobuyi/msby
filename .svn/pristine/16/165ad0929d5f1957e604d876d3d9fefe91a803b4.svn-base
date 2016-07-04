//
//  QWTopNotice.h
//  APP
//
//  Created by Martin.Liu on 15/11/9.
//  Copyright © 2015年 carret. All rights reserved.
//

typedef void(^ClickNoticeBlock)();

#import <Foundation/Foundation.h>

@interface QWTopNotice : NSObject

/*
 展示通知
 **/
+ (void) showNoticeWithText:(NSString *)contentText;

/*
 展示通知 , 当点击左边的时候调用clickBlock块
 **/
+ (void)showNoticeWithText:(NSString *)contentText clickBlock:(ClickNoticeBlock)clickBlock;

/*
 隐藏通知
 **/
+ (void) hiddenNotice;

//+ (void) showNoticeWithText:(NSString *)contentText inView:(UIView *)inView;

@end
