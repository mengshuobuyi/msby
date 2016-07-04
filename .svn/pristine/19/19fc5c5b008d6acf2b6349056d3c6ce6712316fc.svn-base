//
//  ChannelActivityDetialViewController.m
//  APP
//
//  Created by qw_imac on 15/11/12.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "ChannelActivityDetialViewController.h"
#import "ChannelActivityTableViewCell.h"
@interface ChannelActivityDetialViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *activities;
}
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIImageView *drugImg;
@property (weak, nonatomic) IBOutlet UILabel *drugTitle;
@property (weak, nonatomic) IBOutlet UILabel *spec;
@property (weak, nonatomic) IBOutlet UILabel *drugSource;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation ChannelActivityDetialViewController

static NSString *cellIdentifier = @"Cell";
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ChannelActivityTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    self.title = @"活动列表";
    [self setupUI];
    // Do any additional setup after loading the view from its nib.
}

-(void)setupUI {
    self.tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0 , APP_W, [[UIScreen mainScreen] bounds].size.height - 64 -40 ) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.scrollEnabled = YES;
    self.tableView.tableHeaderView = self.headView;
    
}
#pragma mark - UITableViewDataSource UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return activities.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    if (self.tableView == tableView) {
        ChannelActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == self.tableView){
        return 44.0f;
    }else {
        return 0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 50)];
    view.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 6, APP_W, 44)];
    label.text = [NSString stringWithFormat:@"%lu个活动",(unsigned long)activities.count];
    [view addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(tableView == self.tableView){
        return 50;
    }else{
        return 0;
    }
}
#pragma mark - 跳转H5详情页面


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
