//
//  PostDetailViewController.h
//  APP
//
//  Created by Martin.Liu on 15/12/30.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "QWBaseVC.h"
#import "Forum.h"
typedef void (^DeletePostSuccess)();
@interface PostDetailViewController : QWBaseVC
@property (nonatomic, strong) NSString          * postId;
@property (nonatomic, strong) QWPostDetailModel * postDetail;

@property (strong, nonatomic) NSString          *jumpType;
@property (nonatomic, assign) BOOL              isFromSendPostVC;       // 如果从发帖入口进来的 ， 隐藏关注按钮；
@property (nonatomic, assign) BOOL              isSending;              // 如果从编辑帖子发布置YES，当发布成功，置NO， 如果YES， 不可上拉加载
@property (nonatomic, strong) NSString          *reminderExperts;       // 从发布帖子带过来，如果发送失败，需要用到
@property (nonatomic, copy  ) DeletePostSuccess deletePostSuccess;      // 删除帖子成功的回调函数

@property (nonatomic, strong) NSString          *preVCNameStr;          // 统计时间中用到
@property (nonatomic, assign) BOOL              isBackToDismiss;        // 3.1 详情外链h5激活app ， 点击返回键是否dismiss vc
@property (nonatomic, assign) BOOL              showLink;


@end
