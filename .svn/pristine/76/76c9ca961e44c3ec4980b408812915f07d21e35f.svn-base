//
//  ActivityModel.h
//  APP
//
//  Created by Meng on 15/3/19.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseAPIModel.h"

@interface ActivityModel : BaseAPIModel

@end


@interface ActivityBodyModel : BaseAPIModel

@property(strong,nonatomic)NSString *page;
@property(strong,nonatomic)NSString *pageSize;
@property(strong,nonatomic)NSString *pageSum;
@property(strong,nonatomic)NSString *totalRecords;
@property(strong,nonatomic)NSArray  *list;

@end

//药房详情活动轮播
//add by lijian 2.2.0
@interface BranchActivityModel : BaseAPIModel

@property(strong,nonatomic) NSArray *list;

@end

//add by lijian 2.2.0
@interface BranchActivityVo : BaseAPIModel

@property(strong,nonatomic)NSString *activityId;
@property(strong,nonatomic)NSString *actityType;
@property(strong,nonatomic)NSString *title;
@property(strong,nonatomic)NSString *sortTime;

@end

@interface GrabProductListVoModel : BaseAPIModel

@property(strong,nonatomic)NSArray *productList;

@end

@interface GrabActivityVoModel : BaseAPIModel

@property(strong,nonatomic)NSString *activityId;
@property(strong,nonatomic)NSString *activityStartTime;
@property(strong,nonatomic)NSString *activityEndTime;
@property(strong,nonatomic)NSString *timestamp;
@property(strong,nonatomic)NSArray  *promotionProducts;
@property(nonatomic,assign ) NSInteger activityStatus;

@end

@interface ChannelActivityArrayVoModel : BaseAPIModel

@property(strong,nonatomic)NSArray  *channelList;

@end

@interface ChannelActivityVOModel : BaseAPIModel

@property(strong,nonatomic)NSString *channelId;
@property(strong,nonatomic)NSString *title;
@property(strong,nonatomic)NSString *desc;
@property(strong,nonatomic)NSString *imgUrl;

@end



@interface GrabPromotionProductVoModel : BaseAPIModel

@property(strong,nonatomic)NSString *proId;
@property(strong,nonatomic)NSString *promotionId;
@property(strong,nonatomic)NSString *imgUrl;
@property(strong,nonatomic)NSString *proName;
@property(strong,nonatomic)NSString *proDiscountPrice;
@property(strong,nonatomic)NSString *proCostPrice;
@property(strong,nonatomic)NSString  *spec;
@property(assign,nonatomic)NSInteger totalNum;
@property(assign,nonatomic)NSInteger currentNum;
@property(assign,nonatomic)NSInteger status;
@property(assign,nonatomic)NSInteger activityStatus;


@end



@interface ActivityDataModel : BaseAPIModel

@property(strong,nonatomic)NSString *activityId;
@property(strong,nonatomic)NSString *groupId;
@property(strong,nonatomic)NSString *title;
@property(strong,nonatomic)NSString *imgUrl;
@property(strong,nonatomic)NSString *content;
@property(strong,nonatomic)NSString *publishTime;
@property(strong,nonatomic)NSArray  *imgs;
@property(strong,nonatomic)NSString *source;
@property(strong,nonatomic)NSString *startDate;
@property(strong,nonatomic)NSString *endDate;
@property(strong,nonatomic)NSString *deleted;
@property(strong,nonatomic)NSString *expired;
@property(strong,nonatomic)UIImage  *imageSrc;
@property(strong,nonatomic)NSString *createTime;

@end


@interface ActivityImgsModel : BaseModel

@property(strong,nonatomic)NSString  *normalImg;
@property(strong,nonatomic)NSString  *sort;

@end

@interface BranchPromotionListModel : BaseAPIModel

@property(strong,nonatomic)NSString *page;
@property(strong,nonatomic)NSString *pageSize;
@property(strong,nonatomic)NSString *pageSum;
@property(strong,nonatomic)NSString *totalRecords;
@property(strong,nonatomic)NSArray  *list;

@end

@interface BranchPromotionModel : BaseAPIModel

@property (nonatomic ,strong) NSString *desc;
@property (nonatomic ,strong) NSString *id;
@property (nonatomic ,strong) NSString *imgUrl;
@property (nonatomic ,strong) NSString *status;
@property (nonatomic ,strong) NSString *title;
@property (nonatomic ,strong) NSString *pushStatus;

@end
@interface GrabPromotionProductVo : BaseModel
@property (nonatomic, strong) NSString *proId;              //商品Id
@property (nonatomic, strong) NSString *promotionId;         //优惠Id
@property (nonatomic, strong) NSString *imgUrl;             //商品图片
@property (nonatomic, strong) NSString *proName;            //商品名称
@property (nonatomic, strong) NSString *proDiscountPrice;   //商品原价
@property (nonatomic, strong) NSString *proCostPrice;       //商品折扣价
@property (nonatomic, strong) NSString *spec;               //商品规格
@property (nonatomic, strong) NSString *totalNum;           //优惠商品总数
@property (nonatomic, strong) NSString *currentNum;         //已抢商品数量
@property (nonatomic, strong) NSString *status;             //抢购状态：0:未抢购；1：已抢购
//@property (nonatomic, strong) NSString *activityStatus;     //抢购活动状态：0:抢购未开始；1:抢购未开始；3：抢购结束
//@property (nonatomic, strong) NSString *activityId;         //抢购活动状态：抢购活动Id
@end
@interface GrabProductListVo : BaseAPIModel
@property (nonatomic, strong) NSString *activityStatus;     //抢购活动状态：0:抢购未开始；1:抢购未开始；3：抢购结束
@property (nonatomic, strong) NSString *activityId;         //抢购活动状态：抢购活动Id
@property (nonatomic, strong) NSArray *productList;  //抢购商品列表
@end

@interface PurchaseGrabProduct : BaseModel
@property (nonatomic,strong) NSString *apiStatus;
@property (nonatomic,strong) NSString *apiMessage;
@property (nonatomic,strong) NSString *proDrugId;
@end

@interface ChannelProductArrayVo : BaseAPIModel
@property (nonatomic,assign) NSInteger page;        //当前页码
@property (nonatomic,assign) NSInteger pageSize;    //页面大小
@property (nonatomic,strong) NSArray *productList;  //频道优惠商品列表
@end

@interface ChannelProductVo : BaseAPIModel

@property (nonatomic, assign) BOOL spellFlag;
@property (nonatomic,strong) NSString *proId;           //商品ID
@property (nonatomic,strong) NSString *proName;         //商品名称
//@property (nonatomic,strong) NSString *pid;             //商品促销ID
//@property (nonatomic,strong) NSString *label;           //促销标签
@property (nonatomic,strong) NSString *spec;            //规格
//@property (nonatomic,strong) NSString *signCode;        //显示控制码
@property (nonatomic,strong) NSString *factoryName;     //厂家名称
@property (nonatomic,strong) NSString *imgUrl;          //图片地址
//@property (nonatomic,strong) NSString *source;          //来源（1:全维 2:商户）
//@property (nonatomic,strong) NSString *beginDate;       //有效期起始日期
//@property (nonatomic,strong) NSString *endDate;         //有效期结束日期
@property (nonatomic,assign) BOOL multiPromotion;       //是否参与多个活动
@property (nonatomic,strong) NSArray *promotionList;    //该商品参加的活动列表


@property(nonatomic)BOOL isSelect;//是否展开
@end

@interface ActivityCategoryVo : BaseModel
@property (nonatomic,strong) NSString *pid;    //促销活动的ID
@property (nonatomic,strong) NSString *activityType;    //活动类型：1 增；2 折；3 抵；4 特
@property (nonatomic,strong) NSString *actvityName;    //活动名称 
@end

@interface LuckdrawAwardListVo : BaseAPIModel
@property (nonatomic,assign) NSInteger unreadCounts;
@property (nonatomic,assign) NSInteger awardCounts;
@property (nonatomic,strong) NSArray *awards;
@property (nonatomic,strong) NSArray *used;
@property (nonatomic,strong) NSArray *overdue;
@property (nonatomic,strong) NSArray *grant;
@end

@interface LuckdrWonAwardVo : BaseModel
@property (nonatomic,strong) NSString *status;//0 正常1 已使用2 已过期 3 已发放
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *desc;
@property (nonatomic,strong) NSString *actTitle;//奖品所属活动标题,
@property (nonatomic,strong) NSString *actType;// 奖品所属活动类别：（1:大转盘, 2:翻牌, 3:摇一摇, 4:刮刮乐）,
@property (nonatomic,strong) NSString *date;
@property (nonatomic,assign) NSInteger objType;         //奖励对象类型（1:优惠券, 2:优惠商品, 3:实物, 4:谢谢参与,5:虚拟,6:积分
@property (nonatomic,strong) NSString *objId;           //奖品ID
@property (nonatomic,strong) NSString *pickedObjId;     //奖品领取ID
@property (nonatomic,strong) NSString *remark;     //奖品领取ID
@property (nonatomic,strong) NSString *chargeNo;// 【虚拟专用】充值号码,
@property (nonatomic,assign) BOOL chargeNoEmpty;//【虚拟专用】是否填写手机号码,
@property (nonatomic,strong) NSString *postNick; //【实物专用】收货人名称,
@property (nonatomic,strong) NSString *postAddr; //【实物专用】收货人地址,
@property (nonatomic,strong) NSString *postMobile; //【实物专用】收货人号码,
@property (nonatomic,assign) BOOL postAddrEmpty;//【实物专用】是否填写收货地址
@end
//3.0微商开通情况下的抢购
@interface GrabActivityRushVo : BaseAPIModel
@property (nonatomic,strong) NSString *activityId;
@property (nonatomic,strong) NSNumber *begin;//活动开始时间,
@property (nonatomic,strong) NSNumber * end;  //活动结束时间,
@property (nonatomic,strong) NSNumber * timestamp; //当前服务器时间,
@property (nonatomic,strong) NSString * activityStatus;  //抢购活动状态：1:抢购未开始；2:抢购已开始；3：抢购结束,
@property (nonatomic,strong) NSArray * productList;  //抢购商品列表
@end

@interface RushProductVo : BaseModel
@property (nonatomic,strong)NSString* proId; // 商品编码,
@property (nonatomic,strong)NSString* imgUrl; // 商品图片,

@property (nonatomic,strong)NSString* proName; // 商品名称,
@property (nonatomic,strong)NSString* spec; // 商品规格,
@property (nonatomic,strong)NSString* totalNum; // 优惠商品总数,
@property (nonatomic,strong)NSString* currentNum; // 已抢商品数量,
@property (nonatomic,strong)NSString* proDiscountPrice; // 商品折扣价,
@property (nonatomic,strong)NSString* proCostPrice;// 商品原价,
@property (nonatomic,assign)BOOL grab; //是否已抢购
@end