//
//  SearchModel.h
//  APP
//
//  Created by 李坚 on 15/8/19.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseModel.h"
#import "BaseAPIModel.h"

@interface SearchModel : BaseModel

@end

@interface SearchHistoryVo : BaseModel

@property (strong, nonatomic) NSString *proId;//商品编码
@property (strong, nonatomic) NSString *proName;//商品名称
@property (strong, nonatomic) NSString *mallFlag;//1.MshopProductVo 2.SearchProductVo

@end

@interface ScanProductVo : BaseModel

@property (strong, nonatomic) NSString *prodId;//商品编码
@property (strong, nonatomic) NSString *prodSpec;//商品规格
@property (strong, nonatomic) NSString *prodName;//商品名称
@property (strong, nonatomic) NSString *prodImg;//商品图片地址
@property (strong, nonatomic) NSString *prodSignCode;
@property (strong, nonatomic) NSString *prodContent;
@property (strong, nonatomic) NSString *prodFactory;

@end

@interface SearchProductVo : BaseModel

@property (strong, nonatomic) NSString *proId;//商品编码
@property (strong, nonatomic) NSString *spec;//商品规格
@property (strong, nonatomic) NSString *prodName;//商品名称
@property (strong, nonatomic) NSString *prodImg;//商品图片地址
@property (strong, nonatomic) NSString *prodFactoryName;//生产厂家
@property (strong, nonatomic) NSString *prodBrandName;//商品品牌
@property (strong, nonatomic) NSArray *promotionId;//优惠商品ID
@property (strong, nonatomic) NSArray *promotionType;//优惠类型
@end

@interface MshopProductVo : BaseModel

@property (strong, nonatomic) NSString *proId;//商品编码
@property (strong, nonatomic) NSString *proName;//商品名称
@property (strong, nonatomic) NSString *imgUrl;//商品图片地址
@property (strong, nonatomic) NSString *brandName;//商品品牌
@property (strong, nonatomic) NSString *content;//商品需要展示的说明内容
@property (strong, nonatomic) NSString *maxPrice;//商品最高价
@property (strong, nonatomic) NSString *minPrice;//商品最低价
@property (strong, nonatomic) NSString *showPrice;//商品展示价
@property (strong, nonatomic) NSString *spec;//商品展示价
@end

@interface HighlightPosition : BaseModel

@property (strong, nonatomic) NSNumber *start;
@property (strong, nonatomic) NSNumber *length;

@end

@interface HighlightAssociateVO : BaseModel

@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSArray *highlightPositionList;

@end

@interface KeywordModel : BaseModel

@property (copy, nonatomic) NSString *apiStatus;
@property (copy, nonatomic) NSString *apiMessage;
@property (strong, nonatomic) NSArray *list;

@end

@interface KeywordVO : BaseModel

@property (copy, nonatomic) NSString *apiStatus;
@property (copy, nonatomic) NSString *apiMessage;
@property (copy, nonatomic) NSString *type;// 关键词搜索类型 0:商品, 1:疾病, 2:症状 3:药店
@property (copy, nonatomic) NSString *resultCount;
@property (strong, nonatomic) NSArray *keywords;

@end

@interface OpenCityCheckVoModel : BaseAPIModel

@property (nonatomic, strong) NSString  *cityCode;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString  *remark;

@end


@interface OpenCityList : BaseAPIModel

@property (copy, nonatomic) NSArray *openCitys;

@end

@interface OpenCityModel : BaseAPIModel

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *province;
@property (strong, nonatomic) NSString *provinceName;
@property (strong, nonatomic) NSString *city;

@property (strong, nonatomic) NSString *cityName;
@property (strong, nonatomic) NSString *open;
@property (strong, nonatomic) NSString *remark;
@property (strong, nonatomic) NSString *code;

@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;

@end


@interface Keyword : BaseModel

@property (copy, nonatomic) NSString *keywordId;
@property (copy, nonatomic) NSString *keyword;
@property (copy, nonatomic) NSString *promotion;

@end

@interface hotKeywordList : BaseModel

@property (copy, nonatomic) NSString *apiStatus;
@property (copy, nonatomic) NSString *apiMessage;
@property (copy, nonatomic) NSString *homeHintMsg;
@property (copy, nonatomic) NSString *searchHintMsg;
@property (strong, nonatomic) NSArray *searchWords;

@end

@interface hotKeyword : BaseModel

@property (copy, nonatomic) NSString *word;
@property (copy, nonatomic) NSString *des;
@property (copy, nonatomic) NSString *isShow;

@end


@interface MicroMallSearchProArrayVo : BaseAPIModel

@property (strong, nonatomic) NSArray *products;//搜索结果

@end

@interface MicroMallSearchProVo : BaseModel

@property (copy, nonatomic) NSString *proId;    //商品编码
@property (copy, nonatomic) NSString *proName;  //商品名称
@property (copy, nonatomic) NSString *imgUrl;   //商品图片地址
@property (copy, nonatomic) NSString *content;  //商品需要展示的说明内容
@property (copy, nonatomic) NSString *showPrice;//商品名称
@property (copy, nonatomic) NSString *spec;     //商品规格
@property (strong, nonatomic) NSString *branchProId;//门店商品id。仅店内搜索时才有值

@end

@interface HotkeyListVo : BaseAPIModel
@property (strong, nonatomic)NSArray *keys;//热门搜索词
@end


@interface HotKeyVo : BaseModel
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *description;
@property (assign, nonatomic) BOOL show;
@end

@interface PostSearchListVo : BaseAPIModel
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic)NSArray *posts;
@end

@interface PostSearchVo : BaseModel
@property (strong, nonatomic) NSString *postId ;//(java.lang.String, optional): 帖子ID,
@property (strong, nonatomic) NSString *postTitle ;//(java.lang.String, optional): 帖子标题,
@property (strong, nonatomic) NSString *postContent;// (java.lang.String, optional): 帖子内容概述,
@property (strong, nonatomic) NSString *posterType;// (int, optional): 发帖人类型(1:普通用户, 2:马甲, 3:药师, 4:营养师),
@property (strong, nonatomic) NSString *postStrDate;// (java.lang.String, optional): 发帖时间,
@property (strong, nonatomic) NSString *headUrl ;//(java.lang.String, optional): 头像,
@property (strong, nonatomic) NSString *nickname;// (java.lang.String, optional): 昵称,
@property (strong, nonatomic) NSString *mbrLvl ;//(int, optional): 用户等级,
@property (strong, nonatomic) NSString *brandName;// (java.lang.String, optional): 专家品牌名称,
@property (strong, nonatomic) NSString *readCount ;//(int, optional): 阅读数,
@property (strong, nonatomic) NSString *replyCount ;//(int, optional): 回复数,
@property (strong, nonatomic) NSString *upVoteCount ;//(int, optional): 点赞数,
@property (strong, nonatomic) NSString *collectCount ;//(int, optional): 收藏数,
@property (strong, nonatomic) NSString *shareCount;// (int, optional): 分享数,
@property (strong, nonatomic)NSArray *imgUrls;// (java.util.List[string], optional): 帖子图片集合
@property (assign, nonatomic)BOOL flagAnon;//是否匿名
@end