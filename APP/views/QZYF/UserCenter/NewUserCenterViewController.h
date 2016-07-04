//
//  NewUserCenterViewController.h
//  APP
//
//  Created by qw_imac on 16/6/13.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "QWBaseVC.h"
#import "NewUserCenterHeaderView.h"
typedef NS_ENUM(NSInteger,ShowLvlAlert){
    ShowLvlAlertYes,
    ShowLvlAlertNo,
};
@interface NewUserCenterViewController : QWBaseVC
@property (nonatomic,assign) CurrentCityStatus status;      //开通微商状态  
@end
