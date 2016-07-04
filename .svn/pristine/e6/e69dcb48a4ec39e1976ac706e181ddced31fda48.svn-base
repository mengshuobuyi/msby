//
//  QWBaseTabBar.m
//  APP
//
//  Created by Yan Qingyang on 15/3/2.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "QWBaseTabBar.h"
#import "Constant.h"
#import "HomePageViewController.h"
#import "HealthInfoMainViewController.h"
#import "ShoppingCartViewController.h"
#import "NewSellUserCenterViewController.h"
#import "BranchGoodListViewController.h"
#import "QWCustomedTabBar.h"
#import "LocationExcessiveViewController.h"
#import "NewUserCenterViewController.h"


@implementation QWTabbarItem

+ (NSString *)getPrimaryKey
{
    return @"tag";
}

@end


@interface QWBaseTabBar()<UINavigationControllerDelegate>
{
    NSMutableArray * arrBadges;
    
}
@end

@implementation QWBaseTabBar
@synthesize arrTabItems;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // replace by customedTabBar
    [self setValue:[QWCustomedTabBar new] forKey:@"tabBar"];
}

- (void)addTabBarItem:(QWTabbarItem*)firstObject, ... {
    
    arrTabItems=nil;
    arrTabItems = [NSMutableArray array];
    
    NSMutableArray * arrTags = [NSMutableArray array];
    
    UINavigationController * nav = nil;
    
    if (firstObject)
    {
        
        va_list args;
        va_start(args, firstObject);
        for (QWTabbarItem *obj = firstObject; obj != nil; obj = va_arg(args,QWTabbarItem*)) {
            if([obj.clazz isEqualToString:@"HomePageViewController"]) {
                
                 nav = [[QWBaseNavigationController alloc] initWithRootViewController:[[HomePageViewController alloc] initWithNibName:@"HomePageViewController" bundle:nil]];
            }
            else if ([obj.clazz isEqualToString:@"NewUserCenterViewController"]){
                NewUserCenterViewController *viewController = [[NewUserCenterViewController alloc] initWithNibName:@"NewUserCenterViewController" bundle:nil];
                if (obj.tag.integerValue == Enum_TabBar_Items_SellUseCenter) {
                    viewController.status = CurrentCityStatusOpenWeChatBussness;
                }else {
                    viewController.status = CurrentCityStatusUnopenWechatBussness;
                }
                nav = [[QWBaseNavigationController alloc] initWithRootViewController:viewController];
                [viewController viewDidLoad];
            }
            else if ([obj.clazz isEqualToString:@"HealthInfoMainViewController"]){
                HealthInfoMainViewController *viewController = [[HealthInfoMainViewController alloc] initWithNibName:@"HealthInfoMainViewController" bundle:nil];
                nav = [[QWBaseNavigationController alloc] initWithRootViewController:viewController];
            }else if ([obj.clazz isEqualToString:@"ShoppingCartViewController"]) {
                ShoppingCartViewController *viewController = [[ShoppingCartViewController alloc] initWithNibName:@"ShoppingCartViewController" bundle:nil];
                nav = [[QWBaseNavigationController alloc] initWithRootViewController:viewController];
                UIView *view = [[UIView alloc] init];
                view.hidden = YES;
                [viewController.view addSubview:view];
            }
            else if([obj.clazz isEqualToString:@"BranchGoodListViewController"]){
                BranchGoodListViewController *viewController = [[BranchGoodListViewController alloc] initWithNibName:@"BranchGoodListViewController" bundle:nil];
                nav = [[QWBaseNavigationController alloc] initWithRootViewController:viewController];
            }else if ([obj.clazz isEqualToString:@"LocationExcessiveViewController"]) {
                
                LocationExcessiveViewController *viewController = [[LocationExcessiveViewController alloc] initWithNibName:@"LocationExcessiveViewController" bundle:nil];
                nav = [[QWBaseNavigationController alloc] initWithRootViewController:viewController];
                
            }else{
                nav = [[QWBaseNavigationController alloc] initWithRootViewController:[[NSClassFromString(obj.clazz) alloc] init]];
                nav.delegate = self;
            }
            UITabBarItem *item = [self createTabBarItem:obj.title normalImage:obj.picNormal selectedImage:obj.picSelected itemTag:obj.tag.integerValue titleColor:obj.titleNormalColor titleSelectedColor:obj.titleSelectedColor];
            nav.tabBarItem = item;
            [arrTabItems addObject:nav];
            [arrTags addObject:obj.tag];
        }
        va_end(args);
        
        [self addBadge:arrTags];
        [self.tabBar setBackgroundImage:[UIImage imageNamed:@"black_Navigation"]];
        self.viewControllers = arrTabItems;
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(navigationController.viewControllers.count > 1){
        return;
    }
    
    //每次当navigation中的界面切换，设为空。本次赋值只在程序初始化时执行一次
    static UIViewController *lastController = nil;
    
    //若上个view不为空
    if (lastController != nil)
    {
        //若该实例实现了viewWillDisappear方法，则调用
        if ([lastController respondsToSelector:@selector(viewWillDisappear:)])
        {
            [lastController viewWillDisappear:animated];
        }
    }
    
    //将当前要显示的view设置为lastController，在下次view切换调用本方法时，会执行viewWillDisappear
    lastController = viewController;
    
    [viewController viewWillAppear:animated];
}

- (UITabBarItem *)createTabBarItem:(NSString *)strTitle normalImage:(NSString *)strNormalImg selectedImage:(NSString *)strSelectedImg itemTag:(NSInteger)intTag titleColor:(UIColor *)normalColor titleSelectedColor:(UIColor *)selectedColor
{
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:strTitle image:nil tag:intTag];
    
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:normalColor, NSForegroundColorAttributeName,fontSystem(kFontS6), NSFontAttributeName, nil] forState:UIControlStateNormal];
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:selectedColor, NSForegroundColorAttributeName,fontSystem(kFontS6), NSFontAttributeName,  nil] forState:UIControlStateSelected];
    
    if (iOSv7) {
        [item setImage:[[UIImage imageNamed:strNormalImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item setSelectedImage:[[UIImage imageNamed:strSelectedImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }else{
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_7_0
        [item setFinishedSelectedImage:[UIImage imageNamed:strSelectedImg] withFinishedUnselectedImage:[UIImage imageNamed:strNormalImg]];
#endif
    }
    return item;
}

/**
 *  按钮添加红点
 *
 *  @param tags 所有按钮的tag
 */
- (void)addBadge:(NSArray*)tags{
    arrBadges = nil;
    arrBadges = [NSMutableArray array];
    
    CGFloat ww = APP_W/tags.count;
    CGRect frm=(CGRect){0,7,10,10};
    
    int i = 0;
    
    for (NSString *obj in tags) {
        frm.origin.x=ww*i+45.f;//AutoValue(45.f);
        
        UIImageView *imgIcon;
        imgIcon = [[UIImageView alloc] initWithFrame:frm];
        imgIcon.tag=obj.integerValue;
        imgIcon.layer.cornerRadius = 5.0f;
        imgIcon.layer.masksToBounds = YES;
        imgIcon.backgroundColor = RGBHex(qwColor3);
        imgIcon.hidden = YES;
        [self.tabBar addSubview:imgIcon];
        [arrBadges addObject:imgIcon];
        
        i++;
    }
    
}

- (void)showBadgePoint:(BOOL)enabled itemTag:(NSInteger)intTag
{
    for (UIImageView *obj in arrBadges) {
        if (obj.tag==intTag) {
            [self.tabBar bringSubviewToFront:obj];
            obj.hidden=!enabled;
        }
    }
}

- (void)showBadgeNum:(NSInteger)num itemTag:(NSInteger)intTag{
    int i = 0;
    for (UINavigationController *obj in arrTabItems) {
        if (obj.tabBarItem.tag==intTag) {
            if (num<=0)
                obj.tabBarItem.badgeValue=nil;
            else if(num>99)
                obj.tabBarItem.badgeValue=@"...";
            else
                obj.tabBarItem.badgeValue=[NSString stringWithFormat:@"%i",num];
        }
        i++;
    }
}
@end
