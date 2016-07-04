//
//  ReciverAddressTableViewController.h
//  APP
//
//  Created by qw_imac on 15/12/30.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "QWBaseVC.h"
#import "ReceiveAddress.h"
typedef void (^SelectAddressCallback)(NSString *strAddress);
typedef void (^H5Refresh)();
typedef enum Enum_PageComeFrom{
    PageComeFromHomePage = 1,       //从首页过来
    PageComeFromStoreList,          //从药房列表过来
    PageComeFromSearch,             //从搜索过来
    PageComeFromReceiveAddress,
    PageComeFromH5,                //H5过来
    PageComeFromMall,
}PageComeFrom;
@interface ReceiverAddressTableViewController : QWBaseVC
@property (nonatomic,assign) PageComeFrom           pageType;
//@property (nonatomic,copy) void(^changeAddress)(NSString *address);
@property (nonatomic, strong) SelectAddressCallback extCallback;
@property (nonatomic,copy) H5Refresh                refresh;
@property (nonatomic,copy) void(^chooseAddress)(AddressVo *addressInfo);
@property (nonatomic,assign) BOOL                   isComeFromAdd;    //是否是从添加地址过来
@property (nonatomic,strong) NSString               *branchCity;        //药房城市
@end
