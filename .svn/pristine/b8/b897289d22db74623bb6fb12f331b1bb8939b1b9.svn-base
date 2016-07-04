//
//  PayInfoModel.h
//  APP
//
//  Created by garfield on 16/3/18.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseAPIModel.h"
@interface PayInfoModel : BaseAPIModel

@property (assign,nonatomic) NSInteger      result;         //1:未支付;2:支付中;3:支付成功;4:支付失败
@property (strong, nonatomic) NSString      *resultDesc;    //对当前查询订单状态的描述和下一步操作的指引
@property (strong, nonatomic) NSString      *notiType;      //通知的类型 1 支付宝 2 微信
@property (strong, nonatomic) NSString      *notiTypeStatus;//通知的类型 1 失败 2 成功 3未知

@end


