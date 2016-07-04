//
//  ForumModel.m
//  APP
//
//  Created by Martin.Liu on 16/1/7.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "ForumModel.h"

@implementation ForumModel

@end

@implementation QWCircleHotInfo

@end

@implementation QWCircleModel

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    if ([object isKindOfClass:[QWCircleModel class]]) {
        QWCircleModel* other = (QWCircleModel*)object;
        return [self.teamId isEqual:other.teamId];
    }
    return NO;
}

- (NSUInteger)hash
{
    return [self.teamId hash];
}

- (void)buildWithCircleListModel:(CircleListModel*)model
{
    self.teamId     = [model.teamId copy];
    self.teamName   = [model.teamName copy];
    self.flagAttn   = model.flagAttn;
    self.flagMaster = model.flagMaster;
}

@end

@implementation QWNoticePushModel

@end

@implementation QWPostModel

@end

@implementation QWPostDetailModel

@end

@implementation QWPostContentInfo

- (NSComparisonResult)compare:(id)obj
{
    if ([obj isKindOfClass:[QWPostContentInfo class]]) {
        QWPostContentInfo* other = obj;
        if (self.postContentSort > other.postContentSort) {
            return NSOrderedDescending;
        }
        else if (self.postContentSort < other.postContentSort)
        {
            return NSOrderedAscending;
        }
    }
    return NSOrderedSame;
}

- (void)buildWithQWPostContentInfoWithImage:(QWPostContentInfoWithImage*)model;
{
    self.postContent     = [model.postContent copy];
    self.postContentDesc = [model.postContentDesc copy];
    self.postContentType = model.postContentType;
    self.postContentSort = model.postContentSort;
}

@end

@implementation QWPostContentInfoWithImage

@end

@implementation QWPostReply

@end

@implementation QWCirclerModel

@end

@implementation QWCircleDetailsInfo

@end

@implementation QWExpertInfoModel

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    if ([object isKindOfClass:[QWExpertInfoModel class]]) {
        QWExpertInfoModel* other = object;
        return [self.id isEqualToString:other.id];
    }
    return NO;
}

- (NSUInteger)hash
{
    return [self.id hash];
}

- (id)copyWithZone:(NSZone *)zone
{
    QWExpertInfoModel* expert = [[[self class] allocWithZone:zone] init];
    expert.id                 = [self.id copy];
    expert.nickName           = [self.nickName copy];
    expert.headImageUrl       = [self.headImageUrl copy];
    expert.groupName          = [self.groupName copy];
    expert.postCount          = self.postCount;
    expert.replyCount         = self.replyCount;
    expert.mbrLvl             = self.mbrLvl;
    expert.upVoteCount        = self.upVoteCount;
    expert.attnCount          = self.attnCount;
    expert.userType           = self.userType;
    expert.expertise          = [self.expertise copy];
    expert.isAttnFlag         = self.isAttnFlag;
    expert.isMaster           = self.isMaster;
    return expert;
}

@end

@implementation QWAttnAndRecommendExpertList

@end

@implementation QWComplaintReason

@end

@implementation QWMyCircleList

@end

@implementation QWPostDrafts

- (instancetype)init
{
    if (self = [super init]) {
        self.postStatus = PostStatusType_WaitForPost;
    }
    return self;
}

+ (NSString *)getPrimaryKey
{
    return @"postId";
}

+ (BOOL)deleteWIthPostId:(NSString*)postId
{
    NSArray* postdrafts = [self.class getArrayFromDBWithWhere:[NSString stringWithFormat:@"postId = '%@'", postId]];
    if (postdrafts.count == 0) {
        return YES;
    }
    for (QWPostDrafts* postDraft in postdrafts) {
        DebugLog(@"成功删除草稿箱帖子");
        return [postDraft deleteToDB];
    }
    return NO;
}

@end

@implementation PostCollectList

@end

@implementation PostCollectVo

@end

@implementation QWTopPostId

@end

@implementation QWCircleMessage

@end

@implementation QWCircleMessageListModel

@end

@implementation QWMyForumInfo

@end

@implementation QWCircleCreditModel

@end

@implementation QWCirclePostShareModel

@end

@implementation QWAttentionCircleModel

@end

@implementation QWAttentionMbrModel

@end

@implementation QWHealthCircleInfoModel

@end

@implementation QWMbrInfoModel

@end

@implementation QWCircleSquareModel

@end

@implementation QWSyncTeamListModel

@end