//
//  ChooseCouponView.h
//  APP
//
//  Created by 李坚 on 16/1/19.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MallCartModel.h"
typedef void (^disMissCallback) (NSInteger obj);

@interface ChooseCouponView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign) NSInteger selectedRow;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *confrimBtn;
@property (nonatomic, strong) UIView *BKView;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) PayTypeVoModel *pay;
@property (copy,nonatomic) disMissCallback dismissCallback;

+ (ChooseCouponView *)showInView:(UIView *)aView withList:(NSArray *)dataList withSelectedIndex:(NSInteger)index withPayType:(PayTypeVoModel *)payType andSelectCallback:(disMissCallback)callBack;

+ (ChooseCouponView *)showPaymentView:(UIView *)aView supportOnline:(BOOL)flag confrimCallback:(disMissCallback)callBack;
@end
