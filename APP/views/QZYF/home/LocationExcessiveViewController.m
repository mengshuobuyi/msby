//
//  LocationExcessiveViewController.m
//  APP
//
//  Created by garfield on 16/6/16.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "LocationExcessiveViewController.h"
#import "MallCart.h"
#import "SVProgressHUD.h"
#import "AppGuide.h"


@interface LocationExcessiveViewController ()

@property (weak, nonatomic) IBOutlet UIButton *recommendButton;

@end

@implementation LocationExcessiveViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"问药";
    _recommendButton.layer.masksToBounds = YES;
    _recommendButton.layer.cornerRadius = 18.0f;
    _recommendButton.layer.borderColor = RGBHex(qwColor4).CGColor;
    _recommendButton.layer.borderWidth = 1.0f;
    AppGuide* guide = [[AppGuide alloc] initWithFrame:CGRectMake(0, 0, APP_W, SCREEN_H - 64 - 49)];
    if(IS_IPHONE_4_OR_LESS) {
        guide.imgNames = @[@"user_bg_guide1_734",@"user_bg_guide2_734",@"user_bg_guide3_734"];
    }else if (IS_IPHONE_5) {
        guide.imgNames = @[@"user_bg_guide1_1136",@"user_bg_guide2_1136",@"user_bg_guide3_1136",];
    }else if (IS_IPHONE_6) {
        guide.imgNames = @[@"user_bg_guide1_1108",@"user_bg_guide2_1108",@"user_bg_guide3_1108"];
    }else if (IS_IPHONE_6P) {
        guide.imgNames = @[@"user_bg_guide1_1870",@"user_bg_guide2_1870",@"user_bg_guide3_1870"];
    }

    [self.view addSubview:guide];
    [self.view sendSubviewToBack:guide];
    
    if([QWUserDefault getBoolBy:kReportNotOpenKey])
    {
        [_recommendButton setTitle:@"您已建议开通" forState:UIControlStateNormal];
        [_recommendButton setTitleColor:RGBHex(qwColor9) forState:UIControlStateNormal];
        _recommendButton.layer.borderColor = RGBHex(qwColor9).CGColor;
    }else{
        [_recommendButton addTarget:self action:@selector(highlyRecommendedToOpen) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

//强烈建议开通
- (void)highlyRecommendedToOpen
{
    if(![QWGLOBALMANAGER checkLoginStatus:self])
        return;
    [QWGLOBALMANAGER statisticsEventId:@"x_gwc_kt" withLable:@"购物车-强烈建议开通" withParams:nil];
    [QWGLOBALMANAGER readLocationWhetherReLocation:NO block:^(MapInfoModel *mapInfoModel) {
        MmallAdviceModelR *modelR = [MmallAdviceModelR new];
        modelR.token = QWGLOBALMANAGER.configure.userToken;
        modelR.city = mapInfoModel.city;
        modelR.deviceType = 2;
        modelR.deviceCode =QWGLOBALMANAGER.deviceToken;
        [MallCart queryMmallAdvice:modelR success:^(BaseAPIModel *responseModel) {
            if([responseModel.apiStatus integerValue] == 0) {
                [QWUserDefault setBool:YES key:kReportNotOpenKey];
                [_recommendButton setTitle:@"您已建议开通" forState:UIControlStateNormal];
                [_recommendButton removeTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
                [_recommendButton setTitleColor:RGBHex(qwColor9) forState:UIControlStateNormal];
                _recommendButton.layer.borderColor = RGBHex(qwColor9).CGColor;
            }else{
                [SVProgressHUD showErrorWithStatus:responseModel.apiMessage duration:0.8f];
            }
        } failure:NULL];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
