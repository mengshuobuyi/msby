//
//  MyEvaluationViewController.m
//  APP
//
//  Created by 李坚 on 15/8/26.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "MyEvaluationViewController.h"
#import "RatingView.h"
#import "Promotion.h"
#import "SVProgressHUD.h"

@interface MyEvaluationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *evaluationText;
@property (weak, nonatomic) IBOutlet RatingView *starView;
@property (weak, nonatomic) IBOutlet UILabel *timelabel;

@end

@implementation MyEvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的评价";
    self.starView.userInteractionEnabled = NO;
    [self.starView setImagesDeselected:@"star_none" partlySelected:@"star_half" fullSelected:@"star_full" andDelegate:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    if(QWGLOBALMANAGER.currentNetWork == kNotReachable){
        [self showInfoView:kWarning12 image:@"网络信号icon"];
        return;
    }
    
    [self loadEvaluation];
}

- (void)loadEvaluation{
    
    commnetModelR *modelR = [commnetModelR new];
    modelR.orderId = self.orderId;
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    
    [Promotion checkMyComment:modelR success:^(id obj) {
        
        CommentVo *vo = obj;
        
        if([vo.apiStatus intValue] == 1){
            [SVProgressHUD showErrorWithStatus:vo.apiMessage];
            return ;
        }else{
            [self.starView displayRating:[vo.star floatValue]/2];
            self.evaluationText.text = vo.content;
            self.timelabel.text = vo.time;
        }
    } failure:^(HttpException *e) {
        
    }];
    
}

@end
