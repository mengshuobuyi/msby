//
//  PackageView.h
//  APP
//  药品详情套餐自定义弹出框
//  Created by 李坚 on 16/3/14.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AddCallback) (NSInteger obj);

@interface PackageView : UIView<UITableViewDataSource,UITableViewDelegate>

+ (PackageView *)showView:(UIWindow *)window WithContent:(NSString *)content andDataList:(NSArray *)array callBack:(AddCallback)callBack;

@property (copy,nonatomic) AddCallback callback;


@property (strong, nonatomic) NSArray *dataArr;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *headLabel;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainViewHeightConstant;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UITableView *PKTableView;
@property (weak, nonatomic) IBOutlet UILabel *mainPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *lessPriceLabel;
- (IBAction)AddAction:(id)sender;
- (IBAction)ReduceAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
- (IBAction)closeAction:(id)sender;

- (IBAction)GoodCarAction:(id)sender;

@end
