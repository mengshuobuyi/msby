//
//  QWYSViewController.m
//  APP
//
//  Created by carret on 15/5/25.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QWYSViewController.h"
#import "OfficeChatTableViewCell.h"
#import "MessageModel.h"


#import "IntroduceQwysViewController.h"

#import "SVProgressHUD.h"
#import "UIScrollView+XHkeyboardControl.h"
#import "ChatManagerDefs.h"
#import "ChatBubbleViewHeader.h"
#import "IMApi.h"
#import "DrugGuideModel.h"
#import "DetailSubscriptionListViewController.h"
#import "DiseaseSubList.h"

#import "WebDirectViewController.h"
#import "ReturnIndexView.h"

@interface QWYSViewController ()<MLEmojiLabelDelegate>


/**
 *  记录旧的textView contentSize Heigth
 */
@property (strong, nonatomic) ReturnIndexView *indexView;
@property (nonatomic, copy) NSString *messageSender;

@end
@implementation QWYSViewController


- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ((QWBaseNavigationController *)self.navigationController).canDragBack = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全维药事";
    [self setRightItems];
    self.dataSource=[NSMutableArray array];
    
    //下拉刷新

//    self.tableMain.headerPullToRefreshText = @"下拉刷新";
//    self.tableMain.headerReleaseToRefreshText = @"松开刷新";
//    self.tableMain.headerRefreshingText = @"正在刷新";
//    [self.tableMain addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    [self enableSimpleRefresh:self.tableMain block:^(SRRefreshView *sender) {
        [self headerRereshing];
    }];
    
    [self.tableMain setBackgroundColor:RGBHex(qwColor11)];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadOfficial) name:OFFICIAL_MESSAGE object:nil];
    [self.tableMain removeFooter];
    self.dataSource = [self queryOfficialDataBaseCache];
    [self sortMessages];
    [self scrollToBottomAnimated:YES];
    if(QWGLOBALMANAGER.loginStatus) {
        [self setOfficialMessagesRead];
    }
    if(!QWGLOBALMANAGER.loginStatus) {
        [self.tableMain removeHeader];
    }

    [QWGLOBALMANAGER postNotif:NotifMessageNeedUpdate data:nil object:self];
}

- (void)reloadOfficial
{
    [self setOfficialMessagesRead];
    self.dataSource = [self queryOfficialDataBaseCache];
    [self.tableMain reloadData];
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self refeshingRecentMessage];
    [QWGLOBALMANAGER updateUnreadCount:[NSString stringWithFormat:@"%ld",(long)[QWGLOBALMANAGER getAllUnreadCount]]];
}

//从服务器拉取数据
- (void)refeshingRecentMessage
{
    ImSelectQWModelR *imSelectQWModelR = [ImSelectQWModelR new];
    imSelectQWModelR.endpoint = @"1";
    imSelectQWModelR.token = QWGLOBALMANAGER.configure.userToken;
    imSelectQWModelR.to = @"";
    imSelectQWModelR.cl = @"0";

    if(self.dataSource.count == 0) {
        imSelectQWModelR.viewType = @"-1";
        imSelectQWModelR.view = @"15";
    }
    else{
        MessageModel *message = self.dataSource[self.dataSource.count -1];
        imSelectQWModelR.point = [NSString stringWithFormat:@"%.0f",[message.timestamp timeIntervalSince1970] * 1000.0f];
        imSelectQWModelR.viewType = @"1";
        imSelectQWModelR.view = @"0";
    }
    [IMApi selectIMQwWithParams:imSelectQWModelR
                        success:^(id obj){
                            if (obj) {
                                NSArray *array = obj[@"records"];
                                if([array isKindOfClass:[NSString class]])
                                {
                                    [self.tableMain headerEndRefreshing];
                                    return;
                                }
                                if (array.count==0) {
                                    return;
                                }
                                [self refreshingRecentMessage:array messageSender:self.messageSender isOfficial:YES];
                                self.dataSource = [self queryOfficialDataBaseCache];
                                [self sortMessages];
                                [self.tableMain reloadData];
                                [self.tableMain headerEndRefreshing];
                                [self scrollToBottomAnimated:YES];
                                [QWGLOBALMANAGER postNotif:NotifMessageNeedUpdate data:nil object:self];
                            }
                        }
                        failure:^(HttpException *e){
                        }];
}


- (void)refreshingRecentMessage:(NSArray *)array
                  messageSender:(NSString *)messageSender
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
    }
    
}



#pragma --头部刷新
- (void)headerRereshing
{
    ImSelectQWModelR *imSelectQWModelR = [ImSelectQWModelR new];
    imSelectQWModelR.endpoint = @"1";
    imSelectQWModelR.token = QWGLOBALMANAGER.configure.userToken;
    imSelectQWModelR.viewType = @"-1";
    imSelectQWModelR.view = @"15";
    
    
    if(self.dataSource.count == 0) {
        imSelectQWModelR.point = [NSString stringWithFormat:@"%0.f",[[NSDate date] timeIntervalSince1970] * 1000];
    }else{
        MessageModel *message = self.dataSource[0];
        imSelectQWModelR.point = [NSString stringWithFormat:@"%.0f",[message.timestamp timeIntervalSince1970] * 1000.0f];
    }
    imSelectQWModelR.to = @"";
    imSelectQWModelR.cl = @"0";
    [IMApi selectIMQwWithParams:imSelectQWModelR
                        success:^(id obj){
                            if (obj) {
                                NSArray *array = obj[@"records"];
                                if([array isKindOfClass:[NSString class]])
                                {
                                    [self.tableMain headerEndRefreshing];
                                    return;
                                }
                                [self headerRefreshingMessage:array messageSender:self.messageSender  messages:self.dataSource official:YES];
                                
                                [self sortMessages];
                                [self.tableMain reloadData];
                                [self.tableMain headerEndRefreshing];
                                [QWGLOBALMANAGER postNotif:NotifMessageNeedUpdate data:nil object:self];
                            }
                        }
                        failure:^(HttpException *e){
                        }];
    
    [self.tableMain performSelector:@selector(headerEndRefreshing) withObject:nil afterDelay:5.0f];
}




- (void)headerRefreshingMessage:(NSArray *)array
                  messageSender:(NSString *)messageSender
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
        
        MessageModel *message = nil;
        switch (msgType)
        {
            case XHBubbleMessageMediaTypeText:
            {
                message = [[MessageModel alloc] initWithText:content sender:fromId timestamp:date UUID:UUID];
                break;
            }
            case XHBubbleMessageMediaTypeAutoSubscription:
            {
                
                message = [[MessageModel alloc] initWithAutoSubscription:content sender:fromId timestamp:date UUID:UUID tagList:tagList];
                
                break;
            }
            case XHBubbleMessageMediaTypeDrugGuide:
            {
                if(tagList.count == 0)
                    continue;
                TagWithMessage * tag = tagList[0];
                
                message = [[MessageModel alloc] initWithDrugGuide:content title:fromName sender:fromId timestamp:date UUID:UUID tagList:tagList subTitle:tag.title fromTag:fromTag];
                break;
            }
            case XHBubbleMessageMediaTypePurchaseMedicine:
            {
                
                TagWithMessage * tag = tagList[0];
                
                message = [[MessageModel alloc]initWithPurchaseMedicine:content sender:fromId timestamp:date UUID:UUID tagList:tagList title:fromName subTitle:tag.title fromTag:fromTag];
                break;
            }
            case XHBubbleMessageMediaTypeSpreadHint:
            {
                message = [[MessageModel alloc] initWithSpreadHint:content title:@"" sender:fromId timestamp:[NSDate date] UUID:UUID tagList:nil fromTag:0];
                break;
            }
                
            default:
                
                break;
        }
        message.avator = [UIImage imageNamed:@"全维药事icon.png"];
        message.officialType = YES;
        if(message)
            [messages addObject:message];
    }
    
}



#pragma ----是否滚动到底部
- (void)scrollToBottomAnimated:(BOOL)animated {
    if(self.tableMain.tableFooterView == nil) {
        NSInteger rows = [self.tableMain numberOfRowsInSection:0];
        if (rows > 0) {
            [self.tableMain scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rows - 1 inSection:0]
                                  atScrollPosition:UITableViewScrollPositionBottom
                                          animated:animated];
        }
    }else{
        [self.tableMain scrollRectToVisible:self.tableMain.tableFooterView.frame animated:YES];
    }
}
#pragma ------将全维药事的信息置为已读
-(void)setOfficialMessagesRead
{
    [OfficialMessages updateSetToDB:@"issend = '1'" WithWhere:nil];
}

#pragma ------从数据库里拉去全维药事的信息
- (NSMutableArray *)queryOfficialDataBaseCache
{
    NSMutableArray *retArray = [NSMutableArray array];
    NSArray *array =  [OfficialMessages getArrayFromDBWithWhere:nil];
    for (OfficialMessages *msg in array) {
        MessageModel *message = nil;
        double time = [msg.timestamp doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
        NSString *where = [NSString stringWithFormat:@"UUID = '%@'",msg.UUID];
        NSArray *tagList = [TagWithMessage getArrayFromDBWithWhere:where];
        DebugLog(@"queryOfficialDataBaseCache-----%@",msg.body);
        switch ([msg.messagetype intValue])
        {
            case MessageMediaTypeAutoSubscription:
            {
                message = [[MessageModel alloc] initWithAutoSubscription:msg.body sender:@"" timestamp:date UUID:msg.UUID tagList:tagList];
                break;
            }
            case MessageMediaTypeDrugGuide://8
            {
                TagWithMessage *tag = tagList[0];
                message = [[MessageModel alloc] initWithDrugGuide:msg.body title:msg.title sender:@"" timestamp:date UUID:msg.UUID tagList:tagList subTitle:tag.title fromTag:msg.fromTag];
                break;
            }
            case MessageMediaTypePurchaseMedicine:
            {
                if(tagList.count == 0)
                    continue;
                TagWithMessage * tag = tagList[0];
                message = [[MessageModel alloc]initWithPurchaseMedicine:msg.body sender:@"" timestamp:date UUID:msg.UUID tagList:tagList title:msg.title subTitle:tag.title fromTag:msg.fromTag];
                break;
            }
            case MessageMediaTypeText:
            {
                message = [[MessageModel alloc] initWithText:msg.body sender:@"" timestamp:date UUID:msg.UUID];
                break;
            }
            case MessageMediaTypeSpreadHint:
            {
                message = [[MessageModel alloc] initWithSpreadHint:msg.body title:@"" sender:self.messageSender timestamp:[NSDate date] UUID:msg.UUID tagList:nil fromTag:0];
                break;
            }
            default:
                break;
        }
        message.avator = [UIImage imageNamed:@"全维药事icon.png"];
        message.officialType = YES;
        if(message)
            [retArray addObject:message];
    }
    return retArray;
}
#pragma --------排列信息的顺序
-(void)sortMessages
{
    NSSortDescriptor*sorter=[[NSSortDescriptor alloc]initWithKey:@"timestamp" ascending:YES];
    NSMutableArray *sortDescriptors=[[NSMutableArray alloc]initWithObjects:&sorter count:1];
    NSArray *sortArray=[self.dataSource sortedArrayUsingDescriptors:sortDescriptors];
    self.dataSource = [[NSMutableArray alloc]initWithArray:sortArray];
}


#pragma mark 配置界面的代理
/**
 *  是否显示时间轴Label的回调方法
 *  @param indexPath 目标消息的位置IndexPath
 *  @return 根据indexPath获取消息的Model的对象，从而判断返回YES or NO来控制是否显示时间轴Label
 */
- (BOOL)shouldDisplayTimestampForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MessageModel *message1 = self.dataSource[indexPath.row];
    if(indexPath.row == 0) {
        return YES;
    }else{
        MessageModel *message0 =  self.dataSource[indexPath.row-1];
        NSTimeInterval offset = [message1.timestamp timeIntervalSinceDate:message0.timestamp];
        if(offset >= 300.0)
            return YES;
    }
    return NO;
}

#pragma ----------左上角的按钮的排列
- (void)setRightItems{
    UIView *qwysBarItems = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 55)];
    //[customBarItems setBackgroundColor:[UIColor yellowColor]];
    UIButton *meButton = [[UIButton alloc] initWithFrame:CGRectMake(28, 0, 55, 55)];
    [meButton setImage:[UIImage imageNamed:@"IM_qwys_icon.png"]  forState:UIControlStateNormal];
    [meButton addTarget:self action:@selector(pushIntoOfficialIntroduce:) forControlEvents:UIControlEventTouchDown];
    [qwysBarItems addSubview:meButton];
    
//    UIButton *indexButton = [[UIButton alloc] initWithFrame:CGRectMake(65, 0, 55, 55)];
//    [indexButton setImage:[UIImage imageNamed:@"icon-unfold.PNG"] forState:UIControlStateNormal];
//    [indexButton addTarget:self action:@selector(showIndex) forControlEvents:UIControlEventTouchDown];
//    [qwysBarItems addSubview:indexButton];
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width = -48;
    self.navigationItem.rightBarButtonItems = @[fixed,[[UIBarButtonItem alloc] initWithCustomView:qwysBarItems]];
}
#pragma -----全维药事的介绍页面
- (void)pushIntoOfficialIntroduce:(id)sender
{
    IntroduceQwysViewController *introduceQwysViewController = [[IntroduceQwysViewController alloc] initWithNibName:@"IntroduceQwysViewController" bundle:nil];
    [self.navigationController pushViewController:introduceQwysViewController animated:YES];
}
#pragma -----首页的点击
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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    ((QWBaseNavigationController *)self.navigationController).canDragBack = YES;
}

#pragma -----tableview的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        MessageModel *model;
        model = self.dataSource[indexPath.row];
    
        OfficeChatTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:@"OfficeChatTableViewCell"];
        BOOL displayTimestamp = YES;
        displayTimestamp = [self shouldDisplayTimestampForRowAtIndexPath:indexPath];
        [cell setupSubviewsForMessageModel:model];
        cell.displayTimestamp = displayTimestamp;
        cell.messageModel = model;
        [cell updateBubbleViewConsTraint:model];
        if (displayTimestamp) {
            [cell configureTimeStampLabel:model];
        }
        [cell setupTheBubbleImageView:model];
        return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL displayTimestamp = YES;
    displayTimestamp = [self shouldDisplayTimestampForRowAtIndexPath:indexPath];
    return [ChatTableViewCell tableView:tableView heightForRowAtIndexPath:indexPath withObject:self.dataSource[indexPath.row] hasTimeStamp:displayTimestamp];
}


- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer
{
    
}

- (void)pushToDrugDetailWithDrugID:(NSString *)drugId promotionId:(NSString *)promotionID{
    
    WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    MapInfoModel *modelMap = [QWUserDefault getObjectBy:APP_MAPINFOMODEL];
    WebDrugDetailModel *modelDrug = [WebDrugDetailModel new];
    modelDrug.modelMap = modelMap;
    modelDrug.proDrugID = drugId;
    modelDrug.promotionID = promotionID;
//    modelDrug.showDrug = @"0";
    WebDirectLocalModel *modelLocal = [WebDirectLocalModel new];
//    modelLocal.title = @"药品详情";
    modelLocal.modelDrug = modelDrug;
    modelLocal.typeLocalWeb = WebPageToWebTypeMedicine;
    [vcWebMedicine setWVWithLocalModel:modelLocal];
    [self.navigationController pushViewController:vcWebMedicine animated:YES];
}



#pragma mark - UIResponder actions

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    NSInteger linkType=[[userInfo objectForKey:@"type"] integerValue];
    MessageModel *model=[userInfo objectForKey:KMESSAGEKEY];
    if(linkType == [[NSNumber numberWithInt:MLEmojiLabelLinkTypeMedicineDetail] integerValue])
    {
        [self pushToDrugDetailWithDrugID:[userInfo objectForKey:@"link"] promotionId:@""];
        
    }else if (linkType ==  [[NSNumber numberWithInt:MLEmojiLabelLinkTypeDrugGuide] integerValue])
    {
        DetailSubscriptionListViewController *detailSubscriptionViewController = [[DetailSubscriptionListViewController alloc] init];
        NSString *title = @"慢病订阅";
        for(TagWithMessage *tag in [model tagList])
        {
            if([tag.tagId isEqualToString:[userInfo objectForKey:@"link"]]){
                title = [[model text] substringWithRange:NSMakeRange([tag.start integerValue], [tag.length integerValue])];
                break;
            }
        }
        DrugGuideListModel    *modelDrugGuideR = [DrugGuideListModel  new];
        modelDrugGuideR.title = title;
        modelDrugGuideR.guideId  = [userInfo objectForKey:@"link"];
        detailSubscriptionViewController.modelDrugGuide = modelDrugGuideR;
        
        DiseaseSubList* diseasesublist = [DiseaseSubList getObjFromDBWithKey:[userInfo objectForKey:@"link"]];
        if (diseasesublist) {
            diseasesublist.hasRead = @"YES";
            [DiseaseSubList updateObjToDB:diseasesublist WithKey:[userInfo objectForKey:@"link"]];
        }
        [self.navigationController pushViewController:detailSubscriptionViewController animated:YES];
    }

    
}

//链接被点击
- (void)chatTextCellUrlPressed:(NSURL *)url
{
    if (url) {

    }
}


@end
