//
//  ChooseCouponView.m
//  APP
//
//  Created by 李坚 on 16/1/19.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "ChooseCouponView.h"

#import "ChooseCouponTableViewCell.h"
#import "PaymentTableViewCell.h"

static NSString *const storeCellIdentifier = @"ChooseCouponTableViewCell";
static NSString *const payCellIdentifier = @"PaymentTableViewCell";

#define TableViewHeight 44.0f
#define TitleHeight 40.0f

@implementation ChooseCouponView

+ (ChooseCouponView *)showInView:(UIView *)aView withList:(NSArray *)dataList withSelectedIndex:(NSInteger)index withPayType:(PayTypeVoModel *)payType andSelectCallback:(disMissCallback)callBack{
    
    if(dataList == nil || dataList.count == 0){
        return nil;
    }

    ChooseCouponView *CHV = [[ChooseCouponView alloc]initWithFrame:CGRectMake(0, 0, APP_W,SCREEN_H)];
    CHV.dismissCallback = callBack;
    CHV.dataArray = dataList;
    CHV.pay = payType;
    CGFloat tableHeight = dataList.count > 6?(TableViewHeight * 6 + 41):(dataList.count * TableViewHeight + 41);
    CHV.mainTableView.frame = CGRectMake(0, SCREEN_H, APP_W, tableHeight);
    CHV.confrimBtn.frame = CGRectMake(0, SCREEN_H + tableHeight-41, APP_W, 41.0f);
    CHV.selectedRow = index;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:CHV];
    [keyWindow makeKeyWindow];
    [UIView animateWithDuration:0.5 animations:^{
        CHV.BKView.alpha = 0.4f;
        CGRect rect = CHV.mainTableView.frame;
        //少算了底部关闭按钮的高度
        rect.origin.y = SCREEN_H - tableHeight-41;
        CHV.mainTableView.frame = rect;
        CHV.confrimBtn.frame = CGRectMake(0, SCREEN_H  - 41, APP_W, 41.0f);
    } completion:^(BOOL finished) {
        [CHV.mainTableView reloadData];
    }];
    
    
    return CHV;
}

+ (ChooseCouponView *)showPaymentView:(UIView *)aView supportOnline:(BOOL)flag confrimCallback:(disMissCallback)callBack{
    
    ChooseCouponView *CHV = [[ChooseCouponView alloc]initWithFrame:CGRectMake(0, 0, APP_W,SCREEN_H)];
    CHV.dismissCallback = callBack;
    if(flag){
        CHV.dataArray = @[@"在线支付",@"当面付款"];
    }else{
        CHV.dataArray = @[@"当面付款"];
    }
    CHV.selectedRow = 0;
    CGFloat tableHeight = CHV.dataArray.count * TableViewHeight;
    
    CHV.mainTableView.frame = CGRectMake(0, APP_H + TitleHeight, APP_W, tableHeight);
    CHV.titleLabel.hidden = NO;
    CHV.titleLabel.frame = CGRectMake(0, APP_H, APP_W, TitleHeight);
    CHV.confrimBtn.frame = CGRectMake(0, APP_H + tableHeight + TitleHeight, APP_W, 41.0f);
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:CHV];
    [keyWindow makeKeyWindow];
    [UIView animateWithDuration:0.5 animations:^{
        CHV.BKView.alpha = 0.4f;
        CHV.titleLabel.frame = CGRectMake(0, SCREEN_H - tableHeight - TitleHeight - 41, APP_W, TitleHeight);
        CGRect rect = CHV.mainTableView.frame;
        //少算了底部关闭按钮的高度
        rect.origin.y = SCREEN_H - tableHeight - 41;
        CHV.mainTableView.frame = rect;
        CHV.confrimBtn.frame = CGRectMake(0, SCREEN_H  - 41, APP_W, 41.0f);
    } completion:^(BOOL finished) {
        [CHV.mainTableView reloadData];
    }];
    
    return CHV;
}


- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self == [super initWithFrame:frame]){
        
        _BKView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, SCREEN_H)];
        _BKView.backgroundColor = RGBHex(qwColor17);
        _BKView.alpha = 0.0f;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)];
        [_BKView addGestureRecognizer:tap];
        [self addSubview:_BKView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, APP_W, TitleHeight)];
        _titleLabel.backgroundColor = RGBHex(qwColor4);
        _titleLabel.hidden = YES;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"选择付款方式";
        _titleLabel.font = fontSystem(kFontS1);
        _titleLabel.textColor = RGBHex(qwColor6);
        [self addSubview:_titleLabel];
        
        _mainTableView = [[UITableView alloc]init];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        [_mainTableView registerNib:[UINib nibWithNibName:storeCellIdentifier bundle:nil] forCellReuseIdentifier:storeCellIdentifier];
        [_mainTableView registerNib:[UINib nibWithNibName:payCellIdentifier bundle:nil] forCellReuseIdentifier:payCellIdentifier];
        
        [self addSubview:_mainTableView];
        
        _confrimBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, APP_W, 41.0f)];
        [_confrimBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confrimBtn setTitleColor:RGBHex(qwColor4) forState:UIControlStateNormal];
        _confrimBtn.titleLabel.font = fontSystem(kFontS3);
        _confrimBtn.backgroundColor = RGBHex(qwColor2);
        [_confrimBtn addTarget:self action:@selector(conFormChoose:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_confrimBtn];
        
    }
    return self;
}

-(void)setSelectedRow:(NSInteger)selectedRow {
     id unknowModel = self.dataArray[0];
    if ([unknowModel isKindOfClass:[CartPromotionVoModel class]]) {
        CartPromotionVoModel *model = (CartPromotionVoModel *)self.dataArray[selectedRow];
        if (model.onlySupportOnlineTrading && _pay.type == 1) {//当面付款且只支持网上支付（上次选中）
            for (NSInteger index = 0; index < self.dataArray.count; index ++) {
                CartPromotionVoModel *promodel = (CartPromotionVoModel *)self.dataArray[index];
                if (promodel.onlySupportOnlineTrading && _pay.type == 1) {//当面付款且只支持网上支付(重新遍历)
                    
                }else {
                    _selectedRow = index;
                    break;
                }
            }
        }else {
            _selectedRow = selectedRow;
        }
    }
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    if(self.dataArray.count > 0) {
        id unknowModel = self.dataArray[0];
        if([unknowModel isKindOfClass:[CartPromotionVoModel class]]) {

        }else if([unknowModel isKindOfClass:[DeliveryTypeVoModel class]]){
            _selectedRow = -1;
        }
    }else{
        _selectedRow = 0;
    }
}

- (void)dismissView{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.alpha = 0.0;
        self.mainTableView.frame = CGRectMake(0, SCREEN_H + _dataArray.count * TableViewHeight, APP_W, _dataArray.count * TableViewHeight);
        self.confrimBtn.frame = CGRectMake(0, SCREEN_H + _dataArray.count * TableViewHeight + 41, APP_W, 41.0f);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (void)conFormChoose:(id)sender{
    
    [self dismissView];
    if(_selectedRow == -1)
        return;
    
    if(self.dismissCallback){
        self.dismissCallback(_selectedRow);
    }
}
#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return TableViewHeight;
}

- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id unknowModel = self.dataArray[indexPath.row];
    if([unknowModel isKindOfClass:[DeliveryTypeVoModel class]]){
        DeliveryTypeVoModel *model = (DeliveryTypeVoModel *)unknowModel;
        if(!model.available) {
            return nil;
        }
    }
    return indexPath;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id unknowModel = self.dataArray[indexPath.row];
    
    if([unknowModel isKindOfClass:[NSString class]]) {
        
        PaymentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:payCellIdentifier forIndexPath:indexPath];
        cell.mainLabel.text = self.dataArray[indexPath.row];
        if([cell.mainLabel.text isEqualToString:@"在线支付"]){
            cell.imgUrl.image = [UIImage imageNamed:online];
        }else{
            cell.imgUrl.image = [UIImage imageNamed:face];
        }
        
        if(indexPath.row == _selectedRow){
            [cell.chooseImage setImage:[UIImage imageNamed:@"icon_shopping_selected"]];
        }else{
            [cell.chooseImage setImage:[UIImage imageNamed:@"icon_shopping_rest"]];
        }
        
        if(indexPath.row != (self.dataArray.count - 1)){
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, TableViewHeight - 0.5, APP_W - 30, 0.5)];
            line.backgroundColor = RGBHex(qwColor10);
            [cell addSubview:line];
        }
        
        return cell;
    }
    
    ChooseCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:storeCellIdentifier forIndexPath:indexPath];

    if([unknowModel isKindOfClass:[CartPromotionVoModel class]]) {
        CartPromotionVoModel *model = (CartPromotionVoModel *)unknowModel;
        cell.ALabel.text = model.title;

        if(model.onlySupportOnlineTrading){
            cell.ALabel.frame = CGRectMake(15, 9.5, APP_W - 70, 15);
            cell.BLabel.frame = CGRectMake(15, cell.ALabel.frame.origin.y + cell.ALabel.frame.size.height, APP_W - 70, 15);
            cell.BLabel.hidden = NO;
            cell.BLabel.text = @"仅限在线支付使用";
            if (_pay.type == 1) {//当面支付
                cell.cover.hidden = NO;
                cell.cover.frame = CGRectMake(0, 0, APP_W, TableViewHeight);
                cell.userInteractionEnabled = NO;
            }else {
                cell.cover.hidden = YES;
                cell.userInteractionEnabled = YES;
            }
        }else{
            cell.cover.hidden = YES;
            cell.userInteractionEnabled = YES;
            cell.ALabel.frame = CGRectMake(15, 0, APP_W - 70, TableViewHeight);
            cell.BLabel.hidden = YES;
        }
        
       
    }else if([unknowModel isKindOfClass:[DeliveryTypeVoModel class]]){
        DeliveryTypeVoModel *model = (DeliveryTypeVoModel *)unknowModel;
        
        if(StrIsEmpty(model.tip)){
            cell.ALabel.frame = CGRectMake(15, 14.5, APP_W - 70, 15);
            cell.BLabel.hidden = YES;
        }else{
            cell.ALabel.frame = CGRectMake(15, 9.5, APP_W - 70, 15);
            cell.BLabel.frame = CGRectMake(15, cell.ALabel.frame.origin.y + cell.ALabel.frame.size.height, APP_W - 70, 15);
            cell.BLabel.hidden = NO;
        }
        
        
        cell.ALabel.text = model.content;
        if(!model.available) {
            cell.ALabel.enabled = NO;
            cell.BLabel.text = model.tip;
            cell.selectImage.hidden = YES;
        }else{
            cell.ALabel.enabled = YES;
            cell.BLabel.text = nil;
            cell.selectImage.hidden = NO;
        }
    }else{
        cell.ALabel.text = self.dataArray[indexPath.row];
    }
    
    if(indexPath.row == _selectedRow){
        [cell.selectImage setImage:[UIImage imageNamed:@"icon_shopping_selected"]];
    }else{
        [cell.selectImage setImage:[UIImage imageNamed:@"icon_shopping_rest"]];
    }
    if(indexPath.row != (self.dataArray.count - 1)){
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, TableViewHeight - 0.5, APP_W - 30, 0.5)];
        line.backgroundColor = RGBHex(qwColor10);
        [cell addSubview:line];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _selectedRow = indexPath.row;
    [_mainTableView reloadData];
}

@end
