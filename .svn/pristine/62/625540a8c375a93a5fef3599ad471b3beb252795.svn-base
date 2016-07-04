//
//  MyPageViewController.h
//  APP
//
//  Created by qw on 15/2/27.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QWBasePage.h"
#import "UIView+Extension.h"

//登陆前代理
@protocol BeforeAndAfterLoginViewDelegate <NSObject>

@required
/**
 *  点击登录按钮
 */
- (void)loginButtonClick;
/**
 *  点击个人头像
 */
- (void)personHeadImageClick;

@end

/**
 *  登陆前的view 显示登录按钮
 */
@interface BeforeLoginView : UIView

@property (nonatomic ,strong) id<BeforeAndAfterLoginViewDelegate> delegate;

@end


/**
 *  登录后的view 显示登录用户的头像 昵称
 */
@interface AfterLoginView : UIView

@property (nonatomic ,strong) UIImageView   *headImageView;
@property (nonatomic ,strong) UILabel       *nameLabel;
@property (nonatomic ,strong) id<BeforeAndAfterLoginViewDelegate> delegate;

@end

@interface MyPageViewController : QWBasePage

@end
