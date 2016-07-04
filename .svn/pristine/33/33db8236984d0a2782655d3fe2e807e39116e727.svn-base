//
//  DrugGuideModel.h
//  APP
//
//  Created by chenzhipeng on 3/13/15.
//  Copyright (c) 2015 carret. All rights reserved.
//

#import "BaseAPIModel.h"
#import "BasePrivateModel.h"

@interface DrugGuideModel : BaseAPIModel

@property (nonatomic, strong) NSMutableArray *list;

@end

@interface DrugGuideListModel : BasePrivateModel

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *displayTime;
@property (nonatomic, strong) NSString *guideId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *unReadCount;
@property (nonatomic, strong) NSString *attentionId;
//@property (nonatomic, assign) BOOL hasRead;
//@property (nonatomic, strong) NSString *nodeTime;   //节点时间 判断是否已读

@end

@interface DrugGuideMsgLogModel : BaseAPIModel

@property (nonatomic, strong) NSString *page;
@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic, strong) NSString *pageSize;
@property (nonatomic, strong) NSString *pageSum;
@property (nonatomic, strong) NSString *totalRecords;

@end

@interface DrugGuideCheckNewMsgListModel : BasePrivateModel
@property (nonatomic, strong) NSMutableArray *list;
@end

@interface DrugGuideCheckNewMsgModel : BasePrivateModel
@property (nonatomic, strong) NSString *attentionId;
@property (nonatomic, strong) NSString *nodeTime;
@end

@interface DrugGuideMsgLogListModel : BaseAPIModel

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *dataFrom;
@property (nonatomic, strong) NSString *favoriteStatus;
@property (nonatomic, strong) NSString *likeNumber;
@property (nonatomic, strong) NSString *likeStatus;
@property (nonatomic, strong) NSString *logId;
@property (nonatomic, strong) NSString *msgId;
@property (nonatomic, strong) NSString *readStatus;
@property (nonatomic, strong) NSString *sendTime;
@property (nonatomic, strong) NSString *sender;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *triggerObjId;
@property (nonatomic, strong) NSString *triggerType;
@property (nonatomic, strong) NSString *expanded;


@end

@interface DrugAttentionModel : BaseAPIModel

@property (nonatomic, strong) NSArray *list;

@end

@interface DrugAttentionListModel : BaseAPIModel

@property (nonatomic, strong) NSString *attentionId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *childList;

@end

@interface DrugAttentionChildModel : BaseAPIModel

@property (nonatomic, strong) NSString *attentionId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *pushPoint;
@property (nonatomic, strong) NSString *guideId;
@property (nonatomic, assign) BOOL isSelected;

@end

@interface ChronicDiseaseListModel : BaseAPIModel

@property (nonatomic, strong) NSArray *data;

@end

@interface ChronicDiseaseModel : BaseAPIModel

@property (nonatomic, strong) NSString *diseaseId;
@property (nonatomic, strong) NSString *diseaseName;
@property (nonatomic, strong) NSString *diseaseParentName;
@property (nonatomic, strong) NSString *id;

@end
