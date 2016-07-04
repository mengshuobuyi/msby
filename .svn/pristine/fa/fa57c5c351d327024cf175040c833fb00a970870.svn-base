//
//  FeedBackModelR.h
//  APP
//
//  Created by qwfy0006 on 15/3/16.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseModel.h"

@interface FeedBackModelR : BaseModel

@property (strong ,nonatomic) NSString          *token;         //用户端 或 药店端 令牌，非必填项
@property (strong ,nonatomic) NSString          *content;       //反馈建议内容，必填
@property (strong ,nonatomic) NSString          *source;        //反馈建议来源(1:商户平台, 2:网站, 3:WAP, 4:android, 5:iOS,6:android药店端,       7:ios药   店端)，int，必填
@property (strong ,nonatomic) NSString          *type;          //类型(0:投诉, 1:建议, 2:问题,3:其他) ，默认值为：1，int，必填
@property (strong ,nonatomic) NSString          *contact;       //联系方式，选填

@end
