//
//  ConfigInfoModel.h
//  APP
//
//  Created by garfield on 15/8/24.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseAPIModel.h"
@class ConfigInfoVoModel;
@class TemplatePosVoModel;

@interface ConfigInfoModel : BaseAPIModel
@property (nonatomic, strong)   NSString *uId;
@property (nonatomic, strong)   NSString *title;
@property (nonatomic, strong)   NSString *type;
@property (nonatomic, strong)   NSString *imgUrl;
@property (nonatomic, strong)   NSString *content;
@property (nonatomic, strong)   NSString *iconPos;
@property (nonatomic, strong)   NSString *duration;
@property (nonatomic, strong)   NSString *branchId;
@property (nonatomic, strong)   NSString *groupId;
@property (nonatomic, strong)   NSString *proId;
@end

@interface HomePageEleVoModel : BaseAPIModel

@property (nonatomic, strong)   ConfigInfoModel     *circular;              //通告栏数据Model
@property (nonatomic, strong)   ConfigInfoModel     *start;                 //启动页Model
@property (nonatomic, strong)   NSArray             *couponCover;           //运营点数据,里面每个都是 ConfigInfoModel
@property (nonatomic, strong)   ConfigInfoModel     *refreshPattern;        //下拉刷新的背景图片
@property (nonatomic, strong)   NSArray             *icons;
@end

@interface ConfigInfoListVoModel : BaseAPIModel

@property (nonatomic, strong) NSArray<ConfigInfoVoModel *>               *configInfos;

@end

@interface ConfigInfoVoModel : BaseAPIModel

@property (nonatomic, strong)   NSString *uId;
@property (nonatomic, strong)   NSString *title;
@property (nonatomic, strong)   NSString *type;
@property (nonatomic, strong)   NSString *imgUrl;
@property (nonatomic, strong)   NSString *placeHolderImage;
@property (nonatomic, strong)   NSString *content;
@property (nonatomic, strong)   NSString *iconPos;
@property (nonatomic, assign)   NSInteger Pos;
@property (nonatomic, strong)   NSString *duration;
@property (nonatomic, strong)   NSString *branchId;
@property (nonatomic, strong)   NSString *groupId;
@property (nonatomic, strong)   NSString *proId;
@property (nonatomic, assign)   NSInteger configIndex;

@end

@interface TemplateListVoModel : BaseAPIModel

@property (nonatomic, assign)   NSInteger templateCounts;
@property (nonatomic, strong)   NSArray   *templates;

@end

@interface TemplateVoModel : BaseAPIModel

@property (nonatomic, strong)   NSString *type;
@property (nonatomic, assign)   NSInteger posUsed;
@property (nonatomic, strong)   NSArray<TemplatePosVoModel *> *pos;

@end


@interface TemplatePosVoModel : BaseModel

@property (nonatomic, strong)   NSString *imgUrl;
@property (nonatomic, strong)   NSString *placeHolder;
@property (nonatomic, strong)   NSString *forwordUrl;
@property (nonatomic, strong)   NSString *title;
@property (nonatomic, strong)   NSString *objId;
@property (nonatomic, assign)   NSInteger cls; //1.慢病，2.专题列表，3.专区，4.某个专题详情,
@property (nonatomic, assign)   BOOL special;   //是否特刊
@property (nonatomic, assign)   NSInteger *seq;
@property (nonatomic, strong)   NSString *flagShare;   // 是否可以分享

@end



@interface ForumAreaInfoListModel : BaseAPIModel

@property (nonatomic, strong) NSArray       *list;

@end

@interface ForumAreaInfoModel : BaseAPIModel

@property (nonatomic, strong)   NSString *type;
@property (nonatomic, strong)   NSString *posFirst_imgUrl;
@property (nonatomic, strong)   NSString *posFirst_ContentUrl;
@property (nonatomic, strong)   NSString *posTwo_imgUrl;
@property (nonatomic, strong)   NSString *posTwo_ContentUrl;
@property (nonatomic, strong)   NSString *posThree_imgUrl;

@property (nonatomic, strong)   NSString *posThree_ContentUrl;
@property (nonatomic, strong)   NSString *posFour_imgUrl;
@property (nonatomic, strong)   NSString *posFour_ContentUrl;

@property (nonatomic, strong)   NSString *cls;      // 1. 慢病 2. 专题列表 3. 专区 4. 某个专题详情
@property (nonatomic, strong)   NSString *isSpecial;    // N 普通样式  Y 特刊样式

@property (nonatomic, strong)   NSString *posFirst_Cls;      // 1. 慢病 2. 专题列表 3. 专区 4. 某个专题详情
@property (nonatomic, strong)   NSString *posFirst_IsSpecial;    // N 普通样式  Y 特刊样式
@property (nonatomic, strong)   NSString *posFour_Cls;      // 1. 慢病 2. 专题列表 3. 专区 4. 某个专题详情
@property (nonatomic, strong)   NSString *posFour_IsSpecial;    // N 普通样式  Y 特刊样式
@property (nonatomic, strong)   NSString *posThree_Cls;      // 1. 慢病 2. 专题列表 3. 专区 4. 某个专题详情
@property (nonatomic, strong)   NSString *posThree_IsSpecial;    // N 普通样式  Y 特刊样式
@property (nonatomic, strong)   NSString *posTwo_Cls;      // 1. 慢病 2. 专题列表 3. 专区 4. 某个专题详情
@property (nonatomic, strong)   NSString *posTwo_IsSpecial;    // N 普通样式  Y 特刊样式

@property (nonatomic, strong)   NSString *posFirst_Title;
@property (nonatomic, strong)   NSString *posFour_Title;
@property (nonatomic, strong)   NSString *posThree_Title;
@property (nonatomic, strong)   NSString *posTwo_Title;

@end


@interface BannerInfoListModel : BaseAPIModel

@property (nonatomic, strong) NSArray       *list;

@end

@interface BannerInfoModel : BaseAPIModel

@property (nonatomic, strong) NSString       *type;     //（1:外链 2:优惠活动 3:咨询 4:品牌展示 5:门店 6:专题 7:优惠券 8:商品 9:常规）,
@property (nonatomic, strong) NSString       *name;    
@property (nonatomic, strong) NSString       *imgUrl;
@property (nonatomic, strong) NSString       *content;  //链接地址/优惠活动id/优惠券id/优惠商品的优惠id,
@property (nonatomic, strong) NSString       *branchId; //门店id（只有type为2的时候用到）
@property (nonatomic, strong) NSString       *groupId;      //商家id（只有type为7的时候用到）,
@property (nonatomic, strong) NSString       *proId;        //商品id（只有type为8的时候用到）
@property (strong, nonatomic) NSString           *flagShare;    //是否可分享（Y/N）

@end

//渠道
@interface ChannerTypeModel : BaseAPIModel

@property (nonatomic, strong) NSString       *objId;
@property (nonatomic, strong) NSString       *objRemark;
@property (nonatomic, strong) NSString       *cKey;

@end

@interface OpTemplateVOListModel : BaseAPIModel

@property (nonatomic, strong) NSArray   *list;

@end


@interface OpTemplateVOModel : BaseAPIModel

@property (nonatomic, assign) NSInteger       pos;
@property (nonatomic, assign) NSInteger       style;
@property (nonatomic, strong) NSString        *desc;
@property (nonatomic, strong) NSArray         *opTemplatePosVOs;

@end

@interface OpTemplatePosVOModel : BaseAPIModel

@property (nonatomic, assign) NSInteger       type;
@property (nonatomic, assign) NSInteger       seq;
@property (nonatomic, strong) NSString        *title;
@property (nonatomic, strong) NSString        *imgUrl;
@property (nonatomic, strong) NSString        *url;
@property (nonatomic, strong) NSString        *flagShare;
@property (nonatomic, strong) NSString        *objId;

@end







