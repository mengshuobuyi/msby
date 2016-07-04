//
//  AppraiseModel.h
//  APP
//
//  Created by Meng on 15/3/17.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseAPIModel.h"

@interface AppraiseModel : BaseAPIModel

@property (nonatomic, strong) NSString  *flag;

@end

@interface AppraiseByConsultModel : BaseAPIModel

@property (nonatomic, strong) NSString  *result;
@property (nonatomic, strong) NSString  *errorCode;
@property (nonatomic, strong) NSString  *errorDescription;
@property (nonatomic, strong) NSString  *body;

@end


@interface AppraiseByConsultGetModel : BaseAPIModel

@property (nonatomic, strong) NSString  *consultId;
@property (nonatomic, strong) NSString  *consultTitle;
@property (nonatomic, strong) NSString  *branchId;
@property (nonatomic, assign) float  star;
@property (nonatomic, strong) NSString  *remark;

@end

@interface QueryAppraiseModel : BaseAPIModel

@property(strong,nonatomic) NSString * page;
@property(strong,nonatomic) NSArray  * appraises;
@property(strong,nonatomic) NSString * pageSum;
@property(strong,nonatomic) NSString * pageSize;
@property(strong,nonatomic) NSString * totalRecords;

@end



@interface StoreAppraiseModel : BaseModel

@property (nonatomic ,strong) NSString *nick;//昵称
@property (nonatomic ,strong) NSString *sex;//性别。0男1女
@property (nonatomic ,strong) NSString *remark;//评价内容
@property (nonatomic ,strong) NSString *stars;//星级
@property (nonatomic ,strong) NSString *date;//日期

@end
