//
//  MyIndentViewController.m
//  APP
//
//  Created by qw_imac on 15/12/29.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "MyIndentViewController.h"

#import "IndentDetailViewController.h"

@interface MyIndentViewController ()<QCSlideSwitchViewDelegate>
{
    NSMutableArray *viewControllers;
    IndentDetailViewController *currentVC;
}

@end

@implementation MyIndentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.title = @"我的订单";
    viewControllers = [[NSMutableArray alloc]init];
    
    [self setViewControllers];
 
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_index != -1) {
        [self.slideSwitchView jumpToTabAtIndex:_index - 1];
        self.index = -1;
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - QCSlideViewController
-(void)setViewControllers {
    IndentDetailViewController *allIndentVC = [IndentDetailViewController new];
    allIndentVC.title = @"全部";
    allIndentVC.navi = self.navigationController;
    allIndentVC.status = 0;
    [viewControllers addObject:allIndentVC];
    
    IndentDetailViewController *undoneIndentVC= [IndentDetailViewController new];
    undoneIndentVC.title = @"未完成";
    undoneIndentVC.navi = self.navigationController;
    undoneIndentVC.status = 1;
    [viewControllers addObject:undoneIndentVC];
    
    IndentDetailViewController *doneIndentVC = [IndentDetailViewController new];
    doneIndentVC.title = @"待评价";
    doneIndentVC.navi = self.navigationController;
    doneIndentVC.status = 2;
    [viewControllers addObject:doneIndentVC];
    
    [self setupSlide];
}

-(void)setupSlide {
    self.slideSwitchView = [[QCSlideSwitchView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H-NAV_H)];
    self.slideSwitchView.tabItemNormalColor = [QCSlideSwitchView colorFromHexRGB:@"666666"];
    [self.slideSwitchView.topScrollView setBackgroundColor:RGBHex(qwColor4)];
    self.slideSwitchView.tabItemSelectedColor = RGBHex(qwColor1);
    [self.slideSwitchView.rigthSideButton.titleLabel setFont:fontSystem(kFontS4)];
    self.slideSwitchView.slideSwitchViewDelegate = self;
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"blue_line_and_shadow"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    if (_index != 1) {
        self.slideSwitchView.isSpecial = YES;
    }
    [self.slideSwitchView buildUI];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, APP_H-NAV_H, APP_W, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [self.slideSwitchView addSubview:line];
    self.slideSwitchView.rootScrollView.scrollEnabled = YES;
    [self.view addSubview:self.slideSwitchView];
}

-(NSUInteger)numberOfTab:(QCSlideSwitchView *)view {
    return viewControllers.count;
}

-(UIViewController *)slideSwitchView:(QCSlideSwitchView *)view viewOfTab:(NSUInteger)number {
    return viewControllers[number];
}

- (void)slideSwitchView:(QCSlideSwitchView *)view willselectTab:(NSUInteger)number {
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    switch (number) {
        case 0:
            tdParams[@"订单分类"] = @"全部";
            break;
        case 1:
            tdParams[@"订单分类"] = @"未完成";
            break;
        case 2:
            tdParams[@"订单分类"] = @"待评价";
            break;
    }
    [QWGLOBALMANAGER statisticsEventId:@"x_wddd" withLable:@"我的订单" withParams:tdParams];
    [viewControllers[number] viewWillAppear:NO];
}


-(void)popVCAction:(id)sender {
    [super popVCAction:sender];
    [QWGLOBALMANAGER statisticsEventId:@"x_wddd_fh" withLable:@"我的订单" withParams:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
