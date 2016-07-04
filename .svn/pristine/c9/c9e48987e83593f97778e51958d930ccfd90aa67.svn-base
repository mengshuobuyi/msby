//
//  BuyerMessageViewController.h
//  APP
//  买家留言
//  Created by PerryChen on 3/28/16.
//  Copyright © 2016 carret. All rights reserved.
//

#import "QWBaseVC.h"
@interface BuyerMessageModel:NSObject
@property (nonatomic,assign)NSInteger selectedIndex;
@property (nonatomic,assign)BOOL      isselected;
@property (nonatomic,strong)NSString  *message;
@end
@interface BuyerMessageViewController : QWBaseVC
@property (nonatomic,copy)void(^message)(NSString *,BuyerMessageModel *);
@property (nonatomic,strong) BuyerMessageModel *buyerMessage;
@end
