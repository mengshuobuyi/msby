//
//  ConfigureModel.h
//  APP
//
//  Created by qw on 15/3/4.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BasePrivateModel.h"
#import "BaseAPIModel.h"
#import "ForumModel.h"
@interface UserInfoModel : BaseAPIModel

@property (nonatomic,strong) NSString   *userToken;
@property (nonatomic,strong) NSString   *passPort;
@property (nonatomic,strong) NSString   *userName;
@property (nonatomic,strong) NSString   *passWord;
@property (nonatomic,strong) NSString   *nickName;
@property (nonatomic,strong) NSString   *avatarUrl;
@property (nonatomic,strong) NSString   *sex;
@property (nonatomic,strong) NSString   *version;
@property (nonatomic,strong) NSString   *lastTimestamp;
@property (nonatomic,assign) BOOL expertCommentRed;
@property (nonatomic,assign) BOOL expertFlowerRed;
@property (nonatomic,assign) BOOL expertSystemInfoRed;
@property (nonatomic,assign) BOOL expertPrivateMsgRed;      // 圈子私聊小红点
// 2.2.3 增加
@property (nonatomic) BOOL firstTPAL;
@property (nonatomic) BOOL setPwd;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic ,assign) BOOL flagSilenced;
// 2.2.4 增加
@property (nonatomic) BOOL full;                        // 完善资料的标识 ， 用于密码登录和验证码登录
@property (nonatomic,strong) NSString* inviteCode;      // 邀请码
@property (nonatomic) BOOL qq;                          // 绑定qq的标识
@property (nonatomic) BOOL weChat;                      // 绑定微信的标识
// 3.0.0
@property (nonatomic) BOOL reg;                         // 本次登录是否来自注册,
@property (nonatomic) NSInteger authStatus;             // 专家认证状态:1.未认证,2.认证中(申请成功),3.已认证(认证通过),4.认证失败,
@property (nonatomic) NSInteger mbrLvl;                 // 圈子中的用户等级
@property (nonatomic) PosterType userType;              // 发帖用到的，标识是普通用户，营养师还是药师
@property (nonatomic) BOOL isThirdLogin;                // 是否是第三方登录
//3.2.1
@property (nonatomic, assign) BOOL forceSecurityVerifyCode;   // 是否用安全注册
- (NSString*)getMyUsername;
@end


@interface UserInfoModelPrivate : BasePrivateModel

@property (nonatomic,strong) NSString   *userToken;
@property (nonatomic,strong) NSString   *passPort;
@property (nonatomic,strong) NSString   *userName;
@property (nonatomic,strong) NSString   *passWord;
@property (nonatomic,strong) NSString   *nickName;
@property (nonatomic,strong) NSString   *avatarUrl;

@end

@interface receiveMessage : BaseAPIModel

@property (nonatomic) BOOL   sound;
@property (nonatomic) BOOL   vibration;

@end
@interface medicineClock : BaseAPIModel

@property (nonatomic) BOOL   sound;
@property (nonatomic) BOOL   vibration;

@end

@interface SaveMemberInfo : BaseAPIModel

@property (nonatomic) BOOL taskChanged;  // 任务是否有变化。积分或成长值,
@property (nonatomic) BOOL full;  // 用户资料是否完善

@end
