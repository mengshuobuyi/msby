//
//  MyRecommenderViewController.m
//  APP
//  我的推荐人展示页面
//  Created by 李坚 on 16/5/9.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "MyRecommenderViewController.h"
#import "AboutWenYaoViewController.h"
#import "Mbr.h"

@interface MyRecommenderViewController ()
@property (nonatomic ,strong) NSMutableArray *array;
@property (weak, nonatomic) IBOutlet UILabel *recommendLabel;
@property (weak, nonatomic) IBOutlet UIView *recommendView;


@end

@implementation MyRecommenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的推荐人";
    self.recommendView.hidden = YES;
    [self loadMyRecommenderList];
}

- (void)loadMyRecommenderList{
    
//    MbrInviterR *modelR = [MbrInviterR new];
//    modelR.token = QWGLOBALMANAGER.configure.userToken;
//    
//    [Mbr queryMyRecommendList:modelR success:^(MyRecommendListVo *obj) {
//        
//        if([obj.apiStatus intValue] == 0){
//            
//            _array = [NSMutableArray arrayWithArray:obj.myRecommends];
//            
//            if(_array.count > 0){
//                self.recommendView.hidden = NO;
//                MyRecommendVo *VO = _array[0];
//                _recommendLabel.text = [NSString stringWithFormat:@"%@（%@）",VO.nick,VO.mobile];
//            }else{
//               [self showInfoView:@"暂无我的推荐人" image:@"ic_img_fail"];
//            }
//        }else{
//            [self showInfoView:@"暂无我的推荐人" image:@"ic_img_fail"];
//        }
//        
//    } failure:^(HttpException *e) {
//        [self showInfoView:@"暂无我的推荐人" image:@"ic_img_fail"];
//    }];
}


- (void)popVCAction:(id)sender{
    
    for(UIViewController *VC in self.navigationController.viewControllers){
        
        if([VC isKindOfClass:[AboutWenYaoViewController class]]){
            [self.navigationController popToViewController:VC animated:YES];
            break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
