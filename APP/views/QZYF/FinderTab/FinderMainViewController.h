//
//  FinderMainViewController.h
//  APP
//
//  Created by 李坚 on 15/12/30.
//  Copyright © 2015年 carret. All rights reserved.
//

#import "QWBaseVC.h"
#import "FXBlurView.h"
@interface FinderMainViewController : QWBaseVC


@property (nonatomic,strong) CALayer *dotLayer1;
@property (nonatomic,assign) CGPoint EndPoint1;
@property (nonatomic,strong) UIBezierPath *path1;
@property (nonatomic, strong) FXBlurView *blurView;
- (void)removeBlurView;

@end
