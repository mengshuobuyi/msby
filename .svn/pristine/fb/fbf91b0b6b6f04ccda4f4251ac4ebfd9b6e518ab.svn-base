//
//  MallCartModelR.h
//  APP
//
//  Created by garfield on 16/1/15.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "BaseAPIModel.h"

@interface MallCartModelR : BaseAPIModel

@property (nonatomic, strong) NSString      *token;

@end

@interface MMallCartCheckModelR : BaseAPIModel

@property (nonatomic, strong) NSString      *token;
@property (nonatomic, strong) NSString      *productsJson;      //购买商品信息-JSON
@property (nonatomic, assign) double        payableAccounts;


@end

@interface MMallCartSyncModelR : BaseAPIModel

@property (nonatomic, strong) NSString      *token;
@property (nonatomic, strong) NSString      *proJson;      //商品信息


@end

@interface MMallCartPreviewModelR : BaseAPIModel

@property (nonatomic, strong) NSString      *token;
@property (nonatomic, assign) NSInteger     deliveryType;      //配送方式：1.到店自提 2.送货上门 3.快递
@property (nonatomic, strong) NSString      *postAddressId;    //收货人地址
@property (nonatomic, strong) NSString      *couponId;         //门店优惠（优惠券）ID
@property (nonatomic, strong) NSString      *productsJson;
@property (nonatomic, strong) NSString      *remark;
@property (nonatomic, strong) NSString      *deviceCode;
@property (nonatomic, assign) NSInteger     deviceType;
@property (nonatomic, assign) NSInteger     payType;
@property (nonatomic, assign) double        payableAccounts;
@property (nonatomic, assign) NSInteger     channel;
@property (nonatomic, strong) NSString      *buildChannel;     //打包平台

@end

@interface MmallAdviceModelR : BaseAPIModel

@property (nonatomic, strong) NSString      *token;
@property (nonatomic, strong) NSString      *city;
@property (nonatomic, assign) NSInteger     deviceType;
@property (nonatomic, strong) NSString      *deviceCode;         //门店优惠（优惠券）ID

@end

@interface MMallRedemptionModelR : BaseAPIModel

@property (nonatomic, strong) NSString      *branchIds;

@end

@interface GetOrderResultModelR : BaseAPIModel

@property (nonatomic, strong) NSString      *token;
@property (nonatomic, strong) NSString      *orderId;

@end



