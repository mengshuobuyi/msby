//
//  OrderBaseModelR.h
//  APP
//
//  Created by garfield on 15/8/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseAPIModel.h"

@interface OrderBaseModelR : BaseAPIModel

@end

@interface OrderBaseCommentModelR : BaseAPIModel

@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *star;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *token;

@end


@interface PlaceOrderModel : BaseAPIModel

@property (nonatomic, strong) NSString *appid;      //微信分配的公众账号ID（企业号corpid即为此appId）
@property (nonatomic, strong) NSString *mch_id;     //微信支付分配的商户号
@property (nonatomic, strong) NSString *nonce_str;  //随机字符串，不长于32位。推荐随机数生成算法

@property (nonatomic, strong) NSString *sign;       //签名，详见签名生成算法https://pay.weixin.qq.com/wiki/doc/api/app.php?chapter=4_3
@property (nonatomic, strong) NSString *body;       //商品或支付单简要描述
@property (nonatomic, strong) NSString *detail;     //商品名称明细列表
@property (nonatomic, strong) NSString *out_trade_no;   //商户系统内部的订单号,32个字符内、可包含字母, 其他说明见商户订单号
@property (nonatomic, strong) NSString *fee_type;   //符合ISO 4217标准的三位字母代码，默认人民币：CNY，其他值列表详见货币类型
@property (nonatomic, strong) NSString *total_fee;  //订单总金额，单位为分，详见支付金额
@property (nonatomic, strong) NSString *spbill_create_ip;   //APP和网页支付提交用户端ip，Native支付填调用微信支付API的机器IP。
@property (nonatomic, strong) NSString *time_start; //订单生成时间，格式为yyyyMMddHHmmss，如2009年12月25日9点10分10秒表示为20091225091010。其他详见时间规则
@property (nonatomic, strong) NSString *time_expire;    //订单失效时间，格式为yyyyMMddHHmmss，如2009年12月27日9点10分10秒表示为20091227091010。其他详见时间规则,注意：最短失效时间间隔必须大于5分钟


@property (nonatomic, strong) NSString *notify_url; //接收微信支付异步通知回调地址，通知url必须为直接可访问的url，不能携带参数。
@property (nonatomic, strong) NSString *trade_type; //取值如下：JSAPI，NATIVE，APP，详细说明见参数规定
@property (nonatomic, strong) NSString *product_id; //trade_type=NATIVE，此参数必传。此id为二维码中包含的商品ID，商户自行定义。
@property (nonatomic, strong) NSString *limit_pay;  //no_credit--指定不能使用信用卡支付
@property (nonatomic, strong) NSString *openid;     //trade_type=JSAPI，此参数必传，用户在商户appid下的唯一标识。openid如何获取，可参考【获取openid】。企业号请使用【企业号OAuth2.0接口】获取企业号内成员userid，再调用【企业号userid转openid接口】进行转换

@end

@interface AliPayOrder : BaseAPIModel

@property(nonatomic, copy) NSString * partner;
@property(nonatomic, copy) NSString * seller;
@property(nonatomic, copy) NSString * tradeNO;
@property(nonatomic, copy) NSString * productName;
@property(nonatomic, copy) NSString * productDescription;
@property(nonatomic, copy) NSString * amount;
@property(nonatomic, copy) NSString * notifyURL;

@property(nonatomic, copy) NSString * service;
@property(nonatomic, copy) NSString * paymentType;
@property(nonatomic, copy) NSString * inputCharset;
@property(nonatomic, copy) NSString * itBPay;
@property(nonatomic, copy) NSString * showUrl;


@property(nonatomic, copy) NSString * rsaDate;//可选
@property(nonatomic, copy) NSString * appID;//可选

@property(nonatomic, readonly) NSMutableDictionary * extraParams;

@end

