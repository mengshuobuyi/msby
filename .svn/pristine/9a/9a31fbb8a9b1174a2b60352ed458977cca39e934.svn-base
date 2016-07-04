//
//  PromotionShower.m
//  APP
//
//  Created by 李坚 on 16/6/15.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "PromotionShower.h"

#import "RobPromotionTableViewCell.h"
#import "promotionViewTableViewCell.h"
#import "QWGlobalManager.h"
#import "ConsultStoreModel.h"

static NSString *const promotionCellIdentifier = @"promotionViewTableViewCell";
static NSString *const RobCellIdentifier = @"RobPromotionTableViewCell";

@implementation PromotionShower

+ (PromotionShower *)showTitle:(NSString *)title message:(NSString *)message list:(NSArray *)dataArr
                   andCallBack:(disMissCallback)callBack{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"PromotionShower" owner:self options:nil];
    PromotionShower *bpView = [nibView objectAtIndex:0];
    bpView.frame = CGRectMake(0, 0, APP_W, 345.0f);
    bpView.mainLabel.backgroundColor = RGBHex(qwColor4);
    [bpView.messageView removeFromSuperview];
    [bpView layoutIfNeeded];
    
    if(!StrIsEmpty(title)){
        bpView.mainLabel.text = title;
    }
    
    bpView.dismissCallback = callBack;
    bpView.dataArray = dataArr;
    [bpView.mainTableView reloadData];
    
    return bpView;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.dataArray = [[NSMutableArray alloc]init];
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainTableView registerNib:[UINib nibWithNibName:promotionCellIdentifier bundle:nil] forCellReuseIdentifier:promotionCellIdentifier];
    [self.mainTableView registerNib:[UINib nibWithNibName:RobCellIdentifier bundle:nil] forCellReuseIdentifier:RobCellIdentifier];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BranchProductPromotionVo *VO = _dataArray[indexPath.row];
    if([VO.type intValue] == 5){
        self.mainLabel.text = @"抢购规则";
        return 100.0f;      // changed by perry, UIBUG 1、	文字颜色：6号色；每行之间的间距为20px；
    }else{
        self.mainLabel.text = @"商品优惠";
        return 50.0f;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    {
        BranchProductPromotionVo *VO = _dataArray[indexPath.row];
        
        if([VO.type intValue] == 5){
            RobPromotionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RobCellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone; // changed by perry, UIBUG 4、去掉点击态
            
            cell.mainLabel.text = [NSString stringWithFormat:@"活动期间，每人只可享有%d件抢购价",[VO.limitQty intValue]];
            cell.titleLabel.text = VO.rushTitle;
            cell.dateLabel.text = VO.validityDate;
            
            cell.titleLabel.textColor = RGBHex(qwColor6);  // changed by perry, UIBUG 1、	文字颜色：6号色；每行之间的间距为20px；
            cell.dateLabel.textColor = RGBHex(qwColor6);   // changed by perry, UIBUG 1、	文字颜色：6号色；每行之间的间距为20px；
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 99.5, APP_W, 0.5)];
            line.backgroundColor = RGBHex(qwColor10);      // changed by perry, UIBUG 2、	分隔线：1px 10号色；
            [cell addSubview:line];
            
            return cell;
        }else{
            promotionViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:promotionCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = VO.title;
            cell.dateLabel.text = VO.validityDate;
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 49.5, APP_W, 0.5)];
            line.backgroundColor = RGBHex(qwColor10);
            [cell addSubview:line];
            
            return cell;
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (IBAction)closeAction:(id)sender {
    
    self.dismissCallback(1);
}
@end
