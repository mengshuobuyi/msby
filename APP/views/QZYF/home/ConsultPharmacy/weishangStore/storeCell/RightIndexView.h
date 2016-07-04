//
//  RightIndexView.h
//  APP
//
//  Created by 李坚 on 16/6/16.
//  Copyright © 2016年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^selectCallback) (NSInteger obj);

@interface RightIndexView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (copy,nonatomic) selectCallback callback;

@property (assign, nonatomic) BOOL isShow;
@property (strong, nonatomic) UITableView *mainTableView;
@property (strong, nonatomic) UIView *backView;

@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) NSArray *titleArray;

+ (RightIndexView *)showIndexViewWithImage:(NSArray *)images title:(NSArray *)titles SelectCallback:(selectCallback)callBack;

- (void)hide;
@end
