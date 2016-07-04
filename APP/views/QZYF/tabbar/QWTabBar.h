//
//  QWTabBar.h
//  APP
//
//  Created by Yan Qingyang on 15/2/28.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QWBaseTabBar.h"
/**
 tab标签
 1、主页
 2、自查
 3、健康咨询
 4、我的
 */
enum  Enum_TabBar_Items {
    // 第一个tab
    Enum_TabBar_Items_HomePage = 0,
    Enum_TabBar_Items_ConsultPharmacy = 1,
    Enum_TabBar_Items_ShoppingCart = 3,
    Enum_TabBar_Items_SellUseCenter = 4,
    // 第二个tab
    Enum_TabBar_Items_HealthInfo = 5,
    Enum_TabBar_Items_ForumHome = 6,
    Enum_TabBar_Items_FinderMain = 8,
    Enum_TabBar_Items_ContentUseCenter = 9,
    
    Enum_TabBar_Items_SPECIALTABBARITEMTAG = 1001,
};

@interface QWTabBar : QWBaseTabBar
@property (nonatomic, strong) UIButton* wenyaoBtn;  // 暂时只当成图片控件来用，以后有需要再拓展

/**
 *  初始化
 *
 *  @param dlg 托管delegate
 *
 *  @return 返回self
 */
- (id)initWithDelegate:(id)dlg;


@end
