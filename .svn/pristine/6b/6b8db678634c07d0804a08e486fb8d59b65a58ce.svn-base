//
//  PrivateMessageCenter.m
//  APP
//  私聊数据管理类，用来API取数据，对底层数据库的操作，管理聊天队列
//  Created by Martin.Liu on 16/3/10.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "PrivateMessageCenter.h"

#import "PrivateChatTimerUtils.h"
#import "ChatManagerDefs.h"

#import "NSMutableArray+EX.h"
#import "SDImageCache.h"
#import "QWPrivateMessageModel.h"

#import "PrivateChatParamR.h"
#import "PrivateChatAPI.h"
#import "SBJson.h"
#import "SVProgressHUD.h"
static NSInteger kPageSize = 16;
static CGFloat kPollingMinInterval = 3.0;
static CGFloat kPollingMaxInterval = 30.0;

@interface PrivateMessageCenter()
{
    dispatch_source_t timerPolling;
    IMListBlock msgListBlock;
    IMSuccessBlock successStatusBlock;
    BOOL isAll;
    BOOL isClose;
    BOOL isStop;
    NSInteger curPage;
    
    NSInteger noDataTimes;
    
    MessageModel *modOffset;
    
}
@property (nonatomic,strong) NSMutableArray *arrMessages;


@property (nonatomic,assign) CGFloat      pollingInterval;

@end

@implementation PrivateMessageCenter
@synthesize delegate=_delegate;
@synthesize count=_count;
@synthesize oID=_oID;
@synthesize type=_type;
@synthesize serverTime=_serverTime;
#pragma mark - init
- (id)init
{
    if (self = [super init]) {
        self.sendingCount=0;
        self.count=0;
        self.pageSize = kPageSize;
        self.pollingInterval = kPollingMinInterval;
        self.serverTime = 0;
        
        isStop=NO;
        isAll=NO;
        isClose=YES;
        //        hadNew=false;
        
        noDataTimes=0;
        curPage=0;
        
        self.arrMessages = nil;
        self.arrMessages = [[NSMutableArray alloc]initWithCapacity:self.pageSize];
        
        [self addObserverGlobal];
        [self DBDataInit];
    }
    return self;
}

- (id)initWithID:(NSString*)oID type:(IMType)type
{
    if (self = [self init]) {
        self.oID = StrFromObj(oID);
        self.type = type;
        //        self.delegate=delegate;
    }
    return self;
}

- (void)setPageSize:(NSInteger)pageSize{
    if (pageSize <= 0) {
        _pageSize = kPageSize;
    }
    else _pageSize = pageSize;
}

- (void)setPollingInterval:(CGFloat)pollingInterval{
    if (pollingInterval <= 0) {
        _pollingInterval = kPollingMinInterval;
    }
    else _pollingInterval = pollingInterval;
}

//返回数据数量
- (NSInteger)count{
    return self.arrMessages.count;
}

//正在发送的线程数量
- (void)setSendingCount:(NSInteger)sendingCount{
    _sendingCount=sendingCount;
    [self checkSendingCount];
}

- (void)checkSendingCount{
    if (_sendingCount<=0) {
        //发送线程都结束,且消息中心在停止状态，发送通知
        //        DebugLog(@"发送线程都结束");
        if (isStop) {
            NSMutableDictionary *dd=[NSMutableDictionary dictionary];
            if (self.oID) {
                dd[@"oID"]=self.oID;
            }
            if (self.sessionID) {
                dd[@"sessionID"]=self.sessionID;
            }
            [QWGLOBALMANAGER postNotif:NotifIMCenterSended data:dd object:self];
        }
    }
}
#pragma mark - 外部方法

- (void)start{
    // 删除正在发送的无效记录
    [QWPrivateMessageModel deleteObjFromDBWithWhere:[NSString stringWithFormat:@"issend = '%@' OR issend = '%@'", StrFromInt(MessageDeliveryState_Pending), StrFromInt(MessageDeliveryState_Delivering)]];
    //先在DB取老数据
    NSArray* tmp = [self getAllDataFromDB];
    if (tmp.count>0) {
        [self reloadPrivateDatas:IMListDB];
    }
    
//    [self getAllMessages];
//    //调restart
    [self restart];
}

//重启轮询方法
- (void)restart{
    if (isStop==NO && isClose==NO) {
        return;
    }
    
    isStop=NO;
    isClose=NO;
    self.pollingInterval = kPollingMinInterval;
    [PRIVATETIMER timerAfter:timerPolling timeDelay:self.pollingInterval blockAfter:^{
        [self beginPolling];
    }];
}


//停轮询
- (void)stop{
    isStop=YES;
    [self checkSendingCount];
    [self suspend];
}

//彻底关闭
- (void)close{
    [self removeObserverGlobal];
    [self suspend];
}

//判断是非关闭状态
- (BOOL)isClose{
    if (isClose || isStop) {
        return YES;
    }
    return NO;
}
#pragma mark 暂停/重启
- (void)suspend{
    if (isClose) {
        return;
    }
    
    isClose=YES;
    [PRIVATETIMER timerClose:timerPolling];
}

- (void)resume{
    if (isStop) {
        return;
    }
    [self restart];
}

#pragma mark 显示tableview当前位置单数据
- (MessageModel*)getMessageByIndex:(NSInteger)index{
    if (index<self.arrMessages.count)   {
        return self.arrMessages[index];
    }
    return nil;
}

-(NSInteger) getMessageIndex:(MessageModel*)messagemodel
{
    
    return  [self.arrMessages indexOfObject:messagemodel];
    
}
//- (void)getMessageByIndex:(NSInteger)index messageBlock:(void (^)(id message))messageBlock success:(IMSuccessBlock)success failure:(IMFailureBlock)failure{
//
//}
#pragma mark  显示当前数据列表
- (void)getMessages:(IMListBlock)list success:(IMSuccessBlock)success failure:(IMFailureBlock)failure{
    
    msgListBlock=nil;
    msgListBlock=list;
    
    successStatusBlock=nil;
    successStatusBlock=success;
    
    //判断轮询没开始，并且不在全量拉数据的时候启动
    if (timerPolling==nil && isAll==false) {
        [self beginPolling];
    }
    
    //获取窗口数据
    [self showCurrentMessages:IMListCurrent successData:nil];
}

#pragma mark 翻上页
- (void)getHistory:(IMHistoryBlock)block success:(IMSuccessBlock)success failure:(IMFailureBlock)failure{
    //获取历史数据
    [self setOffset:0];
    NSArray *arr1=[self getDataFromDB];
    
    if ((arr1.count<self.pageSize) && (self.type==IMTypePTPClient || self.type==IMTypePTPStore)) {
        //如果数据数小于每页条数
        if (self.type==IMTypePTPClient || self.type==IMTypePTPStore) {
            //PTP API拉历史数据
            [self getHistoryMessages:block success:success failure:failure];
        }
        else [self showHistoryMessages:block success:success];
    }
    else {
        [self showHistoryMessages:block success:success];
    }
    
    
    
}

#pragma mark 添加/重发对话
- (void)sendMessage:(MessageModel*)model success:(IMSuccessBlock)success failure:(IMFailureBlock)failure{
    //转QWmodel保存DB
    model.sended=MessageDeliveryState_Delivering;//待发送
    model.download=MessageFileState_Downloaded;
    QWPrivateMessageModel* qwmsg=[self buildQWMessageFromMessage:model];
    qwmsg.issend=StrFromInt(model.sended);
    qwmsg.download=StrFromInt(model.download);
    [self createMessage:qwmsg];
    
    //加入数据队列
//    [self messagesQueue:model reset:NO];
//    NSArray* privateModelArray = [self getAllDataFromDB];
//    NSMutableArray* array = [NSMutableArray array];
//    for (QWPrivateMessageModel* message in privateModelArray) {
//        [array addObject:[self buildMessageFromQWMessage:message]];
//    }
    
    //刷新界面
    [self reloadPrivateDatas:IMListAdd];
    
    //调接口
    [self sendAMessage:model success:success failure:failure];
}

- (void)resendMessage:(MessageModel*)model success:(IMSuccessBlock)success failure:(IMFailureBlock)failure{
    //DB删数据
    id msg=[self buildQWMessageFromMessage:model];
    [self deleteMessage:msg];
    
    //调发送
    model.timestamp = [NSDate new];
    [self sendMessage:model success:success failure:failure];
}

//添加DB数据
- (void)addMessage:(MessageModel*)model{
    
    //    model.sended=MessageDeliveryState_Delivering;//待发送
    model.download=MessageFileState_Downloaded;
    QWPrivateMessageModel* qwmsg=[self buildQWMessageFromMessage:model];
    qwmsg.issend=StrFromInt(model.sended);
    qwmsg.download=StrFromInt(model.download);
    [self createMessage:qwmsg];
    
    //加入数据队列
    [self messagesQueue:model reset:NO];
    
    //刷新界面
    [self showCurrentMessages:IMListAdd successData:nil];
}
#pragma mark 删除对话
- (void)removeMessage:(MessageModel*)model  success:(IMSuccessBlock)success failure:(IMFailureBlock)failure{
    //DB删数据
    id msg=[self buildQWMessageFromMessage:model];
    [self deleteMessage:msg];
    
    //实时数据队列删数据
    [self.arrMessages removeObject:model];
    //重置页面节点
//    [self setOffset:0];
    
    //刷新界面
    [self showCurrentMessages:IMListDelete successData:nil];
    
    //接口删数据
//    [self deleteAMessage:model success:success failure:failure];
}

#pragma mark 添加/重发大数据
- (void)resendFileMessage:(MessageModel* )model success:(IMSuccessBlock)success failure:(IMFailureBlock)failure  uploadProgressBlock:(void (^)(MessageModel* target, float progress ))uploadProgressBlock{
    //DB删数据
    id msg=[self buildQWMessageFromMessage:model];
    [self deleteMessage:msg];

    model.timestamp = [NSDate new];
    [self sendFileMessage:model success:success failure:failure uploadProgressBlock:uploadProgressBlock];
}

- (void)sendMessageWithoutMessageQueue:(MessageModel*)model success:(IMSuccessBlock)success failure:(IMFailureBlock)failure{
    //转QWmodel保存DB
    model.sended=MessageDeliveryState_Delivering;//待发送
    model.download=MessageFileState_Downloaded;
    QWMessage* qwmsg=[self buildQWMessageFromMessage:model];
    qwmsg.issend=StrFromInt(model.sended);
    qwmsg.download=StrFromInt(model.download);
    [self createMessage:qwmsg];
    
    //刷新界面
    [self showCurrentMessages:IMListAdd successData:nil];
    
    //调接口
    [self sendAMessage:model success:success failure:failure];
}

//发送文件类消息
- (void)sendFileMessage:(MessageModel* )model success:(IMSuccessBlock)success failure:(IMFailureBlock)failure  uploadProgressBlock:(void (^)(MessageModel* target, float progress ))uploadProgressBlock
{
    NSData *data=nil;
    
    if (model.messageMediaType==MessageMediaTypePhoto) {
        UIImage *img=[self getImageByMessage:model];
        if (img) {
            data=UIImageJPEGRepresentation(img, 1.0);
        }
        
    }
    else if (model.messageMediaType==MessageMediaTypeVoice) {
        //获取语音文件
        data=[NSData dataWithContentsOfFile:model.voicePath];
    }
    
    if (!data ) {
        if (failure) {
            failure(nil);
        }
        return;
    }
    
    //转QWmodel保存DB
    model.sended=MessageDeliveryState_Delivering;//待发送
    model.download=MessageFileState_Downloaded;
    QWPrivateMessageModel* qwmsg=[self buildQWMessageFromMessage:model];
    qwmsg.issend=StrFromInt(model.sended);
    qwmsg.download=StrFromInt(model.download);
    if (model.messageMediaType==MessageMediaTypeVoice)
    {
        qwmsg.richbody = model.voicePath;
    }
    [self createMessage:qwmsg];
    
    //加入数据队列
//    [self messagesQueue:model reset:NO];
    [self reloadPrivateDatas:IMListAdd];
    
    //刷新界面
//    [self showCurrentMessages:IMListAdd successData:nil];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = StrFromObj(QWGLOBALMANAGER.configure.userToken);
    
    if (model.messageMediaType==MessageMediaTypePhoto) {
        params[@"type"] = @(4);
        
        
        
        [self uploadImage:data params:params success:^(id responseObj) {
            id res=responseObj[@"body"];
            if (res==nil) {
                res=responseObj;
            }
            uploadFile *obj = [uploadFile parse:res];
            if([obj.apiStatus intValue] == 0){
                model.richBody=obj.url;
                NSString *uuid=model.UUID;
                DebugLog(@"图片发送1:%@",model.UUID);
                // url保存在本地
                qwmsg.richbody=obj.url;
                [self createMessage:qwmsg];
                [self sendAMessage:model success:^(id successObj) {
                    if (model.messageMediaType == MessageMediaTypePhoto) {
                        DebugLog(@"图片发送2:%@ UUID:%@",successObj,model.UUID);
                        UIImage *imagedata =  [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:uuid] ;
                        [[SDImageCache sharedImageCache] storeImage:imagedata forKey:StrFromObj(successObj)];
//
                    }
                    if (success) {
                        success(StrFromObj(successObj));
                    }
//                    [self reloadPrivateDatas:IMListAdd];
                } failure:failure];
            }else  {
                [self sendAMessageDidFailure:model.UUID QWMessage:qwmsg MessageModel:model];
                if (failure)
                    failure(nil);
            }
        } failure:^(HttpException *e) {
            [self sendAMessageDidFailure:model.UUID QWMessage:qwmsg MessageModel:model];
            if (failure) {
                failure(e);
            }
        } uploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            double pre=(double)totalBytesWritten/(double)totalBytesExpectedToWrite;
            //            DebugLog(@"上传图片:%f",pre);
            if (uploadProgressBlock) {
                uploadProgressBlock(model,pre);
            }
        }];
    }
    else if (model.messageMediaType==MessageMediaTypeVoice) {
        
        [self uploadFile:data params:params success:^(id responseObj) {
            uploadFile *file = [uploadFile parse:responseObj];
            if([file.apiStatus intValue] == 0 && file.url){
                model.voiceUrl=file.url;
                // url保存在本地
                qwmsg.fileUrl=file.url;
                [self createMessage:qwmsg];
                [self sendAMessage:model success:^(id successObj) {
                    
                    if (model.messageMediaType == MessageMediaTypeVoice  && [successObj isKindOfClass:[NSString class]]) {
                        
                        //                        model.voiceUrl=file.url;
                        NSString *path=[FileManager rename:successObj oldPath:model.voicePath];
                        DebugLog(@"文件发送2:%@ path:%@",successObj,path);
                        model.voicePath=path;
                        model.UUID = successObj;
                        [self updateMessage:model];
                        
                        if (success) {
                            success(successObj);
                        }
                    }
                    
                } failure:failure];
                
            }else{
                [self sendAMessageDidFailure:model.UUID QWMessage:qwmsg MessageModel:model];
                if (failure)
                    failure(nil);
            }
        } failure:^(HttpException *e) {
            [self sendAMessageDidFailure:model.UUID QWMessage:qwmsg MessageModel:model];
            if (failure) {
                failure(e);
            }
        } uploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            double pre=(double)totalBytesWritten/(double)totalBytesExpectedToWrite;
            DebugLog(@"上传文件:%f",pre);
            if (uploadProgressBlock) {
                uploadProgressBlock(model,pre);
            }
        }];
    }
    
}
//上传图片
- (void)uploadImage:(NSData*)file params:(NSDictionary*)params success:(void(^)(id responseObj))success failure:(void(^)(HttpException * e))failure  uploadProgressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))uploadProgressBlock{
    HttpClient *httpClent = [HttpClient new];
    //cj----cj
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *apiUrl = [def objectForKey:@"APIDOMAIN"];
    NSString *h5Url = [def objectForKey:@"H5DOMAIN"];
    if(!StrIsEmpty(apiUrl)){
        [httpClent setBaseUrl:apiUrl];
    }else{
        [httpClent setBaseUrl:BASE_URL_V2];
    }
    httpClent.progressEnabled = NO;
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:file];
    
    [httpClent uploaderImg:array params:params withUrl:NW_uploadFile success:success failure:failure uploadProgressBlock:uploadProgressBlock];
    
}

#pragma mark - 文件上传
- (void)uploadFile:(NSData*)file params:(NSDictionary*)params success:(void(^)(id responseObj))success failure:(void(^)(HttpException * e))failure  uploadProgressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))uploadProgressBlock{
    HttpClient *httpClent = [HttpClient new];
    //cj----cj
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *apiUrl = [def objectForKey:@"APIDOMAIN"];
    NSString *h5Url = [def objectForKey:@"H5DOMAIN"];
    if(!StrIsEmpty(apiUrl)){
        [httpClent setBaseUrl:apiUrl];
    }else{
        [httpClent setBaseUrl:BASE_URL_V2];
    }
    
    httpClent.progressEnabled = NO;
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:file];
    
    [httpClent upRawFile:array params:params withUrl:NW_uploadSpe success:success failure:failure uploadProgressBlock:uploadProgressBlock];
}

#pragma mark 获取图片UUID数组
- (NSArray*)getImages{
    NSString    *sID,*uID;
    sID=self.sessionID;
    uID=self.oID;
    NSString* where = [NSString stringWithFormat:@"messagetype = '%d' AND sendPassport = '%@' AND recvname = '%@'",(int)MessageMediaTypePhoto,QWGLOBALMANAGER.configure.passPort,uID];
    
    NSArray *array = [QWPrivateMessageModel getArrayFromDBWithWhere:where WithorderBy:@"timestamp ASC"];
    
    NSMutableArray *tmp=[[NSMutableArray alloc]initWithCapacity:array.count];
    for (QWPrivateMessageModel *mm in array) {
        if( [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:mm.UUID]) {
            [tmp addObject:mm.UUID];
        }
    }
    
    return tmp;
}
#pragma mark - 内部方法
//设置偏移量，用于翻页
- (void)setOffset:(NSInteger)index{
    curPage=0;
    modOffset=nil;
    if (index>=0 && index<self.arrMessages.count) {
        modOffset=self.arrMessages[index];
    }
}
//排序
- (void)sortMessages
{
    NSSortDescriptor*sorter=[[NSSortDescriptor alloc]initWithKey:@"timestamp" ascending:YES];
    NSMutableArray *sortDescriptors=[[NSMutableArray alloc]initWithObjects:&sorter count:1];
    NSArray *sortArray=[self.arrMessages sortedArrayUsingDescriptors:sortDescriptors];
    self.arrMessages = [[NSMutableArray alloc]initWithArray:sortArray];
}

//反序
- (NSArray*)reverseArray:(NSArray*)arr{
    NSMutableArray *array = [NSMutableArray arrayWithArray:arr];
    NSArray* reversedArray = [[array reverseObjectEnumerator] allObjects];
    return reversedArray;
}

//获取原图
- (UIImage*)getImageByMessage:(MessageModel*)mode{
    if (mode.photo!=nil)
        return mode.photo;
    
    if (mode.messageMediaType==MessageMediaTypePhoto) {
        UIImage *photo = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:mode.UUID];
        return photo;
        //        return UIImageJPEGRepresentation(photo, 1.0);
    }
    return nil;
}
#pragma mark - DB
//db数据重置，比如所有发送中状态改发送失败
- (void)DBDataInit{
    
}

- (NSArray *)getCurrentMessagesFromDB{
    [self setOffset:-1];
    NSArray *arr1=[self getDataFromDB];
    NSArray *arr2=[self messagesListFromQWMessagesList:arr1];
    return arr2;
}

//需要偏移量计算开始页,offset偏移量
//- (NSArray *)getDataFromDBByPage:(NSInteger)page{
- (NSArray *)getDataFromDB{
//    return nil;
    return [self getAllDataFromDB];
}

// 从数据库中获取所有数据
- (NSArray*)getAllDataFromDB{
    NSString *sID,*uID;
    sID=self.sessionID;
    uID=self.oID;
    NSString* where;
    if (StrIsEmpty(self.sessionID)) {
        where = [NSString stringWithFormat:@"sendPassport = '%@' AND recvname = '%@'",QWGLOBALMANAGER.configure.passPort,uID];
    }
    else
    {
        where = [NSString stringWithFormat:@"sendname = '%@' OR (sendPassport = '%@' AND recvname = '%@')",self.sessionID,QWGLOBALMANAGER.configure.passPort,uID];
    }
    NSArray *array = [QWPrivateMessageModel getArrayFromDBWithWhere:where WithorderBy:@"timestamp ASC" offset:0 count:0];
    return array;
}

- (NSMutableArray*)getALLMessageListFromDB
{
    NSArray* privateModelArray = [self getAllDataFromDB];
    NSMutableArray* array = [NSMutableArray array];
    for (QWPrivateMessageModel* message in privateModelArray) {
        [array addObject:[self buildMessageFromQWMessage:message]];
    }
    return array;
}

- (void)reloadPrivateDatas:(IMListType)type
{
    self.arrMessages = [self getALLMessageListFromDB];
    [self showCurrentMessages:type successData:nil];
}

- (MessageModel *)getOffsetModel{
    //    return [self.arrMessages firstObject];
    return modOffset;
}
- (MessageModel *)getLastModel{
    //    return [self.arrMessages firstObject];
    return [self.arrMessages lastObject];
}

//更新DB数据
- (BOOL)updateMessage:(MessageModel*)model{
    QWPrivateMessageModel* msg = [self buildQWMessageFromMessage:model];
    NSString *where=[NSString stringWithFormat:@"UUID = '%@'",model.UUID];
    return [self updateMessage:msg where:where];
}

//删除db数据
- (BOOL)deleteMessage:(QWPrivateMessageModel*)model{
    return [QWPrivateMessageModel deleteToDB:model];
}

//db删除某类型数据
- (BOOL)deleteMessagesByType:(MessageBodyType)type{
    NSString *where;
    
    where = [NSString stringWithFormat:@"messagetype = '%d'",type];
    NSError *err=[QWPrivateMessageModel deleteObjFromDBWithWhere:where];
    if (err==nil) {
        return YES;
    }
    return NO;
}

- (BOOL)updateMessage:(QWPrivateMessageModel*)model where:(NSString*)where{
    return [QWPrivateMessageModel updateToDB:model where:where];
}
- (BOOL)createMessage:(QWPrivateMessageModel*)model{
    return [model updateToDB];
//    NSError *error=nil;
//    error = [QWPrivateMessageModel saveObjToDB:model];
//    if (error) {
//        return NO;
//    }
//    return YES;
}

//更新对象数据，用于外部列表呈现
+ (QWMessage*)checkMessageState:(QWMessage*)msg{
    QWMessage *model=[[QWMessage alloc]initWithMessage:msg];
    switch (model.messagetype.intValue) {
        case MessageMediaTypeText:
            //            model.body = model.text;
            break;
        case MessageMediaTypePhoto:
            model.body = @"[图片]";
            break;
        case MessageMediaTypeLocation:
            model.body = @"[位置]";
            break;
        case MessageMediaTypeActivity:
            model.body = @"[活动]";
            break;
        case MessageMediaTypeMedicineCoupon:
        case MessageMediaTypeMedicine:
            model.body = @"[药品]";
            break;
        case MessageMediaTypeMedicineSpecialOffers:
            model.body = @"[活动]";
            break;
        case MessageMediaTypeVoice:
            model.body = @"[语音]";
            break;
        case MessageMediaTypeCoupon:
            model.body = @"[优惠]";
            break;
        default:
            break;
    }
    return model;
}


//更新mod
- (BOOL)updateAMessage:(MessageModel*)mode{
    return [self updateMessage:mode];
}

#pragma mark - API
//增量
- (void)pollMessages {
    //
    if (self.sessionID == nil) {
        return;
    }
    PCGetChatDetailListR* pcGetChatDetailListR = [PCGetChatDetailListR new];
    pcGetChatDetailListR.token = QWGLOBALMANAGER.configure.userToken;
    pcGetChatDetailListR.sessionId = self.sessionID;
    [PrivateChatAPI getMessages:pcGetChatDetailListR success:^(PrivateChatDetailListModel *chatDetailList) {
        if ([self isClose]) {
            return ;
        }

        if (chatDetailList.serverTime && chatDetailList.serverTime.integerValue>0) {
            self.serverTime=chatDetailList.serverTime.doubleValue/1000.0;
        }
        
        if (chatDetailList.sessionId) {
            self.sessionID = StrFromObj(chatDetailList.sessionId);
        }
        
        [self checkNoDataTimes:chatDetailList.details.count];

        // 保存
        BOOL hasNew = [self checkMessagesFromAPI:chatDetailList type:IMListPolling];
        if (hasNew) {
            [self reloadPrivateDatas:IMListPolling];
        }
    } failure:^(HttpException *e) {
        ;
    }];
}
//全量
- (void)getAllMessages {
    if (StrIsEmpty(self.sessionID)) {
        PCGetAllR* getAllR = [PCGetAllR new];
        getAllR.token = QWGLOBALMANAGER.configure.userToken;
        getAllR.recipientId = self.oID;
        getAllR.point = @"0";
        getAllR.view = 50;
        getAllR.viewType = -1;
        
        [PrivateChatAPI getAll:getAllR success:^(PrivateChatDetailListModel *chatDetailList) {
            if ([self isClose]) {
                return ;
            }
            
            self.onlineFlag = chatDetailList.onlineFlag;
            if(self.pullBack){
                self.pullBack(1);
            }
            
            isAll=YES;
            if (chatDetailList.serverTime && chatDetailList.serverTime.integerValue>0) {
                self.serverTime=chatDetailList.serverTime.doubleValue/1000.0;
            }
            
            if (chatDetailList.sessionId) {
                self.sessionID = StrFromObj(chatDetailList.sessionId);
                // 陈志鹏要的
                QWGLOBALMANAGER.strPrivateCircleMsgID = StrFromObj(chatDetailList.sessionId);
            }
            // 保存
            [self checkMessagesFromAPI:chatDetailList type:IMListAll];
            [self reloadPrivateDatas:IMListAdd];
            if ([chatDetailList.apiStatus integerValue] == 0) {
            }
            else
            {
                if ([chatDetailList.apiStatus integerValue] != 2020006) {
                    if (!StrIsEmpty(chatDetailList.apiMessage)) {
                        [SVProgressHUD showErrorWithStatus:chatDetailList.apiMessage duration:DURATION_LONG];
                    }
                }
            }
            
            
            DebugLog(@"cheat List : %@", chatDetailList);
        } failure:^(HttpException *e) {
            self.onlineFlag = NO;
            if(self.pullBack){
                self.pullBack(1);
            }
        }];
    }
    else
    {
        PCGetAllByChatIdR* getAllR = [PCGetAllByChatIdR new];
        getAllR.token = QWGLOBALMANAGER.configure.userToken;
        getAllR.chatId = self.sessionID;
        getAllR.point = @"0";
        getAllR.view = 50;
        getAllR.viewType = -1;
        
        [PrivateChatAPI getAllByChatId:getAllR success:^(PrivateChatDetailListModel *chatDetailList) {
            if ([self isClose]) {
                return ;
            }
            self.oID = chatDetailList.recipientId;
            
            self.onlineFlag = chatDetailList.onlineFlag;
            if(self.pullBack){
                self.pullBack(1);
            }
            
            isAll=YES;
            if (chatDetailList.serverTime && chatDetailList.serverTime.integerValue>0) {
                self.serverTime=chatDetailList.serverTime.doubleValue/1000.0;
            }
            
            if (chatDetailList.sessionId) {
                self.sessionID = StrFromObj(chatDetailList.sessionId);
                // 陈志鹏要的
                QWGLOBALMANAGER.strPrivateCircleMsgID = StrFromObj(chatDetailList.sessionId);
            }
            // 保存
            [self checkMessagesFromAPI:chatDetailList type:IMListAll];
            [self reloadPrivateDatas:IMListAdd];
            if ([chatDetailList.apiStatus integerValue] == 0) {
            }
            else
            {
                if ([chatDetailList.apiStatus integerValue] != 2020006) {
                    if (!StrIsEmpty(chatDetailList.apiMessage)) {
                        [SVProgressHUD showErrorWithStatus:chatDetailList.apiMessage duration:DURATION_LONG];
                    }
                }
            }
            
            
            DebugLog(@"cheat List : %@", chatDetailList);
        } failure:^(HttpException *e) {
            self.onlineFlag = NO;
            if(self.pullBack){
                self.pullBack(1);
            }
        }];
    }
    
}
//历史
- (void)getHistoryMessages:(IMHistoryBlock)block success:(IMSuccessBlock)success failure:(IMFailureBlock)failure{
    MessageModel *msgModel = nil;
    if (self.arrMessages.count > 0) {
        msgModel = [self.arrMessages firstObject];
    }
    PCGetAllR* getHistory = [PCGetAllR new];
    getHistory.token = QWGLOBALMANAGER.configure.userToken;
    getHistory.recipientId = self.oID;
    getHistory.point = @"0";
    getHistory.view = 15;
    getHistory.viewType = -1;
    if (msgModel) {
        getHistory.point = [NSString stringWithFormat:@"%.f", [msgModel.timestamp timeIntervalSince1970] * 1000.0f];
    }
    
    [PrivateChatAPI getAll:getHistory success:^(PrivateChatDetailListModel *chatDetailList) {
        if ([self isClose]) {
            return ;
        }
        if (success) {
            success(chatDetailList.sessionId);
        }
//        if (chatDetailList.serverTime && chatDetailList.serverTime.integerValue>0) {
//            self.serverTime=chatDetailList.serverTime.doubleValue/1000.0;
//        }
        
        if (chatDetailList.sessionId) {
            self.sessionID = StrFromObj(chatDetailList.sessionId);
        }
        
        // 保存
        BOOL hasNew = [self checkMessagesFromAPI:chatDetailList type:IMListPolling];
        if (hasNew) {
            [self reloadPrivateDatas:IMListHistory];
        }
    } failure:^(HttpException *e) {
        ;
    }];
}
//已读
- (void)readMessages:(NSArray*)arrItems containSystem:(NSInteger)containSystem {
    if (arrItems==nil || arrItems.count==0) {
        return;
    }
    
    NSString *strItems = [self getReadIDs:arrItems];
    
    PTPRead *modelR = [PTPRead new];
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    modelR.sessionId =self.sessionID;

    modelR.detailIds = strItems;
    modelR.containSystem = [NSString stringWithFormat:@"%ld",(long)containSystem]; //系统消息条数不用设已读
    [ChatAPI PTPReadMessagesWithParams:modelR success:^(ApiBody *responModel) {
        DebugLog(@"******* 已读 %@",strItems);
    } failure:^(HttpException *e) {
        
    }];
}
//发送
- (void)sendAMessage:(MessageModel*)model success:(IMSuccessBlock)success failure:(IMFailureBlock)failure{
    PCCreateR* createR = [self buildPCCreateRFromMessage:model];
    createR.UUID = model.UUID;
    [PrivateChatAPI addChatDetail:createR success:^(PrivateChatAddChatModel *addChatModel) {
        if ([addChatModel.apiStatus integerValue] == 0) {
            NSArray* modelArray = [QWPrivateMessageModel getArrayFromDBWithWhere:[NSString stringWithFormat:@"UUID = '%@'", model.UUID]];
            NSString* newUUID = model.UUID;
            if (modelArray.count > 0) {
                for (QWPrivateMessageModel* model in modelArray) {
                    self.sessionID = addChatModel.sessionId;
                    model.issend = StrFromInt(MessageDeliveryState_Delivered);
                    model.sendname = (self.sessionID)?self.sessionID:self.oID;
                    model.UUID = addChatModel.detailId;
                    newUUID = addChatModel.detailId;
                    [model updateToDB];
                }
                if (success) {
                    success(newUUID);
                }
                [self reloadPrivateDatas:IMListAdd];
            }
        }
        else
        {
            if (!StrIsEmpty(addChatModel.apiMessage)) {
                [SVProgressHUD showErrorWithStatus:addChatModel.apiMessage duration:DURATION_LONG];
            }
            
            NSArray* modelArray = [QWPrivateMessageModel getArrayFromDBWithWhere:[NSString stringWithFormat:@"UUID = '%@'", model.UUID]];
            if (modelArray.count > 0) {
                for (QWPrivateMessageModel* model in modelArray) {
                    model.issend = StrFromInt(MessageDeliveryState_Failure);
                    [model updateToDB];
                }
                [self reloadPrivateDatas:IMListAdd];
            }
            if (failure) failure(addChatModel);
        }
    } failure:^(HttpException *e) {
        NSArray* modelArray = [QWPrivateMessageModel getArrayFromDBWithWhere:[NSString stringWithFormat:@"UUID = '%@'", model.UUID]];
        if (modelArray.count > 0) {
            for (QWPrivateMessageModel* model in modelArray) {
                model.issend = StrFromInt(MessageDeliveryState_Failure);
                [model updateToDB];
            }
            [self reloadPrivateDatas:IMListAdd];
        }
        if (failure) failure(e);
    }];
}

- (PCCreateR*)buildPCCreateRFromMessage:(MessageModel*)model
{
    PCCreateR* mm = [PCCreateR new];
    mm.token = QWGLOBALMANAGER.configure.userToken;
    mm.recipientId = self.oID;
    mm.deviceCode = DEVICE_ID;

    PrivateChatContentJson *contentJson = [PrivateChatContentJson new];
    
    switch (model.messageMediaType) {
        case MessageMediaTypeText:
            mm.contentType = @"TXT";
            contentJson.content = model.text;
            break;
        case MessageMediaTypePhoto:
            mm.contentType = @"IMG";
            contentJson.imgUrl = model.richBody;
            break;
            /////
        case MessageMediaTypeLocation:
            mm.contentType = @"POS";
            contentJson.desc = model.text;
            contentJson.lon = [NSString stringWithFormat:@"%f",model.location.coordinate.longitude];
            contentJson.lat = [NSString stringWithFormat:@"%f",model.location.coordinate.latitude];;
            break;
        case MessageMediaTypeActivity:
        {
            mm.contentType = @"ACT";
            //            contentJson.imgUrl = model.richBody;
            contentJson.actId = model.richBody;
            contentJson.actImgUrl = model.activityUrl;
            contentJson.actTitle = model.title;
            contentJson.actContent = model.text;
            
            break;
        }
        //微商药房商品 add by lijian at V4.0
        case MessageMediaMallMedicine:
        {
            mm.contentType = @"MPRO";
            contentJson.name = model.text;
            contentJson.spec = model.spec;
            contentJson.id = model.richBody;
            contentJson.branchId = model.branchId;
            contentJson.branchProId = model.branchProId;
            contentJson.imgUrl = model.activityUrl;
            
            break;
        }
        case MessageMediaTypeMedicine:
        {
            mm.contentType = @"PRO";
            //            contentJson.imgUrl = model.richBody;
            contentJson.name = model.text;
            contentJson.id = model.richBody;
            contentJson.imgUrl = model.activityUrl;
            break;
        }
        case MessageMediaTypeMedicineCoupon:
        {
            mm.contentType = @"PRO";
            
            contentJson.name = model.text;
            contentJson.id = model.richBody;
            contentJson.imgUrl = model.activityUrl;
            
            if (model.subTitle.length) {
                contentJson.pmtLabe=model.subTitle;
                contentJson.pmtId=model.otherID;
            }
            
            break;
        }
        case MessageMediaTypeMedicineSpecialOffers:
        {
            mm.contentType = @"PMT";
            //            contentJson.imgUrl = model.richBody;
            contentJson.content = model.text;
            contentJson.title = model.title;
            contentJson.id = model.richBody;
            contentJson.imgUrl = model.activityUrl;
            contentJson.branchLogo = model.thumbnailUrl;
            contentJson.groupId = model.otherID;
            break;
        }
        case MessageMediaTypeCoupon:
        {
            mm.contentType = @"COU";
            contentJson.groupId=model.title;
            contentJson.groupName=model.subTitle;
            contentJson.couponTag=model.text;
            contentJson.couponValue=model.richBody;
            contentJson.couponId=model.otherID;
            contentJson.scope=model.style;
            contentJson.begin=model.arrList.firstObject;
            contentJson.end=model.arrList.lastObject;
            contentJson.imgUrl=model.thumbnailUrl;
            contentJson.top=model.isMarked?@"1":@"0";
            break;
        }
        case MessageMediaTypeVoice:
        {
            mm.contentType = @"SPE";
            contentJson.duration = model.voiceDuration;
            contentJson.speUrl = model.voiceUrl;
            contentJson.platform = @"IOS";
            contentJson.speText=@"[语音]";
            break;
        }
            
            
        default:
            break;
    }
    mm.contentJson = [[contentJson dictionaryModel] JSONRepresentation];
    return mm;
}

//删除
- (void)deleteAMessage:(MessageModel*)model success:(IMSuccessBlock)success failure:(IMFailureBlock)failure{
    
}

////检查DB数据状态
//+ (id)checkMessageStateByID:(NSString*)oid{
//    return nil;
//}

#pragma mark  发送成功/失败
//发送成功后调用
- (void)sendAMessageDidSuccess:(NSString *)UUID QWMessage:(id)qwmsg MessageModel:(MessageModel*)msg{
    //更新db
}

//发送失败后调用
- (void)sendAMessageDidFailure:(NSString *)UUID QWMessage:(QWPrivateMessageModel*)qwmsg MessageModel:(MessageModel*)msg{
    //message比对上一条数据时间，小于时间，以上一条时间＋1
    //如果大于，并小于轮询时间戳+max间隔，以message时间为准
    //超过轮询时间戳+max间隔，以轮询时间戳+max间隔为准
    
    //保存db
    //最后一条数据,要判断是不是提示信息，过滤掉
    MessageModel *last=[self getLastModel];
    
    //轮询时间戳
    NSDate *dt=nil;
    dt=[self getServerMaxInterval];
    
    DebugLog(@"sendAMessageDidFailure A:%@ B:%@ C:%@",msg.timestamp,last.timestamp,dt);
    if ([msg.timestamp compare:last.timestamp] <= 0) {
        msg.timestamp=[self dateAddOneSecond:last.timestamp];
    }
    else if(dt && [msg.timestamp compare:dt] > 0){
        msg.timestamp=dt;
    }
    
    //修改状态
    msg.sended=MessageDeliveryState_Failure;//发送, 失败
    qwmsg.issend = StrFromInt(msg.sended);
    qwmsg.timestamp = [NSString stringWithFormat:@"%.0f",[msg.timestamp timeIntervalSince1970]*1000.f];
    //    qwmsg=(QWPTPMessage*)[self buildQWMessageFromMessage:msg];
    
    //更新db
    NSString *where=[NSString stringWithFormat:@"UUID = '%@'",UUID];
    [self updateMessage:qwmsg where:where];
    [self reloadPrivateDatas:IMListAll];
}
#pragma mark  已读数组string
- (NSString*)getReadIDs:(NSArray*)arrItems {
    NSString *strItems = [arrItems componentsJoinedByString:SeparateStr];
    return strItems;
}

#pragma mark - 轮询拉数据
- (void)beginPolling{
    if (isClose) {
        return;
    }
    
    timerPolling=[PRIVATETIMER timerLoop:timerPolling timeInterval:self.pollingInterval blockLoop:^{
        if (!isAll) {
            [self getAllMessages];
        }
        else
            [self pollMessages];
    } blockStop:^{
        //
    }];
}


//弹性轮询, 轮询收到消息或者发送消息后需重新设置
- (void)checkNoDataTimes:(NSInteger)num{
    //    return;
    
    //一分钟按最小间隔拉n次
    NSInteger minTimes = 60/kPollingMinInterval;
    
    //MinInterval内一直有数据来
    if (self.pollingInterval == kPollingMinInterval && num > 0) {
        return;
    }
    
    //MaxInterval内一直无数据
    if (self.pollingInterval == kPollingMaxInterval && num == 0) {
        return;
    }
    
    if (num == 0) {
        noDataTimes++;
    }
    else noDataTimes = 0;
    
    if (noDataTimes <= minTimes) {
        self.pollingInterval=kPollingMinInterval;
    }
    else {
        self.pollingInterval=kPollingMinInterval+(noDataTimes-minTimes)*2;
    }
    
    if (self.pollingInterval > kPollingMaxInterval) {
        self.pollingInterval=kPollingMaxInterval;
    }
    
    [PRIVATETIMER timerAfter:timerPolling timeDelay:self.pollingInterval blockAfter:^{
        [self beginPolling];
    }];
}

#pragma mark  数据整理 model转化
//api model整理成MessageModel
- (BOOL)checkMessagesFromAPI:(id)mode type:(IMListType)lType{
    //    DebugLog(@"VVVVVVVVVVVVVVVVVVVVVVVVVV 准备处理数据");
    //  需要区分两端数据格式
    NSArray *arrDetails=nil;
    NSInteger num=0;

    if([mode isKindOfClass:[PrivateChatDetailListModel class]]){
        CustomerSessionDetailList *model=mode;
        arrDetails=model.details;
        num=model.details.count;
    }
    
    NSMutableArray *arrItems = [[NSMutableArray alloc]initWithCapacity:num];
    BOOL hadNewMsg=NO;
    for(PrivateChatDetailModel *detail in arrDetails)
    {
        [arrItems addObject:detail.detailId];
        
        //API数据转DB格式，并判断是否DB重复数据，不是返回db数据格式
        QWPrivateMessageModel *msg = (QWPrivateMessageModel*)[self buildQWMessageFromAPIModel:mode detail:detail];
        if (msg==nil)
            continue ;
        else
            hadNewMsg=YES;

        
        //新数据存DB
        BOOL OK = NO;
        OK = [self createMessage:msg];
    }
    
//    [self readMessages:arrItems containSystem:0];
    
    return hadNewMsg;
}
//APIModel->QWPrivateMessageModel
- (QWPrivateMessageModel *)buildQWMessageFromAPIModel:(id)mode detail:(PrivateChatDetailModel*)detail {
    QWPrivateMessageModel *qwmsg = [[QWPrivateMessageModel alloc] init];
    qwmsg.UUID = [NSString stringWithFormat:@"%@",detail.detailId];
    
    //检查db里是否有该数据
    if([QWPrivateMessageModel getObjFromDBWithKey:qwmsg.UUID]) {
        return nil;
    }
    
    qwmsg.timestamp = [NSString stringWithFormat:@"%.0f",[detail.createTime doubleValue]];
    qwmsg.isRead = @"1";
    qwmsg.sendname = self.sessionID;
    qwmsg.recvname = self.oID;
    qwmsg.issend = StrFromInt(MessageDeliveryState_Delivered);
    qwmsg.download = StrFromInt(MessageFileState_Pending);
    qwmsg.userType = detail.userType;
    qwmsg.senderId = detail.senderId;
    qwmsg.nickName = detail.nickName;
    
    if (detail.myselfFlag) {
        qwmsg.direction = StrFromInt(MessageTypeSending);
        qwmsg.avatorUrl = QWGLOBALMANAGER.configure.avatarUrl;
    }
    else
    {
        qwmsg.direction = StrFromInt(MessageTypeReceiving);
        qwmsg.avatorUrl = detail.headImg;
    }

    ContentJson *contentJson = [ContentJson parse:[detail.contentJson jsonStringToDict]];
    if([detail.contentType isEqualToString:@"TXT"]) {
        qwmsg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)MessageMediaTypeText];
        qwmsg.body = contentJson.content;
    }
    else if([detail.contentType isEqualToString:@"IMG"]) {
        qwmsg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)MessageMediaTypePhoto];
        qwmsg.richbody = contentJson.imgUrl;
    }
    else if ([detail.contentType isEqualToString:@"POS"]){
        qwmsg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)MessageMediaTypeLocation];
        qwmsg.star = [NSString stringWithFormat:@"%@,%@",contentJson.lat,contentJson.lon];
        qwmsg.body = contentJson.desc;
    }
    else if ([detail.contentType isEqualToString:@"ACT"]) {
        qwmsg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)MessageMediaTypeActivity];
        qwmsg.star = contentJson.actTitle;
        qwmsg.body = contentJson.actContent;
        qwmsg.imgUrl = contentJson.actImgUrl;
        qwmsg.richbody = contentJson.actId;
        if(!contentJson.actId) {
            qwmsg.richbody = contentJson.imgUrl;
        }
    }
    //微商药房商品 add by lijian at V4.0
    else if ([detail.contentType isEqualToString:@"MPRO"]) {
        qwmsg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)MessageMediaMallMedicine];
        qwmsg.body = contentJson.name;//商品名称
        qwmsg.imgUrl = contentJson.imgUrl;//商品图片
        qwmsg.richbody = contentJson.id;
        qwmsg.spec = contentJson.spec;
        qwmsg.branchId = contentJson.branchId;
        qwmsg.branchProId = contentJson.branchProId;
    }
    //药品／优惠商品 yqy
    else if ([detail.contentType isEqualToString:@"PRO"]) {
        qwmsg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)MessageMediaTypeMedicine];
        qwmsg.body = contentJson.name;
        qwmsg.imgUrl = contentJson.imgUrl;
        qwmsg.richbody = contentJson.id;
        
        if (contentJson.pmtLabe.length) {
            qwmsg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)MessageMediaTypeMedicineCoupon];
            qwmsg.title = contentJson.pmtLabe;
            qwmsg.fileUrl = contentJson.pmtId;
        }
    }
    //优惠券
    else if ([detail.contentType isEqualToString:@"COU"]) {
        qwmsg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)MessageMediaTypeCoupon];
        qwmsg.title = contentJson.groupId;
        qwmsg.body = contentJson.groupName;
        qwmsg.star = contentJson.couponTag;
        qwmsg.richbody = contentJson.couponValue;
        qwmsg.fileUrl = contentJson.couponId;
        qwmsg.fromTag = contentJson.scope.intValue;
        qwmsg.imgUrl = contentJson.imgUrl;
        qwmsg.list = [NSString stringWithFormat:@"%@;%@",contentJson.begin,contentJson.end];
        qwmsg.tags = contentJson.top.integerValue;
    }
    //优惠活动
    else if ([detail.contentType isEqualToString:@"PMT"]) {
        qwmsg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)MessageMediaTypeMedicineSpecialOffers];
        qwmsg.star = contentJson.title;
        qwmsg.imgUrl = contentJson.imgUrl;
        qwmsg.richbody = contentJson.id;
        qwmsg.body = contentJson.content;
    }
    else if ([detail.contentType isEqualToString:@"SYS"])
    {
        //             msg.direction = [NSString stringWithFormat:@"%ld",(long)XHBubbleMessageTypeReceiving];
        if([contentJson.type integerValue] == 1) {
            qwmsg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)MessageMediaTypeHeader];
            
            qwmsg.body = contentJson.content;
            
        }else if([contentJson.type integerValue] == 2) {
            qwmsg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)MessageMediaTypeLine];
            
            qwmsg.body = contentJson.content;
            
        }else if ([contentJson.type integerValue] == 3) {
            qwmsg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)MessageMediaTypePhone];
            
            qwmsg.body = contentJson.content;
        }else if ([contentJson.type integerValue] == 4) {
            
            //            SYSMessageCount ++;
            qwmsg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)MessageMediaTypeFooter];
            
            qwmsg.body = contentJson.content;
        }
    }
    
    else if([detail.contentType isEqualToString:@"SPE"]){
        DebugLog(@"***************  收到语音 *************** %@",detail);
        qwmsg.messagetype = StrFromInt(MessageMediaTypeVoice);
        qwmsg.duration = contentJson.duration;
        qwmsg.richbody = nil;
        qwmsg.fileUrl = contentJson.speUrl;
        //        qwmsg.
    }
    //end
    
    return qwmsg;

}
//MessageModel->QWPrivateMessageModel
- (QWPrivateMessageModel *)buildQWMessageFromMessage:(MessageModel *)model{
    
    QWPrivateMessageModel * qwmsg = [[QWPrivateMessageModel alloc] init];
    qwmsg.direction = [NSString stringWithFormat:@"%ld",(long)model.messageDeliveryType];
    qwmsg.timestamp = [NSString stringWithFormat:@"%.0f",[model.timestamp timeIntervalSince1970]*1000.f];
    qwmsg.UUID = model.UUID;
    qwmsg.avatorUrl = model.avatorUrl;
    qwmsg.sendname = (self.sessionID)?self.sessionID:self.oID; //QWGLOBALMANAGER.configure.passPort;
    qwmsg.recvname = self.oID;
    qwmsg.download = [NSString stringWithFormat:@"%ld",(long)model.download];
    qwmsg.issend = [NSString stringWithFormat:@"%ld",(long)model.sended];
    qwmsg.isRead = @"1";
    qwmsg.richbody = @"";
    qwmsg.messagetype = [NSString stringWithFormat:@"%lu",(unsigned long)model.messageMediaType];
    
    switch (model.messageMediaType ){
        case MessageMediaTypeText: {
            
            qwmsg.star = [NSString stringWithFormat:@"%f",model.starMark];
            qwmsg.body = model.text;
            
            break;
        }
        case MessageMediaTypePhoto: {
            qwmsg.star = [NSString stringWithFormat:@"%f",model.starMark];
            qwmsg.richbody = model.richBody;
            qwmsg.body = @"[图片]";
            break;
        }
        case MessageMediaTypeLocation: {
            
            qwmsg.star = [NSString stringWithFormat:@"%@,%@",model.latitude,model.longitude ];
            qwmsg.body = model.text;
            break;
        }
        case MessageMediaTypeActivity: {
            //            qwmsg.star = [NSString stringWithFormat:@"%f",model.starMark];
            qwmsg.richbody = model.richBody;
            qwmsg.star = model.title;
            qwmsg.imgUrl = model.activityUrl;
            
            qwmsg.body = model.text;
            break;
        }
            
        case MessageMediaTypeStarStore:
        {
            //            qwmsg.star = [NSString stringWithFormat:@"%f",model.starMark];
            qwmsg.richbody = model.richBody;
            qwmsg.star = model.title;
            qwmsg.imgUrl = model.activityUrl;
            qwmsg.body = model.text;
            break;
        }
            
            
        case MessageMediaTypePhone:
        {
            
            qwmsg.star = [NSString stringWithFormat:@"%f",model.starMark];
            qwmsg.body = @"[图片]";
            break;
        }
            
        case MessageMediaTypeMedicineShowOnce:
        {
            qwmsg.star = model.title;
            qwmsg.richbody = model.richBody;
            qwmsg.imgUrl = model.activityUrl;
            qwmsg.branchProId = model.branchProId;
            qwmsg.branchId = model.branchId;
            qwmsg.spec = model.spec;
            qwmsg.body = model.text;
            break;
        }
        case MessageMediaTypeMedicineSpecialOffersShowOnce:
        {
            qwmsg.star = model.title;
            qwmsg.richbody = model.richBody;
            qwmsg.body = model.text;
            break;
        }
        //微商药房商品 add by lijian at V4.0
        case MessageMediaMallMedicine:
        {
            qwmsg.body = model.text;
            qwmsg.branchId = model.branchId;
            qwmsg.branchProId = model.branchProId;
            qwmsg.richbody = model.richBody;
            qwmsg.imgUrl = model.activityUrl;
            qwmsg.spec = model.spec;

            break;
        }
        case MessageMediaTypeVoice:
        {
            qwmsg.duration = model.voiceDuration;
            qwmsg.richbody = model.voicePath;
            qwmsg.fileUrl = model.voiceUrl;
            break;
        }
            // add  by  shen
        case MessageMediaTypeMedicine:
        {
            //            qwmsg.star = [NSString stringWithFormat:@"%f",model.starMark];
            qwmsg.richbody = model.richBody;
            qwmsg.body = model.text;
            qwmsg.star = model.title;
            qwmsg.imgUrl = model.activityUrl;//药品图片
            
            break;
        }
            //yqy 优惠
        case MessageMediaTypeCoupon:
        {
            qwmsg.title = model.title;
            qwmsg.body = model.subTitle;
            qwmsg.star = model.text;
            qwmsg.richbody = model.richBody;
            qwmsg.fileUrl = model.otherID;
            qwmsg.fromTag = model.style.intValue;
            qwmsg.list = [NSString stringWithFormat:@"%@;%@",model.arrList.firstObject,model.arrList.lastObject];
            qwmsg.imgUrl=model.thumbnailUrl;
            qwmsg.tags=model.isMarked?1:0;
            break;
        }
        case MessageMediaTypeMedicineCoupon:
        {
            qwmsg.richbody = model.richBody;
            qwmsg.body = model.text;
            qwmsg.star = model.title;
            qwmsg.imgUrl = model.activityUrl;
            
            qwmsg.title = model.subTitle;
            qwmsg.fileUrl = model.otherID;
            break;
        }
            //优惠活动
        case MessageMediaTypeMedicineSpecialOffers:
        {
            
            qwmsg.richbody = model.richBody;
            qwmsg.body = model.text;
            qwmsg.star = model.title;
            qwmsg.imgUrl = model.activityUrl;
            qwmsg.title = model.otherID ;
            qwmsg.fileUrl = model.thumbnailUrl;
            break;
        }
        default:
            break;
    }
    return qwmsg;
}
//QWPrivateMessageModel->MessageModel
- (MessageModel *)buildMessageFromQWMessage:(QWPrivateMessageModel *)qwmsg
{
    NSString *tt=(qwmsg.timestamp.length>10)?[qwmsg.timestamp  substringToIndex:10]:qwmsg.timestamp;
    NSDate *dt=[NSDate dateWithTimeIntervalSince1970:[tt doubleValue]];
    //    DebugLog(@"%@ %@",tt,qwmsg.timestamp);
    MessageModel *msg = nil;
    switch ([qwmsg.messagetype integerValue]){
        case MessageMediaTypeText: {
            msg = [[MessageModel alloc] initWithText:qwmsg.body sender:self.oID timestamp:dt UUID:qwmsg.UUID];
            break;
        }
        case MessageMediaTypePhoto: {
            msg = [[MessageModel alloc] initWithPhoto:nil thumbnailUrl:qwmsg.richbody originPhotoUrl:qwmsg.richbody sender:self.oID timestamp:dt UUID:qwmsg.UUID richBody:msg.richBody];
            break;
        }
        case MessageMediaTypeLocation: {
            NSString *latitude = [qwmsg.star componentsSeparatedByString:@","][0];
            NSString *longitude = [qwmsg.star componentsSeparatedByString:@","][1];
            msg = [[MessageModel alloc] initWithLocation:qwmsg.body latitude:latitude longitude:longitude sender:self.oID timestamp:dt UUID:qwmsg.UUID];
            break;
        }
        case MessageMediaTypeActivity: {
            msg = [[MessageModel alloc] initMarketActivity:qwmsg.star sender:self.oID imageUrl:qwmsg.imgUrl content:qwmsg.body comment:@"" richBody:qwmsg.richbody timestamp:dt UUID:qwmsg.UUID];
            break;
        }
            
            
            // add  by  shen
        case MessageMediaTypeStarStore:
        {
            msg = [[MessageModel alloc] initInviteEvaluate:qwmsg.body sender:qwmsg.sendname timestamp:dt  UUID:qwmsg.UUID];
            msg.starMark = [qwmsg.star integerValue];
            if(msg.starMark > 0) {
                msg.isMarked = NO;
            }else{
                msg.isMarked = YES;
            }
            break;
        }
            
            
        case MessageMediaTypePhone:
        {
            msg = [[MessageModel alloc]initWithPhone:qwmsg.body timestamp:dt UUID:qwmsg.UUID];
            break;
        }
        case MessageMediaTypeHeader:
        {
            msg = [[MessageModel alloc]initWithHeader:qwmsg.body timestamp:dt UUID:qwmsg.UUID];
            break;
        }
        case MessageMediaTypeFooter:
        {
            msg = [[MessageModel alloc]initWithFooter:qwmsg.body timestamp:dt UUID:qwmsg.UUID];;
            break;
        }
        case MessageMediaTypeLine:
        {
            msg = [[MessageModel alloc]initWithLine:qwmsg.body timestamp:dt UUID:qwmsg.UUID];;
            break;
        }
        case MessageMediaTypeMedicineShowOnce:
        {
            msg = [[MessageModel alloc] initWithMedicineShowOnce:qwmsg.body productId:qwmsg.richbody imageUrl:qwmsg.imgUrl spec:qwmsg.spec sender:@"" timestamp:dt UUID:qwmsg.UUID];
            break;
        }
            //add by lijian at V4.0
        case MessageMediaMallMedicine:{
            
            msg = [[MessageModel alloc]initWithMallMedicine:qwmsg.body proId:qwmsg.richbody imgUrl:qwmsg.imgUrl spec:qwmsg.spec branchId:qwmsg.branchId branchProId:qwmsg.branchProId sender:qwmsg.sendname timestamp:dt UUID:qwmsg.UUID];
            break;
        }
        case MessageMediaTypeMedicineSpecialOffersShowOnce:
        {
            NSString *imageUrl = qwmsg.imgUrl;
            if(imageUrl == nil)
                imageUrl = @"";
            NSString *star = qwmsg.star;
            if(star == nil || [star isEqual:[NSNull null]])
                star = @"";
            msg = [[MessageModel alloc] initWithSpecialOffersShowOnce:star content:qwmsg.body activityUrl:imageUrl activityId:qwmsg.richbody sender:@"" timestamp:dt UUID:qwmsg.UUID];
            break;
        }
            // add  end
            // add yqy
        case MessageMediaTypeVoice:{
            msg = [[MessageModel alloc] initWithVoicePath:qwmsg.richbody voiceUrl:qwmsg.fileUrl voiceDuration:qwmsg.duration sender:self.oID timestamp:dt UUID:qwmsg.UUID];
            break;
        }
        case MessageMediaTypeMedicine:
        {
            msg = [[MessageModel alloc] initWithMedicine:qwmsg.body productId:qwmsg.richbody imageUrl:qwmsg.imgUrl sender:self.oID timestamp:dt UUID:qwmsg.UUID];
            break;
        }
            //优惠活动
        case MessageMediaTypeMedicineSpecialOffers:
        {
            msg = [[MessageModel alloc] initWithSpecialOffers:qwmsg.star content:qwmsg.body activityUrl:qwmsg.imgUrl activityId:qwmsg.richbody groupId:qwmsg.title branchLogo:qwmsg.fileUrl sender:self.oID timestamp:dt UUID:qwmsg.UUID];
            break;
        }
            //优惠商品
        case MessageMediaTypeMedicineCoupon:{
            msg = [[MessageModel alloc] initWithMedicineCoupon:qwmsg.body productId:qwmsg.richbody imageUrl:qwmsg.imgUrl pmtLable:qwmsg.title pmtID:qwmsg.fileUrl sender:self.oID timestamp:dt UUID:qwmsg.UUID];
            break;
        }
            //优惠券
        case MessageMediaTypeCoupon:{
            NSArray *atmp=[qwmsg.list componentsSeparatedByString:@";"];
            msg = [[MessageModel alloc] initWithCoupon:qwmsg.title couponName:qwmsg.body couponValue:qwmsg.richbody couponTag:qwmsg.star couponId:qwmsg.fileUrl begin:atmp.firstObject end:atmp.lastObject scope:StrFromInt(qwmsg.fromTag) top:qwmsg.tags imgUrl:qwmsg.imgUrl sender:self.oID timestamp:dt UUID:qwmsg.UUID];
            break;
        }
        default:
            break;
    }
    if([qwmsg.direction integerValue] == MessageTypeReceiving) {
        msg.messageDeliveryType = MessageTypeReceiving;
        msg.avatorUrl = qwmsg.avatorUrl;
    }else{
        msg.messageDeliveryType = MessageTypeSending;
        msg.avatorUrl = QWGLOBALMANAGER.configure.avatarUrl;
    }
    msg.sended = [qwmsg.issend integerValue];
    msg.download = [qwmsg.download integerValue];
    msg.userType = qwmsg.userType;
    msg.senderId = qwmsg.senderId;
    msg.nickName = qwmsg.nickName;
    return msg;
}

//db取出的QWMessage转MessageModel
- (NSMutableArray *)messagesListFromQWMessagesList:(NSArray*)array{
    NSMutableArray *retArray = [NSMutableArray arrayWithCapacity:self.pageSize];
    for(QWMessage *qwmsg in array)
    {
        MessageModel *msg=[self buildMessageFromQWMessage:qwmsg];
        if(msg)
            [retArray addObject:msg];
    }
    
    return retArray;
}

//加入队列
- (void)messagesQueue:(id)obj reset:(BOOL)reset{
    if (obj==nil) {
        return;
    }
    
    if (reset) {
        self.arrMessages = nil;
    }
    
    if (self.arrMessages == nil) {
        self.arrMessages = [[NSMutableArray alloc]initWithCapacity:self.pageSize];
    }
    
    if ([obj isKindOfClass:[MessageModel class]]) {
        [self.arrMessages addObject:obj];
    }
    else if ([obj isKindOfClass:[NSArray class]]){
        [self.arrMessages addObjectsFromArray:obj];
    }
}

//翻页数据加入呈现队列
- (void)messagesHistory:(id)obj{
    if (obj==nil) {
        return;
    }
    
    if (self.arrMessages == nil) {
        self.arrMessages = [[NSMutableArray alloc]initWithCapacity:self.pageSize];
    }
    
    if ([obj isKindOfClass:[NSArray class]]){
        [self.arrMessages insertArray:obj atIndex:0];
    }
    //    else if ([obj isKindOfClass:[MessageModel class]]) {
    //        [self.arrMessages insertObject:obj atIndex:0];
    //    }
    
}

//判断是非有呈现数据
- (BOOL)hadMessages{
    if (self.arrMessages && self.arrMessages.count>0) return YES;
    return NO;
}




#pragma mark  返回所需数据
//刷新UI呈现
- (void)showCurrentMessages:(IMListType)rType successData:(id)successData{
    if (msgListBlock) {
        msgListBlock(self.arrMessages, rType);
    }
    
    if (successStatusBlock) {
        successStatusBlock(successData);
    }
}

//历史/翻页数据要UI呈现
- (void)showHistoryMessages:(IMHistoryBlock)block success:(IMSuccessBlock)success{
    [self setOffset:0];
    NSArray *arr1=[self getDataFromDB];
    NSArray *arr2=[self messagesListFromQWMessagesList:arr1];
    [self messagesHistory:arr2];
    
    if (block) {
        if (arr2.count>0) {
            block(YES);
        }
        else block(NO);
    }
    
    if (success) {
        success(nil);
    }
}


#pragma mark - 方法
//根据uuid取数据model
- (MessageModel *)getMessageWithUUID:(NSString *)uuid
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"UUID == %@",uuid];
    NSArray *array = [self.arrMessages filteredArrayUsingPredicate:predicate];
    if([array count] > 0) {
        return array[0];
    }else{
        return nil;
    }
}

- (NSString *)toJSONStr:(id)theData{
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];;
        
    }else{
        return nil;
    }
}
//取得时间＋1秒
- (NSDate *)dateAddOneSecond:(NSDate*)date{
    //    NSDate *date = [NSDate date];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.second = 1;
    NSDate *next = [gregorian dateByAddingComponents:components toDate:date options:0];
    return next;
}
//服务器时间＋轮询最大间隔。给断网数据用
- (NSDate *)getServerMaxInterval{
    if (self.serverTime<=0) {
        return nil;
    }
    DebugLog(@"%f %f",_serverTime,kPollingMaxInterval);
    double dd=((double)_serverTime + (double)kPollingMaxInterval) ;
    NSDate *dt=[NSDate dateWithTimeIntervalSince1970:dd];
    //    [NSString stringWithFormat:@"%.0f",(double)(self.serverTime+kPollingMaxInterval) ];
    return dt;
}

//- (void)parseHistoryMessage:(CustomerConsultDetailList *)model cache:(BOOL)cache
//{
//}


#pragma mark 接收通知
- (void)getNotifType:(Enum_Notification_Type)type data:(id)data target:(id)obj
{
    if (type == NotifAppDidEnterBackground){
        //进后台
        DebugLog(@"轮询暂停");
        [self suspend];
    }
    else if (type == NotifAppDidBecomeActive){
        //back
        DebugLog(@"轮询继续");
        [self resume];
    }
}



#pragma mark 全局通知
- (void)addObserverGlobal{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotif:) name:kQWGlobalNotification object:nil];
}

- (void)removeObserverGlobal{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kQWGlobalNotification object:nil];
}

- (void)getNotif:(NSNotification *)sender{
    
    NSDictionary *dd=sender.userInfo;
    NSInteger ty=-1;
    id data;
    id obj;
    
    if ([GLOBALMANAGER object:[dd objectForKey:@"type"] isClass:[NSNumber class]]) {
        ty=[[dd objectForKey:@"type"]integerValue];
    }
    data=[dd objectForKey:@"data"];
    obj=[dd objectForKey:@"object"];
    
    [self getNotifType:ty data:data target:obj];
}

@end
