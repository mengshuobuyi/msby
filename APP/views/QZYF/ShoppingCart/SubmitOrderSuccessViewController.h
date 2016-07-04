//
//  SubmitOrderSuccessViewController.h
//  APP
//
//  Created by garfield on 16/1/4.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "QWBaseVC.h"
#import "MallCart.h"

@interface SubmitOrderSuccessViewController : QWBaseVC


@property (nonatomic, strong) NSString                           *orderId;
@property (nonatomic, assign) NSInteger                          payType;

@end
