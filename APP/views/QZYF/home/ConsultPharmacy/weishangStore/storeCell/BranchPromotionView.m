//
//  BranchPromotionView.m
//  APP
//
//  Created by 李坚 on 16/1/12.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "BranchPromotionView.h"
#import "WeiStoreTableViewCell.h"
#import "promotionViewTableViewCell.h"
#import "QWGlobalManager.h"
#import "RobPromotionTableViewCell.h"
#import "TradeInProductTableViewCell.h"

static NSString *const storeCellIdentifier = @"WeiStoreTableViewCell";
static NSString *const promotionCellIdentifier = @"promotionViewTableViewCell";
static NSString *const RobCellIdentifier = @"RobPromotionTableViewCell";
static NSString *const ChangeCellIdentifier = @"TradeInProductTableViewCell";

@implementation BranchPromotionView

+ (BranchPromotionView *)showInView:(UIWindow *)blackView withTitle:(NSString *)title message:(NSString *)message list:(NSArray *)dataArr withSelectedIndex:(NSInteger)index  withType:(BranchPromotionViewType)type andCallBack:(disMissCallback)callBack{

    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"BranchPromotionView" owner:self options:nil];
    BranchPromotionView *bpView = [nibView objectAtIndex:0];
    bpView.frame = CGRectMake(0, 0, APP_W, APP_H + 20);
    bpView.viewType = type;
    
    if(type == Enum_Consult){
        bpView.mainLabel.backgroundColor = RGBHex(qwColor4);
        [bpView.messageView removeFromSuperview];
        bpView.mainLabel.text = @"附近可售药房";
    }else if(type == Enum_Coupon){
        bpView.mainLabel.backgroundColor = RGBHex(qwColor4);
        [bpView.messageView removeFromSuperview];
    }else if(type == Enum_Change){
        bpView.hideBtn.hidden = NO;
        bpView.mainLabel.backgroundColor = RGBHex(qwColor4);
        bpView.mainLabel.text = @"换购商品";
        bpView.changeGoodNumber = index;
        [bpView.closeBtn setTitle:@"确定" forState:UIControlStateNormal];
    }else if(type == Enum_CouponDetail){
        bpView.hideBtn.hidden = NO;
        bpView.mainLabel.backgroundColor = RGBHex(qwColor4);
        bpView.mainLabel.text = @"券适用药房";
        bpView.mainLabel.font =fontSystem(kFontS3);
        bpView.changeGoodNumber = index;
        [bpView.closeBtn setTitle:@"确定" forState:UIControlStateNormal];
    }
    [bpView layoutIfNeeded];
    
    if(!StrIsEmpty(title)){
        bpView.mainLabel.text = title;
    }
    if(!StrIsEmpty(message)){
        bpView.messageLabel.text = message;
    }
    
    bpView.dismissCallback = callBack;
    bpView.dataArray = dataArr;
    [bpView.bpTableView reloadData];
    
    bpView.backView.alpha = 0.0f;
    CGRect rect = bpView.mainView.frame;
    rect.origin.y = APP_H + 20;
//防止做UI优化
//    CGFloat PKHeight = 95 + (112 * (dataArr.count > 2?2:dataArr.count));
//    rect.size.height=PKHeight;
//    bpView.mainConstant.constant=PKHeight;
    bpView.mainView.frame = rect;
    
    if(!bpView.superview) {
        [blackView addSubview:bpView];
    }
    [blackView bringSubviewToFront:bpView];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        bpView.backView.alpha = 0.4f;
        CGRect rect = bpView.mainView.frame;
        rect.origin.y = APP_H - 290;
        bpView.mainView.frame = rect;
        
    } completion:^(BOOL finished) {
        
    }];
    
    return bpView;
}

- (id)initWithFrame:(CGRect)frame
{
    CGRect rect = [UIScreen mainScreen].bounds;
    self = [super initWithFrame:rect];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        
    }
    return self;
}


- (void)awakeFromNib{
    [super awakeFromNib];
    _changeGoodNumber = -1;
    self.hideBtn.hidden = YES;
    [self.hideBtn addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideView)];
    [self.backView addGestureRecognizer:tap];
    [self.closeBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    self.dataArray = [[NSMutableArray alloc]init];
    self.bpTableView.dataSource = self;
    self.bpTableView.delegate = self;
    self.bpTableView.tableFooterView = [[UIView alloc]init];
    self.bpTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.bpTableView registerNib:[UINib nibWithNibName:storeCellIdentifier bundle:nil] forCellReuseIdentifier:storeCellIdentifier];
    [self.bpTableView registerNib:[UINib nibWithNibName:promotionCellIdentifier bundle:nil] forCellReuseIdentifier:promotionCellIdentifier];
    [self.bpTableView registerNib:[UINib nibWithNibName:RobCellIdentifier bundle:nil] forCellReuseIdentifier:RobCellIdentifier];
    [self.bpTableView registerNib:[UINib nibWithNibName:ChangeCellIdentifier bundle:nil] forCellReuseIdentifier:ChangeCellIdentifier];
}

- (void)confirmAction{
    
    if(_viewType == Enum_Change){
        if(self.dismissCallback){
            self.dismissCallback(_changeGoodNumber);
        }
    }else if(_viewType == Enum_Consult){
        _changeGoodNumber = -1;
        if(self.dismissCallback){
            self.dismissCallback(_changeGoodNumber);
        }
    }
    [self hideView];
}

- (void)hideView{

    [UIView animateWithDuration:0.5 animations:^{
        
        self.backView.alpha = 0.0f;
        CGRect rect = self.mainView.frame;
        rect.origin.y = APP_H + 20;
        self.mainView.frame = rect;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(_viewType == Enum_Consult){
        return 88.0f;
    }else if(_viewType == Enum_Coupon){
        BranchProductPromotionVo *VO = _dataArray[indexPath.row];
        if([VO.type intValue] == 5){
            self.mainLabel.text = @"抢购规则";
            return 100.0f;      // changed by perry, UIBUG 1、	文字颜色：6号色；每行之间的间距为20px；
        }else{
            self.mainLabel.text = @"商品优惠";
            return 50.0f;
        }
    }else if(_viewType == Enum_Change){
        return [TradeInProductTableViewCell getCellHeight:nil];
    }
    return 0.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(_viewType == Enum_Consult){
        WeiStoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:storeCellIdentifier];
        MicroMallBranchVo *VO = _dataArray[indexPath.row];
        
        cell.priceLabel.hidden = NO;
        cell.priceLabel.text = [NSString stringWithFormat:@"￥%@",VO.price];
        cell.imgUrlWidthLayout.constant = 0.0f;
        cell.leftConstant.constant = 5.0f;
        cell.path = indexPath;
        [cell layoutIfNeeded];
        //不要米数的cell
        [cell setNoMiCell:VO withSpell:^(NSIndexPath *path) {
//            MicroMallBranchVo *model = _dataArray[path.row];
//            model.spelled = !model.spelled;
//            [_bpTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
        }];
        
        return cell;
    }else if(_viewType == Enum_Coupon){

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
    }else if(_viewType == Enum_Change){
        
        TradeInProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ChangeCellIdentifier];
        if(_changeGoodNumber == indexPath.row){
            cell.chooseIconImage.image = [UIImage imageNamed:@"img_no_selected"];
        }else{
            cell.chooseIconImage.image = [UIImage imageNamed:@"img_no_select"];
        }
        //@解正鸿
        //TODO:
        [cell setCell:_dataArray[indexPath.row]];
        
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.viewType == Enum_Change){
        CartRedemptionVoModel *model = _dataArray[indexPath.row];
        if(model.currentConsume < model.limitPrice) {
            return;
            
        }
        
        if(_changeGoodNumber == indexPath.row){
            _changeGoodNumber = -1;
        }else{
            _changeGoodNumber = indexPath.row;
        }
        [self.bpTableView reloadData];
        return;
    }
    if(self.viewType == Enum_Coupon){
        return;
    }
    if(self.dismissCallback){
        self.dismissCallback(indexPath.row);
    }
    [self hideView];
}

@end
