//
//  TaReplyViewController.h
//  wenYao-store
//
//  Created by Yang Yuexia on 16/1/15.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "QWBaseVC.h"

@class TaReplyViewController;
@protocol TaReplyViewControllerDelegaet <NSObject>

- (void)expertDidScrollToTop:(TaReplyViewController *)vc;

@end

@interface TaReplyViewController : QWBaseVC
@property (nonatomic, assign) id<TaReplyViewControllerDelegaet> delegate;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) NSString *expertId; //专家id

@property (assign, nonatomic) int expertType;        // 事件统计用的，用来区分是营养师还是药师, 专栏进来设置

- (void)currentViewSelected:(void (^)(CGFloat height))finishLoading;
- (void)footerRereshing:(void (^)(CGFloat height))finishRefresh :(void(^)(BOOL canLoadMore))canLoadMore :(void(^)())failure;

@end
