//
//  MineCareExpertViewController.m
//  APP
//
//  Created by Martin.Liu on 16/1/20.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "MineCareExpertViewController.h"
#import "ExpertTableCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "Forum.h"
#import "ExpertPageViewController.h"
@interface MineCareExpertViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MineCareExpertViewController
{
    NSArray* myAttnExpertArray;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"我关注的专家";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"ExpertTableCell" bundle:nil] forCellReuseIdentifier:@"ExpertTableCell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)loadData
{
    GetMyAttnExpertListR* getMyAttnExpertListR = [GetMyAttnExpertListR new];
    getMyAttnExpertListR.token = QWGLOBALMANAGER.configure.userToken;
    [Forum getMyAttnExpertList:getMyAttnExpertListR success:^(NSArray *expertList) {
        myAttnExpertArray = expertList;
        if (myAttnExpertArray.count == 0) {
            [self showInfoView:@"暂无关注的专家" image:@"ic_img_fail"];
        }
        else
        {
            [self removeInfoView];
        }
        [self.tableView reloadData];
    } failure:^(HttpException *e) {
        ;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return myAttnExpertArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExpertTableCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ExpertTableCell" forIndexPath:indexPath];
    [self configure:cell indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:@"ExpertTableCell" cacheByIndexPath:indexPath configuration:^(id cell) {
        [self configure:cell indexPath:indexPath];
    }];
}

- (void)configure:(id)cell indexPath:(NSIndexPath*)indexPath
{
    if (indexPath.row < myAttnExpertArray.count) {
        QWExpertInfoModel* expert = myAttnExpertArray[indexPath.row];
        [cell setCell:expert];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < myAttnExpertArray.count) {
        QWExpertInfoModel* expert = myAttnExpertArray[indexPath.row];
        
        
        if ([expert.id isEqualToString:QWGLOBALMANAGER.configure.passPort]) {
            return;
        }
        
        [QWGLOBALMANAGER statisticsEventId:@"x_wgzdzj_dj" withLable:@"热议" withParams:[NSMutableDictionary dictionaryWithDictionary:@{@"专家名":StrDFString(expert.nickName, @"专家名"),@"药房名":StrDFString(expert.groupName, @"药房名"),@"擅长领域":StrDFString(expert.expertise, @"擅长领域")}]];
        
        ExpertPageViewController *vc = [[UIStoryboard storyboardWithName:@"ExpertPage" bundle:nil] instantiateViewControllerWithIdentifier:@"ExpertPageViewController"];
        vc.hidesBottomBarWhenPushed = YES;
        vc.posterId = expert.id;
        vc.expertType = (int)expert.userType;
        vc.preVCNameStr = @"我专注的专家";
        vc.nickName = expert.nickName;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
