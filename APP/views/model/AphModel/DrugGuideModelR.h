//
//  DrugGuideModelR.h
//  APP
//
//  Created by chenzhipeng on 3/13/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "BaseModel.h"

@interface DrugGuideModelR : BaseModel

@end

@interface DrugGuideListModelR : DrugGuideModelR

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *currPage;
@property (nonatomic, strong) NSString *pageSize;

@end

@interface DrugMsgLogListModelR : DrugGuideModelR

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *drugGuideId;
@property (nonatomic, strong) NSString *currPage;
@property (nonatomic, strong) NSString *pageSize;

@end

@interface DrugGuideAttentionModelR : DrugGuideModelR
@property (nonatomic, strong) NSString *token;
@end

@interface ChronicDiseaseItemModelR : DrugGuideModelR

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *currPage;
@property (nonatomic, strong) NSString *pageSize;

@end

@interface DrugGuideLikeCountModelR : DrugGuideModelR

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *objId;
@property (nonatomic, strong) NSString *objType;

@end
