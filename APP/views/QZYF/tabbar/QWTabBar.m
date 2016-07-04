//
//  QWTabBar.m
//  APP
//
//  Created by Yan Qingyang on 15/2/28.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QWTabBar.h"
#import "AppDelegate.h"


#import "UIImage+Ex.h"



@interface QWTabBar ()
{

}
@end

@implementation QWTabBar

- (id)initWithDelegate:(id)dlg{
    self = [super init];
    if (self) {
        self.delegate=dlg;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
//    self.wenyaoBtn.center = CGPointMake(APP_W/2, self.tabBar.frame.size.height / 2 - 11);
//    [self.tabBar addSubview:self.wenyaoBtn];
//    for(UIView *subView in self.tabBar.subviews)
//    {
//        if([subView isKindOfClass:[UIImageView class]] && subView.frame.size.height == 0.5) {
//            [self.tabBar insertSubview:subView belowSubview:self.wenyaoBtn];
//        }
//    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    for(UIView *subView in self.tabBar.subviews)
//    {
//        if([subView isKindOfClass:[UIImageView class]] && subView.frame.size.height <= 0.5) {
//            [self.tabBar insertSubview:subView belowSubview:self.wenyaoBtn];
//        }
//    }
}

/*
- (UIButton *)wenyaoBtn
{
    if (!_wenyaoBtn) {
        UIImage* wenyaoBtnImage = [UIImage imageNamed:@"icon_common_healthy"];
        _wenyaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _wenyaoBtn.frame = CGRectMake(0, 10, wenyaoBtnImage.size.width, wenyaoBtnImage.size.height);
        // 暂且当图片用
        _wenyaoBtn.userInteractionEnabled = NO;
        // 显示的图片
        [_wenyaoBtn setImage:[UIImage imageNamed:@"icon_common_healthy"] forState:UIControlStateNormal];
    }
    return _wenyaoBtn;
}
 */



- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
 
    //    [self showBadgePoint:YES itemTag:tabBarController.selectedIndex];
    //    [self showBadgeNum:99 itemTag:tabBarController.selectedIndex];
    // add by martin  为了中间按钮的适配
    if(item.tag == Enum_TabBar_Items_ConsultPharmacy){
        
    }
    
    if(item.tag == Enum_TabBar_Items_SPECIALTABBARITEMTAG)
    {
        return;
    }
    if (item.tag == Enum_TabBar_Items_HealthInfo) {
        [QWGLOBALMANAGER postNotif:NotifInfoListTabbarSelected data:nil object:nil];
    }
}

@end
