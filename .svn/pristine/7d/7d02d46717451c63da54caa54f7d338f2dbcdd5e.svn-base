//
//  HealthToolViewController.m
//  APP
//
//  Created by qw_imac on 16/4/18.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "HealthToolViewController.h"
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
@interface HealthToolViewController ()

@end

@implementation HealthToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"健康工具";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
}

-(void)popVCAction:(id)sender {
    [super popVCAction:sender];
    [QWGLOBALMANAGER statisticsEventId:@"x_jkgj_fh" withLable:@"健康工具" withParams:nil];
}

- (IBAction)healthToolClick:(UIButton *)sender {
    NSMutableDictionary *tdParams = [NSMutableDictionary dictionary];
    switch (sender.tag) {
        case 1://用药提醒
        {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LocalNotif" bundle:nil];
            WYLocalNotifVC* vc = [sb instantiateViewControllerWithIdentifier:@"WYLocalNotifVC"];
            [self.navigationController pushViewController:vc animated:YES];
            tdParams[@"工具名"]=@"用药提醒";
        }
            break;
        case 2://家庭药箱
        {
            if(!QWGLOBALMANAGER.loginStatus) {
                LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                UINavigationController *navgationController = [[QWBaseNavigationController alloc] initWithRootViewController:loginViewController];
                loginViewController.isPresentType = YES;
                [self presentViewController:navgationController animated:YES completion:NULL];
                __weak typeof(self) weakSelf = self;
                loginViewController.loginSuccessBlock = ^(){
                    [weakSelf enterFamily];
                };
            }else {
                [self enterFamily];
            }
        }
            break;
        case 3://健康评测
        {
            WebDirectViewController *vc = [[UIStoryboard storyboardWithName:@"WebDirect" bundle:nil] instantiateViewControllerWithIdentifier:@"WebDirectViewController"];
            WebDirectLocalModel *model = [WebDirectLocalModel new];
            model.typeLocalWeb = WebPageToWebTypeHealthCheckBegin;
            model.title=@"健康评测";
            [vc setWVWithLocalModel:model];
            [self.navigationController pushViewController:vc animated:YES];
            tdParams[@"工具名"]=@"健康评测";
        }
            break;
        case 4://检测指标
        {
            HealthIndicatorViewController *vc = [HealthIndicatorViewController new];
            [self.navigationController pushViewController:vc animated:YES];
            tdParams[@"工具名"]=@"检测指标";
        }
            break;
        case 5://药品
        {
            QuickMedicineViewController *vc = [QuickMedicineViewController new];
            [self.navigationController pushViewController:vc animated:YES];
            tdParams[@"工具名"]=@"药品";
        }
            break;
        case 6://疾病
        {
            DiseaseViewController *vc = [DiseaseViewController new];
            [self.navigationController pushViewController:vc animated:YES];
            tdParams[@"工具名"]=@"疾病";
        }
            break;
        case 7://症状
        {
            SymptomMainViewController *vc = [SymptomMainViewController new];
            [self.navigationController pushViewController:vc animated:YES];
            tdParams[@"工具名"]=@"症状";
        }
            break;
        case 8://健康方案
        {
            HealthyScenarioViewController * healthyScenario = [[HealthyScenarioViewController alloc] init];
            [self.navigationController pushViewController:healthyScenario animated:YES];
            tdParams[@"工具名"]=@"健康方案";
        }
            break;
        case 9://品牌
        {
            FactoryListViewController *vc = [[FactoryListViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            tdParams[@"工具名"]=@"品牌";
        }
            break;
    }
    [QWGLOBALMANAGER statisticsEventId:@"x_fx_jkgj" withLable:@"发现" withParams:tdParams];
}

-(void)enterFamily {
    FamliyMedcineViewController *famliyMedcineViewController = [[UIStoryboard storyboardWithName:@"FamilyMedicineListViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"FamliyMedcineViewController"];
    [self.navigationController pushViewController:famliyMedcineViewController animated:YES];
}

- (IBAction)backClick:(UIButton *)sender {
//    [self popVCAction:nil];
}
@end
