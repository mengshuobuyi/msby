//
//  DiseaseViewController.m
//  APP
//
//  Created by qwfy0006 on 15/3/10.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "DiseaseViewController.h"
#import "DiseaseWikiViewController.h"
#import "QCSlideSwitchView.h"
#import "DiseaseSubViewController.h"
#import "FinderSearchViewController.h"
#import "CommonDiseaseViewController.h"
#import "MessageBoxListViewController.h"
#import "LoginViewController.h"

@interface DiseaseViewController ()<QCSlideSwitchViewDelegate>

{
    __weak QWBaseVC  *currentViewController;
}
@property (nonatomic ,strong) NSMutableArray * viewControllerArray;
@property (nonatomic ,strong) QCSlideSwitchView * slideSwitchView;

@property (nonatomic, strong) UIButton *searchButton;
@end

@implementation DiseaseViewController

- (id)init{
    if (self = [super init]) {
        self.title = @"疾病";
        self.viewControllerArray = [NSMutableArray array];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViewController];
    [self setupSliderView];
    
#pragma 按钮的调整
    
    
}
-(void)popVCAction:(id)sender {
    [super popVCAction:sender];
    [QWGLOBALMANAGER statisticsEventId:@"x_jb_1_fh" withLable:@"疾病" withParams:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setRightItems];
    ((QWBaseNavigationController *)self.navigationController).canDragBack = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    ((QWBaseNavigationController *)self.navigationController).canDragBack = YES;
}

-(void)setRightItems{
    UIView *jbBarItems = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 55)];
    self.searchButton = [[UIButton alloc] initWithFrame:CGRectMake(28, 0, 55, 55)];
    [self.searchButton setImage:[UIImage imageNamed:@"icon_navigation_search_common"]  forState:UIControlStateNormal];
    [self.searchButton addTarget:self action:@selector(rightBarbuttonClick) forControlEvents:UIControlEventTouchDown];
    [jbBarItems addSubview:self.searchButton];
    
//    UIButton *indexButton = [[UIButton alloc] initWithFrame:CGRectMake(65, 0, 55, 55)];
//    [indexButton setImage:[UIImage imageNamed:@"icon-unfold.PNG"] forState:UIControlStateNormal];
//    [indexButton addTarget:self action:@selector(showIndex) forControlEvents:UIControlEventTouchDown];
//    [jbBarItems addSubview:indexButton];
    
    
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    fixed.width = -20;
//    self.navigationItem.rightBarButtonItems = @[fixed,[[UIBarButtonItem alloc] initWithCustomView:jbBarItems]];
    fixed.width = -48;
    self.navigationItem.rightBarButtonItems = @[fixed,[[UIBarButtonItem alloc] initWithCustomView:jbBarItems]];

}

- (void)rightBarbuttonClick{
    FinderSearchViewController * searchViewController = [[FinderSearchViewController alloc] initWithNibName:@"FinderSearchViewController" bundle:nil];
    searchViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchViewController animated:YES];}

- (void)setupViewController{
    
    CommonDiseaseViewController *common = [[CommonDiseaseViewController alloc] init];
    common.navigationController = self.navigationController;
    [self.viewControllerArray addObject:common];
    
    DiseaseSubViewController * diseaseSubViewController = [[DiseaseSubViewController alloc]init];
    diseaseSubViewController.navigationController = self.navigationController;
    DiseaseWikiViewController * diseaseWikiViewController = [[DiseaseWikiViewController alloc]init];
    diseaseWikiViewController.navigationController = self.navigationController;
    currentViewController = diseaseSubViewController;
//    [self.viewControllerArray addObject:diseaseSubViewController];
    [self.viewControllerArray addObject:diseaseWikiViewController];
    
}

- (void)setupSliderView{
    
    self.slideSwitchView = [[QCSlideSwitchView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H-NAV_H)];
    self.slideSwitchView.tabItemNormalColor = [QCSlideSwitchView colorFromHexRGB:@"666666"];
    [self.slideSwitchView.topScrollView setBackgroundColor:RGBHex(qwColor4)];
    self.slideSwitchView.tabItemSelectedColor = RGBHex(qwColor1);
    [self.slideSwitchView.rigthSideButton.titleLabel setFont:fontSystem(kFontS4)];
    self.slideSwitchView.slideSwitchViewDelegate = self;
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"blue_line_and_shadow"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    [self.slideSwitchView buildUI];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 35, APP_W, 0.5)];
    line.backgroundColor = RGBHex(qwColor10);
    [self.slideSwitchView addSubview:line];
    
    [self.view addSubview:self.slideSwitchView];
}

/*!
 * @method 顶部tab个数
 * @abstract
 * @discussion
 * @param 本控件
 * @result tab个数
 */
- (NSUInteger)numberOfTab:(QCSlideSwitchView *)view{
    return self.viewControllerArray.count;
}

/*!
 * @method 每个tab所属的viewController
 * @abstract
 * @discussion
 * @param tab索引
 * @result viewController
 */
- (UIViewController *)slideSwitchView:(QCSlideSwitchView *)view viewOfTab:(NSUInteger)number{
    return self.viewControllerArray[number];
}

- (void)slideSwitchView:(QCSlideSwitchView *)view willselectTab:(NSUInteger)number
{
    self.searchButton.enabled = NO;
}

- (void)slideSwitchView:(QCSlideSwitchView *)view didselectTab:(NSUInteger)number{
    self.searchButton.enabled = YES;
    [self.viewControllerArray[number] viewDidCurrentView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
