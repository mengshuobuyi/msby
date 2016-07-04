//
//  WYChooseMyDrugModel.h
//  wenyao
//
//  Created by Yan Qingyang on 15/4/15.
//  Copyright (c) 2015年 xiezhenghong. All rights reserved.
//

#import "BaseModel.h"

@interface WYChooseMyDrugModel : BaseModel
@property (nonatomic) NSString *productId; //药品id
@property (nonatomic) NSString *productName; //药品名字

@property (nonatomic) NSString *drugTag; //
@property (nonatomic) NSString *intervalDay;//
@property (nonatomic) NSString *createTime;//
@property (nonatomic) NSString *boxId;


@property (assign) BOOL chooseEnabled;
@end
