//
//  AddAddressInfoViewController.h
//  APP
//
//  Created by qw_imac on 15/12/31.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "QWBaseVC.h"
#import "ReceiveAddress.h"
#import "ReceiverAddressTableViewController.h"
typedef void (^H5Refresh)();
typedef enum NSInteger {
    StyleAdd,
    StyleEdit,
}EditAddressStyle;
typedef void (^SelectAddressCallback)(NSString *strAddress);
@interface AddOrChangeAddressInfoViewController : QWBaseVC
@property (nonatomic,assign) BOOL                   isChange;
@property (nonatomic,assign) EditAddressStyle       styleEdit;
@property (nonatomic,strong) AddressVo              *vo;
@property (nonatomic,assign) PageComeFrom           pageType;
@property (nonatomic, strong) SelectAddressCallback extCallback;
@property (nonatomic,copy) H5Refresh                refresh;
@end
