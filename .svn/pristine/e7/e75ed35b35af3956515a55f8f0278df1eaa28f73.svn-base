//
//  MarketDetailViewController.h
//  quanzhi
//
//  Created by xiezhenghong on 14-7-3.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "QWBaseVC.h"


@interface MarketDetailViewController : QWBaseVC

//previewMode为1 是预览模式
@property (nonatomic, assign) NSUInteger                previewMode;
@property (nonatomic, strong) NSString                  *htmlUrl;
@property (nonatomic, strong) NSMutableDictionary       *infoDict;
@property (nonatomic, strong) NSString                  *activityId;
//userType 进入营销活动页面类型值  (userType的值依次累加)
//   1.从“我“进去userType=1     2.从聊天页面进去userType=2     3.从首页Banner进去userType=3
@property (nonatomic,assign)  NSInteger                 userType;
@property (nonatomic,assign)  NSInteger                 imStatus;//从聊天进入是2
@property (nonatomic,assign)  NSInteger                 bannerStatus;//从首页banner进来是1
@property (nonatomic, strong) NSMutableDictionary       *infoNewDict;//物理删除
@property (nonatomic, strong) IBOutlet UIScrollView     *scrollView;
@property (nonatomic, strong) IBOutlet UILabel          *contentLabel;
@property (nonatomic, strong) IBOutlet UILabel          *titleLabel;
//@property (nonatomic, strong) IBOutlet UILabel          *dateLabel;//弃用
@property (weak, nonatomic) IBOutlet   UILabel          *lblSource;//放日期

@end
