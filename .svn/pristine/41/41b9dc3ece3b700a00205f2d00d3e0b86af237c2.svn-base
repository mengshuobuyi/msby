//
//  ImInfo.m
//  APP
//  和聊天相关的网络交互接口
//  Created by qw on 15/2/22.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "ImInfo.h"
#import "Constant.h"

@implementation ImInfo


//未读数据列表
+ (void)alternativeIMSelect:(NSDictionary *)condition
                    success:(void (^)(id resultObj))success
                    failure:(void (^)(HttpException *))failure
{
//    [[HttpClient sharedInstance] post:AlternativeIMSelect
//                               params:condition
//                              success:^(id resultObj) {
////                                  if ([resultObj[@"body"] isKindOfClass:[NSDictionary class]]) {
////                                      
////                                  }
////                                  
////                                  if(success)
////                                      success(resultObj);
//                                  
//                                  if([resultObj[@"result"] isEqualToString:@"OK"])
//                                  {
//                                      NSArray *historys = resultObj[@"body"];
//                                      //初始化列表
//                                      NSMutableArray *UUIDLists = [NSMutableArray arrayWithCapacity:10];
//                                      for(NSDictionary *dict in historys)
//                                      {
//                                          NSString *content = dict[@"content"];
//                                          
//                                          NSXMLDocument *document = [[NSXMLDocument alloc] initWithXMLString:content options:0 error:nil];
//                                          XMPPIQ *iq = (XMPPIQ *)[document rootElement];
//                                          NSXMLElement *notification = [iq elementForName:@"notification"];
//                                          
//                                          //                if([dict[@"fromTag"] integerValue] == 1) {
//                                          if(notification && [[notification xmlns] isEqualToString:@"androidpn:iq:notification"])
//                                          {
//                                              //接受消息成功
//                                              //消息id
//                                              NSString *UUID = [[notification elementForName:@"id"] stringValue];
//                                              NSDictionary *UUIDdict = @{@"id":UUID};
//                                              [UUIDLists addObject:UUIDdict];
//                                              
//                                              //消息内容
//                                              NSString *text = [[notification elementForName:@"message"] stringValue];
//                                              //消息来源
//                                              NSString *from = [[notification elementForName:@"fromUser"] stringValue];
//                                              //消息发送时间
//                                              double timeStamp = [[notification elementForName:@"timestamp"] stringValueAsDouble] / 1000;
//                                              
//                                              //消息icon
//                                              NSString *avatorUrl = [[notification elementForName:@"uri"] stringValue];
//                                              //消息接收对象
//                                              NSString *sendName = [[notification elementForName:@"to"] stringValue];
//                                              //消息类型
//                                              NSUInteger messageType = [[notification elementForName:@"msType"] stringValueAsInt32];
//                                              
//                                              //消息标题
//                                              NSString *title = [[notification elementForName:@"title"] stringValue];
//                                              
//                                              XHBubbleMessageType bubbleMessageType;
//                                              if([self.configureList[APP_USER_TOKEN] isEqualToString:from]) {
//                                                  bubbleMessageType = XHBubbleMessageTypeSending;
//                                              }else{
//                                                  bubbleMessageType = XHBubbleMessageTypeReceiving;
//                                              }
//                                              
//                                              [app.dataBase insertMessages:[NSNumber numberWithInt:bubbleMessageType]
//                                                                 timestamp:[NSString stringWithFormat:@"%.0f",timeStamp]
//                                                                      UUID:UUID star:title
//                                                                 avatorUrl:avatorUrl
//                                                                  sendName:from
//                                                                  recvName:sendName
//                                                                    issend:[NSNumber numberWithInt:Sended]
//                                                               messagetype:[NSNumber numberWithInt:messageType]
//                                                                    unread:[NSNumber numberWithInt:1]
//                                                                  richbody:avatorUrl
//                                                                      body:text];
//                                              
//                                              [app.dataBase insertHistorys:from
//                                                                 timestamp:[NSString stringWithFormat:@"%.0f",timeStamp]
//                                                                      body:text
//                                                                 direction:[NSNumber numberWithInt:XHBubbleMessageTypeReceiving]
//                                                               messagetype:[NSNumber numberWithInt:messageType]
//                                                                      UUID:UUID
//                                                                    issend:[NSNumber numberWithInt:Sended]
//                                                                 avatarUrl:@""];
//                                              
//                                          }
//                                          
//                                      }
//                                      
//                                      if(UUIDLists.count > 0)
//                                      {
//                                          [app updateUnreadCountBadge];
//                                          [[NSNotificationCenter defaultCenter] postNotificationName:MESSAGE_NEED_UPDATE object:nil];
//                                          [[NSNotificationCenter defaultCenter] postNotificationName:@"offLineMessage" object:nil];
//                                          
//                                          NSMutableDictionary *setting = [NSMutableDictionary dictionary];
//                                          setting[@"ids"] = UUIDLists;
//                                          
//                                          [[HTTPRequestManager sharedInstance] imSetReceived:setting completion:^(id resultObj) {
//                                              
//                                          } failure:NULL];
//                                      }
//                              }
//                              failure:^(HttpException *e) {
//                                  DebugLog(@"%@",e);
//                                  if (failure) {
//                                      failure(e);
//                                  }
//                              }];
}
     
 //设置im消息已经接收
 + (void)imSetReceived:(NSDictionary *)condition
                          success:(void (^)(id resultObj))success
                          failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] post:IMSetReceived
                               params:condition
                              success:^(id resultObj) {
                                  if([resultObj[@"result"] isEqualToString:@"OK"])
                                  {
                                      if(success)
                                          success(resultObj[@"body"]);
                                  }
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}

//心跳数据
+ (void)heartBeat:(NSDictionary *)condition
                    success:(void (^)(id resultObj))success
                    failure:(void (^)(HttpException *))failure
{
    [[HttpClient sharedInstance] post:HeartBeat
                               params:condition
                              success:^(id resultObj) {
                                  if ([resultObj[@"body"] isKindOfClass:[NSDictionary class]]) {
                                      
                                  }
                                  
                                  if(success)
                                      success(resultObj);
                              }
                              failure:^(HttpException *e) {
                                  DebugLog(@"%@",e);
                                  if (failure) {
                                      failure(e);
                                  }
                              }];
}



@end
