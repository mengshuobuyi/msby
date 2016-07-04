//
//  SubjectModelR.h
//  APP
//
//  Created by garfield on 15/8/28.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseAPIModel.h"
@interface SubjectModelR : BaseAPIModel

@end

@interface SaveCommentModelR : BaseAPIModel

@property (nonatomic, strong) NSString  *msgID;
@property (nonatomic, strong) NSString  *subjectId;
@property (nonatomic, strong) NSString  *token;
@property (nonatomic, strong) NSString  *device;
@property (nonatomic, strong) NSString  *content;
@property (nonatomic, strong) NSString  *province;
@property (nonatomic, strong) NSString  *city;

@end