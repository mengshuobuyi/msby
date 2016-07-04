//
//  DiseaseSubList.h
//  APP
//
//  Created by qw on 15/3/20.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseModel.h"

@interface DiseaseSubList : BaseModel
@property (nonatomic, strong) NSString *guideId;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *displayTime;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *unReadCount;
@property (nonatomic, strong) NSString *hasRead;
@end
