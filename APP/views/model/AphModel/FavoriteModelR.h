//
//  FavoriteModelR.h
//  APP
//
//  Created by chenzhipeng on 3/9/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "BaseModel.h"

@interface FavoriteModelR : BaseModel

@property (nonatomic, strong) NSString *lng;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *currPage;
@property (nonatomic, strong) NSString *page;
@property (nonatomic, strong) NSString *pageSize;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;

@end

@interface FavoriteCollectR : BaseModel

@property (nonatomic,strong)NSString *token;
@property (nonatomic,strong)NSString *objId;
@property (nonatomic,strong)NSString *objType;
//对象类型：1.商品, 2.消息(用药指导收藏信息), 3.疾病, 4.保留, 5.健康资讯, 6.症状, 7.药店, 8.优惠活动, 9.专题/特刊, 10.帖子
@property (nonatomic,strong)NSString *method;

@end

@interface AdviceFavoriteCollectR : BaseModel
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *adviceId;
@end
@interface FavRequestModelR : BaseModel
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *currPage;
@property (nonatomic, strong) NSString *pageSize;
@end
//删除收藏
@interface DelCollectionR : BaseModel
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *objID;
@property (nonatomic,strong) NSString *objType;
@end