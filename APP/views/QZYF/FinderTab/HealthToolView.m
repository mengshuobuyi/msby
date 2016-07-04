//
//  HealthToolView.m
//  APP
//
//  Created by qw_imac on 15/12/31.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "HealthToolView.h"
#import "WYLocalNotifVC.h"
#import "FamliyMedcineViewController.h"
#import "HealthyScenarioViewController.h"
#import "FactoryListViewController.h"
#import "WebDirectViewController.h"
#import "QuickMedicineViewController.h"
#import "SymptomMainViewController.h"
#import "DiseaseViewController.h"
#import "HealthIndicatorViewController.h"
#import "LoginViewController.h"
@implementation HealthToolView

+(HealthToolView *)healthToolView {
    HealthToolView *nibView =  [[NSBundle mainBundle] loadNibNamed:@"HealthToolView" owner:nil options:nil][0];
//    float scale = APP_W / 320;
//    nibView.right.constant = scale * 30;
//    nibView.left.constant = scale *30;
//    nibView.rightLead.constant = scale *35;
//    nibView.leftLead.constant = scale *35;
    return nibView;
}




- (IBAction)btnClick:(UIButton *)sender {
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    
    
    switch (sender.tag) {
        case 1://用药提醒
        { UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LocalNotif" bundle:nil];
            WYLocalNotifVC* vc = [sb instantiateViewControllerWithIdentifier:@"WYLocalNotifVC"];
            vc.hidesBottomBarWhenPushed=YES;
            [self.vc.navigationController pushViewController:vc animated:YES];
            [self removeAction];
            tdParams[@"工具名"]=@"用药提醒";
            break;
        }
        case 2://家庭药箱
        {
            if(!QWGLOBALMANAGER.loginStatus) {
                self.hidden = YES;
                self.vc.blurView.hidden = YES;
                LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
                loginViewController.isPresentType = YES;
                [self.vc presentViewController:navgationController animated:YES completion:NULL];
                __weak typeof(self) weakSelf = self;
                loginViewController.loginSuccessBlock = ^(){
                    [weakSelf enterFamily];
                };
            }else {
                [self enterFamily];
            }
            break;
        }
        case 3://血压
        {
//            WebDirectViewController *vc = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
//            WebDirectLocalModel *model = [WebDirectLocalModel new];
//            model.typeLocalWeb = WebLocalTypeBp;
//            [vc setWVWithLocalModel:model];
//            [self.vc.navigationController pushViewController:vc animated:YES];
//            [self removeAction];
            break;
        }
        case 4://体重指数
        {
//            WebDirectViewController *vc = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
//            WebDirectLocalModel *model = [WebDirectLocalModel new];
//            model.typeLocalWeb = WebLocalTypeWeight;
//            [vc setWVWithLocalModel:model];
//            [self.vc.navigationController pushViewController:vc animated:YES];
//            [self removeAction];
            break;
        }
        case 5://体温
        {
//            WebDirectViewController *vc = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
//            WebDirectLocalModel *model = [WebDirectLocalModel new];
//            model.typeLocalWeb = WebLocalTypeTemperature;
//            [vc setWVWithLocalModel:model];
//            [self.vc.navigationController pushViewController:vc animated:YES];
//            [self removeAction];
            break;
        }
        case 6://预产期
        {
            WebDirectViewController *vc = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
            WebDirectLocalModel *model = [WebDirectLocalModel new];
            model.typeLocalWeb = WebLocalTypeEdc;
            [vc setWVWithLocalModel:model];
            [self.vc.navigationController pushViewController:vc animated:YES];
            [self removeAction];
            tdParams[@"工具名"]=@"预产期";
            break;
        }
        case 7://健康评测
        {
            WebDirectViewController *vc = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
            WebDirectLocalModel *model = [WebDirectLocalModel new];
            model.typeLocalWeb = WebPageToWebTypeHealthCheckBegin;
            model.title=@"健康评测";
            [vc setWVWithLocalModel:model];
            [self.vc.navigationController pushViewController:vc animated:YES];
            [self removeAction];
            tdParams[@"工具名"]=@"健康评测";
            break;
        }
        case 8://药品
        {
            QuickMedicineViewController *vc = [QuickMedicineViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.vc.navigationController pushViewController:vc animated:YES];
            
            [self removeAction];
            tdParams[@"工具名"]=@"药品";
            break;
        }
        case 9://疾病
        {
            DiseaseViewController *vc = [DiseaseViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.vc.navigationController pushViewController:vc animated:YES];
            [self removeAction];
            tdParams[@"工具名"]=@"疾病";
            break;
        }
        case 10://症状
        {
            SymptomMainViewController *vc = [SymptomMainViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.vc.navigationController pushViewController:vc animated:YES];
            [self removeAction];
            tdParams[@"工具名"]=@"症状";
            break;
        }
        case 11://检测指标
        {
            HealthIndicatorViewController *vc = [HealthIndicatorViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.vc.navigationController pushViewController:vc animated:YES];
            [self removeAction];
            tdParams[@"工具名"]=@"检测指标";
            break;
        }
        case 12://体检
        {
            //[self removeAction];
            break;
        }
        case 13://健康方案
        {
            HealthyScenarioViewController * healthyScenario = [[HealthyScenarioViewController alloc] init];
            healthyScenario.hidesBottomBarWhenPushed = YES;
            [self.vc.navigationController pushViewController:healthyScenario animated:YES];
            
            [self removeAction];
            tdParams[@"工具名"]=@"健康方案";
            break;
        }
        case 14://品牌
        {
            FactoryListViewController *vc = [[FactoryListViewController alloc] init];
             vc.hidesBottomBarWhenPushed=YES;
            [self.vc.navigationController pushViewController:vc animated:YES];
           
            [self removeAction];
            tdParams[@"工具名"]=@"品牌";
            break;
        }
        default:
        {
            [self removeAction];
        }
            break;
    }
   [QWGLOBALMANAGER statisticsEventId:@"x_fx_jkgj" withLable:@"发现" withParams:tdParams];
}

-(void)removeAction {
//    float h = [[UIScreen mainScreen] bounds].size.height;
//    [UIView animateWithDuration:0.5 animations:^{
//        self.frame = CGRectMake(0, h, APP_W, h);
//    }completion:^(BOOL finished) {
//        [self removeFromSuperview];
//    }];
//
    [self.vc removeBlurView];
    self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    [UIView animateWithDuration:0.25f animations:^{
        self.transform = CGAffineTransformMakeScale(0.00, 0.01);
    }completion:^(BOOL finish){
        
        [self removeFromSuperview];
        
    }];

}

-(void)enterFamily {
    FamliyMedcineViewController *famliyMedcineViewController = [[UIStoryboard storyboardWithName:@"FamilyMedicineListViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"FamliyMedcineViewController"];
    famliyMedcineViewController.hidesBottomBarWhenPushed = YES;
    [self.vc.navigationController pushViewController:famliyMedcineViewController animated:YES];
    [self removeAction];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
