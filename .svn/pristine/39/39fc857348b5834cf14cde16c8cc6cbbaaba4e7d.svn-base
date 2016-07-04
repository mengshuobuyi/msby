//
//  DietTipsListViewController.m
//  APP
//
//  Created by garfield on 16/5/9.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "DietTipsListViewController.h"
#import "DietTipsTableCell.h"
#import "Product.h"

static NSString *const DietTipsCellIdentifier = @"DietTipsCellIdentifier";


@interface DietTipsListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) IBOutlet      UITableView     *tableView;
@property (nonatomic, strong) DietTipsTableCell             *calculateCell;
@property (nonatomic, strong) NSArray                       *dataSource;

@end

@implementation DietTipsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeUI];
    [self queryDietList];
}

//初始化UI控件
- (void)initializeUI
{
    self.title = @"饮食小贴士";
    [self.tableView setBackgroundColor:RGBHex(qwColor11)];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"DietTipsTableCell" bundle:nil] forCellReuseIdentifier:DietTipsCellIdentifier];
    self.calculateCell = (DietTipsTableCell *)[[NSBundle mainBundle] loadNibNamed:@"DietTipsTableCell" owner:self options:nil][0];
}

- (void)queryDietList
{
    ProductOrderModelR *modelR = [ProductOrderModelR new];
    modelR.orderId = self.orderId;
    [Product queryProFoodTaboos:modelR success:^(ProFoodTabooListVoModel *responseModel) {
        if([responseModel.apiStatus integerValue] == 0) {
            _dataSource = responseModel.tips;
            [self.tableView reloadData];
        }
    } failure:NULL];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    ProductTabooVoModel *model = _dataSource[index];
    self.calculateCell.tipTitleLabel.text = model.proName;
    self.calculateCell.contentOneLabel.text = model.taboo;
    
    CGSize size = [self.calculateCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)atableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DietTipsTableCell *cell = [atableView dequeueReusableCellWithIdentifier:DietTipsCellIdentifier];
    NSInteger index = indexPath.row;
    ProductTabooVoModel *model = _dataSource[index];
    [cell setCell:model];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
