//
//  AppraiseModelR.h
//  APP
//
//  Created by Meng on 15/3/17.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseModel.h"

@interface AppraiseModelR : BaseModel

@end

@interface AddAppraiseModelR : AppraiseModelR

@property (nonatomic ,strong) NSString *groupId;
@property (nonatomic ,strong) NSString *token;
@property (nonatomic ,strong) NSString *star;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *imId;


@end

@interface GetAppraiseModelR : AppraiseModelR
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *consultId;
@end

@interface AppraiseByConsultModelR : AppraiseModelR

@property (nonatomic ,strong) NSString *token;
@property (nonatomic ,strong) NSString *branchId;
@property (nonatomic ,strong) NSString *branchName;
@property (nonatomic ,strong) NSString *star;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *consultId;
@property (nonatomic, strong) NSString *consultMessage;

@end


@interface StoreAppraiseModelR : AppraiseModelR

@property (nonatomic ,strong) NSString *branchId;
@property (nonatomic ,strong) NSNumber *page;
@property (nonatomic ,strong) NSNumber *pageSize;

@end