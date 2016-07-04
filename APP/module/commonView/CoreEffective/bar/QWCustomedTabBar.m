//
//  QWCustomedTabBar.m
//  APP
//
//  Created by  ChenTaiyu on 16/6/16.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "QWCustomedTabBar.h"
#import "QWTabBar.h"
#import "QWGlobalManager.h"
#import "AppDelegate.h"

@interface QWCustomedTabBar () {
    UIButton *_specialButton;
}

@property (nonatomic, strong) UIButton *specialButton;
@property (nonatomic, strong) UIButton *specialBgView;
@property (nonatomic, assign) CGFloat tabBarItemWidth;
@property (nonatomic, assign) BOOL hasSpecialButton;
@property (nonatomic, strong) NSArray *barBtns;
@property (nonatomic, assign) BOOL hasSpecialBgView;

@end

const NSInteger kBarBtnTagOffset = 0xFF;
//const CGFloat kTabBarMidItemWidth = 100.0;
const CGFloat kTabBarMidItemOffsetY = 0;//-8.0;

@implementation QWCustomedTabBar

#pragma mark - Public

- (void)changeStyleWithItemConfig:(NSArray<QWTabbarItem *> *)itemConfig
{
    QWTabbarItem *midItem = itemConfig[itemConfig.count/2];
    // title为空则当做特殊Item处理
    if (!midItem.title.length) {
        UIButton *button = [self specialButtonWithItem:midItem];
        [self changeStyleWithItemConfig:itemConfig withSpecialBtn:button];
    } else {
        [self changeStyleWithItemConfig:itemConfig withSpecialBtn:nil];
    }
}

- (void)changeStyleWithItemConfig:(NSArray <QWTabbarItem *>*)itemConfig withSpecialBtn:(UIButton *)specialBtn
{
    self.hasSpecialButton = [specialBtn isKindOfClass:[UIButton class]];
    self.specialButton = self.hasSpecialButton ? specialBtn : nil;
    UITabBarController *tabVC = (id)self.delegate;
    if ([tabVC isKindOfClass:[UITabBarController class]]) {
        NSInteger index = 0;
        for (UIViewController *vc in tabVC.viewControllers) {
            QWTabbarItem *obj = itemConfig[index];
            UITabBarItem *item = [self createTabBarItem:obj.title normalImage:obj.picNormal selectedImage:obj.picSelected itemTag:obj.tag.integerValue titleColor:obj.titleNormalColor titleSelectedColor:obj.titleSelectedColor];
            if (self.hasSpecialButton && index == tabVC.viewControllers.count/2) {
                item.image = nil;
                item.selectedImage = nil;
            }
            item.badgeValue = vc.tabBarItem.badgeValue;
            vc.tabBarItem = item;
            index++;
        }
    }
}

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.hasSpecialBgView = YES;
    }
    return self;
}

- (void)setSelectedItem:(UITabBarItem *)selectedItem
{
    [super setSelectedItem:selectedItem]; // call tabbarVC shouldSelect
    
    // check index change
    NSInteger toSelectedIndex = [self.items indexOfObject:self.selectedItem];
    if (toSelectedIndex == self.items.count/2 ) {
        self.specialBgView.selected = YES;
        self.specialButton.selected = YES;
    } else {
        self.specialBgView.selected = NO;
        self.specialButton.selected = NO;
    }
}

- (UIButton *)specialBgView
{
    if (!_specialBgView) {
        _specialBgView = [self specialButtonBackground];
        _specialBgView.adjustsImageWhenHighlighted = NO;
        _specialBgView.userInteractionEnabled = NO;
    }
    return _specialBgView;
}

- (void)setSpecialButton:(UIButton *)specialButton
{
    if (_specialButton != specialButton) {
        [_specialButton removeFromSuperview];
        specialButton.adjustsImageWhenHighlighted = NO;
        specialButton.userInteractionEnabled = NO;
//        [specialButton addTarget:self action:@selector(specialButtonClicked:) forControlEvents:UIControlEventTouchDown];
        _specialButton = specialButton;
    }
}


- (UIButton *)specialButtonBackground
{
    UIButton * specialButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *bgImgNormal =  [UIImage imageNamed:@"icon_common_healthybackground_rest"];
    [specialButton setBackgroundImage:bgImgNormal forState:UIControlStateNormal];
    [specialButton setBackgroundImage:[UIImage imageNamed:@"icon_common_healthybackground_selected"] forState:UIControlStateSelected];
    CGFloat aspectRadio = bgImgNormal.size.width / bgImgNormal.size.height;
    CGFloat height = self.bounds.size.height;
    specialButton.frame = CGRectMake(0, 10, height * aspectRadio, height /* -1 */);
    return specialButton;
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self getBarBtnAndAddClickListen];

    CGFloat barWidth = self.bounds.size.width;
    CGFloat barHeight = self.bounds.size.height;
    self.tabBarItemWidth = barWidth / self.items.count;
    
    if (self.hasSpecialButton) {
        if (!self.specialButton.superview) {
            [self addSubview:self.specialButton];
        }
        CGFloat multiplerInCenterY = 0.5 /*[self multiplerInCenterY]*/;
        self.specialButton.center = CGPointMake(barWidth * 0.5, barHeight * multiplerInCenterY + kTabBarMidItemOffsetY);
    } else {
        [self.specialButton removeFromSuperview];
    }

    NSUInteger plusButtonIndex = self.items.count / 2;
    
    UITabBarItem *item = self.items[plusButtonIndex];
    UIControl *ctrl = [item valueForKey:@"view"];
    UILabel *label = [ctrl valueForKey:@"label"];
    label.hidden = self.hasSpecialButton;
    
    NSArray *tabBarButtonArray = self.barBtns;
    [tabBarButtonArray enumerateObjectsUsingBlock:^(UIView * _Nonnull childView, NSUInteger buttonIndex, BOOL * _Nonnull stop) {
//        childView.backgroundColor = [UIColor colorWithRed:0.1 * buttonIndex green:0 blue:0 alpha:1];
        if (buttonIndex == plusButtonIndex) {
//            childView.hidden = self.hasSpecialButton;
            self.specialBgView.hidden = !self.hasSpecialBgView;
            [childView insertSubview:self.specialBgView atIndex:0];
        }
        if (buttonIndex == plusButtonIndex) {
            self.specialBgView.center = CGPointMake(childView.frame.size.width/2, childView.frame.size.height/2 - .5f);
        } /* else {
            childView.frame = CGRectMake(childViewX,
                                     CGRectGetMinY(childView.frame),
                                     self.tabBarItemWidth,
                                     CGRectGetHeight(childView.frame)
                                     );
        }*/
    }];
    if (self.hasSpecialButton) {
        [self bringSubviewToFront:self.specialButton];
    }
}

#pragma mark - Click event

- (void)getBarBtnAndAddClickListen
{
    NSMutableArray *arrM = [NSMutableArray array];
    for (UITabBarItem *item in self.items) {
        // barButton
        UIControl *ctrl = [item valueForKey:@"view"];
        if ([ctrl isKindOfClass:[UIControl class]]) {
            ctrl.tag = kBarBtnTagOffset + [self.items indexOfObject:item];
            [self addClickEventListenForContorl:ctrl];
            [arrM addObject:ctrl];
        }
    }
    
    if (!arrM.count) {
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[UIControl class]] && ![view isKindOfClass:[UIButton class]]) {
                UIControl *ctrl = (UIControl *)view;
                [arrM addObject:ctrl];
            }
        }
        NSArray *barBtns = [self sortedViewsFromArray:arrM];
        for (UIControl *ctrl in barBtns) {
            ctrl.tag = kBarBtnTagOffset + [barBtns indexOfObject:ctrl];
            [self addClickEventListenForContorl:ctrl];
        }
    }
    self.barBtns = [arrM copy];
}

- (void)addClickEventListenForContorl:(UIControl *)ctrl {
    NSArray<NSString *> *selectorNamesArray = [ctrl actionsForTarget:self forControlEvent:UIControlEventTouchDown];
    BOOL hasSel = NO;
    for (NSString *selName in selectorNamesArray) {
        if ([selName isEqualToString:NSStringFromSelector(@selector(tabBarItemClicked:))]) {
            hasSel = YES;
            break;
        }
    }
    if (!hasSel) {
        [ctrl addTarget:self action:@selector(tabBarItemClicked:) forControlEvents:UIControlEventTouchDown];
    }
}

// 切换中间item的背景
- (void)tabBarItemClicked:(UIControl *)ctrl
{
//#if DEBUG
//    [QWGLOBALMANAGER renewTabbarStyle];
//#endif

    //  移至 [self setSelectedItem:..]  因为会多调用一遍shouldSelect
//    NSInteger lastSelectIndex = [self.items indexOfObject:self.selectedItem];
//    NSInteger toSelectedIndex = ctrl.tag - kBarBtnTagOffset;
//    UITabBarController *tabVC = (UITabBarController *)self.delegate;
//    if ([tabVC isKindOfClass:[UITabBarController class]]) {
//        BOOL shouldSelect = [tabVC.delegate tabBarController:tabVC shouldSelectViewController:tabVC.viewControllers[toSelectedIndex]];
//        if (shouldSelect) {
//            if (toSelectedIndex == self.items.count/2) {
//                self.specialBgView.selected = YES;
//                self.specialButton.selected = YES;
//            } else {
//                self.specialBgView.selected = NO;
//                self.specialButton.selected = NO;
//            }
//        }
//    }
//    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    if(toSelectedIndex == 2 && [app isMainTab]) {
//        [QWGLOBALMANAGER postNotif:NotiMessageOPLaunchingScreenDisappear data:nil object:nil];
//    }
}

- (void)specialButtonClicked:(UIButton *)button
{
    
    
}


#pragma mark - Assistance Method

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

- (CGFloat)multiplerInCenterY {
    CGFloat multiplerInCenterY;

    CGSize sizeOfPlusButton = self.specialButton.frame.size;
    CGFloat heightDifference = sizeOfPlusButton.height - self.bounds.size.height;
    if (heightDifference < 0) {
        multiplerInCenterY = 0.5;
    } else {
        CGPoint center = CGPointMake(self.bounds.size.height * 0.5, self.bounds.size.height * 0.5);
        center.y = center.y - heightDifference * 0.5;
        multiplerInCenterY = center.y / self.bounds.size.height;
    }
    
    return multiplerInCenterY;
}

/*!
 *  Deal with some trickiness by Apple, You do not need to understand this method, somehow, it works.
 *  NOTE: If the `self.title of ViewController` and `the correct title of tabBarItemsAttributes` are different, Apple will delete the correct tabBarItem from subViews, and then trigger `-layoutSubviews`, therefore subViews will be in disorder. So we need to rearrange them.
 */
- (NSArray *)sortedViewsFromArray:(NSArray *)viewArray
{
    NSArray *sortedSubviews = [viewArray sortedArrayUsingComparator:^NSComparisonResult(UIView * formerView, UIView * latterView) {
        CGFloat formerViewX = formerView.frame.origin.x;
        CGFloat latterViewX = latterView.frame.origin.x;
        return  (formerViewX > latterViewX) ? NSOrderedDescending : NSOrderedAscending;
    }];
    return sortedSubviews;
}

/*!
 *  Capturing touches on a subview outside the frame of its superview.
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.clipsToBounds || self.hidden || (self.alpha == 0.f)) {
        return nil;
    }
    UIView *result = [super hitTest:point withEvent:event];
    if (result) {
        return result;
    }
    for (UIView *subview in self.subviews.reverseObjectEnumerator) {
        CGPoint subPoint = [subview convertPoint:point fromView:self];
        result = [subview hitTest:subPoint withEvent:event];
        if (result) {
            return result;
        }
    }
    return nil;
}

- (UIButton *)specialButtonWithItem:(QWTabbarItem *)item
{
    UIButton *_wenyaoBtn;
    UIImage* wenyaoBtnImage = [UIImage imageNamed:item.picNormal];
    _wenyaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _wenyaoBtn.frame = CGRectMake(0, 0, wenyaoBtnImage.size.width, wenyaoBtnImage.size.height);
    [_wenyaoBtn setImage:wenyaoBtnImage forState:UIControlStateNormal];
    [_wenyaoBtn setImage:[UIImage imageNamed:item.picSelected] forState:UIControlStateSelected];
    return _wenyaoBtn;
}


#pragma mark - Test Method

- (UIButton *)specialButtonFestival
{
    UIButton *_wenyaoBtn;
    UIImage* wenyaoBtnImage = [UIImage imageNamed:@"icon_common_healthy"];
    _wenyaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _wenyaoBtn.frame = CGRectMake(0, 0, wenyaoBtnImage.size.width, wenyaoBtnImage.size.height);
    [_wenyaoBtn setImage:wenyaoBtnImage forState:UIControlStateNormal];
    return _wenyaoBtn;
}

- (NSArray *)styleCommon
{
    QWTabbarItem *bar1=[QWTabbarItem new];
    bar1.title=@"首页";
    bar1.picNormal=@"icon_common_homepage_rest";
    bar1.picSelected=@"icon_common_homepage_selected";
    bar1.titleNormalColor = RGBHex(qwColor6);
    bar1.titleSelectedColor = RGBHex(qwColor1);
    bar1.tag=[NSString stringWithFormat:@"%i",Enum_TabBar_Items_HomePage];
    
    QWTabbarItem *bar2=[QWTabbarItem new];
    bar2.title=@"分类";
    bar2.picNormal=@"icon_common_classify_rest";
    bar2.picSelected=@"icon_common_classify_selected";
    bar2.titleNormalColor = RGBHex(qwColor6);
    bar2.titleSelectedColor = RGBHex(qwColor1);
    bar2.tag=[NSString stringWithFormat:@"%i",Enum_TabBar_Items_ConsultPharmacy];
    
    QWTabbarItem *bar3=[QWTabbarItem new];
    bar3.title=@"购物车";
    bar3.picNormal=@"icon_common_shopping_rest";
    bar3.picSelected=@"icon_common_shopping_selected";
    bar3.titleNormalColor = RGBHex(qwColor6);
    bar3.titleSelectedColor = RGBHex(qwColor1);
    bar3.tag=[NSString stringWithFormat:@"%i",Enum_TabBar_Items_ShoppingCart];
    
    QWTabbarItem *bar4=[QWTabbarItem new];
    bar4.title=@"我的订单";
    bar4.picNormal=@"icon_common_personal_rest";
    bar4.picSelected=@"icon_common_personal_selected";
    bar4.titleNormalColor = RGBHex(qwColor6);
    bar4.titleSelectedColor = RGBHex(qwColor1);
    bar4.tag=[NSString stringWithFormat:@"%i",Enum_TabBar_Items_SellUseCenter];
    
    QWTabbarItem *specialBar=[QWTabbarItem new];
    specialBar.title=@"健康圈";
    specialBar.titleNormalColor = RGBHex(qwColor4);
    specialBar.picNormal=@"icon_common_healthyring_rest";
    specialBar.picSelected=@"icon_common_healthyring_selected";
    specialBar.tag=[NSString stringWithFormat:@"%i",Enum_TabBar_Items_SPECIALTABBARITEMTAG];
    
    BOOL isTabBarOne = APPDelegate.mainVC.currentTabbar == APPDelegate.mainVC.tabbarOne;
    if (!isTabBarOne) {
        bar1.tag = @(Enum_TabBar_Items_HealthInfo).stringValue;
        bar1.title = @"资讯";
        bar2.tag = @(Enum_TabBar_Items_ForumHome).stringValue;
        bar2.title = @"圈子";
        bar3.tag = @(Enum_TabBar_Items_FinderMain).stringValue;
        bar3.title = @"发现";
        bar4.tag = @(Enum_TabBar_Items_ContentUseCenter).stringValue;
        bar4.title = @"个人中心";
    }
    
    return @[bar1,bar2, specialBar,bar3,bar4];
}

- (NSArray *)styleFestival
{
    QWTabbarItem *bar1=[QWTabbarItem new];
    bar1.title=@"首页";
    bar1.picNormal=@"icon_common_homepage";
    bar1.picSelected=@"icon_common_homepage";
    bar1.titleNormalColor = RGBHex(qwColor6);
    bar1.titleSelectedColor = RGBHex(0xfd4444);
    bar1.tag=[NSString stringWithFormat:@"%i",Enum_TabBar_Items_HomePage];
    
    QWTabbarItem *bar2=[QWTabbarItem new];
    bar2.title=@"分类";
    bar2.picNormal=@"icon_common_classify";
    bar2.picSelected=@"icon_common_classify";
    bar2.titleNormalColor = RGBHex(qwColor6);
    bar2.titleSelectedColor = RGBHex(0xfd4444);
    bar2.tag=[NSString stringWithFormat:@"%i",Enum_TabBar_Items_ConsultPharmacy];
    
    QWTabbarItem *bar3=[QWTabbarItem new];
    bar3.title=@"购物车";
    bar3.picNormal=@"icon_common_shopping";
    bar3.picSelected=@"icon_common_shopping";
    bar3.titleNormalColor = RGBHex(qwColor6);
    bar3.titleSelectedColor = RGBHex(0xfd4444);
    bar3.tag=[NSString stringWithFormat:@"%i",Enum_TabBar_Items_ShoppingCart];
    
    QWTabbarItem *bar4=[QWTabbarItem new];
    bar4.title=@"我的订单";
    bar4.picNormal=@"icon_common_personal";
    bar4.picSelected=@"icon_common_personal";
    bar4.titleNormalColor = RGBHex(qwColor6);
    bar4.titleSelectedColor = RGBHex(0xfd4444);
    bar4.tag=[NSString stringWithFormat:@"%i",Enum_TabBar_Items_SellUseCenter];
    
    QWTabbarItem *specialBar=[QWTabbarItem new];
    specialBar.title=@"";
    specialBar.titleNormalColor = RGBHex(qwColor4);
    specialBar.picNormal=@"icon_common_healthy";
    specialBar.tag=[NSString stringWithFormat:@"%i",Enum_TabBar_Items_SPECIALTABBARITEMTAG];
    
    BOOL isTabBarOne = APPDelegate.mainVC.currentTabbar == APPDelegate.mainVC.tabbarOne;
    if (!isTabBarOne) {
        bar1.tag = @(Enum_TabBar_Items_HealthInfo).stringValue;
        bar1.title = @"资讯";
        bar2.tag = @(Enum_TabBar_Items_ForumHome).stringValue;
        bar2.title = @"圈子";
        bar3.tag = @(Enum_TabBar_Items_FinderMain).stringValue;
        bar3.title = @"发现";
        bar4.tag = @(Enum_TabBar_Items_ContentUseCenter).stringValue;
        bar4.title = @"个人中心";
    }

    return @[bar1,bar2, specialBar,bar3,bar4];
}

@end
