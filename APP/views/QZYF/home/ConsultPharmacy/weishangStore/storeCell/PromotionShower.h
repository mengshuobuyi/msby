//
//  PromotionShower.h
//  APP
//
//  Created by 李坚 on 16/6/15.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^disMissCallback) (NSInteger obj);

@interface PromotionShower : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataArray;

@property (copy,nonatomic) disMissCallback dismissCallback;
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

- (IBAction)closeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIView *messageView;

+ (PromotionShower *)showTitle:(NSString *)title message:(NSString *)message list:(NSArray *)dataArr andCallBack:(disMissCallback)callBack;

@end
