//
//  XHDemoWeChatMessageTableViewController.m
//  MessageDisplayExample
//
//  Created by qtone-1 on 14-4-27.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "PTPWeChatMessageTableViewController.h"

#import "XHAudioPlayerHelper.h"
#import "MJRefresh.h"
#import "ShowLocationViewController.h"
#import "SVProgressHUD.h"
#import "MarkPharmacyViewController.h"
#import "MarketDetailViewController.h"
#import "DetailSubscriptionListViewController.h"
#import "SBJson.h"
#import "PharmacyStoreViewController.h"
#import "IntroduceQwysViewController.h"
#import "QuickSearchViewController.h"
#import "DiseaseSubscriptionViewController.h"
#import "PersonInformationViewController.h"
#import "DrugFirstDetailViewController.h"
#import "QWGlobalManager.h"
#import "QWcss.h"
#import "QWMessage.h"
#import "IMApi.h"
#import "System.h"
#import "Appraise.h"
#import "DiseaseSubList.h"
#import "XHmessage+Helper.h"
#import "SJAvatarBrowser.h"
#import "PhotoModel.h"
#import "QYPhotoAlbum.h"
#import "ReturnIndexView.h"
#import "XMPPStream.h"
#import "CouponDeatilViewController.h"
#import "PharmacyStoreDetailViewController.h"
#import "ConsultPTP.h"
#import "QWMessage.h"
#import "XHFoundationMacro.h"
#import "ConsultFirstViewController.h"
#import "PhotoPreView.h"


 @interface PTPWeChatMessageTableViewController () <XHAudioPlayerHelperDelegate,MLEmojiLabelDelegate,ReturnIndexViewDelegate>
{
    UIImageView         *hintView;
    PhotoModel          *currentSendPhotoModel;
       UIImageView *phoneView;
    NSInteger phone;
    float phonePointY;
    UILabel *phoneLabel;
    NSString *ptpSessionID;
    NSString *phoneNumber;
    UIButton *phoneBtn ;
    BOOL showPhone;
}
@property (nonatomic, copy)   dispatch_source_t         pullMessageDetailTimer;       //拉取咨询详情
@property (nonatomic, strong) NSString *errorMsg;
@property (nonatomic, strong) NSMutableArray            *photoArrays;
@property (nonatomic, strong) NSArray *emotionManagers;
@property (nonatomic, strong) NSMutableArray    *cacheList;
@property (nonatomic, strong) XHMessageTableViewCell *currentSelectedCell;
@property (strong, nonatomic) ReturnIndexView *indexView;

@end

@implementation PTPWeChatMessageTableViewController
@synthesize pullMessageDetailTimer;
- (void)loadDemoDataSource
{
    WEAKSELF
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.messageTableView reloadData];
            
            [weakSelf scrollToBottomAnimated:NO];
     [self showOrHideHeaderView];
//        });
//    });
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    GetByPharModelR *imSelectQWModelR = [GetByPharModelR new];
    imSelectQWModelR.branchId = self.branchId;
    imSelectQWModelR.token = QWGLOBALMANAGER.configure.userToken;
    imSelectQWModelR.point = @"-1";
    imSelectQWModelR.view = @"15";
    imSelectQWModelR.viewType = @"-1";
    
   
        if(self.messages.count == 0) {
            imSelectQWModelR.point = [NSString stringWithFormat:@"%0.f",[[NSDate date] timeIntervalSince1970] * 1000];
        }else if(self.messages.count == 1)
        {
            imSelectQWModelR.point = [NSString stringWithFormat:@"0"];
        }else{
            XHMessage *message = self.messages[0];
            imSelectQWModelR.point = [NSString stringWithFormat:@"%.0f",[message.timestamp timeIntervalSince1970] * 1000.0f];
        }
    
    [ConsultPTP getByPhar:imSelectQWModelR success:^(CustomerSessionDetailList *responModel) {
        
        for(SessionDetailVo *detail in responModel.details)
        {
            
            
            QWMessage *msg = [[QWMessage alloc] init];
            msg.UUID = [NSString stringWithFormat:@"%@",detail.detailId];
//            if([QWMessage getObjFromDBWithKey:msg.UUID])
//                continue;
            msg.timestamp = [NSString stringWithFormat:@"%.0f",[detail.createTime doubleValue] / 1000.0];
            msg.isRead = @"1";
            msg.sendname = QWGLOBALMANAGER.configure.passPort;
            msg.recvname = self.branchId;
            msg.issend = [NSString stringWithFormat:@"%d",Sended];
            if([detail.type isEqualToString:@"BC"]) {
                msg.direction = [NSString stringWithFormat:@"%ld",(long)XHBubbleMessageTypeReceiving];
                if(self.avatarUrl) {
                    msg.avatorUrl = self.avatarUrl;
                }else{
                    self.avatarUrl = responModel.pharAvatarUrl;
                    msg.avatorUrl = responModel.pharAvatarUrl;
                }
            }else{
                msg.direction = [NSString stringWithFormat:@"%ld",(long)XHBubbleMessageTypeSending];
                msg.avatorUrl = QWGLOBALMANAGER.configure.avatarUrl;
                
            }
            ContentJson *contentJson = [ContentJson parse:[detail.contentJson JSONValue]];
            if([detail.contentType isEqualToString:@"TXT"]) {
                msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypeText];
                msg.body = contentJson.content;
            }else if([detail.contentType isEqualToString:@"IMG"]) {
                msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypePhoto];
                msg.richbody = contentJson.imgUrl;
            }else if ([detail.contentType isEqualToString:@"POS"]){
                msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypeLocation];
                msg.star = [NSString stringWithFormat:@"%@,%@",contentJson.lat,contentJson.lon];
                msg.body = contentJson.desc;
            }else if ([detail.contentType isEqualToString:@"ACT"]) {
                msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypeActivity];
                msg.star = contentJson.actTitle;
                msg.body = contentJson.actContent;
                msg.avatorUrl = contentJson.actImgUrl;
                msg.richbody = contentJson.actId;
                if(!contentJson.actId) {
                    msg.richbody = contentJson.imgUrl;
                }
            }else if ([detail.contentType isEqualToString:@"PRO"]) {
                msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypeMedicine];
                msg.body = contentJson.name;
                msg.avatorUrl = contentJson.imgUrl;
                msg.richbody = contentJson.id;
            }else if ([detail.contentType isEqualToString:@"PMT"]) {
                msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypeMedicineSpecialOffers];
                msg.star = contentJson.title;
                msg.avatorUrl = contentJson.imgUrl;
                msg.richbody = contentJson.id;
                msg.body = contentJson.content;
            }else if ([detail.contentType isEqualToString:@"SYS"])
            {
                
                if([contentJson.type integerValue] == 1) {
                    msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypeHeader];
                    
                    msg.body = contentJson.content;
                    
                }else if([contentJson.type integerValue] == 2) {
                    msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypeLine];
                    
                    msg.body = contentJson.content;
                    
                }else if ([contentJson.type integerValue] == 3) {
                    msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypePhone];
                    
                    msg.body = contentJson.content;
                }else if ([contentJson.type integerValue] == 4) {
                    
                
                    msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypeFooter];
                    
                    msg.body = contentJson.content;
                }
            }
            
            NSError *error = [QWMessage saveObjToDB:msg];
          
            
                XHMessage *message = [self buildXhmessageWithQWMessage:msg];
                if(message)
                    [self.messages addObject:message];
   
        }
                    [self sortMessages];
                    [self.messageTableView reloadData];
                    [self.messageTableView headerEndRefreshing];
         [self showOrHideHeaderView];
                    [QWGLOBALMANAGER postNotif:NotifPTPMsgNeedUpdate data:nil object:self];
        
    } failure:^(HttpException *e) {
              [self.messageTableView headerEndRefreshing];
    }];
//    [ConsultPTP getByPhar:imSelectQWModelR success:^(CustomerSessionDetailList *responModel) {
//      

//        
//    } failure:^(HttpException *e) {
//    
//}];
 
    [self.messageTableView performSelector:@selector(headerEndRefreshing) withObject:nil afterDelay:5.0f];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self createMessageTimer];
    [self showOrHideHeaderView];
    // 将全局变量的session id 置为会话ID
    QWGLOBALMANAGER.strPTPSessionID = [NSString stringWithFormat:@"%@",ptpSessionID];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (pullMessageDetailTimer) {
        dispatch_source_cancel(pullMessageDetailTimer);
        pullMessageDetailTimer = NULL;
    }
    //取消轮询拉去咨询详情
    [self.messageInputView.inputTextView resignFirstResponder];
//    [QWGLOBALMANAGER updateUnreadCountBadge:0];
    //报告未读数
    
    // 将全局变量的session id 置为空
    QWGLOBALMANAGER.strPTPSessionID = @"";
    
    [super viewWillDisappear:animated];
}

- (XHMessage *)getMessageWithUUID:(NSString *)uuid
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"UUID == %@",uuid];
    NSArray *array = [self.messages filteredArrayUsingPredicate:predicate];
    if([array count] > 0) {
        return array[0];
    }else{
        return nil;
    }
}

- (void)loadMoreMessage
{
    [_taskLock lock];
    if(_cacheList.count == 0)
    {
        [_taskLock unlock];
        return;
    }
    [self addCacheMessage:_cacheList];
    [_cacheList removeAllObjects];
    [self setMessagesReaded:self.branchId];
    [QWGLOBALMANAGER postNotif:NotifPTPMsgNeedUpdate data:nil object:self];
    [_taskLock unlock];
}
-(void)deleteLocalDB
{
       NSString* where = [NSString stringWithFormat:@"sendname = '%@' and recvname = '%@'",QWGLOBALMANAGER.configure.passPort,self.branchId];
    [QWMessage deleteObjFromDBWithWhere:where];
}

- (NSMutableArray *)queryDataBaseCache
{
    NSString* where = [NSString stringWithFormat:@"sendname = '%@' and recvname = '%@'",QWGLOBALMANAGER.configure.passPort,self.branchId];
    
    
     NSArray *array =  [QWMessage getArrayFromDBWithWhere:where
                                             WithorderBy:@"timestamp desc"
                                                  offset:0
                                                   count:15];
    NSMutableArray *retArray = [NSMutableArray arrayWithCapacity:15];
    
    switch (self.showType) {
        case MessageShowTypeNewCreate:
        {
            NSString *where = [NSString stringWithFormat:@"recvname = %@ and direction = %@",self.branchId,[NSString stringWithFormat:@"%ld",(long)XHBubbleMessageTypeSending]];
            QWMessage *msg = [QWMessage getObjFromDBWithWhere:where];
            if(!msg || self.consultInfo) {
                XHMessage *message = [self buildConsultTitleMessage:[[NSDate date] timeIntervalSince1970]];
                if(message)
                    [retArray addObject:message];
            }
            break;
        }
        case MessageShowTypeAnswering: {
            
            break;
        }
        default:
            break;
    }
    for(QWMessage *msg in array)
    {
        XHMessage *message = nil;
        double time = [msg.timestamp doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
        switch ([msg.messagetype intValue])
        {
            case XHBubbleMessageMediaTypeText:
            {
                message = [[XHMessage alloc] initWithText:msg.body sender:msg.sendname timestamp:date UUID:msg.UUID];
                break;
            }
            case XHBubbleMessageMediaTypeStarStore:
            {
                message = [[XHMessage alloc] initInviteEvaluate:msg.body sender:msg.sendname timestamp:date UUID:msg.UUID];
                message.starMark = [msg.star integerValue];
                if(message.starMark > 0) {
                    message.isMarked = NO;
                }else{
                    message.isMarked = YES;
                }
                break;
            }
            case XHBubbleMessageMediaTypeStarClient:
            {
                message = [[XHMessage alloc] initEvaluate:[msg.star floatValue] text:[NSString stringWithFormat:@"评价内容:%@",msg.body] sender:msg.sendname timestamp:date UUID:msg.UUID];
                
                break;
            }
            case XHBubbleMessageMediaTypeLocation:
            {
                NSString *latitude = [msg.star componentsSeparatedByString:@","][0];
                NSString *longitude = [msg.star componentsSeparatedByString:@","][1];
                
                message = [[XHMessage alloc] initWithLocation:msg.body latitude:latitude longitude:longitude sender:msg.sendname timestamp:date UUID:msg.UUID];
                break;
            }

            case XHBubbleMessageMediaTypeActivity:
            {
                NSString *imageUrl = msg.avatorUrl;
                if(imageUrl == nil)
                    imageUrl = @"";
                NSString *star = msg.star;
                if(star == nil || [star isEqual:[NSNull null]])
                    star = @"";
                message = [[XHMessage alloc] initMarketActivity:star sender:msg.sendname imageUrl:imageUrl content:msg.body comment:@"" richBody:msg.richbody timestamp:date UUID:msg.UUID];
                break;
            }
            case XHBubbleMessageMediaTypeMedicineSpecialOffers:
            {
                NSString *imageUrl = msg.avatorUrl;
                if(imageUrl == nil)
                    imageUrl = @"";
                NSString *star = msg.star;
                if(star == nil || [star isEqual:[NSNull null]])
                    star = @"";
                message = [[XHMessage alloc] initWithSpecialOffers:star content:msg.body activityUrl:imageUrl activityId:msg.richbody sender:@"" timestamp:date UUID:msg.UUID];
                break;
            }
            case XHBubbleMessageMediaTypeMedicine:
            {
                message = [[XHMessage alloc] initWithMedicine:msg.body productId:msg.richbody imageUrl:msg.avatorUrl sender:@"" timestamp:date UUID:msg.UUID];
                break;
            }
            case XHBubbleMessageMediaTypeDrugGuide:
            {
                NSString *where = [NSString stringWithFormat:@"UUID = '%@'",msg.UUID];
                NSArray *tagList = [TagWithMessage getArrayFromDBWithWhere:where];
             
                TagWithMessage* tag = tagList[0];
                message = [[XHMessage alloc] initWithDrugGuide:msg.body title:tag.title sender:@"" timestamp:date UUID:msg.UUID tagList:tagList subTitle:tag.title fromTag:msg.fromTag];
                break;
            }
            case XHBubbleMessageMediaTypePurchaseMedicine:
            {
                NSString *where = [NSString stringWithFormat:@"UUID = '%@'",msg.UUID];
                NSArray *tagList = [TagWithMessage getArrayFromDBWithWhere:where];
                
                TagWithMessage * tag = tagList[0];
 
                message = [[XHMessage alloc]initWithPurchaseMedicine:msg.body sender:@"" timestamp:date UUID:msg.UUID tagList:tagList title:msg.title subTitle:tag.title fromTag:msg.fromTag];
                break;
            }
            case XHBubbleMessageMediaTypePhoto:
            {
                UIImage *imagedata =  [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:msg.UUID] ;
                message = [[XHMessage alloc] initWithPhoto:imagedata thumbnailUrl:msg.richbody originPhotoUrl:msg.richbody sender:@"" timestamp:date UUID:msg.UUID richBody:msg.richbody];
                if (self.consultInfo.list.count>0) {
                    [self.uploaderPhoto addObject:message];
                    [self.consultInfo.list removeObjectAtIndex:0];
                }
                
                break;
                
            }
            case XHBubbleMessageMediaTypeMedicineShowOnce:
            {
                message = [[XHMessage alloc] initWithMedicineShowOnce:msg.body productId:msg.richbody imageUrl:msg.avatorUrl sender:@"" timestamp:date UUID:msg.UUID];
                break;
            }
            case XHBubbleMessageMediaTypeMedicineSpecialOffersShowOnce:
            {
                NSString *imageUrl = msg.avatorUrl;
                if(imageUrl == nil)
                    imageUrl = @"";
                NSString *star = msg.star;
                if(star == nil || [star isEqual:[NSNull null]])
                    star = @"";
                message = [[XHMessage alloc] initWithSpecialOffersShowOnce:star content:msg.body activityUrl:imageUrl activityId:msg.richbody sender:@"" timestamp:date UUID:msg.UUID];
                break;
            }
            case XHBubbleMessageMediaTypePhone:
            {
                message = [[XHMessage alloc]initWithPhone:msg.body timestamp:date UUID:msg.UUID];
                break;
            }
            case XHBubbleMessageMediaTypeHeader:
            {
                message = [[XHMessage alloc]initWithHeader:msg.body timestamp:date UUID:msg.UUID];
                break;
            }
            case XHBubbleMessageMediaTypeFooter:
            {
                message = [[XHMessage alloc]initWithFooter:msg.body timestamp:date UUID:msg.UUID];;
                break;
            }
            case XHBubbleMessageMediaTypeLine:
            {
//                [NSDate dateWithTimeIntervalSince1970:[qwmsg.timestamp doubleValue]]
                message = [[XHMessage alloc]initWithLine:msg.body timestamp:date UUID:msg.UUID];;
                break;
            }
            default:
                break;
        }
        
        if([msg.direction intValue] == XHBubbleMessageTypeSending)
        {
            message.avatorUrl = QWGLOBALMANAGER.configure.avatarUrl;
        }else{
            if(self.avatarUrl)
                message.avatorUrl = self.avatarUrl;
            else
                message.avator = [UIImage imageNamed:@"药店默认头像.png"];
        }
        message.sended = [msg.issend intValue];
        message.bubbleMessageType = [msg.direction intValue];
        if(message)
            [retArray addObject:message];
    }
    //[self setupFooterHintView:0 withConsultMessage:nil];
    return retArray;
}

//仿阿里旺旺,通过药品进入,显示该药品的快捷发送链接,
//显示在当前消息列表最后一条,随便消息递增,会往上翻滚,
//点击一次发送链接,移除此链接,并发送出药品消息
- (XHMessage *)buildMedicineShowOnceMessage:(id)drugModel
{
    NSDate *lastTimeStamp = [NSDate date];
    if(self.messages.count > 0) {
        XHMessage *lastMsg = [self.messages lastObject];
        lastTimeStamp = [lastMsg.timestamp dateByAddingTimeInterval:1];
        
    }
//    XHMessage *message = [[XHMessage alloc] initWithMedicineShowOnce:self.drugDetailModel.shortName productId:self.proId imageUrl:PORID_IMAGE(self.proId) sender:self.messageSender timestamp:lastTimeStamp UUID:[XMPPStream generateUUID]];
    XHMessage *message = [[XHMessage alloc] initWithMedicineShowOnce:self.drugDetailModel.shortName productId:self.proId imageUrl:self.drugDetailModel.imgUrl sender:self.messageSender timestamp:lastTimeStamp UUID:[XMPPStream generateUUID]];
   
    
    message.sended = Sended;
    message.bubbleMessageType = XHBubbleMessageTypeSending;
    message.avatorUrl = QWGLOBALMANAGER.configure.avatarUrl;
    
    QWMessage* msg = [[QWMessage alloc] init];
    msg.direction = [NSString stringWithFormat:@"%ld",(long)XHBubbleMessageTypeSending];
    msg.timestamp = [NSString stringWithFormat:@"%.0f",[message.timestamp timeIntervalSince1970]];
    msg.UUID = message.UUID;
    msg.star = message.title;
    msg.avatorUrl = message.activityUrl;
    msg.sendname = QWGLOBALMANAGER.configure.passPort;
    msg.recvname = self.branchId;
    msg.issend = [NSString stringWithFormat:@"%d",Sended];
    msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypeMedicineShowOnce];
    msg.isRead = @"1";
    msg.richbody = message.richBody;
    msg.body = message.text;
    [QWMessage saveObjToDB:msg];
    
    return message;
}

//仿阿里旺旺,通过优惠活动进入,显示该活动的快捷发送链接,
//显示在当前消息列表最后一条,随便消息递增,会往上翻滚,
//点击一次发送链接,移除此链接,并发送出活动消息
- (XHMessage *)buildSpecialOffersShowOnceMessage:(id)drugModel
{
    NSDate *lastTimeStamp = [NSDate date];
    if(self.messages.count > 0) {
        XHMessage *lastMsg = [self.messages lastObject];
        lastTimeStamp = [lastMsg.timestamp dateByAddingTimeInterval:1];
        
    }
    XHMessage *message = [[XHMessage alloc] initWithSpecialOffersShowOnce:self.coupnDetailModel.title content:self.coupnDetailModel.desc activityUrl:self.coupnDetailModel.url activityId:self.coupnDetailModel.id sender:self.messageSender timestamp:lastTimeStamp UUID:[XMPPStream generateUUID]];
    message.sended = Sended;
    message.bubbleMessageType = XHBubbleMessageTypeSending;
    message.avatorUrl = QWGLOBALMANAGER.configure.avatarUrl;
    
    QWMessage* msg = [[QWMessage alloc] init];
    msg.direction = [NSString stringWithFormat:@"%ld",(long)XHBubbleMessageTypeSending];
    msg.timestamp = [NSString stringWithFormat:@"%.0f",[message.timestamp timeIntervalSince1970]];
    msg.UUID = message.UUID;
    msg.star = message.title;
    msg.avatorUrl = message.activityUrl;
    msg.sendname = QWGLOBALMANAGER.configure.passPort;
    msg.recvname = self.branchId;
    msg.issend = [NSString stringWithFormat:@"%d",Sended];
    msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypeMedicineSpecialOffersShowOnce];
    msg.isRead = @"1";
    msg.richbody = message.richBody;
    msg.body = message.text;
    [QWMessage saveObjToDB:msg];
    
    return message;
}

- (XHMessage *)buildConsultTitleMessage:(double)timeStamp
{
    NSString *hintMsg = self.consultInfo.title;
    if(!hintMsg)
        return nil;
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    XHMessage *message = [[XHMessage alloc] initWithText:hintMsg sender:QWGLOBALMANAGER.configure.passPort timestamp:timeDate UUID:self.consultInfo.firstConsultId];
    message.sended = Sended;
    message.bubbleMessageType = XHBubbleMessageTypeSending;
    message.avatorUrl = QWGLOBALMANAGER.configure.avatarUrl;
    QWMessage* msg = [[QWMessage alloc] init];
    msg.direction = [NSString stringWithFormat:@"%ld",(long)XHBubbleMessageTypeSending];
    msg.timestamp = [NSString stringWithFormat:@"%.0f",timeStamp];
    msg.UUID = message.UUID;
    msg.star = @"";
    msg.avatorUrl = @"";
    msg.sendname = QWGLOBALMANAGER.configure.passPort;
    msg.recvname = self.branchId;
    msg.issend = [NSString stringWithFormat:@"%d",Sended];
    msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypeText];
    msg.isRead = @"1";
    msg.richbody = @"";
    msg.body = hintMsg;
    [QWMessage saveObjToDB:msg];

    PharMsgModel *history = [PharMsgModel new];
    history.branchId = self.branchId;
    history.latestTime = [NSString stringWithFormat:@"%.0f",timeStamp];
//    double stimestamp = timeStamp;
    history.timestamp =[NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]]; ;
    timeStamp = timeStamp / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    history.formatShowTime = [QWGLOBALMANAGER updateFirstPageTimeDisplayer:date];
//    history.UUID = message.UUID;
    history.content = hintMsg;
    history.issend = @"2";
     history.title = self.title;
    if(self.consultInfo && self.consultInfo.branchId) {
//        history.diffusion = NO;
        history.branchName = self.consultInfo.storeModel.shortName;
        history.imgUrl = self.consultInfo.storeModel.imgUrl;
        if([self.consultInfo.storeModel.isStar isEqualToString:@"Y"]) {
            history.pharType = @"2";
        }else{
            history.pharType = @"1";
        }
    }else{
//        history.diffusion = YES;
    }
//    history.consultStatus = @"1";
    history.unreadCounts = @"0";
    [PharMsgModel updateObjToDB:history WithKey:message.UUID];
    return message;
}

//由于生成了假的药品和优惠活动发送链接数据,在退出界面时,
//必须清除该数据,这样可以保持从别的界面进入,没有这两条数据影响,
//并且下次再进入时候生成新的假消息数据
- (void)removeShowOnceMessage
{
    NSString *where = [NSString stringWithFormat:@"messagetype = '%d' or messagetype = '%d'",XHBubbleMessageMediaTypeMedicineShowOnce,XHBubbleMessageMediaTypeMedicineSpecialOffersShowOnce];
    [QWMessage deleteObjFromDBWithWhere:where];
}

- (void)sendMedicineLink:(NSIndexPath *)indexPath
{
    if(QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [SVProgressHUD showErrorWithStatus:@"网络连接不可用，请稍后重试" duration:0.8f];
        return;
    }
    XHMessage *message = self.messages[indexPath.row];
    [self.messages removeObjectAtIndex:indexPath.row];
    [self removeShowOnceMessage];
    [self didSendMedicine:message.text productId:message.richBody imageUrl:message.activityUrl fromSender:message.sender onDate:message.timestamp];
}

- (void)sendPTMLink:(NSIndexPath *)indexPath
{
    if(QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [SVProgressHUD showErrorWithStatus:@"网络连接不可用，请稍后重试" duration:0.8f];
        return;
    }
    XHMessage *message = self.messages[indexPath.row];
    [self.messages removeObjectAtIndex:indexPath.row];
    [self removeShowOnceMessage];
    [self didSendActivity:message.title content:message.text comment:@"" activityUrl:message.activityUrl activityId:message.richBody fromSender:message.sender onDate:message.timestamp];
}

- (void)popVCAction:(id)sender
{
//    [QWMessage updateSetToDB:@"issend = '3'" WithWhere:@"issend = '1'"];
    [self removeShowOnceMessage];
    __block UIViewController *popViewController = nil;
    __block NSArray *viewControllers = self.navigationController.viewControllers;
    [viewControllers enumerateObjectsUsingBlock:^(UIViewController *vc, NSUInteger idx, BOOL *stop) {
        if([vc isKindOfClass:[ConsultFirstViewController class]]) {
            *stop = YES;
            popViewController = viewControllers[idx - 1];
        }
    }];
    if(popViewController) {
        [self.navigationController popToViewController:popViewController animated:YES];
    }else{
        [super popVCAction:sender];
    }
}

- (void)reloadAvatar
{
    [self setMessagesReaded:self.branchId];
    
    NSString* where = [NSString stringWithFormat:@"sendname = '%@' or recvname = '%@'",QWGLOBALMANAGER.configure.passPort,self.branchId];
    QWMessage* msg = [QWMessage getObjFromDBWithWhere:where];
    if (msg) {
        msg.isRead = @"0";
        [QWMessage updateObjToDB:msg WithKey:msg.UUID];
    }
    self.messages = [self queryDataBaseCache];
  [self sortMessages];
    [self.messageTableView reloadData];
     [self showOrHideHeaderView];
}

- (void)reloadOfficial
{
    [self setOfficialMessagesRead];
//    if(self.accountType == OfficialType)
//        self.messages = [self queryOfficialDataBaseCache];
    [self.messageTableView reloadData];
     [self showOrHideHeaderView];
}

- (void)pushIntoOfficialIntroduce:(id)sender
{
    IntroduceQwysViewController *introduceQwysViewController = [[IntroduceQwysViewController alloc] initWithNibName:@"IntroduceQwysViewController" bundle:nil];
    [self.navigationController pushViewController:introduceQwysViewController animated:YES];
}


- (void)closeHintAction:(id)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        hintView.alpha = 0.0;
    }];
}

- (void)setRightItems{
    UIView *qwysBarItems = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 55)];
    //[customBarItems setBackgroundColor:[UIColor yellowColor]];
    UIButton *meButton = [[UIButton alloc] initWithFrame:CGRectMake(28, 0, 55, 55)];
    [meButton setImage:[UIImage imageNamed:@"IM_qwys_icon.png"]  forState:UIControlStateNormal];
    [meButton addTarget:self action:@selector(pushIntoOfficialIntroduce:) forControlEvents:UIControlEventTouchDown];
    [qwysBarItems addSubview:meButton];
    
    UIButton *indexButton = [[UIButton alloc] initWithFrame:CGRectMake(65, 0, 55, 55)];
    [indexButton setImage:[UIImage imageNamed:@"icon-unfold.PNG"] forState:UIControlStateNormal];
    [indexButton addTarget:self action:@selector(showIndex) forControlEvents:UIControlEventTouchDown];
    [qwysBarItems addSubview:indexButton];
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width = -20;
    self.navigationItem.rightBarButtonItems = @[fixed,[[UIBarButtonItem alloc] initWithCustomView:qwysBarItems]];
}

- (void)showIndex
{
    self.indexView = [ReturnIndexView sharedManagerWithImage:@[@"icon home.PNG"] title:@[@"首页"] passValue:-1];
    self.indexView.delegate = self;
    [self.indexView show];
}

- (void)RetunIndexView:(ReturnIndexView *)ReturnIndexView didSelectedIndex:(NSIndexPath *)indexPath
{
    [self.indexView hide];
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self performSelector:@selector(delayPopToHome) withObject:nil afterDelay:0.01];
}

- (void)delayPopToHome
{
    [QWGLOBALMANAGER.tabBar setSelectedIndex:0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!self.branchId) {
        self.branchId = self.storeModel.id;
    }
    phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 13, 260, 20)];
    phoneLabel.text = @"您也可以直接拨打药房电话咨询";
    phoneLabel.font  = [UIFont systemFontOfSize:13.0];
    phoneLabel.textColor = RGBHex(kColor6);
    phoneLabel.backgroundColor = [UIColor clearColor];
    phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    

   PharMsgModel *pharMsgModel = [PharMsgModel getObjFromDBWithKey:self.branchId];
    ptpSessionID = pharMsgModel.sessionId;
    phoneView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.view.bounds), CGRectGetMinY(self.view.bounds), APP_W, 48)];
 

//    phoneView.backgroundColor = [UIColor grayColor];
//    UIImage *img =XH_STRETCH_IMAGE([UIImage imageNamed:@"img_bg"], UIEdgeInsetsMake(30, 28, 85, 28));
    phoneView.image = XH_STRETCH_IMAGE([UIImage imageNamed:@"img_bg_2"], UIEdgeInsetsMake(30, 28, 85, 28));
    phoneView.backgroundColor = [UIColor blackColor];
    phoneView.hidden = YES;

    [phoneView addSubview:phoneLabel];
    phoneBtn.frame = CGRectMake(APP_W-56, 2, 44, 44);
    [phoneBtn setImage:[UIImage imageNamed:@"ic_btn_phone"] forState:UIControlStateNormal];
    [phoneBtn addTarget:self action:@selector(makeCall) forControlEvents:UIControlEventTouchDown];
    phoneBtn.hidden = YES;
   
        _cacheList = [NSMutableArray arrayWithCapacity:15];
        _taskLock = [[NSCondition alloc] init];
        [self setMessagesReaded:self.branchId];
        if(self.consultInfo.list.count > 0) {
            {
                for (int i = 0; i<self.consultInfo.list.count; i++) {
                  currentSendPhotoModel = self.consultInfo.list[i];
                    if (currentSendPhotoModel.fullImage) {
                        UIImage *aimg=[currentSendPhotoModel.fullImage imageByScalingToMinSize];
                        [self didAskDocPhoto:aimg fromSender:self.consultInfo.consultId onDate:[NSDate date]  image:@"" uuid:[XMPPStream generateUUID]];
                    }
                    else {
                        [PhotosAlbum getFullImageByAsset:currentSendPhotoModel.asset photoBlock:^(UIImage *fullResolutionImage) {
                            fullResolutionImage = [fullResolutionImage imageByScalingToMinSize];
                            [self didAskDocPhoto:fullResolutionImage fromSender:self.consultInfo.consultId onDate:[NSDate date]  image:@"" uuid:[XMPPStream generateUUID]];
                        } failure:nil];

                    }
            } }
        }
        self.messages = [self queryDataBaseCache];
     [self sortMessages];
//        [self.messageTableView removeHeader];
    
        self.title = self.pharMsgModel.branchName;
//       if(!self.consultInfo){
        [self consultDetailCustomer];
//    }
        [self syncConsultUnreadCount];
   
    if(!QWGLOBALMANAGER.loginStatus) {
//        [self.messageTableView removeHeader];
    }
    
    [QWGLOBALMANAGER postNotif:NotifPTPMsgNeedUpdate data:nil object:self];
    
    // 添加第三方接入数据
    NSMutableArray *shareMenuItems = [NSMutableArray array];
    NSArray *plugIcons = @[@"photo_image.png",@"take_photo_image.png",@"ic_btn_medical.png",@"ic_btn_collect_sale.png"];
    NSArray *plugTitle = @[@"图片",@"拍照",@"药品",@"我收藏的优惠"];
    for (NSString *plugIcon in plugIcons) {
        XHShareMenuItem *shareMenuItem = [[XHShareMenuItem alloc] initWithNormalIconImage:[UIImage imageNamed:plugIcon] title:[plugTitle objectAtIndex:[plugIcons indexOfObject:plugIcon]]];
        [shareMenuItems addObject:shareMenuItem];
    }
    NSString *emojiPath = [[NSBundle mainBundle] pathForResource:@"expressionImage_custom" ofType:@"plist"];
    NSMutableDictionary *emotionDict = [[NSMutableDictionary alloc] initWithContentsOfFile:emojiPath];
    NSArray *allKeys = [emotionDict allKeys];
    XHEmotionManager *emotionManager = [[XHEmotionManager alloc] init];
    //emotionManager.emotionName = @"表情";
    NSMutableArray *emotionManagers = [NSMutableArray arrayWithCapacity:100];
    
#define ROW_NUM     3
#define COLUMN_NUM  7
    for(NSUInteger index = 0; index < [allKeys count]; ++index)
    {
        NSString *key = allKeys[index];
        if(index != 0 && (index % (ROW_NUM * COLUMN_NUM - 1)) == 0){
            XHEmotionManager *subEmotion = [[XHEmotionManager alloc] init];
            subEmotion.emotionName = @"删除";
            subEmotion.imageName = @"backFaceSelect";
            [emotionManager.emotions addObject:subEmotion];
        }
        XHEmotionManager *subEmotion = [[XHEmotionManager alloc] init];
        subEmotion.emotionName = key;
        subEmotion.imageName = emotionDict[key];
        [emotionManager.emotions addObject:subEmotion];
        if (index == [allKeys count] - 1)
        {
            XHEmotionManager *subEmotion = [[XHEmotionManager alloc] init];
            subEmotion.emotionName = @"删除";
            subEmotion.imageName = @"backFaceSelect";
            [emotionManager.emotions addObject:subEmotion];
        }
    }
    [emotionManagers addObject:emotionManager];
    self.emotionManagers = emotionManagers;
    [self.emotionManagerView reloadData];
    self.shareMenuItems = shareMenuItems;
    [self.shareMenuView reloadData];
    if(QWGLOBALMANAGER.loginStatus)
    {
        [self loadDemoDataSource];
    }
    if (self.messageTableView.contentSize.height > self.messageTableView.frame.size.height)
    {
        CGPoint offset = CGPointMake(0, self.messageTableView.contentSize.height - self.messageTableView.frame.size.height);
        [self.messageTableView setContentOffset:offset animated:NO];
    }
    [self.view addSubview:phoneView];
     [self.view addSubview:phoneBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"进店" style:UIBarButtonItemStylePlain target:self action:@selector(pushIntoStoreDetail:)];
}
-(void)showOrHideHeaderView
{
 
    if(![phoneNumber isEqualToString:@""] &&![phoneNumber isEqual:[NSNull null]] && phoneNumber)
    {
        NSIndexPath *tableViewVisbale = [[self.messageTableView indexPathsForVisibleRows] firstObject];
//           NSLog(@"showOrHideHeaderView--phoneNumber---%@",phoneNumber);
        for (NSInteger i = tableViewVisbale.row; i <self.messages.count ; i++) {
            XHMessage *message =  [self.messages objectAtIndex:i];
            if (  message.messageMediaType == XHBubbleMessageMediaTypePhone) {
                phoneView.hidden = YES;
                phoneBtn.hidden = YES;
//                NSLog(@"showOrHideHeaderView--phoneNumber--i-%d",i);

                break;
            }
            phoneBtn.hidden = NO;
            phoneView.hidden = NO;
        }
    }
    
  
}
- (void)pushIntoStoreDetail:(id)sender
{
    PharmacyStoreDetailViewController *pharmacyStoreDetailViewController = [[PharmacyStoreDetailViewController alloc] initWithNibName:@"PharmacyStoreDetailViewController" bundle:nil];
    pharmacyStoreDetailViewController.storeId = self.branchId;
    pharmacyStoreDetailViewController.shouldPushNextWeChat = YES;
    [self.navigationController pushViewController:pharmacyStoreDetailViewController animated:YES];
}

- (void)syncConsultUnreadCount
{

}

-(void)sortMessages
{
    NSSortDescriptor*sorter=[[NSSortDescriptor alloc]initWithKey:@"timestamp" ascending:YES];
    NSMutableArray *sortDescriptors=[[NSMutableArray alloc]initWithObjects:&sorter count:1];
    NSArray *sortArray=[self.messages sortedArrayUsingDescriptors:sortDescriptors];
    self.messages = [[NSMutableArray alloc]initWithArray:sortArray];
}
#pragma mark
#pragma mark 拉取咨询详情

//启动定时器,app 进入后台后,需要停止该轮询,防止数据拉取,自动更新未读数
- (void)createMessageTimer
{
    pullMessageDetailTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(pullMessageDetailTimer, dispatch_time(DISPATCH_TIME_NOW, 0ull*NSEC_PER_SEC), 10ull*NSEC_PER_SEC , DISPATCH_TIME_FOREVER);
    dispatch_source_set_event_handler(pullMessageDetailTimer, ^{
        if([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
            [self consultDetailCustomerPoll];//拉取咨询详情
        }else{
            dispatch_source_cancel(pullMessageDetailTimer);
            pullMessageDetailTimer = NULL;
        }
    });
    dispatch_source_set_cancel_handler(pullMessageDetailTimer, ^{
        NSLog(@"has been canceled");
    });
    dispatch_resume(pullMessageDetailTimer);
}


- (XHMessage *)buildXhmessageWithQWMessage:(QWMessage *)qwmsg
{
    XHMessage *msg = nil;
    switch ([qwmsg.messagetype integerValue]){
        case XHBubbleMessageMediaTypeText: {
            msg = [[XHMessage alloc] initWithText:qwmsg.body sender:self.branchId timestamp:[NSDate dateWithTimeIntervalSince1970:[qwmsg.timestamp doubleValue]] UUID:qwmsg.UUID];
            break;
        }
        case XHBubbleMessageMediaTypePhoto: {
            msg = [[XHMessage alloc] initWithPhoto:nil thumbnailUrl:qwmsg.richbody originPhotoUrl:qwmsg.richbody sender:self.branchId timestamp:[NSDate dateWithTimeIntervalSince1970:[qwmsg.timestamp doubleValue]] UUID:qwmsg.UUID richBody:msg.richBody];
            break;
        }
        case XHBubbleMessageMediaTypeLocation: {
            NSString *latitude = [qwmsg.star componentsSeparatedByString:@","][0];
            NSString *longitude = [qwmsg.star componentsSeparatedByString:@","][1];
            msg = [[XHMessage alloc] initWithLocation:qwmsg.body latitude:latitude longitude:longitude sender:self.branchId timestamp:[NSDate dateWithTimeIntervalSince1970:[qwmsg.timestamp doubleValue]] UUID:qwmsg.UUID];
            break;
        }
        case XHBubbleMessageMediaTypeActivity: {
            msg = [[XHMessage alloc] initMarketActivity:qwmsg.star sender:self.branchId imageUrl:qwmsg.avatorUrl content:qwmsg.body comment:@"" richBody:qwmsg.richbody timestamp:[NSDate dateWithTimeIntervalSince1970:[qwmsg.timestamp doubleValue]] UUID:qwmsg.UUID];
            break;
        }
        case XHBubbleMessageMediaTypeMedicine:
        {
            msg = [[XHMessage alloc] initWithMedicine:qwmsg.body productId:qwmsg.richbody imageUrl:qwmsg.avatorUrl sender:self.messageSender timestamp:[NSDate dateWithTimeIntervalSince1970:[qwmsg.timestamp doubleValue]] UUID:qwmsg.UUID];
            break;
        }
        case XHBubbleMessageMediaTypeMedicineSpecialOffers:
        {
            msg = [[XHMessage alloc] initWithSpecialOffers:qwmsg.star content:qwmsg.body activityUrl:qwmsg.avatorUrl activityId:qwmsg.richbody sender:self.messageSender timestamp:[NSDate dateWithTimeIntervalSince1970:[qwmsg.timestamp doubleValue]] UUID:qwmsg.UUID];
            break;
        }
        case XHBubbleMessageMediaTypePhone:
        {
            msg = [[XHMessage alloc]initWithPhone:qwmsg.body timestamp:[NSDate dateWithTimeIntervalSince1970:[qwmsg.timestamp doubleValue]] UUID:qwmsg.UUID];
            break;
        }
        case XHBubbleMessageMediaTypeHeader:
        {
            msg = [[XHMessage alloc]initWithHeader:qwmsg.body timestamp:[NSDate dateWithTimeIntervalSince1970:[qwmsg.timestamp doubleValue]] UUID:qwmsg.UUID];
            break;
        }
        case XHBubbleMessageMediaTypeFooter:
        {
            msg = [[XHMessage alloc]initWithFooter:qwmsg.body timestamp:[NSDate dateWithTimeIntervalSince1970:[qwmsg.timestamp doubleValue]] UUID:qwmsg.UUID];;
            break;
        }
        case XHBubbleMessageMediaTypeLine:
        {
            msg = [[XHMessage alloc]initWithLine:qwmsg.body timestamp:[NSDate dateWithTimeIntervalSince1970:[qwmsg.timestamp doubleValue]] UUID:qwmsg.UUID];;
            break;
        }

        default:
            break;
    }
    if([qwmsg.direction integerValue] == XHBubbleMessageTypeReceiving) {
        msg.bubbleMessageType = XHBubbleMessageTypeReceiving;
        msg.avatorUrl = self.avatarUrl;
    }else{
        msg.bubbleMessageType = XHBubbleMessageTypeSending;
        msg.avatorUrl = QWGLOBALMANAGER.configure.avatarUrl;
    }
    
    return msg;
}

- (void)parseHistoryMessage:(CustomerSessionDetailList *)model cache:(BOOL)cache
{
    NSInteger SYSMessageCount = 0;
    NSMutableArray *arrItems = [@[] mutableCopy];
    BOOL shouldReload = NO;
    BOOL reloadDB = NO;
//    ptpSessionID = model.sessionId;
    phoneNumber = model.pharContact;
    self.title = model.branchName;
    NSLog(@"phoneNumber-----%@",phoneNumber);
    for(SessionDetailVo *detail in model.details)
    {
        QWMessage *msg = [[QWMessage alloc] init];
        msg.UUID = [NSString stringWithFormat:@"%@",detail.detailId];
        if([QWMessage getObjFromDBWithKey:msg.UUID]){
            msg =  [QWMessage getObjFromDBWithKey:msg.UUID];
                reloadDB = YES;
        }
        msg.timestamp = [NSString stringWithFormat:@"%.0f",[detail.createTime doubleValue] / 1000.0];
        msg.isRead = @"1";
        msg.sendname = QWGLOBALMANAGER.configure.passPort;
        msg.recvname = self.branchId;
        msg.issend = [NSString stringWithFormat:@"%d",Sended];
        if([detail.type isEqualToString:@"BC"]) {
            msg.direction = [NSString stringWithFormat:@"%ld",(long)XHBubbleMessageTypeReceiving];
            if(self.avatarUrl) {
                msg.avatorUrl = self.avatarUrl;
            }else{
                self.avatarUrl = model.pharAvatarUrl;
                msg.avatorUrl = model.pharAvatarUrl;
            }
        }else{
            msg.direction = [NSString stringWithFormat:@"%ld",(long)XHBubbleMessageTypeSending];
            msg.avatorUrl = QWGLOBALMANAGER.configure.avatarUrl;
            
        }
        ContentJson *contentJson = [ContentJson parse:[detail.contentJson JSONValue]];
        if([detail.contentType isEqualToString:@"TXT"]) {
            msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypeText];
            msg.body = contentJson.content;
        }else if([detail.contentType isEqualToString:@"IMG"]) {
            msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypePhoto];
            msg.richbody = contentJson.imgUrl;
        }else if ([detail.contentType isEqualToString:@"POS"]){
            msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypeLocation];
            msg.star = [NSString stringWithFormat:@"%@,%@",contentJson.lat,contentJson.lon];
            msg.body = contentJson.desc;
        }else if ([detail.contentType isEqualToString:@"ACT"]) {
            msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypeActivity];
            msg.star = contentJson.actTitle;
            msg.body = contentJson.actContent;
            msg.avatorUrl = contentJson.actImgUrl;
            msg.richbody = contentJson.actId;
            if(!contentJson.actId) {
                msg.richbody = contentJson.imgUrl;
            }
        }else if ([detail.contentType isEqualToString:@"PRO"]) {
            msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypeMedicine];
            msg.body = contentJson.name;
            msg.avatorUrl = contentJson.imgUrl;
            msg.richbody = contentJson.id;
        }else if ([detail.contentType isEqualToString:@"PMT"]) {
            msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypeMedicineSpecialOffers];
            msg.star = contentJson.title;
            msg.avatorUrl = contentJson.imgUrl;
            msg.richbody = contentJson.id;
            msg.body = contentJson.content;
        }else if ([detail.contentType isEqualToString:@"SYS"])
        {
//             msg.direction = [NSString stringWithFormat:@"%ld",(long)XHBubbleMessageTypeReceiving];
            if([contentJson.type integerValue] == 1) {
                msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypeHeader];
 
                msg.body = contentJson.content;
                
            }else if([contentJson.type integerValue] == 2) {
                msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypeLine];
                
                msg.body = contentJson.content;
                
            }else if ([contentJson.type integerValue] == 3) {
                msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypePhone];
                
                msg.body = contentJson.content;
            }else if ([contentJson.type integerValue] == 4) {
                
                 SYSMessageCount ++;
                msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypeFooter];
                
                msg.body = contentJson.content;
            }
        }
    
        NSError *error = [QWMessage saveObjToDB:msg];
        if(error) {
            continue;
        }
            shouldReload = YES;
            XHMessage *message = [self buildXhmessageWithQWMessage:msg];
            if(message)
//                if (cache && model.details.count == 15 &&cleanMessagetMearge) {
//                    [self.messages removeAllObjects];
//                    cleanMessagetMearge = NO;
//                }
                [self.messages addObject:message];
       
        
        if ([detail.readStatus isEqualToString:@"Y"]) {
            continue;
        }
        if ([contentJson.type integerValue]==1 ||[contentJson.type integerValue]==2 ||[contentJson.type integerValue]==3 ) {
            continue;
        }
        [arrItems addObject:detail.detailId];
    }


    if (reloadDB) {
        self.messages = [self queryDataBaseCache];
    }
  [self sortMessages];

    NSString *strItems = [arrItems componentsJoinedByString:SeparateStr];
    PTPRead *modelR = [PTPRead new];
    modelR.token = QWGLOBALMANAGER.configure.userToken;
     modelR.sessionId =ptpSessionID;
    modelR.detailIds = strItems;
    modelR.containSystem = [NSString stringWithFormat:@"%ld",(long)SYSMessageCount];

  
    if(shouldReload  ){
        [self.messageTableView reloadData];
        
       
        if(!reloadDB) {
//            [XHAudioPlayerHelper playMessageReceivedSound];
       }
        
        if (cache) {
             [self scrollToBottomAnimated:NO];
                   }
        else
        {
            [self scrollToBottomAnimated:YES];

        }
//        if (!cache) {
             [self showOrHideHeaderView];
//        }
       
    }
    if(model.branchName && ![model.branchName isEqualToString:@""]) {
        self.title = model.branchName;
    }
//    if (phoneNumber && phoneBtn.hidden == YES) {
//        [self showOrHideHeaderView];
//    }
    if (cache) {
        return;
    }
    [ConsultPTP ptpMessagetRead:modelR success:^(ApiBody *responModel) {
        
    } failure:^(HttpException *e) {
        
    }];
    
}

- (void)updateConsultRead
{
    ConsultItemReadModelR *modelR = [ConsultItemReadModelR new];
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    modelR.consultId = self.branchId;
    modelR.detailIds = @"";
    [Consult updateConsultItemRead:modelR success:NULL failure:NULL];
    
    
}

- (void)showSpreadHint:(NSString *)hintMsg
{
    XHMessage *tryTypeMessage = [self.messages lastObject];
    if(tryTypeMessage.messageMediaType == XHBubbleMessageMediaTypeSpreadHint) {
        return;
    }
    XHMessage *hintMessage = [[XHMessage alloc] initWithSpreadHint:hintMsg title:@"456" sender:self.branchId timestamp:tryTypeMessage.timestamp UUID:@"" tagList:nil fromTag:0];
    hintMessage.bubbleMessageType = XHBubbleMessageTypeReceiving;
    [self.messages addObject:hintMessage];
}

//全量拉取聊天记录,每次进入时,必须触发拉取一次,同步聊天数据,聊天用户信息,未读数,问题状态等等
- (void)consultDetailCustomer
{
    GetByPharModelR *imSelectQWModelR = [GetByPharModelR new];
    imSelectQWModelR.branchId = self.branchId;
    imSelectQWModelR.token = QWGLOBALMANAGER.configure.userToken;
    imSelectQWModelR.point = @"1";
    imSelectQWModelR.view = @"500";
    imSelectQWModelR.viewType = @"1";
    
    if(self.messages.count == 0) {
        imSelectQWModelR.point = [NSString stringWithFormat:@"0"];
         imSelectQWModelR.view = @"15";
        
    }else if(self.messages.count == 1)
    {
        imSelectQWModelR.point = [NSString stringWithFormat:@"0"];
        imSelectQWModelR.view = @"15";
    }
    else{
        XHMessage *message = self.messages[self.messages.count -1];
        imSelectQWModelR.point = [NSString stringWithFormat:@"%.0f",[message.timestamp timeIntervalSince1970] * 1000.0f];
    }
    [ConsultPTP getByPhar:imSelectQWModelR success:^(CustomerSessionDetailList *responModel) {
         ptpSessionID = responModel.sessionId;
        
        [self parseHistoryMessage:responModel cache:YES];
        
        if (self.consultType == Enum_SendConsult_Drug) {
            XHMessage *message = [self buildMedicineShowOnceMessage:nil];
            [self.messages addObject:message];
            [self loadDemoDataSource];
        }else if(self.consultType == Enum_SendConsult_Coupn){
            XHMessage *message = [self buildSpecialOffersShowOnceMessage:nil];
            [self.messages addObject:message];
            [self loadDemoDataSource];
        }
    } failure:^(HttpException *e) {
        if (self.consultType == Enum_SendConsult_Drug) {
            [self buildMedicineShowOnceMessage:nil];
        }else if(self.consultType == Enum_SendConsult_Coupn){
            [self buildSpecialOffersShowOnceMessage:nil];
        }
    }];
}

//轮询拉取聊天记录,每3s拉取一次,同步聊天数据,聊天用户信息,未读数,问题状态等等
- (void)consultDetailCustomerPoll
{
    if (!ptpSessionID) {
        return;
    }
    PollBySessionidModelR *imSelectQWModelR = [PollBySessionidModelR new];
    
    imSelectQWModelR.token = QWGLOBALMANAGER.configure.userToken;
    
    imSelectQWModelR.sessionId = ptpSessionID;
 
    [ConsultPTP pollBySessionId:imSelectQWModelR success:^(CustomerSessionDetailList *responModel) {
        [self parseHistoryMessage:responModel cache:NO];
    } failure:^(HttpException *e) {
        
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    for ( XHMessage * obj in self.uploaderPhoto) {
          [self addPhotoMessage:(XHMessage *)obj];
    }
    [self.uploaderPhoto removeAllObjects];
     [QWGLOBALMANAGER updateUnreadCount:[NSString stringWithFormat:@"%ld",(long)[QWGLOBALMANAGER getAllUnreadCount]]];
//    int  test =QWGLOBALMANAGER.unReadCount;
    
//        NSLog(@"the QWGLOBALMANAGER int number is %d",test);
        dispatch_async(dispatch_get_main_queue(), ^{
              [self  showOrHideHeaderView];
        }) ;
}

- (void)setupFooterHintView:(NSUInteger)showType withConsultMessage:(NSString *)hintMsg
{
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 100)];
    UIImageView *bubbleImageView = [[UIImageView alloc] init];
    bubbleImageView.frame = CGRectMake(16, 10, APP_W * 0.9, 80);
    bubbleImageView.tag = 1004;
    UIImage *resizeImage = [UIImage imageNamed:@"weChatBubble_Receiving_Solid_无角.png"];
    resizeImage = [resizeImage resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20) resizingMode:UIImageResizingModeStretch];
    bubbleImageView.image = resizeImage;
    bubbleImageView.userInteractionEnabled = YES;
    MLEmojiLabel *emojiLabel = [[MLEmojiLabel alloc] initWithFrame:CGRectMake(10, 10, APP_W * 0.85, 60)];
    emojiLabel.numberOfLines = 4;
    emojiLabel.font = [UIFont systemFontOfSize:14.0f];
    emojiLabel.lineBreakMode = NSLineBreakByWordWrapping;
    emojiLabel.backgroundColor = [UIColor clearColor];
    emojiLabel.emojiDelegate = self;
    //emojiLabel.customEmojiRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    emojiLabel.customEmojiPlistName = @"expressionImage_custom.plist";
    emojiLabel.emojiText = @"药师利用空闲时间解答用药相关问题，如未及时回复请谅解，药师的回答仅供参考。除了咨询药师，您还可以快速自查身体不适。";
    [emojiLabel addLinkToURL:[NSURL URLWithString:@""] withRange:NSMakeRange(48, 4)];
    [bubbleImageView addSubview:emojiLabel];
    [container addSubview:bubbleImageView];

    if(showType != 0) {
        bubbleImageView = [[UIImageView alloc] init];
        bubbleImageView.image = resizeImage;
        emojiLabel = [[MLEmojiLabel alloc] init];
        emojiLabel.numberOfLines = 999;
        emojiLabel.font = [UIFont systemFontOfSize:14.0f];
        emojiLabel.lineBreakMode = NSLineBreakByWordWrapping;
        emojiLabel.backgroundColor = [UIColor clearColor];
        emojiLabel.emojiText = hintMsg;
        
        [bubbleImageView addSubview:emojiLabel];
        [container addSubview:bubbleImageView];
        
        CGFloat maxWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) * 0.85;
        CGSize retSzie = [emojiLabel sizeThatFits:CGSizeMake(maxWidth, MAXFLOAT)];
        retSzie.width = maxWidth;
        retSzie.height = MAX(25, retSzie.height) ;
        emojiLabel.frame = CGRectMake(10, 10, APP_W * 0.85, retSzie.height);
        bubbleImageView.frame = CGRectMake(16, 10, APP_W * 0.9, retSzie.height + 15);
        container.frame = CGRectMake(0, 0, APP_W, 100 + bubbleImageView.frame.size.height + 20);
        UIView *firstView = [container viewWithTag:1004];
        firstView.frame = CGRectMake(16,bubbleImageView.frame.origin.y + bubbleImageView.frame.size.height + 10 , APP_W * 0.9, 80);
        
    }

    self.messageTableView.tableFooterView = container;
}

- (void)mlEmojiLabel:(MLEmojiLabel*)emojiLabel didSelectLink:(NSString*)link withType:(MLEmojiLabelLinkType)type
{
    if(type == MLEmojiLabelLinkTypeQuickSearch) {
        QuickSearchViewController *quickSearchViewController = [[QuickSearchViewController alloc] init];
        quickSearchViewController.backButtonEnabled = YES;
        [self.navigationController pushViewController:quickSearchViewController animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    self.emotionManagers = nil;
    [[XHAudioPlayerHelper shareInstance] setDelegate:nil];
}

- (NSMutableArray *)getAllPreViewImageList
{
    __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    [self.messages enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        XHMessage *model = (XHMessage *)obj;
        if(model.messageMediaType == XHBubbleMessageMediaTypePhoto) {
            if( [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:model.UUID]) {
                [array addObject:model.UUID];
            }
        }
    }];
    self.photoArrays = array;
    return array;
}

- (NSUInteger)currentSelectedImageIndex:(NSArray *)UUIDList currentUUID:(NSString *)currentUUID
{
    __block NSUInteger retValue = 0;
    [UUIDList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *UUID = (NSString *)obj;
        if([currentUUID isEqualToString:UUID]) {
            retValue = idx;
            *stop = YES;
        }
    }];
    return retValue;
    
}

#pragma mark - XHMessageTableViewCell delegate

- (void)multiMediaMessageDidSelectedOnMessage:(id<XHMessageModel>)message atIndexPath:(NSIndexPath *)indexPath onMessageTableViewCell:(XHMessageTableViewCell *)messageTableViewCell
{
    UIViewController *disPlayViewController;
    switch (message.messageMediaType) {
        case XHBubbleMessageMediaTypePhoto: {
            
            //预览图片,左右滑动可以预览全部的聊天图片内容
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PhotoAlbum" bundle:nil];
            PhotoPreView* vc = [sb instantiateViewControllerWithIdentifier:@"PhotoPreView"];
            
            vc.arrPhotos = [self getAllPreViewImageList];   //uiimage或者url数组，用全局数组，否则会crash
            vc.indexSelected = [self currentSelectedImageIndex:self.photoArrays currentUUID:message.UUID];   //点击图片在数组里的index
            
            [self presentViewController:vc animated:YES completion:^{
                
            }];
            break;
        }
        case XHBubbleMessageMediaTypeLocation:
        {
            ShowLocationViewController *showLocationViewController = [[ShowLocationViewController alloc] init];
            showLocationViewController.coordinate = [message location].coordinate;
            showLocationViewController.address = [message text];
            [self.navigationController pushViewController:showLocationViewController animated:YES];
            break;
        }
        case XHBubbleMessageMediaTypeStarStore:
        {
            NSMutableDictionary *setting = [NSMutableDictionary dictionary];
            setting[@"imId"] = [message UUID];
            messageTableViewCell.userInteractionEnabled = NO;
            
            [Appraise appraiseExistWithParams:setting
                                      success:^(AppraiseModel *obj){
                                          if (obj) {
                                              messageTableViewCell.userInteractionEnabled = YES;
                                              if([obj.flag integerValue] == 1) {
                                                  [SVProgressHUD showErrorWithStatus:@"请勿重复评价" duration:0.8f];
                                                  return;
                                              }
                                              MarkPharmacyViewController *markPharmacyViewController = [[MarkPharmacyViewController alloc] initWithNibName:@"MarkPharmacyViewController" bundle:nil];
                                              markPharmacyViewController.UUID = [message UUID];
                                              markPharmacyViewController.hidesBottomBarWhenPushed = YES;
                                              markPharmacyViewController.infoDict = self.infoDict;
                                              WEAKSELF
                                              markPharmacyViewController.InsertNewEvaluate = ^(NSDictionary *dict){
                                                  [weakSelf didSendEvaluateStar:[dict[@"rating"] floatValue] Text:dict[@"remark"] fromSender:self.branchId onDate:[NSDate date]];
                                                  XHMessage *message = self.messages[indexPath.row];
                                                  message.starMark = 0;
                                                  message.isMarked = YES;
                                                  
                                                  QWMessage * msg =  [QWMessage getObjFromDBWithKey:message.UUID];
                                                  if (msg) {
                                                      msg.star = @"0";
                                                      [QWMessage updateObjToDB:msg WithKey:message.UUID];
                                                  }
                                                  [self.messageTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                              };
                                              [self.navigationController pushViewController:markPharmacyViewController animated:YES];
                                          }
                                      }
                                      failure:^(HttpException *e){
                                          messageTableViewCell.userInteractionEnabled = YES;
                                      }];
            
            break;
        }
        case XHBubbleMessageMediaTypeActivity:
        {

            MarketDetailViewController *marketDetailViewController = nil;
            marketDetailViewController = [[MarketDetailViewController alloc] initWithNibName:@"MarketDetailViewController" bundle:nil];
           
            NSString *richBody = [message richBody];
            NSDate *date = [message timestamp];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
            infoDict[@"activityId"] = richBody;
            marketDetailViewController.infoDict = infoDict;
            marketDetailViewController.userType = 1;
            marketDetailViewController.imStatus = 2;
            if (!richBody)
            {
                marketDetailViewController.infoDict =[NSMutableDictionary dictionaryWithDictionary:@{@"title":StrFromObj([message title]),
                                                       @"content":StrFromObj([message text]),
                                                       @"imgUrl":([message activityUrl] ==nil)? @"":[message activityUrl],
                                                       @"publishTime":StrFromObj([formatter stringFromDate:date])                                                             }];
            }
            
            marketDetailViewController.infoNewDict =[NSMutableDictionary dictionaryWithDictionary: @{@"title":StrFromObj([message title]),
                                                      @"activityId":StrFromObj([message richBody]),
                                                      @"content":StrFromObj([message text]),
                                                      @"publishTime":StrFromObj([formatter stringFromDate:date])                                                             }];

            [self.navigationController pushViewController:marketDetailViewController animated:YES];
            break;
        }
        case XHBubbleMessageMediaTypeMedicine:
        {
            DrugFirstDetailViewController *drugFirstDetailViewController = [[DrugFirstDetailViewController alloc] initWithNibName:@"DrugFirstDetailViewController" bundle:nil];
            
            drugFirstDetailViewController.drugId = [message richBody];
            drugFirstDetailViewController.isConsult = YES;
            [self.navigationController pushViewController:drugFirstDetailViewController animated:YES];
            break;
        }
        case XHBubbleMessageMediaTypeMedicineSpecialOffers:
        {
            CouponDeatilViewController *couponDeatilViewController = [[CouponDeatilViewController alloc] initWithNibName:@"CouponDeatilViewController" bundle:nil];
            couponDeatilViewController.commonPromotionId = [message richBody];
            couponDeatilViewController.xmJoin = YES;
            [self.navigationController pushViewController:couponDeatilViewController animated:YES];
            break;
        }
        default:
            break;
    }
    if (disPlayViewController) {
        [self.navigationController pushViewController:disPlayViewController animated:YES];
    }
}

- (void)didSelectedAvatorOnMessage:(id<XHMessageModel>)message atIndexPath:(NSIndexPath *)indexPath
{
    //选中头像后的跳转逻辑
//    if([message bubbleMessageType] == XHBubbleMessageTypeSending)
//    {
//        PersonInformationViewController * personInformation = [[PersonInformationViewController alloc] init];
//        personInformation.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:personInformation animated:YES];
//
//    }
}

- (void)menuDidSelectedAtBubbleMessageMenuSelecteType:(XHBubbleMessageMenuSelecteType)bubbleMessageMenuSelecteType
{
    
}

//删除某一条记录
- (void)deleteOneMessageAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"你确定要删除吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = indexPath.row;
    [alertView show];
    
}

//重新发送这条消息
- (void)resendMessageWithIndexPath:(NSIndexPath *)indexPath
{
    if(self.showType == MessageShowTypeClosed || self.showType == MessageShowTypeTimeout) {
        return;
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"重发该消息？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    alertView.tag = indexPath.row;
}

- (void)askOtherStore
{
    XHMessage *lastMessage = [self.messages lastObject];
    if(lastMessage.messageMediaType == XHBubbleMessageMediaTypeSpreadHint) {
        [self.messages removeLastObject];
        [self.messageTableView reloadData];
         [self showOrHideHeaderView];
    }
    ConsultSpreadModelR *consultSpreadModelR = [ConsultSpreadModelR new];
    consultSpreadModelR.token = QWGLOBALMANAGER.configure.userToken;
    consultSpreadModelR.consultId = self.branchId;
    [Consult consultSpreadWithParam:consultSpreadModelR success:^(BaseAPIModel *model) {
        if([model.apiStatus integerValue] == 0) {
            [SVProgressHUD showSuccessWithStatus:@"您已将问题成功发送给其他药店" duration:0.8f];
        }
    } failure:NULL];
}

- (void)didSelectLinkOnMeseage:(id <XHMessageModel>)message atIndexPath:(NSIndexPath *)indexPath LinkSting:(NSString *)link LinkType:(MLEmojiLabelLinkType)linkType
{
    if(linkType == MLEmojiLabelLinkTypeMedicineDetail)
    {
//        DrugDetailViewController *vc = [[DrugDetailViewController alloc] init];
//        vc.proId = link;
//        [self.navigationController pushViewController:vc animated:YES];
        //新改写的二级页面cj HealthyScenarioDrugModel和QueryProductByClassItemModel相似度极高
        DrugFirstDetailViewController *drugDetailViewController = [[DrugFirstDetailViewController alloc] init];
        drugDetailViewController.drugId=link;
        [self.navigationController pushViewController:drugDetailViewController animated:YES];

    }else if (linkType == MLEmojiLabelLinkTypeDrugGuide)
    {
        DetailSubscriptionListViewController *detailSubscriptionViewController = [[DetailSubscriptionListViewController alloc] init];
        NSString *title = @"慢病订阅";
//        if([message tagList].count > 1){
//            
//            DiseaseSubscriptionViewController *subscription = [[DiseaseSubscriptionViewController alloc] init];
//            subscription.title = @"慢病订阅";
//            subscription.subType = YES;
//            subscription.navigationController = self.navigationController;
//            [self.navigationController pushViewController:subscription animated:YES];
//            
//        }else{
            for(TagWithMessage *tag in [message tagList])
            {
                if([tag.tagId isEqualToString:link]){
                    title = [[message text] substringWithRange:NSMakeRange([tag.start integerValue], [tag.length integerValue])];
                    break;
                }
            }
        DrugGuideListModel    *modelDrugGuideR = [DrugGuideListModel  new];
        modelDrugGuideR.title = title;
        modelDrugGuideR.guideId  = link;
            detailSubscriptionViewController.modelDrugGuide = modelDrugGuideR;
            
            DiseaseSubList* diseasesublist = [DiseaseSubList getObjFromDBWithKey:link];
            if (diseasesublist) {
                diseasesublist.hasRead = @"YES";
                [DiseaseSubList updateObjToDB:diseasesublist WithKey:link];
            }
            //[APPDelegate.dataBase updateHasReadFromDiseaseWithId:link hasRead:YES];
            
            [self.navigationController pushViewController:detailSubscriptionViewController animated:YES];
        }
//    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 1001) {
        if (buttonIndex == 1) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phoneNumber]]];
        }
    }else if([alertView.message isEqualToString:@"你确定要删除吗？"]) {
        if(buttonIndex == 1) {
            
            XHMessage *message = self.messages[alertView.tag];
            
            PTPRemove *consultDetailRemoveModelR = [PTPRemove new];
            consultDetailRemoveModelR.sessionId = ptpSessionID;
            consultDetailRemoveModelR.detailId = [message.UUID integerValue];
            consultDetailRemoveModelR.token = QWGLOBALMANAGER.configure.userToken;
            
            //    [Consult consultDetailRemoveWithParams:consultDetailRemoveModelR success:^(id obj) {
            //
            //    } failure:NULL];
            
            [ConsultPTP ptpMessagetRemove:consultDetailRemoveModelR success:^(ApiBody *responModel) {
                PharMsgModel *history = [PharMsgModel getObjFromDBWithKey:self.branchId];
                if(self.messages.count == 0) {
                    [history deleteToDB];
                }else{
                    XHMessage *msg = [self.messages lastObject];
                    history.issend = [NSString stringWithFormat:@"%d",msg.sended];
                    [QWGLOBALMANAGER postNotif:NotiMessagePTPNeedUpdate data:self.branchId object:nil];
                }
            } failure:^(HttpException *e) {
                
            }];
            //删除消息 并存到历史消息中
            QWMessage* msg = [QWMessage getObjFromDBWithKey:message.UUID];
            if (msg) {
                
                [QWMessage deleteObjFromDBWithKey:message.UUID];
            }
            
            [self.messages removeObjectAtIndex:alertView.tag];
            [self.messageTableView reloadData];
            [self showOrHideHeaderView];
        }
    }else{
        if(buttonIndex == 1)
        {
//        if(QWGLOBALMANAGER.currentNetWork != kNotReachable) {
            XHMessage *textMessage = self.messages[alertView.tag];
            [self.messages removeObject:textMessage];
            textMessage.timestamp = [NSDate date];
            textMessage.sended = Sending;
            QWMessage *msg = [QWMessage getObjFromDBWithKey:textMessage.UUID];
            msg.timestamp = [NSString stringWithFormat:@"%.0f",[textMessage.timestamp timeIntervalSince1970]];
            msg.issend = @"1";
            [QWMessage updateObjToDB:msg WithKey:msg.UUID];

            PharMsgModel *historyMsg = [PharMsgModel getObjFromDBWithKey:self.branchId];
            if(!historyMsg)
                historyMsg = [[PharMsgModel alloc] init];
            historyMsg.branchId = self.branchId;
            historyMsg.title = self.title;
            historyMsg.timestamp = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];;
            historyMsg.latestTime = msg.timestamp;
            historyMsg.content = msg.body;
            historyMsg.formatShowTime = [QWGLOBALMANAGER updateFirstPageTimeDisplayer:[NSDate dateWithTimeIntervalSince1970:[historyMsg.timestamp doubleValue]]];
//            historyMsg.direction = [NSString stringWithFormat:@"%ld",(long)XHBubbleMessageTypeSending];
//            historyMsg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypeLocation];
            historyMsg.UUID = msg.UUID;
            [PharMsgModel updateObjToDB:historyMsg WithKey:historyMsg.branchId];
            switch (textMessage.messageMediaType)
            {
                case XHBubbleMessageMediaTypePhoto:
                {
                    textMessage.sended = Sending;
          
                    [self performSelectorOnMainThread:@selector(doSendPhoto:) withObject:textMessage.UUID   waitUntilDone:NO];
                    break;
                }
                case XHBubbleMessageMediaTypeMedicine:
                {
                    [self sendMedicineMessageWithHTTP:textMessage];
                    [self.messages addObject:textMessage];
                    break;
                }
                case XHBubbleMessageMediaTypeMedicineSpecialOffers:
                {
                    [self sendActivityWithHTTP:textMessage];
                    [self.messages addObject:textMessage];
                    break;
                }
                default:{
                   [self sendTextMessageWithHTTP:textMessage];
                    [self.messages addObject:textMessage];
                    break;
                }
            }
            [self.messageTableView reloadData];
            [self scrollToBottomAnimated:YES];
            [self showOrHideHeaderView];
//         }
        }
    }
}

#pragma mark - XHEmotionManagerView DataSource

- (NSInteger)numberOfEmotionManagers
{
    return self.emotionManagers.count;
}

- (XHEmotionManager *)emotionManagerForColumn:(NSInteger)column
{
    return [self.emotionManagers objectAtIndex:column];
}

- (NSArray *)emotionManagersAtManager
{
    return self.emotionManagers;
}

#pragma mark - XHMessageTableViewController Delegate

- (BOOL)shouldLoadMoreMessagesScrollToTop
{
    return YES;
}

- (void)prepareSendingModel:(NSString *)text
                 fromSender:(NSString *)sender
                     onDate:(NSDate *)date
                    message:(XHMessage *)message
{
    QWMessage * msg = [[QWMessage alloc] init];
    msg.direction = [NSString stringWithFormat:@"%ld",(long)XHBubbleMessageTypeSending];
    msg.timestamp = [NSString stringWithFormat:@"%.0f",[date timeIntervalSince1970]];
    msg.UUID = message.UUID;
    msg.star = [NSString stringWithFormat:@"%f",message.starMark];
    msg.avatorUrl = message.avatorUrl;
    msg.sendname = QWGLOBALMANAGER.configure.passPort;
    msg.recvname = self.branchId;
    msg.issend = [NSString stringWithFormat:@"%d",message.sended];
    msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)message.messageMediaType];
    msg.isRead = @"1";
    msg.richbody = message.richBody;
    msg.star = message.title;
    msg.avatorUrl = message.activityUrl;
    
    msg.body = text;
    [QWMessage saveObjToDB:msg];
    
//    PharMsgModel *originalMsg = [PharMsgModel getObjFromDBWithKey:sender];
//    PharMsgModel *hmsg = [[PharMsgModel alloc] init];
//    hmsg.relatedid = self.messageSender;
//    hmsg.timestamp = [NSString stringWithFormat:@"%.0f",[date timeIntervalSince1970]];
//    hmsg.body = text;
//    hmsg.groupName = originalMsg.groupName;
//    hmsg.groupType = originalMsg.groupType;
//    hmsg.groupId = originalMsg.groupId;
//    hmsg.avatarurl = originalMsg.avatarurl;
//    hmsg.direction = [NSString stringWithFormat:@"%ld",(long)XHBubbleMessageTypeSending];
//    hmsg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)message.messageMediaType];
//    hmsg.UUID = message.UUID;
//    hmsg.issend = [NSString stringWithFormat:@"%d",Sending];;
//    [PharMsgModel updateObjToDB:hmsg WithKey:hmsg.relatedid];
}

- (void)didSendEvaluateStar:(CGFloat)star
                       Text:(NSString *)text
                 fromSender:(NSString *)sender
                     onDate:(NSDate *)date
{
    if(self.errorMsg && ![self.errorMsg isEqualToString:@""])
    {
        [self finishSendMessageWithBubbleMessageType:XHBubbleMessageMediaTypeText];
        [SVProgressHUD showErrorWithStatus:self.errorMsg duration:0.8f];
        return;
    }
    
    XHMessage *message = [[XHMessage alloc] initEvaluate:star text:[NSString stringWithFormat:@"评价内容:%@",text] sender:sender timestamp:date UUID:[XMPPStream generateUUID]];
    if(QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        message.sended = Sending;
    }else{
        message.sended = SendFailure;
    }
    message.starMark = star;
    message.bubbleMessageType = XHBubbleMessageTypeSending;
    message.avatorUrl = QWGLOBALMANAGER.configure.avatarUrl;

    [self addMessage:message];
    [self prepareSendingModel:text fromSender:sender onDate:date message:message];

    [self finishSendMessageWithBubbleMessageType:XHBubbleMessageMediaTypeText];
    
    if(QWGLOBALMANAGER.currentNetWork == kNotReachable)
    {
        [self.messageInputView.inputTextView resignFirstResponder];
        [self scrollToBottomAnimated:YES];
        [SVProgressHUD showErrorWithStatus:@"网络连接不可用，请稍后重试" duration:0.8f];
    }
}

/**
 *  发送文本消息的回调方法
 *
 *  @param text   目标文本字符串
 *  @param sender 发送者的名字
 *  @param date   发送时间
 */
- (void)didSendText:(NSString *)text fromSender:(NSString *)sender onDate:(NSDate *)date
{
    if([text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"发送内容不得为空!" duration:0.8f];
        return;
    }
    if([text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length > 1200)
    {
        [SVProgressHUD showErrorWithStatus:@"输入字数过长!" duration:0.8f];
        return;
    }
    XHMessage *textMessage = [[XHMessage alloc] initWithText:text sender:sender timestamp:date UUID:[XMPPStream generateUUID]];
    if(QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        textMessage.sended = Sending;
    }else{
        textMessage.sended = SendFailure;
    }
    textMessage.starMark = 0;
    textMessage.messageMediaType = XHBubbleMessageMediaTypeText;
    textMessage.bubbleMessageType = XHBubbleMessageTypeSending;
    textMessage.avator = [UIImage imageNamed:@"avator"];
    textMessage.avatorUrl = QWGLOBALMANAGER.configure.avatarUrl;
    [self addMessage:textMessage];
    [self finishSendMessageWithBubbleMessageType:XHBubbleMessageMediaTypeText];
    [self prepareSendingModel:text fromSender:sender onDate:date message:textMessage];
    if(QWGLOBALMANAGER.currentNetWork == kNotReachable)
    {
        [self.messageInputView.inputTextView resignFirstResponder];
        [self scrollToBottomAnimated:YES];
        [SVProgressHUD showErrorWithStatus:@"网络连接不可用，请稍后重试" duration:0.8f];
    }
    [QWGLOBALMANAGER postNotif:NotiMessagePTPNeedUpdate data:self.branchId object:nil];
    [self sendTextMessageWithHTTP:textMessage];
    
    PharMsgModel *historyMsg = [PharMsgModel getObjFromDBWithKey:self.branchId];
    if(!historyMsg)
        historyMsg = [[PharMsgModel alloc] init];
    historyMsg.branchId = self.branchId;
    historyMsg.latestTime =[NSString stringWithFormat:@"%@",textMessage.timestamp] ;
    historyMsg.content = text;
    historyMsg.timestamp =[NSString stringWithFormat:@"%.0f",[ date timeIntervalSince1970]];;
     historyMsg.title = self.title;
    historyMsg.issend = [NSString stringWithFormat:@"%d",Sending];
    historyMsg.UUID = textMessage.UUID;
    historyMsg.formatShowTime = [QWGLOBALMANAGER updateFirstPageTimeDisplayer:[NSDate dateWithTimeIntervalSince1970:[historyMsg.timestamp doubleValue]]];
    [PharMsgModel updateObjToDB:historyMsg WithKey:historyMsg.branchId];
}

- (void)sendTextMessageWithHTTP:(XHMessage *)textMessage
{
    
    

    
    PTPCreate *consultDetailCreateModelR = [PTPCreate new];
    consultDetailCreateModelR.token = QWGLOBALMANAGER.configure.userToken;
    consultDetailCreateModelR.sessionId = ptpSessionID;
    consultDetailCreateModelR.contentType = @"TXT";
    consultDetailCreateModelR.UUID = textMessage.UUID;
    ContentJson *contentJson = [ContentJson new];
    contentJson.content = textMessage.text;
    
    consultDetailCreateModelR.contentJson = [[contentJson dictionaryModel] JSONRepresentation];
    [ConsultPTP ptpMessagetCreate:consultDetailCreateModelR success:^(DetailCreateResult *responModel) {
        if([responModel.apiStatus integerValue] == 0) {
            [self messageDidSendSuccess:responModel.UUID withCreateModel:responModel];
        }else{
            [SVProgressHUD showErrorWithStatus:responModel.apiStatus duration:0.8f];
            [self messageDidSendFailure:responModel.UUID];
        }
    } failure:^(HttpException *e) {
           [self messageDidSendFailure:e.UUID];
    }];

}

- (void)didSendText:(NSString *)text fromSender:(NSString *)sender onDate:(NSDate *)date withActivityMessage:(XHMessage *)activityMessage
{
    XHMessage *textMessage = [[XHMessage alloc] initWithText:text sender:sender timestamp:date UUID:[XMPPStream generateUUID]];
    if(QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        textMessage.sended = Sending;
    }else{
        textMessage.sended = SendFailure;
    }
    
    textMessage.messageMediaType = XHBubbleMessageMediaTypeText;
    textMessage.bubbleMessageType = XHBubbleMessageTypeSending;
    textMessage.avatorUrl = QWGLOBALMANAGER.configure.avatarUrl;
    
    [self addMessages:@[activityMessage,textMessage]];
    
    QWMessage * msg = [[QWMessage alloc] init];
    msg.direction = [NSString stringWithFormat:@"%ld",(long)XHBubbleMessageTypeSending];
    msg.timestamp = [NSString stringWithFormat:@"%.0f",[date timeIntervalSince1970]];
    msg.UUID = textMessage.UUID;
    msg.star = [NSString stringWithFormat:@"%f",textMessage.starMark];
    msg.avatorUrl = textMessage.avatorUrl;
    msg.sendname = QWGLOBALMANAGER.configure.passPort;
    msg.recvname = self.branchId;
    if(QWGLOBALMANAGER.currentNetWork == kNotReachable)
    {
        msg.issend = [NSString stringWithFormat:@"%d",SendFailure];
    }else{
        msg.issend = [NSString stringWithFormat:@"%d",Sending];
    }
    msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypeText];
    msg.isRead = @"1";
    msg.richbody = @"";
    msg.body = text;
    [QWMessage saveObjToDB:msg];
    PharMsgModel *historyMsg = [PharMsgModel getObjFromDBWithKey:self.branchId];
    if(!historyMsg)
        historyMsg = [[PharMsgModel alloc] init];
    historyMsg.branchId = self.branchId;
    historyMsg.latestTime =[NSString stringWithFormat:@"%@",textMessage.timestamp] ;
    historyMsg.content = text;
    historyMsg.timestamp =[NSString stringWithFormat:@"%.0f",[  date timeIntervalSince1970]];;
     historyMsg.title = self.title;
    historyMsg.issend = [NSString stringWithFormat:@"%d",Sending];
    historyMsg.UUID = textMessage.UUID;
    historyMsg.formatShowTime = [QWGLOBALMANAGER updateFirstPageTimeDisplayer:[NSDate dateWithTimeIntervalSince1970:[historyMsg.timestamp doubleValue]]];
    [PharMsgModel updateObjToDB:historyMsg WithKey:historyMsg.branchId];
    [self performSelector:@selector(sendTextMessageWithHTTP:) withObject:textMessage afterDelay:2.0f];
}

- (void)didSendActivity:(NSString *)text
                content:(NSString *)content
                comment:(NSString *)comment
            activityUrl:(NSString *)activityUrl
             activityId:(NSString *)activityId
             fromSender:(NSString *)sender
                 onDate:(NSDate *)date
{
    XHMessage *textMessage = [[XHMessage alloc] initWithSpecialOffers:text content:content activityUrl:activityUrl activityId:activityId sender:sender timestamp:date UUID:[XMPPStream generateUUID]];
    if(QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        textMessage.sended = Sending;
    }else{
        textMessage.sended = SendFailure;
    }
    textMessage.starMark = 0;
    textMessage.avator = [UIImage imageNamed:@"avator"];
    textMessage.bubbleMessageType = XHBubbleMessageTypeSending;
    textMessage.avatorUrl = QWGLOBALMANAGER.configure.avatarUrl;
    [self finishSendMessageWithBubbleMessageType:XHBubbleMessageMediaTypeText];
    [self prepareSendingModel:content fromSender:sender onDate:date message:textMessage];
    if(QWGLOBALMANAGER.currentNetWork == kNotReachable)
    {
        [self.messageInputView.inputTextView resignFirstResponder];
        [self scrollToBottomAnimated:YES];
        [SVProgressHUD showErrorWithStatus:@"网络连接不可用，请稍后重试" duration:0.8f];
    }
    [QWGLOBALMANAGER postNotif:NotiMessagePTPNeedUpdate data:self.branchId object:nil];
    
    if(comment && comment.length > 0 && [comment stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0)
    {
        NSDate *continueDate = [date dateByAddingTimeInterval:1];
        [self didSendText:comment fromSender:sender onDate:continueDate withActivityMessage:textMessage];
    }else{
        [self addMessage:textMessage];
    }
    PharMsgModel *historyMsg = [PharMsgModel getObjFromDBWithKey:self.branchId];
    if(!historyMsg)
        historyMsg = [[PharMsgModel alloc] init];
    historyMsg.branchId = self.branchId;
    historyMsg.latestTime =[NSString stringWithFormat:@"%@",textMessage.timestamp] ;
    historyMsg.content = @"[活动]";
     historyMsg.title = self.title;
    historyMsg.timestamp =[NSString stringWithFormat:@"%.0f",[ date timeIntervalSince1970]];;
    historyMsg.issend = [NSString stringWithFormat:@"%d",Sending];
    historyMsg.UUID = textMessage.UUID;
    historyMsg.formatShowTime = [QWGLOBALMANAGER updateFirstPageTimeDisplayer:[NSDate dateWithTimeIntervalSince1970:[historyMsg.timestamp doubleValue]]];
    [PharMsgModel updateObjToDB:historyMsg WithKey:historyMsg.branchId];
    [self sendActivityWithHTTP:textMessage];
}

- (void)sendActivityWithHTTP:(XHMessage *)textMessage
{
    PTPCreate *consultDetailCreateModelR = [PTPCreate new];
    consultDetailCreateModelR.token = QWGLOBALMANAGER.configure.userToken;

    consultDetailCreateModelR.sessionId = ptpSessionID;

    consultDetailCreateModelR.contentType = @"PMT";

    consultDetailCreateModelR.UUID = textMessage.UUID;
    ContentJson *contentJson = [ContentJson new];
    contentJson.content = textMessage.text;
    contentJson.title = textMessage.title;
    contentJson.id = textMessage.richBody;
    contentJson.imgUrl = textMessage.activityUrl;
    consultDetailCreateModelR.contentJson = [[contentJson dictionaryModel] JSONRepresentation];
    
    
    [ConsultPTP ptpMessagetCreate:consultDetailCreateModelR success:^(DetailCreateResult *responModel) {
        if([responModel.apiStatus integerValue] == 0) {
            [self messageDidSendSuccess:responModel.UUID withCreateModel:responModel];
        }else{
            [SVProgressHUD showErrorWithStatus:responModel.apiStatus duration:0.8f];
            [self messageDidSendFailure:responModel.UUID];
        }
    } failure:^(HttpException *e) {
        [self messageDidSendFailure:e.UUID];
    }];
//    [Consult consultDetailCreateWithParams:consultDetailCreateModelR success:^(ConsultDetailCreateModel *model) {
//        if([model.apiStatus integerValue] == 0) {
//            [self messageDidSendSuccess:model.UUID withCreateModel:model];
//        }else{
//            [SVProgressHUD showErrorWithStatus:model.apiStatus duration:0.8f];
//            [self messageDidSendFailure:model.UUID];
//        }
//    } failure:^(HttpException *e) {
//        [self messageDidSendFailure:e.UUID];
//    }];
}


- (void)didSendMedicine:(NSString *)text productId:(NSString *)productId imageUrl:(NSString *)imageUrl fromSender:(NSString *)sender onDate:(NSDate *)date
{
    XHMessage *textMessage = [[XHMessage alloc] initWithMedicine:text productId:productId imageUrl:imageUrl sender:sender timestamp:date UUID:[XMPPStream generateUUID]];
    if(QWGLOBALMANAGER.currentNetWork != kNotReachable) {
        textMessage.sended = Sending;
    }else{
        textMessage.sended = SendFailure;
    }
    textMessage.starMark = 0;
    textMessage.avator = [UIImage imageNamed:@"avator"];
    textMessage.bubbleMessageType = XHBubbleMessageTypeSending;
    textMessage.avatorUrl = QWGLOBALMANAGER.configure.avatarUrl;
    [self addMessage:textMessage];
    [self finishSendMessageWithBubbleMessageType:XHBubbleMessageMediaTypeText];
    [self prepareSendingModel:text fromSender:sender onDate:date message:textMessage];
    if(QWGLOBALMANAGER.currentNetWork == kNotReachable)
    {
        [self.messageInputView.inputTextView resignFirstResponder];
        [self scrollToBottomAnimated:YES];
        [SVProgressHUD showErrorWithStatus:@"网络连接不可用，请稍后重试" duration:0.8f];
    }
    [QWGLOBALMANAGER postNotif:NotiMessagePTPNeedUpdate data:self.branchId object:nil];
    PharMsgModel *historyMsg = [PharMsgModel getObjFromDBWithKey:self.branchId];
    if(!historyMsg)
        historyMsg = [[PharMsgModel alloc] init];
    historyMsg.branchId = self.branchId;
     historyMsg.title = self.title;
    historyMsg.latestTime =[NSString stringWithFormat:@"%@",textMessage.timestamp] ;
    historyMsg.content = @"[药品]";
    historyMsg.timestamp =[NSString stringWithFormat:@"%.0f",[  date  timeIntervalSince1970]];;
    historyMsg.issend = [NSString stringWithFormat:@"%d",Sending];
    historyMsg.UUID = textMessage.UUID;
    historyMsg.formatShowTime = [QWGLOBALMANAGER updateFirstPageTimeDisplayer:[NSDate dateWithTimeIntervalSince1970:[historyMsg.timestamp doubleValue]]];
    [PharMsgModel updateObjToDB:historyMsg WithKey:historyMsg.branchId];
    [self sendMedicineMessageWithHTTP:textMessage];
}

- (void)sendMedicineMessageWithHTTP:(XHMessage *)textMessage
{
    PTPCreate *consultDetailCreateModelR = [PTPCreate new];
    consultDetailCreateModelR.token = QWGLOBALMANAGER.configure.userToken;

    consultDetailCreateModelR.sessionId = ptpSessionID;

    consultDetailCreateModelR.contentType = @"PRO";

    consultDetailCreateModelR.UUID = textMessage.UUID;
    ContentJson *contentJson = [ContentJson new];
    contentJson.name = textMessage.text;
    contentJson.id = textMessage.richBody;
    contentJson.imgUrl = textMessage.activityUrl;
    consultDetailCreateModelR.contentJson = [[contentJson dictionaryModel] JSONRepresentation];

    
    [ConsultPTP ptpMessagetCreate:consultDetailCreateModelR success:^(DetailCreateResult *responModel) {
        if([responModel.apiStatus integerValue] == 0) {
            [self messageDidSendSuccess:responModel.UUID withCreateModel:responModel];
        }else{
            [SVProgressHUD showErrorWithStatus:responModel.apiStatus duration:0.8f];
            [self messageDidSendFailure:responModel.UUID];
        }
    } failure:^(HttpException *e) {
        [self messageDidSendFailure:e.UUID];
    }];
//    [Consult consultDetailCreateWithParams:consultDetailCreateModelR success:^(ConsultDetailCreateModel *model) {
//        if([model.apiStatus integerValue] == 0) {
//            [self messageDidSendSuccess:model.UUID withCreateModel:model];
//        }else{
//            [SVProgressHUD showErrorWithStatus:model.apiStatus duration:0.8f];
//            [self messageDidSendFailure:model.UUID];
//        }
//    } failure:^(HttpException *e) {
//        [self messageDidSendFailure:e.UUID];
//    }];

}


/**
 *  是否显示时间轴Label的回调方法
 *  @param indexPath 目标消息的位置IndexPath
 *  @return 根据indexPath获取消息的Model的对象，从而判断返回YES or NO来控制是否显示时间轴Label
 */
- (BOOL)shouldDisplayTimestampForRowAtIndexPath:(NSIndexPath *)indexPath {

    XHMessage *message1 = self.messages[indexPath.row];
    if(indexPath.row == 0) {
        return YES;
    }else{
        XHMessage *message0 = self.messages[indexPath.row - 1];
        NSTimeInterval offset = [message1.timestamp timeIntervalSinceDate:message0.timestamp];
        if(offset >= 300.0)
            return YES;
    }
    return NO;
}

/**
 *  配置Cell的样式或者字体
 *
 *  @param cell      目标Cell
 *  @param indexPath 目标Cell所在位置IndexPath
 */
- (void)configureCell:(XHMessageTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{

}

/**
 *  协议回掉是否支持用户手动滚动
 *
 *  @return 返回YES or NO
 */
- (BOOL)shouldPreventScrollToBottomWhileUserScrolling
{
    return YES;
}

-(void)setMessagesReaded:(NSString*)relatedid
{
    NSString* where = [NSString stringWithFormat:@"sendname = '%@' or recvname = '%@'",QWGLOBALMANAGER.configure.passPort,self.branchId];
    [QWMessage updateSetToDB:@"isRead = '1'" WithWhere:where];
}

-(void)setOfficialMessagesRead
{
    [OfficialMessages updateSetToDB:@"issend = '1'" WithWhere:nil];
//    NSUserDefaults *UserD = [NSUserDefaults standardUserDefaults];
//    NSInteger intCount = [UserD integerForKey:APP_BADGE_COUNT];
//    [QWGLOBALMANAGER updateUnreadCountBadge:intCount];
}
/**
 *  发送图片消息的回调方法
 *
 *  @param photo  目标图片对象，后续有可能会换
 *  @param sender 发送者的名字
 *  @param date   发送时间
 */
- (void)didSendPhoto:(UIImage *)photo fromSender:(NSString *)sender onDate:(NSDate *)date image:(NSString *)url uuid:(NSString *)uuid
{
    [[SDImageCache sharedImageCache] storeImage:photo forKey:uuid toDisk:YES];
    XHMessage *textMessage   = [[XHMessage alloc] initWithPhoto:photo thumbnailUrl:url originPhotoUrl:url sender:sender timestamp:date UUID:uuid richBody:url];
    textMessage.photo = photo;
    textMessage.sended = Sending;
    textMessage.thumbnailUrl = url;
    textMessage.avatorUrl =QWGLOBALMANAGER.configure.avatarUrl;;
    [self addPhotoMessage:textMessage];
    [self finishSendMessageWithBubbleMessageType:XHBubbleMessageMediaTypePhoto];
    QWMessage * msg = [[QWMessage alloc] init];
    msg.direction = [NSString stringWithFormat:@"%ld",(long)XHBubbleMessageTypeSending];
    msg.timestamp = [NSString stringWithFormat:@"%.0f",[date timeIntervalSince1970]];
    msg.UUID = textMessage.UUID;
    msg.star = [NSString stringWithFormat:@"%f",textMessage.starMark];
    msg.avatorUrl = textMessage.avatorUrl;
    msg.sendname = QWGLOBALMANAGER.configure.passPort;
    msg.recvname = self.branchId;
    msg.issend = [NSString stringWithFormat:@"%d",Sending];
    msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypePhoto];
    msg.isRead = @"1";
    msg.richbody = @"";
    msg.body = @"[图片]";
    [QWMessage saveObjToDB:msg];
    [QWGLOBALMANAGER postNotif:NotiMessagePTPNeedUpdate data:self.branchId object:nil];
    if(QWGLOBALMANAGER.currentNetWork == kNotReachable) {
        [self messageDidSendFailure:uuid];
    }
    PharMsgModel *historyMsg = [PharMsgModel getObjFromDBWithKey:self.branchId];
    if(!historyMsg)
        historyMsg = [[PharMsgModel alloc] init];
    historyMsg.branchId = self.branchId;
    historyMsg.latestTime =[NSString stringWithFormat:@"%@",textMessage.timestamp] ;
    historyMsg.content = @"[图片]";
     historyMsg.title = self.title;
    historyMsg.timestamp = [NSString stringWithFormat:@"%.0f",[date timeIntervalSince1970]];;
    historyMsg.issend = [NSString stringWithFormat:@"%d",Sending];
    historyMsg.UUID = textMessage.UUID;
    historyMsg.formatShowTime = [QWGLOBALMANAGER updateFirstPageTimeDisplayer:[NSDate dateWithTimeIntervalSince1970:[historyMsg.timestamp doubleValue]]];
    [PharMsgModel updateObjToDB:historyMsg WithKey:historyMsg.branchId];
}

-(void)sendXmppPhototimestamp:(NSDate *)timestamp
                     richBody:(NSString *)richBody
                         UUID:(NSString *)UUID
{
    PTPCreate *consultDetailCreateModelR = [PTPCreate new];
    consultDetailCreateModelR.token = QWGLOBALMANAGER.configure.userToken;
    consultDetailCreateModelR.sessionId = ptpSessionID;
    consultDetailCreateModelR.contentType = @"IMG";
    consultDetailCreateModelR.UUID = UUID;
    ContentJson *contentJson = [ContentJson new];
    contentJson.imgUrl = richBody;
    consultDetailCreateModelR.contentJson = [[contentJson dictionaryModel] JSONRepresentation];
    [self.consultInfo.list removeObject:currentSendPhotoModel];
    
    [ConsultPTP ptpMessagetCreate:consultDetailCreateModelR success:^(DetailCreateResult *responModel) {
        if([responModel.apiStatus integerValue] == 0) {
            [self messageDidSendSuccess:responModel.UUID withCreateModel:responModel];
        }else{
            [SVProgressHUD showErrorWithStatus:responModel.apiStatus duration:0.8f];
            [self messageDidSendFailure:responModel.UUID];
        }
    } failure:^(HttpException *e) {
        [self messageDidSendFailure:e.UUID];
    }];
//    [Consult consultDetailCreateWithParams:consultDetailCreateModelR success:^(ConsultDetailCreateModel *model) {
//        if([model.apiStatus integerValue] == 0) {
//            [self messageDidSendSuccess:model.UUID withCreateModel:model];
//        }else{
//            [SVProgressHUD showErrorWithStatus:model.apiMessage duration:1.2];
//            [self messageDidSendFailure:model.UUID];
//        }
////        [QWGLOBALMANAGER postNotif:NotiMessageQueueSendImage data:nil object:nil];
//    } failure:^(HttpException *e) {
////        [QWGLOBALMANAGER postNotif:NotiMessageQueueSendImage data:nil object:nil];
//        [self messageDidSendFailure:e.UUID];
//    }];
}

//发送消息成功
- (void)messageDidSendSuccess:(NSString *)UUID withCreateModel:(DetailCreateResult *)model
{
    XHMessage *filterMessage = [self getMessageWithUUID:UUID];
    if(filterMessage) {
        filterMessage.sended = Sended;
        
//        NSInteger index = [self.messages indexOfObject:filterMessage];
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
//        [self.messageTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.messageTableView reloadData];
        QWMessage *message = [QWMessage getObjFromDBWithKey:UUID];
        
        message.issend = [NSString stringWithFormat:@"%d",Sended];
        message.UUID = model.detailId;
        message.timestamp = [NSString stringWithFormat:@"%.0f",[model.createTime doubleValue] / 1000.0];
        if ([message.messagetype integerValue] == XHBubbleMessageMediaTypePhoto) {
                   UIImage *imagedata =  [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:UUID] ;
            
            [[SDImageCache sharedImageCache] storeImage:imagedata forKey:[NSString stringWithFormat: @"%@",  model.detailId]];
        }
        [QWMessage saveObjToDB:message];
        [QWMessage deleteObjFromDBWithKey:UUID];
        PharMsgModel *history = [PharMsgModel getObjFromDBWithKey:self.branchId];
        history.title = self.title;
        history.timestamp =[NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
        history.formatShowTime = [QWGLOBALMANAGER updateFirstPageTimeDisplayer:[NSDate dateWithTimeIntervalSince1970:[history.timestamp doubleValue]]];
        history.issend = [NSString stringWithFormat:@"%d",Sended];
        switch ([message.messagetype integerValue]) {
            case XHBubbleMessageMediaTypeText:
            {
                history.content = message.body;
                break;
            }
            case XHBubbleMessageMediaTypePhoto:
            {
                history.content = @"[图片]";
                break;
            }
            case XHBubbleMessageMediaTypeActivity:
            {
                history.content = @"[活动]";
                break;
            }
            case XHBubbleMessageMediaTypeLocation:
            {
                history.content = @"[位置]";
                break;
                
            }
            case XHBubbleMessageMediaTypeMedicine:
            {
                history.content = @"[药品]";
                break;
            }
            case XHBubbleMessageMediaTypeMedicineSpecialOffers:
            {
                history.content = @"[活动]";
                break;
                
            }
            default:
                break;
        }

        [PharMsgModel updateObjToDB:history WithKey:self.branchId];
    }
    [QWGLOBALMANAGER postNotif:NotiMessagePTPNeedUpdate data:self.branchId object:nil];
}

//发送消息失败
- (void)messageDidSendFailure:(NSString *)UUID
{
    XHMessage *filterMessage = [self getMessageWithUUID:UUID];
    if(filterMessage) {
        filterMessage.sended = SendFailure;
        //更新本地数据库
        
//        NSInteger index = [self.messages indexOfObject:filterMessage];
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
//        [self.messageTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [self.messageTableView reloadData];
        QWMessage *message = [QWMessage getObjFromDBWithKey:UUID];
        message.issend = [NSString stringWithFormat:@"%d",SendFailure];
        [QWMessage updateObjToDB:message WithKey:UUID];
        PharMsgModel *history = [PharMsgModel getObjFromDBWithKey:self.branchId];
        history.issend = [NSString stringWithFormat:@"%d",SendFailure];
        history.timestamp =  [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]]; ;
//        history.formatShowTime = [];
        history.formatShowTime = [QWGLOBALMANAGER updateFirstPageTimeDisplayer:[NSDate dateWithTimeIntervalSince1970:[history.timestamp doubleValue]]];
        switch ([message.messagetype integerValue]) {
            case XHBubbleMessageMediaTypeText:
            {
                history.content = message.body;
                break;
            }
            case XHBubbleMessageMediaTypePhoto:
            {
                history.content = @"[图片]";
                break;
            }
            case XHBubbleMessageMediaTypeActivity:
            {
                history.content = @"[活动]";
                break;
            }
            case XHBubbleMessageMediaTypeLocation:
            {
                history.content = @"[位置]";
                break;
            }
            case XHBubbleMessageMediaTypeMedicine:
            {
                history.content = @"[药品]";
                break;
            }
            case XHBubbleMessageMediaTypeMedicineSpecialOffers:
            {
                history.content = @"[活动]";
                break;
            }
            default:
                break;
        }

        [PharMsgModel updateObjToDB:history WithKey:UUID];
    }
    [QWGLOBALMANAGER postNotif:NotiMessagePTPNeedUpdate data:self.branchId object:nil];
}

- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj
{
    if(type == NotiMessageQueueSendImage) {
        if(self.consultInfo.list.count > 0) {
            currentSendPhotoModel = self.consultInfo.list[0];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (currentSendPhotoModel.fullImage) {
                    UIImage *aimg=[currentSendPhotoModel.fullImage imageByScalingToMinSize];
//                    [self didSendPhoto:aimg fromSender:self.consultInfo.consultId onDate:[NSDate date] image:@"" uuid:[XMPPStream generateUUID]];
                    [self didAskDocPhoto:aimg fromSender:self.consultInfo.consultId onDate:[NSDate date]  image:@"" uuid:[XMPPStream generateUUID]];
                    
                }
                else {
                    [PhotosAlbum getFullImageByAsset:currentSendPhotoModel.asset photoBlock:^(UIImage *fullResolutionImage) {
                        fullResolutionImage = [fullResolutionImage imageByScalingToMinSize];
                        [self didAskDocPhoto:fullResolutionImage fromSender:self.consultInfo.consultId onDate:[NSDate date]  image:@"" uuid:[XMPPStream generateUUID]];
                    } failure:nil];

                }
            });
            
        }
    }
 
    else if(type == NotimessageIMTabelUpdate)
    {
        [self.messageTableView reloadData];
         [self showOrHideHeaderView];
    }else if (type == NotiRestartTimer) {

        [self createMessageTimer];
    }
}


///// test   send  photo
- (XHMessage *)didAskDocPhoto:(UIImage *)photo fromSender:(NSString *)sender onDate:(NSDate *)date image:(NSString *)url uuid:(NSString *)uuid
{
    [[SDImageCache sharedImageCache] storeImage:photo forKey:uuid toDisk:YES];
   BOOL haveSave = [[SDImageCache sharedImageCache] diskImageExistsWithKey:uuid];
    if (!haveSave) {
        NSLog(@"发现没有保存成功");
     [self didAskDocPhoto:photo fromSender:sender onDate:date  image:url uuid:uuid];
    }
    XHMessage *textMessage   = [[XHMessage alloc] initWithPhoto:photo thumbnailUrl:url originPhotoUrl:url sender:sender timestamp:date UUID:uuid richBody:url];
    textMessage.photo = photo;
    textMessage.sended = Sending;
    textMessage.thumbnailUrl = url;
    textMessage.avatorUrl =QWGLOBALMANAGER.configure.avatarUrl;;

    QWMessage * msg = [[QWMessage alloc] init];
    msg.direction = [NSString stringWithFormat:@"%ld",(long)XHBubbleMessageTypeSending];
    msg.timestamp = [NSString stringWithFormat:@"%.0f",[date timeIntervalSince1970]];
    msg.UUID = textMessage.UUID;
    msg.star = [NSString stringWithFormat:@"%f",textMessage.starMark];
    msg.avatorUrl = textMessage.avatorUrl;
    msg.sendname = QWGLOBALMANAGER.configure.passPort;
    msg.recvname = self.branchId;
    msg.issend = [NSString stringWithFormat:@"%d",Sending];
    msg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)XHBubbleMessageMediaTypePhoto];
    msg.isRead = @"1";
    msg.richbody = @"";
    msg.body = @"[图片]";
    [QWMessage saveObjToDB:msg];
    PharMsgModel *historyMsg = [PharMsgModel getObjFromDBWithKey:self.branchId];
    if(!historyMsg)
        historyMsg = [[PharMsgModel alloc] init];
    historyMsg.branchId = self.branchId;
    historyMsg.timestamp =[NSString stringWithFormat:@"%.0f",[ date timeIntervalSince1970]];;
    historyMsg.latestTime =[NSString stringWithFormat:@"%@",textMessage.timestamp] ;
    historyMsg.formatShowTime = [QWGLOBALMANAGER updateFirstPageTimeDisplayer:[NSDate dateWithTimeIntervalSince1970:[historyMsg.timestamp doubleValue]]];
    historyMsg.content = @"[活动]";
    historyMsg.title = self.title;
    historyMsg.issend = [NSString stringWithFormat:@"%d",Sending];
    historyMsg.UUID = textMessage.UUID;
    [PharMsgModel updateObjToDB:historyMsg WithKey:historyMsg.branchId];
    return textMessage;
//    [QWGLOBALMANAGER postNotif:NotiMessagePTPNeedUpdate data:self.messageSender object:nil];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.messages.count==0) {
        return;
    }
     showPhone = NO;
    NSIndexPath *ip = [self.messageTableView indexPathForRowAtPoint:CGPointMake(0, scrollView.contentOffset.y-15.0)];
    XHMessage *message =  [self.messages objectAtIndex:ip.row];
    if (  message.messageMediaType == XHBubbleMessageMediaTypePhone) {
        phone = ip.row;
        showPhone = YES;
    }
    if (phone ==0 && showPhone ) {
 
        if ( scrollView.contentOffset.y >35) {
 
            phoneBtn.hidden = NO;
            phoneView.hidden = NO;
        }
 
        else
        {
            phoneBtn.hidden = YES;
            phoneView.hidden = YES;
        }
        return;
    }
 
    if (phone <1) {
        return;
    }
 
        if (ip.row > phone-1 ) {
            phoneBtn.hidden = NO;
            phoneView.hidden = NO;
        }else
        {
            phoneBtn.hidden = YES;
            phoneView.hidden = YES;
        }
 

}

-(void)makeCall
{
  
    if(![phoneNumber isEqualToString:@""] &&![phoneNumber isEqual:[NSNull null]] && phoneNumber)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:phoneNumber message: nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
        alert.tag = 1001;
        [alert show];
    }
  

}

-(void)sendToOther:(NSInteger)sender
{
    XHMessage *message =  [self.messages objectAtIndex:sender];
    [self.messages removeObjectAtIndex:sender];
    [QWMessage deleteObjFromDBWithKey:message.UUID];
    [self.messageTableView reloadData];
    [self showOrHideHeaderView];
    
    PTPRemove *consultDetailRemoveModelR = [PTPRemove new];
    consultDetailRemoveModelR.sessionId = ptpSessionID;
    consultDetailRemoveModelR.detailId = [message.UUID integerValue];
    consultDetailRemoveModelR.token = QWGLOBALMANAGER.configure.userToken;
 
    [ConsultPTP ptpMessagetRemove:consultDetailRemoveModelR success:^(ApiBody *responModel) {
        
    } failure:^(HttpException *e) {
        
    }];

    
    ConsultFirstViewController *consultFirstViewController = [[ConsultFirstViewController alloc] init];
    consultFirstViewController.hidesBottomBarWhenPushed = YES;
//    consultFirstViewController.romeType=@"1";//群聊页面，现在romeType不用传值cj
    [self.navigationController pushViewController:consultFirstViewController animated:YES];
}
-(void)scrollToBottomAnimated:(BOOL)animated
{
    [super scrollToBottomAnimated:animated];
//    [self performSelectorOnMainThread:@selector(showOrHideHeaderView) withObject:nil waitUntilDone:YES];
//    [self performSelector:@selector(showOrHideHeaderView) withObject:nil afterDelay:1];
//    dispatch_async(dispatch_get_main_queue(), ^{
//          [self  showOrHideHeaderView];
//    }) ;
  
    
}

@end
