//
//  MyCouponDrugViewController.m
//  APP
//
//  Created by 李坚 on 15/8/23.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "MyCouponDrugViewController.h"
#import "QCSlideSwitchView.h"
#import "MyCouponDrugListViewController.h"
#import "WebDirectViewController.h"

@interface MyCouponDrugViewController ()<QCSlideSwitchViewDelegate>{
    
    NSInteger geNumber;
    
    NSInteger selectedIndex;
}

@property (nonatomic ,strong) NSMutableArray * viewControllerArray;
@property (nonatomic ,strong) QCSlideSwitchView * slideSwitchView;

@end

@implementation MyCouponDrugViewController

- (instancetype)init{
    
    if(self = [super init]){

        selectedIndex = -1;
        self.popToRootView = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的优惠商品";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_btn_explain"] style:UIBarButtonItemStylePlain target:self action:@selector(pushToHelper:)];
    
    self.navigationItem.rightBarButtonItem = item;
    
    
    [self setupViewControllers];
    [self setupSliderView];
}

- (IBAction)popVCAction:(id)sender{
    
    if(self.popToRootView){
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 帮助
- (void)pushToHelper:(id)sender{
    //进入帮助
    WebDirectViewController *vcWebMedicine = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
    WebDirectLocalModel *modelLocal = [[WebDirectLocalModel alloc] init];
    modelLocal.typeLocalWeb = WebLocalTypeCouponHelp;
    [vcWebMedicine setWVWithLocalModel:modelLocal];
    [self.navigationController pushViewController:vcWebMedicine animated:YES];
}

- (void)setupViewControllers{
    
    self.viewControllerArray = [NSMutableArray new];
    
    MyCouponDrugListViewController *couponListPicked = [[MyCouponDrugListViewController alloc]init];
    couponListPicked.title = @"已领取";
    couponListPicked.navigationController = self.navigationController;
    couponListPicked.type = Enum_CouponQuan_HasPicked;
    [self.viewControllerArray addObject:couponListPicked];
    
    MyCouponDrugListViewController *couponListUsed = [[MyCouponDrugListViewController alloc]init];
    couponListUsed.title = @"已使用";
    couponListUsed.navigationController = self.navigationController;
    couponListUsed.type = Enum_CouponQuan_HasPicked;
    [self.viewControllerArray addObject:couponListUsed];
    
    MyCouponDrugListViewController *couponListDated = [[MyCouponDrugListViewController alloc]init];
    couponListDated.title = @"已过期";
    couponListDated.navigationController = self.navigationController;
    couponListDated.type = Enum_CouponQuan_HasPicked;
    [self.viewControllerArray addObject:couponListDated];
    
    self.slideSwitchView.viewArray = self.viewControllerArray;
}

- (void)setupSliderView{
    
    self.slideSwitchView = [[QCSlideSwitchView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H-NAV_H)];
    self.slideSwitchView.tabItemNormalColor = RGBHex(qwColor7);
    [self.slideSwitchView.topScrollView setBackgroundColor:RGBHex(qwColor4)];
    self.slideSwitchView.tabItemSelectedColor = RGBHex(qwColor1);
    [self.slideSwitchView.rigthSideButton.titleLabel setFont:fontSystem(kFontS4)];
    self.slideSwitchView.slideSwitchViewDelegate = self;
    self.slideSwitchView.rootScrollView.scrollEnabled = YES;
    
    
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"blue_line_and_shadow"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    
    [self.slideSwitchView buildUI];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 35, APP_W, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [self.slideSwitchView addSubview:line];
    [self.view addSubview:self.slideSwitchView];
    
 
}

- (void)jumpToPage:(NSInteger)index{
    
    geNumber = index;
    [self performSelector:@selector(jump) withObject:nil afterDelay:0.26];
    
}

- (void)jump{
    
    [self.slideSwitchView jumpToTabAtIndex:geNumber];
}

#pragma mark - QCSlideSwitchViewDelegate
- (NSUInteger)numberOfTab:(QCSlideSwitchView *)view{
    return self.viewControllerArray.count;
}

- (UIViewController *)slideSwitchView:(QCSlideSwitchView *)view viewOfTab:(NSUInteger)number{
    
    return self.viewControllerArray[number];
}

- (void)slideSwitchView:(QCSlideSwitchView *)view didselectTab:(NSUInteger)number{
    
    selectedIndex = number;
    [self changePage];
    
}

- (void)changePage{
    
    if(selectedIndex != -1){
        
        MyCouponDrugListViewController *couponList = self.viewControllerArray[selectedIndex];
        
        if(selectedIndex == 0){
            couponList.type = Enum_CouponQuan_HasPicked;
        }
        if(selectedIndex == 1){
            couponList.type = Enum_CouponQuan_HasUsed;
        }
        if(selectedIndex == 2){
            couponList.type = Enum_CouponQuan_HasOverdDate;
        }
        
        [couponList restData];
        
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if(_shouldJump) {
        [self jumpToPage:1];
        _shouldJump = NO;
        selectedIndex = 1;
        [self changePage];
    }else{
        if(selectedIndex != -1){
            [self changePage];
        }
    }
    
}

@end
