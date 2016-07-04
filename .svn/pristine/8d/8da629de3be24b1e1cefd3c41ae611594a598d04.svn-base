//
//  ResortItem.h
//  TestTopNews
//
//  Created by chenzhipeng on 1/3/16.
//  Copyright © 2016 PerryChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "ResortMacro.h"

@interface ResortItem : BaseModel
@property (nonatomic, strong) NSString *strTitle;
@property (nonatomic, strong) NSString *strID;
@property (nonatomic, assign) itemOriLocation olocation;
@property (nonatomic, strong) NSString *dataType;       // 用来在存储数据库时方便检索
@property (nonatomic, strong) NSString *updatedStatus;  // Y 同步过数据 N 未同步过数据，需要同步
@property (nonatomic, strong) NSString *isInOperate;    // Y 已经被操作过，下次需要更新
@end
