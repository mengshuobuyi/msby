//
//  QWPrivateMessageModel.h
//  APP
//
//  Created by Martin.Liu on 16/3/10.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasePrivateModel+ExcludeORM.h"

@interface QWPrivateMessageModel : BasePrivateModel

@property (nonatomic,strong) NSString           *branchId;
@property (nonatomic,strong) NSString           *branchProId;
@property (nonatomic,strong) NSString           *spec;

@property (nonatomic,strong) NSString           *sendPassport;
@property (nonatomic,strong) NSString           *direction;                 //营销活动
@property (nonatomic,strong) NSString           *timestamp;
@property (nonatomic,strong) NSString           *UUID;                      //聊天记录id 数据库关联
@property (nonatomic,strong) NSString           *star;                      //营销活动 title
@property (nonatomic,strong) NSString           *avatorUrl;                 //头像
@property (nonatomic,strong) NSString           *imgUrl;                    //图片地址
@property (nonatomic,strong) NSString           *sendname;
@property (nonatomic,strong) NSString           *recvname;                  //对方的passport
@property (nonatomic,strong) NSString           *issend;
@property (nonatomic,strong) NSString           *messagetype;
@property (nonatomic,strong) NSString           *isRead;
@property (nonatomic,strong) NSString           *richbody;                  //营销活动 图片地址或者经纬度信息
@property (nonatomic,strong) NSString           *body;
@property (nonatomic,assign) NSInteger          fromTag;
@property (nonatomic,strong) NSString           *title;
@property (nonatomic,strong) NSString           *duration;
@property (nonatomic,strong) NSString           *fileUrl;
@property (nonatomic,strong) NSString           *download;
@property (nonatomic,strong) NSString           *list;
@property (nonatomic,assign) NSInteger            tags;

@property (nonatomic, assign) NSInteger userType;       // 私聊用到的。
@property (nonatomic, strong) NSString  *senderId;      // 发送人Id
@property (nonatomic, strong) NSString  *nickName;      // 发送人的昵称,
@end
