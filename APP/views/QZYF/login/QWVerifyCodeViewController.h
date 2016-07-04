//
//  QWVerifyCodeViewController.h
//  APP
//
//  Created by Martin.Liu on 16/4/15.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "QWBaseVC.h"

typedef void(^VerifyCodeBlock)(NSString* codeValue);

@interface QWVerifyCodeViewController : QWBaseVC
@property (nonatomic, strong) NSString* phoneNumber;
@property (nonatomic, copy)VerifyCodeBlock verifyCodeBlock;
@property (nonatomic, assign) BOOL hasVoiceValid;
@end
