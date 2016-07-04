//
//  XHmessage+Helper.m
//  APP
//
//  Created by garfield on 15/4/3.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "XHMessage+Helper.h"
#import "QWGlobalManager.h"
#import "QWMessage.h"
#import "SBJson.h"

@implementation XHMessage (Helper)

+ (void)refreshingRecentMessage:(NSArray *)array
                  messageSender:(NSString *)messageSender
                      avatarUrl:(NSString *)avatarUrl
                     isOfficial:(BOOL)official
{
        for(NSDictionary *dict in array)
        {
            NSDictionary *info = dict[@"info"];
            NSString *content = info[@"content"];
            NSString *fromId = info[@"fromId"];
            NSString *toId = info[@"toId"];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            double timeStamp = [[formatter dateFromString:info[@"time"]] timeIntervalSince1970];
            NSDate *date = [formatter dateFromString:info[@"time"]];
            NSString *UUID = info[@"id"];
            NSUInteger fromTag = [info[@"fromTag"] integerValue];
            NSString *fromName = info[@"fromName"];
            NSUInteger msgType = [info[@"source"] integerValue];
            if(msgType == 0)
                msgType = 1;
            NSString *where = [NSString stringWithFormat:@"UUID = '%@'",UUID];
            NSArray *tagList = [TagWithMessage getArrayFromDBWithWhere:where];
            for(NSDictionary *tag in info[@"tags"])
            {
                TagWithMessage* tagTemp = [[TagWithMessage alloc] init];
                
                tagTemp.length = tag[@"length"];
                tagTemp.start = tag[@"start"];
                tagTemp.tagType = tag[@"tag"];
                tagTemp.tagId = tag[@"tagId"];
                tagTemp.title = tag[@"title"];
                tagTemp.UUID = UUID;
                [TagWithMessage saveObjToDB:tagTemp];
            }
            
            OfficialMessages * omsg = [OfficialMessages getObjFromDBWithKey:UUID];
            if (omsg) {
                return;
            }
            
                TagWithMessage * tag = nil;
                if (tagList.count>0) {
                    tag = tagList[0];
                }
                OfficialMessages * msg =  [[OfficialMessages alloc] init];
                msg.fromId = fromId;
                msg.toId = toId;
                msg.timestamp = [NSString stringWithFormat:@"%f",timeStamp];
                msg.body = content;
                msg.direction = [NSString stringWithFormat:@"%.0ld",(long)XHBubbleMessageTypeReceiving];
                msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)msgType];
                msg.UUID = UUID;
                msg.issend = @"1";
                msg.fromTag = fromTag ;
                msg.title = fromName;
                msg.relatedid = fromId;///此处是不是有问题
                msg.subTitle = tag.title;
                [OfficialMessages saveObjToDB:msg];
//            }
        }
    
}

+ (void)headerRefreshingMessage:(NSArray *)array
                  messageSender:(NSString *)messageSender
                      avatorUrl:(NSString *)avatorUrl
                       infoDict:(NSDictionary *)infoDict
                       messages:(NSMutableArray *)messages
                     official:(BOOL)official
{
  
        for(NSDictionary *dict in array)
        {
            NSDictionary *info = dict[@"info"];
            NSString *content = info[@"content"];
            NSString *fromId = info[@"fromId"];
             NSString *fromName = info[@"fromName"];
            NSString *toId = info[@"toId"];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            double timeStamp = [[formatter dateFromString:info[@"time"]] timeIntervalSince1970];
            NSDate *date = [formatter dateFromString:info[@"time"]];
            NSString *UUID = info[@"id"];
            NSUInteger fromTag = [info[@"fromTag"] integerValue];
            //NSArray *tags = info[@"tags"];
            NSUInteger msgType = [info[@"source"] integerValue];
            if(msgType == 0)
                msgType = 1;

            for(NSDictionary *tag in info[@"tags"])
            {
                TagWithMessage* tagTemp = [[TagWithMessage alloc] init];
                
                tagTemp.length = tag[@"length"];
                tagTemp.start = tag[@"start"];
                tagTemp.tagType = tag[@"tag"];
                tagTemp.tagId = tag[@"tagId"];
                tagTemp.title = tag[@"title"];
                tagTemp.UUID = UUID;
                [TagWithMessage saveObjToDB:tagTemp];
            }
                    NSString *where = [NSString stringWithFormat:@"UUID = '%@'",UUID];
                    NSArray *tagList = [TagWithMessage getArrayFromDBWithWhere:where];
         
                     OfficialMessages * omsg = [OfficialMessages getObjFromDBWithKey:UUID];
                if (omsg) {
                    return;
                }

                    TagWithMessage * tag = nil;
                    if (tagList.count>0) {
                        tag = tagList[0];
                    }
                   
                    OfficialMessages * msg =  [[OfficialMessages alloc] init];
                    msg.fromId = fromId;
                    msg.toId = toId;
                    msg.timestamp = [NSString stringWithFormat:@"%f",timeStamp];
                    msg.body = content;
                    msg.direction = [NSString stringWithFormat:@"%.0ld",(long)XHBubbleMessageTypeReceiving];
                    msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)msgType];
                    msg.UUID = UUID;
                    msg.issend = @"1";
                    msg.fromTag = fromTag ;
                    msg.title = fromName;
                    msg.relatedid = fromId;///此处是不是有问题
            if(tag == nil) {
                continue;
            }
                    msg.subTitle = tag.title;
                    [OfficialMessages saveObjToDB:msg];
//                }
//            }else if(fromTag == 0)
//            {
//                OfficialMessages * omsg = [OfficialMessages getObjFromDBWithKey:UUID];
//                if(!omsg)
//                {
//                    OfficialMessages * msg =  [[OfficialMessages alloc] init];
//                    msg.fromId = fromId;
//                    msg.toId = toId;
//                    msg.timestamp = [NSString stringWithFormat:@"%f",timeStamp];
//                    msg.body = content;
//                    msg.direction = [NSString stringWithFormat:@"%.0ld",(long)XHBubbleMessageTypeReceiving];
//                    msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)msgType];
//                    msg.UUID = UUID;
//                    msg.issend = @"1";
//                    msg.fromTag = fromTag ;
//                    msg.title = fromName;
//                    msg.relatedid = fromId;///此处是不是有问题
//                    [OfficialMessages saveObjToDB:msg];
//                }
//            }

            XHMessage *message = nil;
            switch (msgType)
            {
                case XHBubbleMessageMediaTypeText:
                {
                    message = [[XHMessage alloc] initWithText:content sender:fromId timestamp:date UUID:UUID];
                    break;
                }
                case XHBubbleMessageMediaTypeAutoSubscription:
                {
                    
                    message = [[XHMessage alloc] initWithAutoSubscription:content sender:fromId timestamp:date UUID:UUID tagList:tagList];
                    
                    break;
                }
                case XHBubbleMessageMediaTypeDrugGuide:
                {
                    if(tagList.count == 0)
                        continue;
                    TagWithMessage * tag = tagList[0];

                    message = [[XHMessage alloc] initWithDrugGuide:content title:fromName sender:fromId timestamp:date UUID:UUID tagList:tagList subTitle:tag.title fromTag:fromTag];
                    break;
                }
                    case XHBubbleMessageMediaTypePurchaseMedicine:
                {
                    
                    TagWithMessage * tag = tagList[0];

                    message = [[XHMessage alloc]initWithPurchaseMedicine:content sender:fromId timestamp:date UUID:UUID tagList:tagList title:fromName subTitle:tag.title fromTag:fromTag];
                    break;
                }
                    case XHBubbleMessageMediaTypeSpreadHint:
                {
                       message = [[XHMessage alloc] initWithSpreadHint:content title:@"" sender:fromId timestamp:[NSDate date] UUID:UUID tagList:nil fromTag:0];
                    break;
                }

                default:

                    break;
            }
            message.avator = [UIImage imageNamed:@"全维药事icon.png"];
            message.bubbleMessageType = XHBubbleMessageTypeReceiving;
            message.officialType = YES;
            if(message)
                [messages addObject:message];
        }
    
}

+ (XHMessage *)getMessages:(NSMutableArray *)messages
                  withUUID:(NSString *)uuid
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"UUID == %@",uuid];
    NSArray *array = [messages filteredArrayUsingPredicate:predicate];
    if([array count] > 0) {
        return array[0];
    }else{
        return nil;
    }
}


@end
