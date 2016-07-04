//
//  News_Channel.h
//  APP
//
//  Created by qw on 15/3/1.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseAPIModel.h"

@interface HealthinfoChannel : BaseAPIModel
@property (nonatomic,strong) NSString           *channelId;                 //栏目id
@property (nonatomic,strong) NSString           *channelName;               //栏目名称
@property (nonatomic,strong) NSString           *sort;                      //栏目排序
@property (nonatomic,strong) NSString           *isRecommend;               //是否推荐位

@end

@interface HealthinfoAdvicel : BaseAPIModel

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

@interface HealthinfoAdvicelPage : BaseAPIModel

@property (nonatomic,strong) NSString           *advicePageId;              //advicePageId
@property (nonatomic,strong) NSString           *page;                  //当前页码
@property (nonatomic,strong) NSString           *pageSize;                  //当前条数
@property (nonatomic,strong) NSString           *pageSum;                 //总共有多少页
@property (nonatomic,strong) NSString           *totalRecords;               //总共有多少条数据
@property (nonatomic,strong) NSArray            *list;                      //当前页的内容
@end

@interface HealthInfoReadCountModel : BaseAPIModel
@property (nonatomic, strong) NSString *readCount;
@property (nonatomic, strong) NSString *pariseCount;
@end

@interface HealthinfoChannelBanner : BaseAPIModel

@property (nonatomic,strong) NSString           *channelId;                 //栏目id
@property (nonatomic,strong) NSString           *adviceId;                  //资讯id
@property (nonatomic,strong) NSString           *bannerImgUrl;              //banner图
@property (nonatomic,strong) NSString           *bannerTitle;              //banner图

@end

// 健康资讯推荐模块
@interface SubjectOrDisvionAreaVO : BaseAPIModel
@property (nonatomic, strong) NSArray          *channelSubjectsVO;
@property (nonatomic, strong) NSArray          *disvionVO;
@end

@interface ChannelSubjectsVO : BaseAPIModel
@property (nonatomic, strong) NSString         *id;
@property (nonatomic, strong) NSString         *type;
@property (nonatomic, strong) NSString         *desc;
@property (nonatomic, strong) NSString         *imgUrl;
@property (nonatomic, strong) NSString         *contentUrl;
@property (nonatomic, strong) NSString         *title;
@end

@interface DisvionVO : BaseAPIModel
@property (nonatomic, strong) NSString         *id;
@property (nonatomic, strong) NSString         *title;
@property (nonatomic, strong) NSString         *desc;
@property (nonatomic, strong) NSString         *imgUrl;
@property (nonatomic, strong) NSString         *contentUrl;
@end

@interface DivisionAreaVoList : BaseAPIModel
@property (nonatomic, strong) NSArray *list;
@end

@interface DivisionAreaVo : BaseAPIModel
@property (nonatomic, strong) NSString *areaId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *url;
@end

@interface MsgArticleListVO : BaseAPIModel
@property (nonatomic, strong) NSArray *list;
@end

@interface MsgArticleVO : BaseAPIModel
@property (nonatomic, strong) NSString *msgID;
@property (nonatomic, strong) NSString *spclID;
@property (nonatomic, strong) NSString *artType;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *imgURl;
@property (nonatomic, strong) NSString *publishTime;
@property (nonatomic, strong) NSString *readCount;
@property (nonatomic, strong) NSString *commentCount;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *showType;
@property (nonatomic, strong) NSString *contentType;
@property (nonatomic, strong) NSString *isTop;
@end

@interface MsgChannelListVO : BaseAPIModel
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong) NSArray *listNoAdd;
@end

@interface MsgChannelVO : BaseAPIModel
@property (nonatomic, strong) NSString *channelID;
@property (nonatomic, strong) NSString *channelName;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, strong) NSString *type;
@end
