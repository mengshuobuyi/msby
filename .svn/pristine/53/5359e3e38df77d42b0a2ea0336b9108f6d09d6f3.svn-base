//
//  ComboxView.m
//  wenyao
//
//  Created by xiezhenghong on 14-9-22.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "ComboxView.h"
#import "Constant.h"


@interface ComboxView ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) UIButton      *backGroundTouch;


@end

@implementation ComboxView

- (id)initWithFrame:(CGRect)frame
{
    CGRect rect = [UIScreen mainScreen].bounds;
    rect.origin.y += frame.origin.y;
    rect.size.width = APP_W;
    self = [super initWithFrame:rect];
    if (self)
    {
        self.ViewOpen = NO;

        [self setBackgroundColor:[UIColor clearColor]];
        frame.origin.y = 0;
        self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backGroundTouch = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.backGroundTouch.frame = rect;
        self.backGroundTouch.userInteractionEnabled = YES;
        self.backGroundTouch.backgroundColor = [UIColor blackColor];
        self.backGroundTouch.alpha = 0.4f;
        [self.backGroundTouch addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchDown];
        [self addSubview:self.backGroundTouch];
        [self addSubview:self.tableView];
        self.alpha = 0.0;
    }
    return self;
}

- (void)dismissView
{
    if(self.ViewOpen == NO){
        return;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if(self.ViewOpen){
            if([self.comboxDeleagte respondsToSelector:@selector(comboxViewDidDisappear:)]){
                [self.comboxDeleagte comboxViewDidDisappear:self];
            }
        }
        self.ViewOpen = !self.ViewOpen;
    }];
    
}

- (void)showInView:(UIView *)superView
{
    self.ViewOpen = YES;
    if(!self.superview) {
        [superView addSubview:self];
    }
    [superView bringSubviewToFront:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1.0;
    }];
}

- (void)showInWindow:(UIView *)superView
{
    self.ViewOpen = YES;
    if(!self.superview) {
        CGRect rect = CGRectMake(0, 104, APP_W, APP_H - 84);
        self.frame = rect;
        [superView addSubview:self];
    }
    [superView bringSubviewToFront:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1.0;
    }];
}

- (void)setDelegate:(id<UITableViewDelegate,UITableViewDataSource>)delegate
{
    _delegate = delegate;
    self.tableView.delegate = delegate;
    self.tableView.dataSource = delegate;
    [self.tableView reloadData];
}


@end
