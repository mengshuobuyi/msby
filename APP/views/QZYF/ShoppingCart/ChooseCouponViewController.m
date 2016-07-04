//
//  ChooseCouponViewController.m
//  APP
//
//  Created by garfield on 16/5/4.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "ChooseCouponViewController.h"
#import "VFourCouponQuanTableViewCell.h"
#import "MallCart.h"

@interface ChooseCouponViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ChooseCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"选择优惠券(%ld)",[_couponList count]];
    [self initializeUI];
}

- (void)initializeUI
{
    [self.tableView registerNib:[UINib nibWithNibName:@"VFourCouponQuanTableViewCell" bundle:nil] forCellReuseIdentifier:@"VFourCouponQuanTableViewCell"];
    [self.tableView setBackgroundColor:RGBHex(qwColor11)];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 60)];

    UIButton *noChooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    noChooseButton.frame = CGRectMake(15, 16, APP_W - 30, 40);
    noChooseButton.layer.masksToBounds = YES;
    noChooseButton.layer.cornerRadius = 4;
    [noChooseButton setBackgroundColor:RGBHex(qwColor2)];
    [noChooseButton setTitle:@"不使用优惠" forState:UIControlStateNormal];
    [noChooseButton addTarget:self action:@selector(chooseNoCouponTicket:) forControlEvents:UIControlEventTouchDown];
    [headerView addSubview:noChooseButton];
    self.tableView.tableHeaderView = headerView;
    
}

- (void)chooseNoCouponTicket:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    if(self.callBack) {
        self.callBack(-1);
    }
}

#pragma mark -
#pragma mark UITableViewDelegate
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CartOnlineCouponVoModel *model = _couponList[section];
    if(!model.onlySupportOnlineTrading) {
        return nil;
    }
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_W, 37.0)];
    [footer setBackgroundColor:[UIColor clearColor]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 8, APP_W - 24, 27)];
    label.font = fontSystem(kFontS5);
    label.textColor = RGBHex(qwColor6);
    label.text = @"  备注: 仅限在线支付使用";
    label.backgroundColor = RGBHex(qwColor4);
    label.layer.borderWidth = 0.5f;
    label.layer.borderColor = RGBHex(qwColor10).CGColor;
    [footer addSubview:label];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CartOnlineCouponVoModel *model = _couponList[section];
    if(!model.onlySupportOnlineTrading) {
        return 0.0001;
    }else{
        return 37.0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _couponList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [VFourCouponQuanTableViewCell getCellHeight:nil];
}

- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VFourCouponQuanTableViewCell *cell = [atableView dequeueReusableCellWithIdentifier:@"VFourCouponQuanTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CartOnlineCouponVoModel *model = _couponList[indexPath.section];
    [cell setCouponChooseQuan:model suppertOnline:self.supportOnlineTrading];
    if([self.chooseModel.couponId isEqualToString:model.couponId]) {
        cell.coverView.hidden = NO;
        cell.coverView.layer.borderWidth = 3.0f;
        cell.coverView.layer.borderColor = RGBHex(qwColor2).CGColor;
    }else{
        cell.coverView.hidden = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [atableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    if(self.callBack) {
        self.callBack(indexPath.section);
    }
}


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
