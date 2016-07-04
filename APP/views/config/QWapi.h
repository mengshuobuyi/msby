/*!
 @header QWapi.h
 @abstract 所有接口地址及相关常量
 @author .
 @version 1.00 2015/01/01  (1.00)
*/
#ifndef QW_APP_API_h
#define QW_APP_API_h

//接口的总结

/**
 *  -------------------------------cj-------------------------------
 */

#define GetHealthPrograms                   @"api/health/healthPrograms"//健康指标的列表

#define GetFactoryList                      @"api/factory/queryFactoryList"//品牌厂家的列表
#define GetFactoryDetail                    @"api/factory/queryFactoryDetail"//厂家的详情
#define GetFactoryProductList               @"api/factory/queryFactoryProductList"          //厂家商品列表

#define GetRecommendClass                   @"api/drug/queryRecommendClass"// 查询常备药品推荐分类
#define GetRecommendKnowledge               @"api/drug/queryRecommendKnowledge"// 根据分类查找健康知识
#define GetRecommendProductByClass          @"api/drug/queryRecommendProductByClass"// 根据推荐商品分类的ID，查找相应的商品(5556)

#define GetProductCollects                  @"api/favorite/productCollects" //收藏的商品列表
#define GetSpmCollects                      @"api/favorite/spmCollects" //收藏的症状列表
#define GetStoreCollects                    @"api/favorite/storeCollects" //关注的药店
#define GetDiseaseCollects                  @"api/favorite/diseaseCollects"// 收藏的疾病列表
#define GetAdviceCollects                   @"api/favorite/adviceCollects"//收藏的资讯
#define GetCoupnCollects                    @"api/favorite/promotionCollects"//收藏的优惠活动

//add by lijian 2.2.0
#define BranchActivities                       @"api/branch/activities" //根据门店获取营销活动列表

#define GetActivities                       @"api/activity/activities" //根据门店获取营销活动列表
#define GetActivityInfo                     @"api/activity/getActivity"// 营销活动详情
#define GetActivityFromBanner               @"api/activity/getBannerActivity"// 营销活动详情(从Banner进入)
#define GetActivityInfoFromBanner           @"api/214/activity/getActivity"// 营销活动详情(从Banner进入)

#define GetAppraise                         @"h5/branch/appraise/byCustomer"    //药店评价列表

#define AppraiseByConsult                   @"api/appraise/byConsult"    //药店评价列表

#define PostComplaintById                   @"api/mbr/complaint/complaintById"// 投诉指定ID的药店
#define GetQueryTypes                       @"api/mbr/complaint/queryTypes"// 查询所有的举报类型


#define QueryProductFirst                @"api/drug/queryProductClass"    //商品一级分类查询  app/drug/queryProductClass
#define QueryProductSecond               @"api/drug/querySecondProductClass"     //查询二级商品分类 (2.0接口)
#define QueryProductByClass              @"api/drug/queryProductByClass"//      //根据classId获取药品列表app/drug/queryProductByClass(5556)
#define FetchProFactoryByClass           @"api/drug/fetchProFactoryByClass" //根据商品获取生产厂家app/drug/fetchProFactoryByClass
#define QueryProductDetail               @"api/drug/queryProductDetail"   //3.3.20	商品明细(OK)

#define Collect                          @"api/favorite/collect"                         //添加取消收藏
//add by lijian 2.2.0
#define SearchHotKeyWord                    @"api/configInfo/searchWord"    //运营点 搜索词
#define SearchOpenCity                      @"api/branch/search/opencity"    //运营点 搜索词
#define ConfigInfoQuery                     @"api/configInfo/query"         //运营点 首页各项内容
#define ConfigInfoQueryBanner               @"api/configInfo/queryBanner"   //运营点 banner

#define ConfigInfoQueryHomePageBanner       @"h5/configInfo/queryIndexBanner"   //首页banner
#define ConfigInfoQueryForumArea            @"api/configInfo/queryForumArea"//运营点 专题，专区列表,如果为专区 只取 第一号位
#define ConfigInfoQueryOpTemplates          @"h5/configInfo/queryIndexTemplate"         //3.0.0运营点 首页各项内容

#define OpencityCheckNew                    @"api/branch/search/opencity/check_new"

#define QueryConfigInfos                    @"api/configInfo/queryConfigInfos"
#define QueryTemplete                       @"api/configInfo/queryTemplete"

#define OrderBaseComment                    @"api/order/base/comment"

#define SearchByKeyWord                     @"api/search/keyword"


#define GetSearchKeywords                @"api/drug/getSearchKeywords"  //搜索关键字联想(OK)  app/drug/getSearchKeywords
#define QueryDiseaseBykwid               @"api/disease/byKwId"
#define QuerySpmByKwId                   @"api/spm/byKwId"      //3.3.44	根据关键字ID获取症状列表
#define QueryProductByKwId               @"api/drug/queryProductByKwId"   //根据关键字ID获取商品列表    app/drug/queryProductByKwId(8)



#define Disease_diseaseClass             @"api/disease/diseaseClass"                //查询疾病类别
#define Disease_diseaseAll               @"api/disease/all"                         //疾病百科 新接口
#define Disease_diseaseDetailIOS         @"api/disease/detail4Ios"                  //疾病详情

#define QW_queryDiseaseFormulaProductList   @"api/drug/queryDiseaseFormulaProductList"      //疾病组方配方用药查询(OK)(5556)
#define Disease_queryDiseaseProductList     @"api/drug/queryDiseaseProductList"        //3个的治疗用药等等(5556)


#define QuerySpmBody                      @"api/spm/spmBody"                       //部位查询(toubu) 症状关键字查询
#define NW_querySpmInfoListByBody         @"api/spm/byBody"                        //部位下关联症状查询
#define NW_querySpmInfoList               @"api/spm/list"                           //获取所有症状列表（症状百科）


//215


#define PostBuildPromotion              @"api/215/promotion/buildPromotion"//生成验证码
#define GetCheck                        @"api/215/promotion/check"//用户端检测是否完成订单

#define ConsultDoctor                   @"api/consult/create?v=2.1"//客户群发问题
#define ConsultSPDoctor                 @"api/consult/sp/create"//客户群发问题




#define GetSlowPromotionQuery                  @"api/promotion/query/slowPromotion"//慢病优惠活动列表

#define NewGetSlowPromotionQuery                  @"api/promotion/query/newSlowPromotion"//慢病优惠活动列表


#define Promotion2qrcode                @"api/promotion/2qrcode" //立即享受优惠活动 fixed by lijian


//附近药房 add by lijian
#define BranchLbs                       @"h5/branch/lbs" //fixed by lijian at 3.0(全部药房)
#define BranchPromotionLbs              @"api/branch/promotion/lbs"

#define BranchSearchPromotion           @"api/branch/search/promotion"          //查询当前有优惠活动的门店

#define CouponBranchSuitable            @"api/coupon/branch/suitable"
//2.2.0 获取我的优惠券详情
#define CouponGetMyCoupon               @"api/coupon/getMyCoupon"

#define CouponGetOnlineCoupon           @"api/coupon/getOnlineCoupon"
#define CouponProductSuitable           @"api/coupon/product/suitable"
#define CouponAssess                    @"api/coupon/assess"
#define CouponAssessQuery               @"api/coupon/assess/query"
#define CouponBranchBuy                 @"api/coupon/branch/buy"
#define CouponCheck                     @"api/coupon/check"
#define CouponPick                      @"api/coupon/pick"
#define CouponPickByMobile              @"api/coupon/pickByMobile"
#define CouponProductBuy                @"api/coupon/product/buy"
#define CouponCondition                 @"api/coupon/condidions"
#define CouponQueryOnlineByCustomer     @"api/coupon/queryOnlineByCustomer"
#define CouponQueryOverdueByCustomer    @"api/coupon/queryOverdueByCustomer"
#define CouponOrderCheck                @"api/coupon/order/loopcheck"

#define CouponQueryUnusedByCustomer     @"api/coupon/queryUnusedByCustomer"
#define CouponQueryUsedByCustomer       @"api/coupon/queryUsedByCustomer"
#define CouponUse                       @"api/coupon/use"
#define CouponShow                      @"api/coupon/show"

//add by lijian 2.2.0
#define ConsultDetailCouponQuan         @"api/branch/coupons"
#define MallBranchDetailCouponQuan      @"h5/coupon/byBranch4New"//add by lijian at V3.1.1
#define ConsultDetailCouponDrug         @"api/branch/promotion/products"
#define ActivityDetail                  @"api/package/activity/detail"
#define ActivityDetailPromotion         @"api/package/activity/products"

//我的优惠券模块 add by lijian 2.2.0
#define CouponQuanPicked              @"api/coupon/queryUnusedByCustomer"
#define CouponQuanUsed                @"api/coupon/queryUsedByCustomer"
#define CouponQuanDated               @"api/coupon/queryOverdueByCustomer"
#define CouponDrug                    @"api/activity/promotion/my/drug"
#define CouponDrugDetail              @"api/activity/promotion/my/drugDetail"
#define DrugBranch                      @"api/activity/promotion/drug/branch"

#define SuitableProducts              @"api/coupon/product/suitable"
#define RemoveByCusomer               @"api/coupon/removeByCustomer"
#define DeleteDrug                    @"api/activity/promotion/my/deleteDrug"

//附近优惠活动商品 add by lijian 2.2.0
#define NearByPromotion              @"api/activity/promotion/drug/nearby"

//附近优惠Tag add by lijian 2.2.0
#define CityTag                      @"api/activity/promotion/drug/tagByCity"
//附近优惠药房Tag add by lijian 2.2.0
#define GroupTag                      @"api/activity/promotion/drug/filterGroup"

#define PromotionDrugBranch         @"api/activity/promotion/drug/branch"
#define PromotionDrugGroup          @"api/activity/promotion/drug/group"
#define PickPromotionDrug           @"api/activity/promotion/drug/pick"
#define CreateVerifyCode            @"api/order/activity/create"
#define BaseLoopCheck               @"api/order/base/loopCheck"
#define GetMyComment                @"api/order/base/mycomment"
#define Comment                     @"api/order/base/comment"


//2.2.3的接口
#define GetNearbyWithSearch        @"api/activity/promotionProduct/nearbyWithSearch"//优惠商品列表和搜索
#define SystemShort                @"api/system/short"                                //转换短链接
#define activityPurch              @"api/activity/channelProductDetail"              //活动列表
#define storeProduct               @"api/act/product/byBranch"                      //药房详情下面的优惠商品
#define QueryWonAwards             @"api/act/luckdraw/queryWonAwards"               //中奖纪录
#define CouponByBranch4New          @"h5/coupon/byBranch4New"//药房优惠券列表

#define CouponQueryNewOnlineByCustomer  @"api/act/coupon/queryOnlineByCustomer"//领券中心的列表
#define CouponInCity                    @"h5/coupon/inCity"

#define Coupon223BranchSuitable         @"api/coupon/223/branch/suitable"//新的适用药房
#define Coupon300BranchSuitableForMy    @"h5/coupon/querySuitableBranchs"//fixed by lijian at V3.2.0
#define Coupon300BranchSuitable         @"h5/coupon/querySuitableBranchsInCity"//fixed by lijian at V3.2.0

#define CouponNewGetOnlineCoupon        @"api/act/coupon/getCoupon"//优惠券的详情

//2.2.4 add by lijian
#define CouponFilterGroup        @"api/act/coupon/filterGroup"//领券中心药房筛选条件
#define AnalystByType            @"api/familyMedicine/analystByType"
#define AnalystByMember          @"api/familyMedicine/analystByMember"

//域名解析
#define GetDomianIs                              @"api/system/checkDomainBlocked"//检查域名是否被封
#define GetNewDomain                             @"api/system/getReserveDomains"//获取新的域名
#define AppLogFlag                 @"api/system/appLogFlag"
#define AppUploadLog               @"api/system/appUploadLog"

//-------------------------add by lijian at V3.0--------------------------
//#define SuitableBranch      @"h5/coupon/querySuitableBranchs"//优惠券领取成功页适用门店GET
#define CheckIOSAudit       @"h5/system/checkIOSAudit"


//购物车
#define MMallCart           @"h5/mmall/cart"
#define MMallCartCheck      @"h5/mmall/cart/check"
#define MMallCartNewCheck   @"h5/mmall/cart/new/check"
#define MMallCartNewSync    @"h5/mmall/cart/new/sync"
#define MMallCartSync       @"h5/mmall/cart/sync"
#define MMallCartPreview    @"h5/mmall/cart/preview"
#define MMallCartSubmit     @"h5/mmall/cart/submit"

#define MMallCartNewPreview    @"h5/mmall/cart/new/preview"
#define MMallCartNewSubmit     @"h5/mmall/cart/new/submit"
#define QueryBranchs        @"h5/mmall/act/queryBranchs"
#define GetOrderResult      @"h5/maicromall/order/getOrderResult"
#define MMallAdvice         @"h5/mmall/advice"

//支付
#define GetAliPayResult             @"h5/pay/getAliPayResult"
#define GetWXPayResult              @"h5/pay/getWXPayResult"

#define QueryProFoodTaboos          @"h5/product/queryProFoodTaboos"

//发现搜索：
#define FinderAssociate     @"api/discovery/searchAssociate"//搜索联想词
#define SearchDiscovery     @"api/discovery/searchDiscovery"//主列表
#define SearchDisease       @"api/discovery/searchDisease"  //疾病列表
#define SearchSymptom       @"api/discovery/searchSpm"      //症状列表
#define SearchProduct       @"api/discovery/searchProduct"  //商品列表
#define SearchProblem       @"api/discovery/searchProblem"  //问答列表

#pragma mark - 微商药房使用接口
#define QueryExpertByBranchId   @"h5/mbr/expert/queryExpertByBranchId"//门店下专家列表
#define QueryExpertHas          @"h5/mbr/expert/hasExperts"//门店下是否有专家
#define QueryBranchIndexNew     @"h5/branch/index/new"//微商药房详情首页数据
#define MallDrugIsSale          @"h5/mmall/isSale"//药品在门店是否有售
#define MallBranch              @"h5/mmall/branchs"                 //切换药房-附近药房Tab
#define FvoriteBranch           @"h5/mbr/favorite/queryMyBranchs"   //切换药房-我的药房Tab
#define ChainBranch             @"h5/mmall/chainBranchs"            //切换药房-连锁药房Tab

#define MallBranchSearch        @"h5/mmall/branchs/search"//药房搜索
#define ProductDetailByCode     @"h5/mmall/product/byCode"//编码搜索详情
#define ProductDetail           @"h5/mmall/product/byId"//店内药品详情
#define ComplaintBranch         @"api/complaint/complaint"//投诉药房
#define ComplaintReason         @"api/complaint/queryReasons"//投诉原因列表
#define OpenMicroMall           @"h5/branch/openMicroMallBranch"//微商药房详情
#define BranchNotice            @"h5/mmall/queryNotice"  //新店内药品的店内公告
#define BranchClassify          @"h5/mmall/queryClassify"  //新店内药品分类列表
#define BranchProductPackage    @"h5/mmall/queryDiscountPackage"  //新店内药品套餐分类商品(不分页)
#define BranchProductClassify   @"h5/mmall/queryProductByclassifyID"  //新店内药品分类列表(分页加载)

#define FavoriteCollect         @"h5/mbr/favorite/collect"//添加收藏药房
#define FavoriteCollectCancel   @"h5/mbr/favorite/collect/cancel"//取消收藏药房
#define FavoriteCollectCheck    @"h5/mbr/favorite/collect/check"//check药房是否已经被收藏


#pragma mark - 首页搜索使用接口
#define SearchAssociate         @"api/indexSearch/searchAssociate"  //搜索联想词
#define MallIndexSearchInCity   @"h5/indexSearch/mmall"             //首页搜索（城市）
#define MallIndexSearchInBranch @"h5/indexSearch/search/byName"     //首页搜索（药房）
#define SearchByBarCodeInBranch @"h5/indexSearch/search/byBarcode"  //扫码搜索

//用户行为的渠道
#define PostChannelMark        @"api/rpt/operate/channel/mark"
#define NewNearBranch          @"h5/mmall/product/onSaleBranchs"



//400版本的新接口
#define GetCouponCenterDetail        @"h5/coupon/getOnlineCoupon"//领券中心的优惠券的详情
#define GetCouponMyDetail            @"h5/coupon/getMyCoupon"//我的优惠券的详情
#define GetCouponDetailProduct       @"h5/coupon/product/suitableInBranch"//优惠券的适用商品
#define GetCouponDetailPharmcy       @"h5/coupon/querySuitableMshopBranchsInCity"//优惠券的适用药房
#define GetShowCode                  @"h5/coupon/showCode"//领券中心的生成code
#define GetStatisBranchArray         @"h5/group/queryTdGroupIds"//获取统计的商家的信息




/**
 *  -------------------------------cj----------------------------------------
 */
/**
 *  -------------------------------cp测试通过-------------------------------
 */
#define QueryProductByBarCode               @"api/drug/queryProductByBarCode"               //扫码获取商品信息    app/drug/queryProductByBarCode(555)
#define QW_GetProductUsage                  @"api/drug/getProductUsage"                     //获取药品的用法用量  app/drug/getProductUsage
//我的用药
#define QueryProductByKeyword               @"api/drug/queryProductByKeyword"       //app/drug/queryProductByKeyword(555)
/**
 *  --------------------------------cp-------------------------------------
 */


/**
 *  --------------------------------yyx测试通过-------------------------------------
 */

#define PromotionBanner                  @"api/promotion/banner"                  //首页 banner
#define QueryProblemModel                @"api/problem/module"                    //大家都在问首页 问题模块
#define QueryFamiliarQuestionChannel     @"api/problem/moduleClass"               //问题类型
#define QueryFamiliarQuestionList        @"api/problem/list"                      //常见用药问题列表
#define QueryFamiliarQuestionDetail      @"api/problem/detail"                    //问题详情
#define QueryCommendPersonPhone          @"api/mbr/inviter/check"                 //用户获取推荐人手机号
#define QueryCimmitPersonPhone           @"api/mbr/inviter"                       //更新推荐人手机号
#define QueryAssociationDisease          @"api/spm/associationDisease"            //症状关联的疾病
#define NW_spmInfoDetail                 @"api/spm/detailInfo"                    //症状明细
#define NW_submitFeedback                @"api/system/submitFeedback"             //添加反馈
#define SystemPushSet                    @"api/system/pushSet"                    //设置推送状态
#define MbrRecommendGetRecommendUrl      @"api/mbr/recommend/getRecommendUrl"     //获得分享的url
#define MbrRecommendShare                @"api/mbr/recommend/share"               //邀请好友的成功的回调
#define DrugGuidePushMsg                 @"api/drugGuide/pushMsg"                 //获取慢病指导信息，弹框提醒与小红点显示
#define DrugGuideReadDot                 @"api/drugGuide/readDot"                 //设置小红点已读
#define ProblemListByModule              @"api/problem/list/byModule"             //大家都在问列表 新街口

#define TeamGetMbrInfoListByTeamId       @"api/team/getMbrInfoListByTeamId"                 //查看圈主列表
#define TeamGetTeamDetailsInfo           @"api/team/getTeamDetailsInfo"                     //圈子详细信息
#define TeamGetPostListInfoByTeamId      @"api/team/getPostListInfoByTeamId"                //圈子详细信息 帖子列表
#define TeamApplyMasterInfo              @"api/team/applyMasterInfo"                        //申请做圈主
#define TeamAttentionTeam                @"api/team/attentionTeam"                          //关注圈子/取消关注圈子
#define TeamAttentionMbr                 @"api/team/attentionMbr"                           //关注用户／取消关注用户
#define TeamAllTeamList                  @"api/team/allTeamList"                            //圈子全部接口
#define TeamMyFansList                   @"api/team/myFansList"                             //我的粉丝
#define TeamMyAttnExpertList             @"api/team/myAttnExpertList"                       //我关注的专家
#define TeamMyAttnTeamList               @"api/team/myAttnTeamList"                         //我关注的圈子
#define TeamMyPostList                   @"api/team/myPostList"                             //我的发帖列表
#define TeamMyReplyList                  @"api/team/myReplyList"                            //我的回帖列表
#define TeamExpertInfo                   @"api/team/expertInfo"                             //专家 专栏信息
#define TeamHisPostList                  @"api/team/hisPostList"                            //Ta的发文列表
#define TeamHisReplyList                 @"api/team/hisReplyList"                           //Ta的回帖列表
#define TeamHisAttnTeamList              @"api/team/hisAttnTeamList"                        //Ta关注的圈子列表
#define TeamHisAttnExpertList            @"api/team/hisAttnExpertList"                      //Ta关注的专家列表
#define TeamUpdateMbrInfo                @"api/team/updateMbrInfo"                          //更新个人信息
#define TeamMyInfo                       @"api/team/myInfo"                                 //个人信息
#define TeamGetCollectionPost            @"api/team/getCollectionPost"                      //我收藏的帖子
#define H5CollectionCancelCollection     @"h5/collection/cancelCollection"                  //取消收藏帖子
#define TeamMessage                      @"api/team/message"                                //圈子消息列表
#define TeamQueryUnReadMessage           @"api/team/queryUnReadMessage"                     //轮询获取圈子消息
#define TeamDelPostInfo                  @"api/team/delPostInfo"                            //删除帖子
#define TeamDelReply                     @"api/team/delReply"                               //删除评论
#define TeamChangeMessageShowFlag        @"api/team/changeMessageShowFlag"                  //删除单条消息
#define TeamQueryZanListByObjId          @"api/team/queryZanListByObjId"                    //查看点赞列表
#define TeamChangeAllMessageReadFlag     @"api/team/changeAllMessageReadFlag"               //全部标记为已读
#define TeamPostReply                    @"api/team/postReply"                              //回复评论
#define TeamChangeMsgReadFlagByMsgClass  @"api/team/changeMsgReadFlagByMsgClass"            //分类标记已读
#define TeamUploadCertInfo               @"api/team/uploadCertInfo"                         //上传药师认证信息
#define TeamQueryAttnTeamExpert          @"h5/team/queryAttnTeamExpert"                     //入驻专家列表


/**
 *  --------------------------------yyx-------------------------------------
 */


/**
 *  --------------------------------lj-------------------------------------
 */
#define Banners                         @"api/banner"//首页Banner轮播接口 fixed by lijian
#define PromotionQueryBranch            @"api/promotion/query/branch"//查询指定优惠活动关联的药店列表 fixed by lijian
#define NW_uploadFile                   @"api/system/uploadFile"//文件上传 fixed by lijian
#define NW_uploadSpe                    @"api/system/upload/audio"//文件上传 fixed by xiezhenghong
#define NW_logout                       @"api/mbr/user/logout"                      //用户登出 fixed by lijian
#define NW_login                        @"api/mbr/user/login"                       //登录 fixed by lijian
#define NW_queryMemberDetail            @"api/mbr/member/queryMemberDetail"                //获取账号用户资料 fixed by lijian
#define UserInfoTag                     @"api/message/cornerMark"                //获取用户收藏等信息 add by lijian 2.2.0
#define NW_registerValid                @"api/mbr/user/registerValid"                    //用户注册校验 fixed by lijian
#define NW_register                     @"api/mbr/user/register"                         //用户注册 fixed by lijian
#define NW_sendVerifyCode               @"api/mbr/code/sendVerifyCode"                   //发送手机验证码 fixed by lijian
#define NW_changeMobile                 @"api/mbr/member/changeMobile"                     //更改手机 fixed by lijian
#define NW_resetPassword                @"api/mbr/user/resetPassword"                    //重置密码 fixed by lijian
#define NW_updatePassword               @"api/mbr/user/updatePassword"                   //修改密码 fixed by lijian
#define NW_saveMemberInfo               @"api/mbr/member/saveMemberInfo"                   //修改个人信息 fixed by lijian
#define FamilyNewTag                    @"api/familyMedicine/hasNew"                   //修改个人信息 add by lijian
#define FamilyHideNewTag                @"api/familyMedicine/into"
/**
 *  --------------------------------lj-------------------------------------
 */




/**
 *  --------------------------------czp-------------------------------------
 */

#define QueryHealthAdviceList        @"api/advice/list"    //健康咨询列表查询
#define NW_QueryHealthAdviceInfo     @"api/advice/detail"          //健康资讯详情
#define QueryHealthAdviceContent     @"api/advice/content"//@"app/healthinfo/getAdviceContent"
#define QueryChannelList             @"api/advice/channels" //@"app/healthinfo/queryChannelList"         //健康资讯栏目列表
#define QueryChannelBanner           @"api/advice/banners" //@"app/healthinfo/queryChannelBanner"       //根据栏目获取banner
#define NW_ReadAdvice                @"api/advice/read"               //阅读数加1
#define NW_PraiseAdvice              @"api/advice/praise"             //点赞
#define NW_CancelPraiseAdvice        @"api/advice/cancel/praise"       //取消点赞
#define CheckAdviceFavorite          @"api/advice/check"            //检查是否收藏
#define HealthAdviceSubject          @"api/advice/subject"          //健康资讯推荐模块

#define NW_shareAdvice               @"api/advice/share/plus"              //健康资讯分享
#define QueryAttentionList           @"api/drugGuide/attentions"       //慢病列表
#define SaveDrugGuideItem            @"api/drugGuide/save"        //收藏慢病订阅
#define DeleteMsgDrugGuide           @"api/drugGuide/delete"       //删除慢病订阅
#define QueryMsgLogList              @"api/drugGuide/msgLogs"          //慢病订阅消息列表页面

#define QueryDivisionAreas           @"api/division/queryAreas"         // 资讯页专区列表

#define LikeCountsPlus               @"api/favorite/likeCountsPlus"             //喜欢数+1
#define LikeCountsDecrease           @"api/favorite/likeCountsDecrease"         // 喜欢数-1
#define QueryNewDiseaseList          @"api/drugGuide/newmsg"            // 获取有新消息的慢病列表

#define QueryAdviceCount             @"api/advice/count"                // 健康咨询阅读数及点赞数

#define SearchRecommendStore              @"api/215/branch/search/recommend"         //获取优质药房
#define OfferName                    @"api/branch/search/offer/name"             // 根据省市区名称获取附近药房

//  need check by perry

#define NW_checkNewVersion           @"api/system/version"//@"api/system/getLastVersion"//读取服务器上最新版本数据
#define CheckLike                    @"app/favorite/checkLike"

#define ConsultCustomer              @"api/consult/217/customer"
#define ConsultCustomerNewDetail     @"api/consult/customer/newDetail"
#define ConsultCustomerAllRead       @"api/consult/detail/read/all"             //全部设置为已读
#define ConsultCustomerItemRead      @"api/consult/detail/read"                 //消息回执
#define ConsultSetUnreadNum          @"api/consult/setUnreadNum"
#define ConsultCustomerExpired       @"api/consult/217/customer/expired"
#define ConsultRemoveAllExpired      @"api/consult/217/customer/removeAllExpired"
#define ConsultRemoveExpired         @"api/consult/217/customer/removeExpired"
#define ConsultNoticeListByCustomer  @"api/message/getNoticeListByCustomer"
#define ConsultPollNoticeListByCustomer @"api/message/pollNoticeListByCustomer"

#define MsgBoxListCouponNotiList     @"api/message/coupon/query"
#define MsgBoxListPullCouponNotiList    @"api/message/coupon/poll"

#define MsgBoxIndexList             @"h5/notice/mbr/index"
#define MsgBoxNoticeMsgList         @"h5/notice/mbr/queryNormalNotices"
#define MsgBoxHealthMsgList         @"h5/notice/mbr/queryQwNotices"
#define MsgBoxRemoveByType          @"h5/notice/mbr/removeByType"
#define MsgBoxSetReadByType         @"h5/notice/mbr/clear"

// 订单通知
#define MsgBoxListOrderNotiList      @"api/message/order/query"
#define OrderNotiMsgRead                @"api/message/order/read"
#define OrderNotiRemoveItem         @"api/message/order/removeByCustomer"

#define MsgBoxListSysNotiList     @"api/message/sys/query"

#define P2PCustomerSessionGetALL     @"api/message/getListByCustomer"
#define P2PCustomerSessionPollNew    @"api/p2p/customer/session/poll"       // p2p 增量

#define ConsultMsgListSetAllReaded   @"api/message/clear"           // 设置全部为已读
#define CouponNotiMsgRead                @"api/message/read"            // 设置优惠通知已读
#define OperateSaveLog               @"api/rpt/operate/saveLog"        //用户行为

#define GetCouponCondition           @"h5/promotion/condition"         // 优惠细则

#define GetCouponPick                @"api/act/coupon/pick"             // 新的领取优惠

#define GetInviteInfo                   @"api/mbr/inviter/getInviteInfo"        //获取邀请好友信息

#define InfoQueryUserChannel                @"api/message/queryUserChannel"             // 获取用户已添加的频到
#define InfoQueryAllChannel             @"api/message/userNotAddChannel"            // 获取用户添加和未添加的频
#define InfoUpdateUserChannel           @"api/message/updateUserChannel"            // 用户修改频道
#define InfoGetMsgList                  @"api/message/msgList"                      // 获取咨询列表
#define InfoGetMyFav                    @"api/message/getCollection"                // 获取用户收藏的资讯
#define AllInfoCircleMsgList            @"h5/team/chat/message/getAll"              // 全量获取圈子消息
#define GetNewInfoCircleMsgList         @"h5/team/chat/message/getMessage"          // 增量获取圈子消息
#define RemoveInfoCircleMsg             @"h5/team/chat/session/del"                 // 删除会话列表
#define UpdateAllCircleMsgRead          @"h5/team/chat/session/updateAllRead"       // 标记全部的圈子消息为已读
#define PollCircleSessionList       @"h5/team/chat/session/getChatList"    // 增量圈子会话列表
#define AllCircleSessionList       @"h5/team/chat/session/getAll" // 全量会话列表  - CircleChatPointModel

/**
 *  --------------------------------czp-------------------------------------
 */


/**
 *  --------------------------------Meng-------------------------------------
 */


#define RptLocate                       @"api/rpt/locate"   //App定位统计
#define Disease_diseaseFormulaList       @"api/disease/formulaList"                 //根据分类查询疾病组方列表



#define Store_checkOpencity             @"api/branch/search/opencity/check"         //开通城市检查
#define Store_SearchRegionName              @"api/branch/search/region/name"                 //区域范围内搜索药店
#define Store_branchSearchLbs              @"api/215/branch/search/lbs"                 //区域范围内搜索药店

#define Store_getAreaCode               @"api/branch/info/getAreaCode"              //获取省市区的编码
#define Drug_getSellWellProducts       @"api/drug/sellWellProducts"        //畅销商品  --jxb 2.2

#define ConsultDetailCustomer           @"api/consult/getDetailByCustomer" //@"api/consult/217/detail/customer"              //客户：查看咨询问题详情
#define ConsultSpread                   @"api/consult/217/spread"              //二次扩散
#define ConsultDetailCustomerPoll       @"api/consult/217/detail/customer/poll"           //客户：轮询获取最新咨询问题详情
#define ConsultDetailRemove             @"api/consult/detail/remove"

#define StoreBranchPromotion             @"api/branch/info/branchPromotion" //查询药店详情时，查询该药店的优惠活动
/**
 *  --------------------------------Meng-------------------------------------
 */



/**
 *  --------------------------------xzh-------------------------------------
 */
#define DeleteIM                     @"api/im/remove"                           //删除聊天记录
#define SelectIM                     @"api/im"                           //查询IM聊天记录数目
#define SelectQWIM                   @"api/im/qw"                        //查询全维药事聊天记录
#define CheckCert                    @"api/branch/certifi/check"                       //推送设置 CheckCert
#define DelAllMessage                @"api/im/chatview/remove"                       //删除指定药店/客户的IM聊天记录
#define IMSetReceived                @"api/im/setReceived"                      //设置IM消息状态已接受IMSetReceived
//#define IMReadNum                    @"app/im/read"                             //查询全维药事聊天记录数目 IMReadNum

#define HeartBeat                        @"api/system/heartbeat"
#define AlternativeIMSelect              @"api/im/unreceived"
#define TokenValid                       @"api/mbr/user/tokenValid"                          //聊天时Token有效性验证
#define AppraiseExist                    @"api/appraise/exist"                              //检查会话是否评价过
#define NW_QueryBranhGroupByStoreAcc     @"api/branch/info/byStoreAccs"              //根据药店账号获取机构信息
#define AddAppraise                      @"api/appraise/add"  ////3.7.1	添加药店评价
#define SystemBackSet                    @"api/system/backSet"   //3.13.9	App是否后台状态设置

#define RptShareSaveLog                  @"api/rpt/share/saveLog"   //3.13.9	App是否后台状态设置

#define GrabHomePageActivity             @"api/grab/activity/activity"          //老版本抢购
#define H5ACTRUSH                        @"h5/act/rush"                         //3.0.0新版本抢购

#define ChannelHomeActivity              @"api/activity/channelHome"

#define ValidVerifyCode                  @"app/mbr/verifyAndChangePassword"
#define QueryMyBox                       @"api/box/list"                           //查询我的用药列表
#define QueryBoxByKeyword                @"api/box/byKeyword"                    //根据关键字查询我的用药
#define QueryBoxByTag                    @"api/box/byTag"                        //根据标签查询我的用药
#define SaveOrUpdateMyBox                @"api/box/saveOrUpdate"                    //添加更新我的用药
#define GetBoxProductDetail              @"api/box/detail"                  //用药详情
#define UpdateBoxProductTag              @"api/box/update/tag"                  //更新用药的药效的标签
#define DeleteBoxProduct                 @"api/box/delete"                     //删除我的用药
#define SimilarDrug                      @"api/box/similarDrugs"                          //同效药品列表
#define QueryAllTags                     @"api/box/tags"                         //我的用药所有标签
#define ConsultDetailCreate              @"api/consult/217/reply"

#define UpdateDeviceByToken          @"api/system/updateDeviceByToken"
/**
 *  --------------------------------xzh-------------------------------------
 */


//zpx

#define GrabPromotionProduct            @"api/grab/activity/activityList"         //获取抢购商品列表
#define GrabAction                      @"api/grab/activity/grab"                   //抢购商品行动
#define ChannelProductList              @"api/activity/channelProductList"        //频道商品列表
#define Sign                            @"api/mbr/score/sign"                       //用户签到
#define MemBerLevel                     @"api/mbr/score/queryMyLevelDetail"         //等级详情
#define QueryAddresses                  @"h5/mbr/address/addresses"                //收货地址
#define UpdateAddresses                 @"h5/mbr/address/address/edit"             //修改或新增地址
#define RemoveAddress                   @"h5/mbr/address/address/remove"           //删除地址
#define SearchHotWord                   @"api/discover/searchHotWord"               //发现搜索热词
#define GrabActivityRushPro             @"h5/act/rush/products"                     //微商抢购
#define QueryOrdersList                 @"h5/maicromall/order/queryUserOrders"      //请求订单列表
#define OperateOrders                   @"h5/maicromall/order/operateUserOrder"     //订单操作
#define GetUserCollectPostList          @"api/team/getCollectionPost"               //用户收藏的帖子列表
#define DeleteUserCollection            @"h5/collection/cancelCollection"           //用户收藏（帖子，资讯）删除
#define QueryUserOrderDetailInfo        @"h5/maicromall/order/queryUserOrderDetail" //订单详情
#define QueryUserCancelReasonInfo       @"h5/maicromall/order/queryReasons4Cancel"  //用户取消订单理由列表
#define UserOrderEvaluate               @"h5/branch/appraise"                       //订单评价
#define GetServiceTelLists              @"h5/system/getServiceTel"                  //客服电话
#define QueryHotKeyWordInfo             @"h5/search/queryHotKey"                    //搜索热词
#define QueryPostListInfo               @"h5/team/search"                           //圈贴搜索
#define OperateChannelMark              @"h5/rpt/operate/channel/mark"              //用户行为统计
//zpx



/**
 *  --------------------------------sgp-------------------------------------
 */

#define GetByPhar                       @"api/p2p/customer/detail/getByPhar"                         //我的用药所有标签
#define PollBySessionId                 @"api/p2p/customer/detail/pollBySessionId"


#define PTPDetailCreate                 @"api/p2p/detail/create"

#define PTPDetailRead                   @"api/p2p/detail/read"

#define PTPDetailRemove                 @"api/p2p/detail/remove"

#define PollByCustomer                  @"api/im/qw/pollByCustomer"

//添加家庭成员
#define AddFamilyMember                  @"api/familyMedicine/addFamilyMember"

//获取家庭成员详细信息
#define GetMemberInfo                  @"api/familyMedicine/getMemberInfo"

#define CheckChronicDiseaseUser          @"api/familyMedicine/isChronicDiseaseUser"
#define SubjectSaveComment              @"api/subject/saveComment"
#define InfoDetailSaveComment           @"api/message/saveComment"

//家庭药箱，查询所有药品
#define QueryAllMedicine                 @"api/familyMedicine/queryAllMedicine"

// 查询家庭成员列表
#define QueryFamilyMembers                 @"api/familyMedicine/queryFamilyMembers"

//查询家人用药列表
#define QueryMemberMedicines                @"api/familyMedicine/queryMemberMedicines"

//查询家庭成员的慢病
#define QueryMemberSlowDisease               @"api/familyMedicine/queryMemberSlowDisease"

//修改家庭成员
#define UpdateFamilyMember             @"api/familyMedicine/updateFamilyMember"

//更新家庭成员的慢病。若已关注则取消，反之则关注
#define UpdateMemberSlowDisease             @"api/familyMedicine/updateMemberSlowDisease"

//修改家庭成员用药的用法用量，药效
#define UpdateUseOrResult        @"api/familyMedicine/updateUseOrResult"


//更新家庭药箱药品的使用人

#define UpdateUsePeople   @"api/familyMedicine/updateUsePeople"
//查询家人用药列表
#define QueryMemberMedicines    @"api/familyMedicine/queryMemberMedicines"

//删除家庭成员
#define DeleteFamilyMember    @"api/familyMedicine/deleteFamilyMember"

#define QueryNoCompleteMedicine    @"api/familyMedicine/queryNoCompleteMedicine" //查询待完善的用药列表

/////api/familyMedicine/completeMemberMedicine 完善用药
#define CompleteMemberMedicine   @"api/familyMedicine/completeMemberMedicine"


///api/familyMedicine/medicineDetail 查询完善药详情
#define MedicineDetail    @"api/familyMedicine/medicineDetail"


#define AddMemberMedicine  @"api/familyMedicine/addMemberMedicine" //添加用药


#define SimilarDrugs    @"api/drug/similarDrugs" //同效药列表 App2.2.0版本

///api/familyMedicine/searchByTag 根据tag搜索家庭成员用药
#define SearchByTag      @"api/familyMedicine/searchByTag"


///api/familyMedicine/byKeyword 根据关键字查询我的用药
#define ByKeyword     @"api/familyMedicine/byKeyword"


///api/familyMedicine/queryTags 查询家庭成员的所有标签

#define QueryTags  @"api/familyMedicine/queryTags"


//////api/familyMedicine/updateTag 标记药效

#define UpdateTag @"api/familyMedicine/updateTag"

#define DeleteMemberMedicine @"api/familyMedicine/deleteMemberMedicine"
 #define RemoveByCustomer     @"api/consult/notice/removeByCustomer"

 #define RemoveByType     @"api/message/removeByType"// 消息盒子删除：按类型全部删除
 #define RemoveByCustomer_coupon     @"api/message/coupon/removeByCustomer"// 客户：删除单条优惠通知
/**
 *  --------------------------------sgp-------------------------------------
 */



/**
 *  --------------------------------ll-------------------------------------
 */
#define API_SendCodeByImageVerify       @"h5/mbr/code/sendCodeByImageVerify"    // 验证图片验证码并发送短信验证码
#define API_GetVerifyCodeSwitch         @"h5/mbr/code/switch"                  // 获取短信验证码发送开关,影响登录页面和注册页面的获取验证码逻辑
#define NW_tpaLogin                     @"api/mbr/user/TPALogin"                   //用户第三方登录
#define NW_validCodeLogin               @"api/mbr/user/validCodeLogin"             // 验证码登陆
#define NW_CheckMobile                  @"api/mbr/member/checkMobile"              //检测手机号是否已被绑定,绑定手机号用
#define GetCreditDetail                 @"api/mbr/score/queryMyScoreDetail"         //获取会员积分
#define GetCreditRecords                @"api/mbr/score/queryScoreRecords"          //获取积分明细
#define QueryTaskRules                  @"api/mbr/score/queryTaskRules"             //获取任务奖励规则列表
#define DoUpgradeTask                   @"api/mbr/score/doUpgradeTask"              // 用户领取月度等级任务
#define API_BindQQ                      @"api/mbr/user/bind/qq"                    // 绑定qq
#define API_BindWeixin                  @"api/mbr/user/bind/wx"                    // 绑定微信
#define API_GetBaseInfo                 @"api/mbr/user/getBaseInfo"                // 获取用户基础信息
#define API_SendVoiceVerifyCode         @"api/mbr/code/sendVoiceVerifyCode"        // 发送语音验证码
// 圈子
#define API_Forum_GetAllTeamList        @"api/team/allTeamList"                    // 全部圈子列表
#define API_Forum_ApplyMasterInfo       @"api/team/applyMasterInfo"                // 申请做圈主
#define API_Forum_AttentionMbr          @"api/team/attentionMbr"                   // 关注用户/取消关注用户
#define API_Forum_DelPostInfo           @"api/team/delPostInfo"                    // 删除帖子
#define API_Forum_EditPostInfo          @"api/team/editPostInfo"                   // 发布/编辑帖子
#define API_Forum_EditPostInfoCheck     @"api/team/editPostCheck"                  // 发布/编辑帖子校验
#define API_Forum_GetAllExpertInfo      @"api/team/getAllExpertInfo"               // 获取所有的专家信息
#define API_Forum_GetExpertListInfo     @"api/team/getExpertListInfo"              // 获取关注和未关注的专家列表信息
#define API_Forum_GetMbrInfoList        @"api/team/getMbrInfoListByTeamId"         // 圈主列表
#define API_Forum_GetPostListInfoByTeamId  @"api/team/getPostListInfoByTeamId"     // 圈子详细信息-帖子列表
#define API_Forum_GetTeamDetailsInfo    @"api/team/getTeamDetailsInfo"             // 圈子-详细信息
#define API_Forum_GetTeamHotInfo        @"api/team/getTeamHotInfo"                 // 圈子-热议
#define API_Forum_AttentionTeam         @"api/team/attentionTeam"                  // 关注圈子
#define API_Forum_GetExpertInfo         @"api/team/getExpertInfo"                  // 获取所有的专家信息
#define API_Forum_ComplaintPostInfo     @"api/team/complaintPostInfo"              // 举报帖子
//#define API_Forum_GetComplaintReson     @"api/team/getComplaintReson"              // 获取举报原因
#define API_Complaint                   @"api/complaint/complaint"                 // 举报
#define API_QuerryComplaintReason       @"api/complaint/queryReasons"              // 获取举报原因列表
#define API_Forum_GetpostDetails        @"h5/team/postDetails"                     // 帖子详情
#define API_Forum_GetMyPostList         @"api/team/myPostList"                     // 我的发帖列表
#define API_Forum_PraisePost            @"api/team/upVote"                         // 帖子点赞功能
#define API_Forum_CancelPraisePost      @"api/team/upVoteRepeal"                   // POST /api/team/upVoteRepeal 帖子点赞取消功能
#define API_Forum_GetMyCircleList       @"api/team/myAttnTeamList"                 // 我关注的圈子列表

#define API_Forum_getHisPostList        @"api/team/hisPostList"                    // Ta的发文列表
#define API_Forum_getHisReplyList       @"api/team/hisReplyList"                   // Ta的回帖列表
#define API_Forum_getMyAttnExpertList   @"api/team/myAttnExpertList"               // 我关注的专家列表
#define API_Forum_getMyFansList         @"api/team/myFansList"                     // 我的粉丝列表
#define API_Forum_getMyReplyList        @"api/team/myReplyList"                    // 我的回帖列表
#define API_Forum_ReplyPost             @"api/team/postReply"                      // 帖子回复功能
#define API_Forum_SharePost             @"api/team/postShare"                      // 帖子分享功能?
#define API_Forum_TopPost               @"api/team/topPost"                        // 置顶帖子
#define API_Forum_CheckCollectPost      @"h5/collection/checkCollection"           // 检查用户是否收藏
#define API_Forum_CollectOBJ            @"h5/collection/mbrCollection"             // 用户收藏
#define API_Forum_CancelCollectOBJ      @"h5/collection/cancelCollection"          // 用户取消收藏帖子
#define API_Forum_GetCollectionPostList @"api/team/getCollectionPost"               // 获取用户收藏帖子了列表

#define API_Forum_PraiseComment         @"api/team/replyUpVote"                    // 帖子评论的点赞功能
#define API_Forum_CancelPraiseComment   @"api/team/replyUpVoteRepeal"              // 帖子评论的取消点赞功能
#define API_Forum_DeletePostReply       @"api/team/delReply"                       // 删除评论
#define API_Forum_GetTopPostId          @"api/team/queryTopPostId"                 // 获取置顶帖子Id

// 消息
#define API_Forum_ChangeAllMessageReadFlag  @"api/team/changeAllMessageReadFlag"    // 修改消息全部已读、未读状态-圈子
#define API_Forum_ChangeMessageReadFlag     @"api/team/changeMessageReadFlag"       // 单条修改消息已读、未读状态-圈子
#define API_Forum_ChangeMessageShowFlag     @"api/team/changeMessageShowFlag"       // 单条修改消息显示、不显示状态-圈子
#define API_Forum_ChangeMsgReadFlagByMsgClass   @"api/team/changeMsgReadFlagByMsgClass"  // 分类修改消息已读、未读状态-圈子
//#define API_Forum_GetMessages           @"api/team/message"                         // 消息
#define API_Forum_QueryUnReadMessage    @"api/team/queryUnReadMessage"              // 商户端--轮询获取未读消息-圈子
#define API_Forum_GetTeamMessage        @"api/team/teamMessage"                     // 消息-圈子
#define API_Forum_UpdateMbrInfo         @"api/team/updateMbrInfo"                   // 更新个人信息
#define API_Forum_GetMyInfo             @"api/team/myInfo"                          // 我的信息

// 私聊 3.1.0
#define API_PrivateChat_GetAll          @"h5/team/chat/detail/getAll"               // 根据toId和fromId查看会话详情
#define API_PrivateChat_GetAllByChatId  @"h5/team/chat/detail/getAllByChatId"       // 根据chatId查看会话详情
#define API_PrivateChat_AddChatDetail   @"h5/team/chat/detail/addChatDetail"        // 添加会话明细
#define API_PrivateChat_GetChatDetailList      @"h5/team/chat/detail/getChatDetailList"     // 【增量轮询】获取会话明细列表

// 3.1.1
#define API_CheckVerifyCodeValid        @"h5/mbr/code/validVerifyCodeOnly4check"    // 验证码校验 <- 不消耗验证码
// 4.0.0
#define API_HealthCircle_Home           @"h5/team/userHomepage"                     // 用户端圈子-首页
#define API_HealthCircle_Square         @"h5/team/teamSquare"                       // 用户端-圈子广场（更多圈子）
#define API_RegiterForPresentGift       @"h5/mbr/user/presentGift"                  // 赠送大礼包
#define API_GetSyncTeamList             @"h5/team/syncTeamList"                     // 可同步的圈子列表
/**
 *  --------------------------------ll-------------------------------------
 */
#endif