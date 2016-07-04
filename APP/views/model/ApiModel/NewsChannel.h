//
//  News_Channel.h
//  APP
//
//  Created by qw on 15/3/1.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseAPIModel.h"

@interface NewsChannel : BaseAPIModel
@property (nonatomic,strong) NSString           *channelId;                 //栏目id
@property (nonatomic,strong) NSString           *channelName;               //栏目名称
@property (nonatomic,strong) NSString           *sort;                      //栏目排序

@end

@interface NewsAdvicel : BaseAPIModel

@property (nonatomic,strong) NSString           *adviceId;                  //资讯id
@property (nonatomic,strong) NSString           *iconUrl;                   //小图
@property (nonatomic,strong) NSString           *imgUrl;                    //banner图
@property (nonatomic,strong) NSString           *introduction;              //简介
@property (nonatomic,strong) NSString           *likeNumber;                //喜欢数
@property (nonatomic,strong) NSString           *pariseNum;                 //点赞数
@property (nonatomic,strong) NSString           *publishTime;               //发布时间
@property (nonatomic,strong) NSString           *publisher;                 //发布者
@property (nonatomic,strong) NSString           *readNum;                   //阅读数
@property (nonatomic,strong) NSString           *source;                    //来源
@property (nonatomic,strong) NSString           *title;                     //标题

@end

@interface NewsAdvicelPage : BaseAPIModel

@property (nonatomic,strong) NSString           *advicePageId;              //advicePageId
@property (nonatomic,strong) NSString           *currPage;                  //当前页码
@property (nonatomic,strong) NSString           *pageSize;                  //当前条数
@property (nonatomic,strong) NSString           *totalPage;                 //总共有多少页
@property (nonatomic,strong) NSString           *totalRecord;               //总共有多少条数据
@property (nonatomic,strong) NSArray            *data;                      //当前页的内容

@end

@interface NewsChannelBanner : BaseAPIModel

@property (nonatomic,strong) NSString           *channelId;                 //栏目id
@property (nonatomic,strong) NSString           *adviceId;                  //资讯id
@property (nonatomic,strong) NSString           *bannerImgUrl;              //banner图

@end