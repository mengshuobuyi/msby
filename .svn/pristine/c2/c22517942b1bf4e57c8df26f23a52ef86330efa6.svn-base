//
//  PackageView.m
//  APP
//  药品详情套餐自定义弹出框
//  Created by 李坚 on 16/3/14.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "PackageView.h"
#import "StoreGoodTableViewCell.h"

#define TableViewCellHeight 79.0f

static NSString *const storeGoodCellIdentifier = @"StoreGoodTableViewCell";

@implementation PackageView
+ (PackageView *)showView:(UIWindow *)BView WithContent:(NSString *)content andDataList:(NSArray *)array callBack:(AddCallback)callBack{
    CartComboVoModel *model=(CartComboVoModel*)array;
    NSArray *drugList=model.druglist;
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"PackageView" owner:self options:nil];
    PackageView *PKView = [nibView objectAtIndex:0];
    PKView.frame = CGRectMake(0, 0, APP_W, APP_H+20);
    CGFloat PKHeight = 157 + (TableViewCellHeight * (drugList.count > 3?3:drugList.count));
    CGRect rect = PKView.mainView.frame;
    rect.size.width = APP_W;
    rect.size.height = PKHeight;
    PKView.mainViewHeightConstant.constant = PKHeight;
    rect.origin.y = APP_H + 20 + PKHeight;
    PKView.mainView.frame = rect;
    PKView.backView.alpha = 0.0f;

    PKView.callback = callBack;
    PKView.headLabel.text = content;
    PKView.dataArr = drugList;
    PKView.mainPriceLabel.text=[NSString stringWithFormat:@"¥%.2f",model.price];
    PKView.lessPriceLabel.text=[NSString stringWithFormat:@"立减¥%.2f",model.reduce];
    [PKView.PKTableView reloadData];
    
    if(!PKView.superview) {
        [BView addSubview:PKView];
    }   
    [BView bringSubviewToFront:PKView];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        PKView.backView.alpha = 0.4f;
        CGFloat PKHeight = 157 + (TableViewCellHeight * (drugList.count > 3?3:drugList.count));
        CGRect rect = PKView.mainView.frame;
        rect.size.width = APP_W;
        rect.size.height = PKHeight;
        PKView.mainViewHeightConstant.constant = PKHeight;
        rect.origin.y = APP_H-PKHeight;
        PKView.mainView.frame = rect;
        
    } completion:^(BOOL finished) {
        
    }];
    
    return PKView;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.countLabel.text = @"1";
    self.countLabel.layer.borderColor = RGBHex(qwColor10).CGColor;
    self.countLabel.layer.borderWidth = 0.5f;
    self.countLabel.layer.masksToBounds = YES;
    self.dataArr = [[NSArray alloc]init];
    self.headView.layer.masksToBounds = YES;
    self.headView.layer.borderColor = RGBHex(qwColor10).CGColor;
    self.headView.layer.borderWidth = 0.5f;
    self.headView.layer.cornerRadius = 2.0f;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideView)];
    [self.backView addGestureRecognizer:tap];
    
    [self.PKTableView registerNib:[UINib nibWithNibName:storeGoodCellIdentifier bundle:nil] forCellReuseIdentifier:storeGoodCellIdentifier];
    self.PKTableView.dataSource = self;
    self.PKTableView.delegate = self;
    self.PKTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)hideView{
    
    CGFloat PKHeight = 157 + (TableViewCellHeight * self.dataArr.count > 3?3:self.dataArr.count);
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.backView.alpha = 0.0f;
        CGRect rect = self.mainView.frame;
        rect.origin.y = APP_H + 20 + PKHeight;
        self.mainView.frame = rect;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (IBAction)AddAction:(id)sender {
    
    self.countLabel.text = [NSString stringWithFormat:@"%d",[self.countLabel.text intValue] + 1];
}

- (IBAction)ReduceAction:(id)sender {
    
    if([self.countLabel.text intValue] == 1){
        return;
    }else{
        self.countLabel.text = [NSString stringWithFormat:@"%d",[self.countLabel.text intValue] - 1];
    }
}

- (IBAction)closeAction:(id)sender {
    
    [self hideView];
}

- (IBAction)GoodCarAction:(id)sender {
    
    if(self.callback){

        self.callback([self.countLabel.text integerValue]);
    }
    [self hideView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return TableViewCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StoreGoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:storeGoodCellIdentifier];
    cell.line.hidden = YES;
    cell.scoreLabel.hidden = YES;
    cell.ticketImage.hidden = YES;
    cell.proName.numberOfLines = 1;
    [cell setPackageCell:self.dataArr[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

@end
