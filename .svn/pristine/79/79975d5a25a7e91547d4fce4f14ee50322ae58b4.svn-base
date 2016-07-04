//
//  ComboxView.h
//  wenyao
//
//  Created by xiezhenghong on 14-9-22.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ComboxView;

@protocol ComboxViewDelegate <NSObject>

@optional
- (void)comboxViewDidDisappear:(ComboxView *)combox;

@end


@interface ComboxView : UIView

@property (nonatomic, assign) id<ComboxViewDelegate>    comboxDeleagte;
@property (nonatomic, assign) id<UITableViewDelegate,UITableViewDataSource> delegate;
@property (nonatomic, strong) UITableView   *tableView;

@property (assign, nonatomic) BOOL ViewOpen;

- (void)showInWindow:(UIView *)superView;
- (void)showInView:(UIView *)superView;
- (void)dismissView;




@end
